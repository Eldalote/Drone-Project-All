-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Controller for the nRF24L01+ radio module. Allows for RX and TX mode, will use advanced shock burst. (only one data pipe, and with RX payload, for now)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Generics:
-- RADIO_DATARATE selects the datarate of the radio. 0 = 250K, 1 = 1M, 2 = 2M. Must be same on RX and TX side
-- RETRANSMIT_PAUSE Selects the pause between retransmit attempts. RETRANSMIT_PAUSE + 1 * 250 us. default 7 turns to 2000 us (TX mode only)
-- MAX_RETRANSMITS selects the maximum amounts of times the radio will try to retransmit in TX mode (TX mode only)
-- RF_CHANNEL selects the RF channel, must be same on TX and RX side
-- RF_POWER Selects the power level of the transmission in TX mode, 3 (11) selects max power (TX mode only)
-- RADIO_ADDRESS Sets the address of the pipeline. Must be same on RX and TX side
-- PAYLOAD_SIZE Sets the size of the RX payload FIFO (max 32)
-- RADIO_RX_MODE selects RX or TX mode, RX = 1, TX = 0
-- 
-- The code is well commented, and should be self evident. (yeah right)
-- 
-- 
--
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Created by Jan Mart Liewes. Semi Verified by testbench, not yet tested in system.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity nRF24L01Plus_Controller is
    generic (
        MAIN_CLOCK_FREQ         : in natural := 100_000_000;
        SCLOCK_TARGET_FREQ      : in natural := 7_500_000;
        RADIO_DATARATE          : in integer range 0 to 2 := 2;        
        RETRANSMIT_PAUSE        : in STD_LOGIC_VECTOR(3 downto 0) := X"7"; 
        MAX_RETRANSMITS         : in STD_LOGIC_VECTOR(3 downto 0) := X"8";
        RF_CHANNEL              : in STD_LOGIC_VECTOR(6 downto 0) := "0000010";
        RF_POWER                : in STD_LOGIC_VECTOR(1 downto 0) := "11";
        THIS_RADIO_ADDRESS      : in STD_LOGIC_VECTOR(39 downto 0) := X"E7E7E7E7E7";
        TARGET_RADIO_ADDRESS    : in STD_LOGIC_VECTOR(39 downto 0) := X"03060FA3A3";
        PAYLOAD_SIZE            : in STD_LOGIC_VECTOR(5 downto 0) := "100000";
        RADIO_RX_MODE           : in STD_LOGIC := '0' -- Rx = 1, TX = 0
        
    );
    port (
        clk                     : in  std_logic;
        rst                     : in  std_logic;
        
        --- Control signals
        i_start_radio           : in STD_LOGIC;        
        o_connection_error      : out STD_LOGIC;
        o_missed_packets        : out integer range 0 to 255;
        
        --- Register interface signals
        o_ready_for_payload_data: out STD_LOGIC;
        i_payload_byte_data     : in STD_LOGIC_VECTOR(7 downto 0);
        i_payload_byte_address  : in integer range 0 to 31;
        i_payload_byte_valid    : in STD_LOGIC;
        i_start_payload_loading : in STD_LOGIC;
        o_payload_byte_data     : out STD_LOGIC_VECTOR(7 downto 0);
        o_payload_byte_address  : out integer range 0 to 31;
        o_payload_byte_valid    : out STD_LOGIC;
        
        --- Test port
        o_status_register       : out STD_LOGIC_VECTOR(7 downto 0) := X"00";
        o_SPI_transmissions     : out STD_LOGIC_VECTOR(7 downto 0);
        o_state_flag            : out STD_LOGIC_VECTOR(7 downto 0) := X"00";
        
        
        
        --- SPI port
        o_SPI_MOSI              : out STD_LOGIC;
        i_SPI_MISO              : in STD_LOGIC;
        o_SPI_SCLK              : out STD_LOGIC;
        o_SPI_CSn               : out STD_LOGIC;
        --- Additional control pins
        i_radio_IRQ             : in STD_LOGIC;
        o_radio_CE              : out STD_LOGIC
    );
end entity;

architecture rtl of nRF24L01Plus_Controller is
   
    
    --- SPI controller wires and registers
    signal r_SPI_TX_byte_data               : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal r_SPI_TX_byte_address            : integer range 0 to 32 := 0;
    signal r_SPI_TX_byte_valid              : STD_LOGIC := '0';
    signal r_SPI_TX_transmit_count_min_1    : integer range 0 to 32 := 0;
    signal r_SPI_TX_start                   : STD_LOGIC := '0';
    signal w_SPI_RX_byte_data               : STD_LOGIC_VECTOR(7 downto 0);
    signal w_SPI_RX_byte_number             : integer range 0 to 32;
    signal w_SPI_RX_byte_valid              : STD_LOGIC;
    signal w_SPI_system_ready_for_commands  : STD_LOGIC;

    --- State machines
    type TSuperState    is (s_idle, s_settings, s_TX, s_RX, s_SPI);
    type TstateSettings is (ss_test_SPI, ss_read_SPI_reply, ss_pipelines, ss_auto_ack, ss_autoretrans, ss_RF_channel, ss_RF_settings, ss_set_RXaddress_P0, ss_set_RXaddress_P1, ss_set_TXaddress, ss_pipe_size, ss_features, 
                            ss_dynpd, ss_config_RX, ss_wait_poweron, ss_flush_TX, ss_flush_RX, ss_clear_IRQ, ss_config_TX, ss_check_config, ss_com_error, ss_flush_RX_for_TX);
    type TStateRX       is (srx_idle, srx_RX_mode, srx_read_status, srx_read_packet, srx_offload_packet, srx_check_fifo_info, srx_read_fifo_info);
    type TStateTX       is (stx_idle, stx_enter_TX_mode, stx_wait_for_interupt, stx_read_status, stx_flush_FIFO, stx_read_response, stx_offloading_response);
    type TStateSPI      is (sspi_transmitting, sspi_reading);
    signal SuperState           : TSuperState := s_idle;
    signal NextSuperState       : TSuperState := s_idle;
    signal StateSettings        : TStateSettings := ss_pipelines;
    signal StateRX              : TStateRX := srx_idle;
    signal StateTX              : TStateTX := stx_idle;
    signal StateSPI             : TStateSPI := sspi_transmitting;
    
    --- SPI control registers --- 
    type TSPIMemory is array(0 to 32) of STD_LOGIC_VECTOR(7 downto 0);
    signal r_SPI_mem            : TSPIMemory := (others => (others => '0'));
    signal r_SPI_mem_pointer    : integer range 0 to 32 := 0;
    signal r_SPI_transmit_number: integer range 0 to 32 := 0;
    
    --- assorted registers
    signal r_idle_counter       : integer := 0;
    signal r_missed_packets     : integer range 0 to 255 := 0;
    
    --- test registers
    signal w_status_reg         : STD_LOGIC_VECTOR(7 downto 0);
    signal r_SPI_transmissions  : integer range 0 to 255 := 0;
    signal r_IRQ_set            : STD_LOGIC := '0';
    signal r_system_state_reg   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    
    
    constant WRITE_REG          : std_logic_vector(2 downto 0) := "001";
    constant READ_REG           : std_logic_vector(2 downto 0) := "000";
    constant READ_RX_PAYLOAD    : std_logic_vector(7 downto 0) := "01100001";
    constant WRITE_TX_PAYLOAD   : std_logic_vector(7 downto 0) := "10100000";
    constant FLUSH_TX_FIFO      : std_logic_vector(7 downto 0) := "11100001";
    constant FLUSH_RX_FIFO      : std_logic_vector(7 downto 0) := "11100010";
    constant WRITE_ACK_PAYLOAD  : std_logic_vector(4 downto 0) := "10101";
    constant NOP                : std_logic_vector(7 downto 0) := "11111111";
    
    constant REG_CONFIG         : std_logic_vector(4 downto 0) := 5X"00";
    constant REG_EN_AA          : std_logic_vector(4 downto 0) := 5X"01";
    constant REG_EN_RXADDR      : std_logic_vector(4 downto 0) := 5X"02";
    constant REG_SETUP_AW       : std_logic_vector(4 downto 0) := 5X"03";
    constant REG_SETUP_RETR     : std_logic_vector(4 downto 0) := 5X"04";
    constant REG_RF_CH          : std_logic_vector(4 downto 0) := 5X"05";
    constant REG_RF_SETUP       : std_logic_vector(4 downto 0) := 5X"06";
    constant REG_STATUS         : std_logic_vector(4 downto 0) := 5X"07";
    constant REG_OBSERVE_TX     : std_logic_vector(4 downto 0) := 5X"08";
    constant REG_RPD            : std_logic_vector(4 downto 0) := 5X"09";
    constant REG_RX_ADDR_P0     : std_logic_vector(4 downto 0) := 5X"0A";
    constant REG_RX_ADDR_P1     : std_logic_vector(4 downto 0) := 5X"0B";
    constant REG_RX_ADDR_P2     : std_logic_vector(4 downto 0) := 5X"0C";
    constant REG_RX_ADDR_P3     : std_logic_vector(4 downto 0) := 5X"0D";
    constant REG_RX_ADDR_P4     : std_logic_vector(4 downto 0) := 5X"0E";
    constant REG_RX_ADDR_P5     : std_logic_vector(4 downto 0) := 5X"0F";
    constant REG_TX_ADDR        : std_logic_vector(4 downto 0) := 5X"10";
    constant REG_RX_PW_P0       : std_logic_vector(4 downto 0) := 5X"11";
    constant REG_RX_PW_P1       : std_logic_vector(4 downto 0) := 5X"12";
    constant REG_RX_PW_P2       : std_logic_vector(4 downto 0) := 5X"13";
    constant REG_RX_PW_P3       : std_logic_vector(4 downto 0) := 5X"14";
    constant REG_RX_PW_P4       : std_logic_vector(4 downto 0) := 5X"15";
    constant REG_RX_PW_P5       : std_logic_vector(4 downto 0) := 5X"16";
    constant REG_FIFO_STATUS    : std_logic_vector(4 downto 0) := 5X"17";
    constant REG_DYNPD          : std_logic_vector(4 downto 0) := 5X"1C";
    constant REG_FEATURE        : std_logic_vector(4 downto 0) := 5X"1D";
    
    
    constant MILLISECONDS_5     : integer := MAIN_CLOCK_FREQ / 200;
    constant MICROSECONDS_15    : integer := MAIN_CLOCK_FREQ / 66666;
    
   
    
begin
    
    o_ready_for_payload_data <= '1' when ((SuperState = s_TX and StateTX = stx_idle) or (SuperState = s_RX and StateRX = srx_idle)) and i_start_payload_loading = '0' else '0';
    o_missed_packets <= r_missed_packets;
    
    w_status_reg <= r_SPI_mem(0);
    o_SPI_transmissions <= STD_LOGIC_VECTOR(to_unsigned(r_SPI_transmissions,8));
    
    o_state_flag <= r_system_state_reg;
    
    
    
    
    
    Advanced_SPI_Master_inst: entity work.Advanced_SPI_Master
        generic map (
            MAIN_CLOCK_FREQ             => MAIN_CLOCK_FREQ,
            SCLOCK_TARGET_FREQ          => SCLOCK_TARGET_FREQ,
            MAXIMUM_BYTE_TRANSFERS      => 33,
            CPOL_clock_polarity         => '0',
            CPHA_clock_phase            => '0'
        )
        port map (
            clk                         => clk,
            rst                         => rst,
            o_SPI_MOSI                  => o_SPI_MOSI,
            i_SPI_MISO                  => i_SPI_MISO,
            o_SPI_SCLK                  => o_SPI_SCLK,
            o_SPI_CSn                   => o_SPI_CSn,
            i_TX_byte_data              => r_SPI_TX_byte_data,
            i_TX_byte_address           => r_SPI_TX_byte_address,
            i_TX_byte_valid             => r_SPI_TX_byte_valid,
            i_TX_transmit_count_min_1   => r_SPI_TX_transmit_count_min_1,
            i_TX_start                  => r_SPI_TX_start,
            o_RX_byte_data              => w_SPI_RX_byte_data,
            o_RX_byte_number            => w_SPI_RX_byte_number,
            o_RX_byte_valid             => w_SPI_RX_byte_valid,
            o_system_ready_for_commands => w_SPI_system_ready_for_commands
        );
    
    irq_process: process (clk) is
    begin
        if rising_edge(clk) then
            if i_radio_IRQ = '0' then
                r_IRQ_set <= '1';
            else
                r_IRQ_set <= '0';
            end if;
            
            if (rst = '1') then
                r_IRQ_set <= '0';
            end if;
        end if;
    end process;

    
    StateMachine_p: process (clk) is
    begin
        if rising_edge(clk) then
            r_SPI_TX_byte_valid <= '0'; --Default
            r_SPI_TX_start <= '0'; --Default
            o_radio_CE <= '0'; --default
            o_payload_byte_valid <= '0'; --Default
            
            case SuperState is
                when s_idle =>
                    SuperState <= s_idle;
                    StateSettings <= ss_test_SPI;
                    StateRX <= srx_idle;
                    StateTX <= stx_idle;
                    if i_start_radio = '1' then
                        SuperState <= s_settings;
                    end if;                    

                when s_settings =>
                    SuperState <= s_settings; --default
                    case StateSettings is      
                        when ss_test_SPI =>
                            r_SPI_mem(0) <= READ_REG & REG_RX_ADDR_P5;
                            r_SPI_mem(1) <= (others => '0');
                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_read_SPI_reply; -- Go to next sub-state after transmit.
                            
                        when ss_read_SPI_reply => 
                            if r_SPI_mem(1) = X"C6" then
                                StateSettings <= ss_RF_channel;
                                r_system_state_reg(0) <= '0';
                            else
                                StateSettings <= ss_test_SPI;
                                r_system_state_reg(0) <= '1';
                            end if;
                            
                        when ss_RF_channel =>
                            r_SPI_mem(0) <= WRITE_REG & REG_RF_CH; 
                            r_SPI_mem(1) <= '0' & RF_CHANNEL; -- Select the RF channel

                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_RF_settings; -- Go to next sub-state after transmit.
                            
                        when ss_RF_settings =>
                            r_SPI_mem(0) <= WRITE_REG & REG_RF_SETUP; 
                            if RADIO_DATARATE = 0 then
                                r_SPI_mem(1) <= "00100" & RF_POWER & '0'; -- 250kbps, RF_Power selects power.
                            elsif RADIO_DATARATE = 1 then
                                r_SPI_mem(1) <= "00000" & RF_POWER & '0'; -- 1mbps, RF_Power selects power.
                            else
                                r_SPI_mem(1) <= "00001" & RF_POWER & '0'; -- 2mbps, RF_Power selects power.
                            end if;                             

                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_autoretrans; -- Go to next sub-state after transmit.
                            
                        when ss_autoretrans =>
                            r_SPI_mem(0) <= WRITE_REG & REG_SETUP_RETR; 
                            r_SPI_mem(1) <= RETRANSMIT_PAUSE & MAX_RETRANSMITS; -- Wait RETRANSMIT_PAUSE+1 * 250uS between retransmits, maximum of MAX_RETRANSMITS retransmits, 0 means no retransmits.

                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_set_RXaddress_P1; -- Go to next sub-state after transmit.
                            
                        when ss_set_RXaddress_P1 =>
                            r_SPI_mem(0) <= WRITE_REG & REG_RX_ADDR_P1; 
                            r_SPI_mem(1) <= THIS_RADIO_ADDRESS(7 downto 0); -- Address  byte 1
                            r_SPI_mem(2) <= THIS_RADIO_ADDRESS(15 downto 8); -- Address  byte 2
                            r_SPI_mem(3) <= THIS_RADIO_ADDRESS(23 downto 16); -- Address  byte 3
                            r_SPI_mem(4) <= THIS_RADIO_ADDRESS(31 downto 24); -- Address  byte 4
                            r_SPI_mem(5) <= THIS_RADIO_ADDRESS(39 downto 32); -- Address  byte 5

                            r_SPI_transmit_number <= 5; -- Transmit 5 bytes after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_dynpd; -- Go to next sub-state after transmit.
                            
                        when ss_dynpd =>
                            r_SPI_mem(0) <= WRITE_REG & REG_DYNPD; 
                            r_SPI_mem(1) <= "00000011"; -- Enable dynamic payload on pipe 1 and 0

                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_features; -- Go to next sub-state after transmit.
                            
                        when ss_features =>
                            r_SPI_mem(0) <= WRITE_REG & REG_FEATURE; 
                            r_SPI_mem(1) <= "00000111"; -- Enable Acknowledge payload and dynamic payload length

                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_flush_RX; -- Go to next sub-state after transmit.
                            
                        when ss_flush_RX =>
                            r_SPI_mem(0) <= FLUSH_RX_FIFO;
                            
                            r_SPI_transmit_number <= 0;
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_flush_TX; -- Go to next sub-state after transmit.
                            
                        when ss_flush_TX =>
                            r_SPI_mem(0) <= FLUSH_TX_FIFO;
                            
                            r_SPI_transmit_number <= 0;
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_clear_IRQ; -- Go to next sub-state after transmit.
                            
                        when ss_clear_IRQ =>
                            r_SPI_mem(0) <= WRITE_REG & REG_STATUS;
                            r_SPI_mem(1) <= X"70"; -- Clear all interupts
                            
                            r_SPI_transmit_number <= 1;
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_config_RX; -- Go to next sub-state after transmit.
                            
                        when ss_config_RX =>
                            r_SPI_mem(0) <= WRITE_REG & REG_CONFIG; 
                            r_SPI_mem(1) <=  "00001011"; -- Turn on the power, and put in rx mode.
                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte     
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data        
                            NextSuperState <= s_settings; -- return to settings
                            StateSettings <= ss_wait_poweron; -- Wait for the chip to power on
                            
                        when ss_wait_poweron =>                            
                            StateSettings <= ss_wait_poweron; --Default
                            if r_idle_counter = MILLISECONDS_5 then  -- 5 ms delay
                                r_idle_counter <= 0; --Reset counter
                                
                                r_SPI_mem(0) <= READ_REG & REG_CONFIG; 
                                r_SPI_mem(1) <=  X"00";
                                r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte     
                                r_SPI_mem_pointer <= 0;
                                SuperState <= s_SPI; -- Transmit the SPI data        
                                NextSuperState <= s_settings; -- return to settings
                                StateSettings <= ss_check_config;
                            else
                                o_radio_CE <= '1';
                                r_idle_counter <= r_idle_counter +1;
                            end if;
                            
                        when ss_check_config => 
                            if r_SPI_mem(1) = "00001011" then
                                if RADIO_RX_MODE = '1' then
                                    SuperState <= s_RX;                                    
                                else
                                    StateSettings <= ss_set_TXaddress;
                                end if;
                            else
                                StateSettings <= ss_com_error;
                            end if;
                            
                        when ss_set_TXaddress =>
                            r_SPI_mem(0) <= WRITE_REG & REG_TX_ADDR; 
                            r_SPI_mem(1) <= TARGET_RADIO_ADDRESS(7 downto 0); -- Address  byte 1
                            r_SPI_mem(2) <= TARGET_RADIO_ADDRESS(15 downto 8); -- Address  byte 2
                            r_SPI_mem(3) <= TARGET_RADIO_ADDRESS(23 downto 16); -- Address  byte 3
                            r_SPI_mem(4) <= TARGET_RADIO_ADDRESS(31 downto 24); -- Address  byte 4
                            r_SPI_mem(5) <= TARGET_RADIO_ADDRESS(39 downto 32); -- Address  byte 5

                            r_SPI_transmit_number <= 5; -- Transmit 5 bytes after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_set_RXaddress_P0; -- Go to next sub-state after transmit.                            

                        when ss_set_RXaddress_P0 =>
                            r_SPI_mem(0) <= WRITE_REG & REG_RX_ADDR_P0; 
                            r_SPI_mem(1) <= TARGET_RADIO_ADDRESS(7 downto 0); -- Address  byte 1
                            r_SPI_mem(2) <= TARGET_RADIO_ADDRESS(15 downto 8); -- Address  byte 2
                            r_SPI_mem(3) <= TARGET_RADIO_ADDRESS(23 downto 16); -- Address  byte 3
                            r_SPI_mem(4) <= TARGET_RADIO_ADDRESS(31 downto 24); -- Address  byte 4
                            r_SPI_mem(5) <= TARGET_RADIO_ADDRESS(39 downto 32); -- Address  byte 5

                            r_SPI_transmit_number <= 5; -- Transmit 5 bytes after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_config_TX; -- Go to next sub-state after transmit.
                            
                        when ss_config_TX =>
                            r_SPI_mem(0) <= WRITE_REG & REG_CONFIG; 
                            r_SPI_mem(1) <=  "00001010"; -- Turn on the power, and put in TX mode.
                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte     
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data        
                            NextSuperState <= s_settings; -- return to settings
                            StateSettings <= ss_flush_RX_for_TX; -- Wait for the chip to power on and flush RX fifo again.
                            
                        when ss_flush_RX_for_TX =>
                            StateSettings <= ss_flush_RX_for_TX;
                            if r_idle_counter = MILLISECONDS_5 then  -- 5 ms delay
                                r_idle_counter <= 0; --Reset counter
                                
                                r_SPI_mem(0) <= FLUSH_RX_FIFO;

                                r_SPI_transmit_number <= 0;
                                NextSuperState <= s_TX; -- Go to TX mode
                                r_SPI_mem_pointer <= 0;
                                SuperState <= s_SPI; -- Transmit the SPI data
                            else
                                r_idle_counter <= r_idle_counter + 1;
                            end if;
                            
                        
                            
                            
                            
                            
                            
                            
                            
                            
                        when ss_pipelines =>
                            r_SPI_mem(0) <= WRITE_REG & REG_EN_RXADDR; 
                            r_SPI_mem(1) <= "00000011"; -- Enable pipe 1 and 0
                            
                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_auto_ack; -- Go to next sub-state after transmit.
                            
                        when ss_auto_ack =>
                            r_SPI_mem(0) <= WRITE_REG & REG_EN_AA;
                            r_SPI_mem(1) <= "00000011"; -- Enable pipe 1 and 0

                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_autoretrans; -- Go to next sub-state after transmit.

                        when ss_pipe_size =>
                            r_SPI_mem(0) <= WRITE_REG & REG_RX_PW_P0; 
                            r_SPI_mem(1) <= "00" & PAYLOAD_SIZE; -- set the RX payload size on pipe 0

                            r_SPI_transmit_number <= 1; -- Transmit 1 byte after address/control byte
                            NextSuperState <= s_settings; -- Return to settings
                            r_SPI_mem_pointer <= 0;
                            SuperState <= s_SPI; -- Transmit the SPI data
                            StateSettings <= ss_features; -- Go to next sub-state after transmit.      
                            
                            
                            
                            

                        when ss_com_error =>
                            StateSettings <= ss_com_error; -- Just stay here, wait for reset.
                            r_system_state_reg(1) <= '1'; -- send flag
                            
                        

                        
                            
                       

                    end case;                    

                when s_TX =>
                    SuperState <= s_TX; --default
                    case StateTX is                        
                        when stx_idle =>
                            StateTX <= stx_idle; --Default
                            if (i_payload_byte_valid = '1') then -- If a new payload byte is presented
                                r_SPI_mem(i_payload_byte_address + 1) <= i_payload_byte_data; -- Load it in the correct memory byte. The plus one is because we have an address/command byte in SPI, not in the payload.
                            end if;
                            if (i_start_payload_loading = '1') then -- Wait for at least 1.5ms
                                r_SPI_mem(0) <= WRITE_TX_PAYLOAD; --Load the command byte
                                r_SPI_transmit_number <= to_integer(unsigned(PAYLOAD_SIZE)); --send the whole payload after the command byte
                                r_SPI_mem_pointer <= 0;
                                StateTX <= stx_enter_TX_mode; -- Set CE high for 15 us to enter TX mode (minimum 10 us, 15 should be more than safe.)
                                NextSuperState <= s_TX; -- Return to TX state
                                SuperState <= s_SPI; -- Send payload.                                                       
                            end if;
                            
                        when stx_enter_TX_mode => -- Set CE high for 15 us to enter TX mode (minimum 10 us, 15 should be more than safe.)
                            StateTX <= stx_enter_TX_mode; --default
                            o_radio_CE <= '1';
                            if (r_idle_counter = MICROSECONDS_15) then -- 15 us delay
                                r_idle_counter <= 0; --Reset idle counter
                                StateTX <= stx_wait_for_interupt; -- go to waiting for interupt state  
                            else
                                r_idle_counter <= r_idle_counter + 1;
                            end if;
                            
                        when stx_wait_for_interupt =>
                            StateTX <= stx_wait_for_interupt; -- Default
                            if r_IRQ_set = '1' then
                                r_SPI_mem(0) <= NOP; --NOP, status register will be read while command byte is sent.
                                r_SPI_transmit_number <= 0; -- Only sent command byte.
                                r_SPI_mem_pointer <= 0;
                                StateTX <= stx_read_status; -- Next state will interpret status register
                                NextSuperState <= s_TX; --Return to TX
                                SuperState <= s_SPI; 
                            end if;
                            
                        when stx_read_status =>                        
                            o_status_register <= r_SPI_mem(0);
                            if w_status_reg(5) = '1' then   --Packet succesfully sent, ACK received.
                                o_connection_error <= '0';  --No connection error (any more)
                                StateTX <= stx_read_response;   --After clearing flags, read the ACK packet    
                            elsif w_status_reg(4) = '1' then--Maximum number of retransmits reached
                                o_connection_error <= '1';  --We have a connection error
                                if r_missed_packets < 255 then    --Prevent overflow                            
                                    r_missed_packets <= r_missed_packets + 1;       --Keep track of the number of lost packets
                                end if;
                                StateTX <= stx_flush_FIFO;  --Since the packet has not been succesfully sent, the FIFO is not empty, so we need to flush it.
                            else -- Wtf?
                                r_missed_packets <= 255;
                                o_connection_error <= '0'; -- Set a weird combo to signal something is very wrong
                            end if;
                            r_SPI_mem(0) <= WRITE_REG & REG_STATUS;  --STATUS register
                            r_SPI_mem(1) <= X"70";          --Clear all interupt flags
                            r_SPI_transmit_number <= 1;     --Send only the one data byte
                            r_SPI_mem_pointer <= 0;
                            NextSuperState <= s_TX;         --Return after clearing flags
                            SuperState <= s_SPI;            --Send the byte
                            

                        when stx_flush_FIFO =>
                            r_SPI_mem(0) <= FLUSH_TX_FIFO; --FLUSH_TX command
                            r_SPI_transmit_number <= 0;
                            r_SPI_mem_pointer <= 0;
                            NextSuperState <= s_TX;
                            SuperState <= s_SPI;
                            StateTX <= stx_idle; --There is no response to read, go back to idle mode
                            
                        when stx_read_response =>
                            r_SPI_mem <= (READ_RX_PAYLOAD, others => X"00"); --R_RX_PAYLOAD command, clear the rest of the bytes
                            r_SPI_transmit_number <= 32; --Read 32 bytes
                            r_SPI_mem_pointer <= 0;
                            NextSuperState <= s_TX;
                            SuperState <= s_SPI;
                            StateTX <= stx_offloading_response; --Offload the package in the next state

                        when stx_offloading_response =>
                            StateTX <= stx_offloading_response;--Default
                            if r_SPI_mem_pointer > 0 then   -- Dont send the reset status register                             
                                o_payload_byte_address <= r_SPI_mem_pointer - 1; --Minus 1, because of the address/command byte 
                                o_payload_byte_data <= r_SPI_mem(r_SPI_mem_pointer); --Send the byte
                                o_payload_byte_valid <= '1';                                
                            end if;
                            if r_SPI_mem_pointer = 32 then
                                r_SPI_mem_pointer <= 0;
                                StateTX <= stx_idle;
                            else
                                r_SPI_mem_pointer <= r_SPI_mem_pointer + 1;
                            end if;
                            
                        

                    end case;
                    

                when s_RX =>
                    case StateRX is
                        when srx_idle =>
                            StateRX <= srx_idle; --Default
                            if (i_payload_byte_valid = '1') then -- If a new payload byte is presented
                                r_SPI_mem(i_payload_byte_address + 1) <= i_payload_byte_data; -- Load it in the correct memory byte. The plus one is because we have an address/command byte in SPI, not in the payload.
                            end if;
                            if (i_start_payload_loading = '1') then 
                                r_SPI_mem(0) <= WRITE_ACK_PAYLOAD & "000"; --Load the command byte
                                r_SPI_transmit_number <= to_integer(unsigned(PAYLOAD_SIZE)); --send the whole payload after the command byte
                                r_SPI_mem_pointer <= 0;
                                StateRX <= srx_RX_mode; -- go into RX mode
                                NextSuperState <= s_RX; -- Return to RX state
                                SuperState <= s_SPI; -- Send payload.  
                                r_idle_counter <= 0;
                            end if;

                        when srx_RX_mode =>
                            StateRX <= srx_RX_mode; --Default
                            o_radio_CE <= '1'; --Turn on the RX mode
                            if r_IRQ_set = '1' then --Interrupt would mean new message, read the status register
                                if r_idle_counter = 1_000_000 then
                                    r_SPI_mem(0) <= NOP; --NOP, status register will be read while command byte is sent.
                                    r_SPI_transmit_number <= 0; -- Only sent command byte.
                                    r_SPI_mem_pointer <= 0;
                                    StateRX <= srx_read_status; -- Next state will interpret status register
                                    NextSuperState <= s_RX; --Return to RX
                                    SuperState <= s_SPI; 
                                end if;
                                r_idle_counter <= r_idle_counter + 1;
                            end if;

                        when srx_read_status =>                           
                            if w_status_reg(6) = '1' then   --Packet succesfully received.
                                StateRX <= srx_read_packet;   --After reading_status read the packet                             
                            else -- Wtf?
                                StateRX <= srx_idle;
                                r_missed_packets <= r_missed_packets + 1;
                                o_connection_error <= '1'; -- set connection error to signal that something weird happened
                            end if;

                        when srx_read_packet =>
                            r_SPI_mem <= (READ_RX_PAYLOAD, others => X"00"); --R_RX_PAYLOAD command, clear the rest of the bytes
                            r_SPI_transmit_number <= to_integer(unsigned(PAYLOAD_SIZE)); --Read payload size bytes
                            r_SPI_mem_pointer <= 0;
                            NextSuperState <= s_RX;
                            SuperState <= s_SPI;
                            StateRX <= srx_offload_packet; --Offload the package in the next state

                        when srx_offload_packet =>
                            StateRX <= srx_offload_packet;--Default
                            if r_SPI_mem_pointer > 0 then   -- Dont send the reset status register                             
                                o_payload_byte_address <= r_SPI_mem_pointer - 1; --Minus 1, because of the address/command byte 
                                o_payload_byte_data <= r_SPI_mem(r_SPI_mem_pointer); --Send the byte
                                o_payload_byte_valid <= '1';                                
                            end if;
                            if r_SPI_mem_pointer = 32 then
                                r_SPI_mem_pointer <= 0;
                                StateRX <= srx_check_fifo_info;
                                r_SPI_mem(0) <= WRITE_REG & REG_STATUS;          --STATUS register
                                r_SPI_mem(1) <= X"70";          --Clear all interupt flags
                                r_SPI_transmit_number <= 1;     --Send only the one data byte
                                r_SPI_mem_pointer <= 0;
                                NextSuperState <= s_RX;         --Return after clearing flags
                                SuperState <= s_SPI;            --Send the byte                
                            else
                                r_SPI_mem_pointer <= r_SPI_mem_pointer + 1;
                            end if;
                            
                        when srx_check_fifo_info =>
                            r_SPI_mem_pointer <= 0;
                            StateRX <= srx_read_fifo_info;
                            r_SPI_mem(0) <= READ_REG & REG_FIFO_STATUS;   --FIFO_STATUS register
                            r_SPI_mem(1) <= X"00";          --Reading only
                            r_SPI_transmit_number <= 1;     --Send only the one data byte
                            r_SPI_mem_pointer <= 0;
                            NextSuperState <= s_RX;         --Return after reading fifo status
                            SuperState <= s_SPI;            --Send the byte                
                            
                            
                        when srx_read_fifo_info =>
                            if r_SPI_mem(1)(0) = '1' then --The RX FIFO is empty
                                StateRX <= srx_idle;
                            else
                                StateRX <= srx_read_packet; -- If not, read another packet
                            end if;

                    end case;
                    
                    
                when s_SPI =>
                    SuperState <= s_SPI; --Default
                    case StateSPI is
                        when sspi_transmitting =>
                            StateSPI <= sspi_transmitting; --Default                            
                            if w_SPI_system_ready_for_commands = '1' then
                                r_SPI_TX_byte_data <= r_SPI_mem(r_SPI_mem_pointer);
                                r_SPI_TX_byte_address <= r_SPI_mem_pointer;
                                r_SPI_TX_byte_valid <= '1';
                                if (r_SPI_mem_pointer < r_SPI_transmit_number ) then                               
                                    r_SPI_mem_pointer <= r_SPI_mem_pointer + 1;
                                else
                                    r_SPI_mem_pointer <= 0;
                                    r_SPI_TX_transmit_count_min_1 <= r_SPI_transmit_number;
                                    r_SPI_TX_start <= '1';
                                    StateSPI <= sspi_reading;
                                    r_idle_counter <= 0;
                                end if; 
                            end if;
                            
                        when sspi_reading =>
                            StateSPI <= sspi_reading;--Default
                            if w_SPI_system_ready_for_commands = '1' then
                                if r_idle_counter = 5 then
                                    SuperState <= NextSuperState;
                                    StateSPI <= sspi_transmitting;                                
                                    r_SPI_transmissions <= r_SPI_transmissions + 1;
                                    r_idle_counter <= 0;
                                else
                                    r_idle_counter <= r_idle_counter + 1;
                                end if;
                            end if;
                            if (w_SPI_RX_byte_valid = '1') then
                                r_SPI_mem(w_SPI_RX_byte_number) <= w_SPI_RX_byte_data;
                            end if;
                            
                    end case;
                    
            end case;
           
            if (rst = '1') then
               SuperState <= s_idle;
               o_connection_error <= '0';
               
            end if;
        end if;
    end process;

   
end architecture;