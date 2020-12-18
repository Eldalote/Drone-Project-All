library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Remote_Radio_Controller is
    generic(
        MAIN_CLOCK_FREQ             : in natural := 100_000_000;
        SCLOCK_TARGET_FREQ          : in natural := 7_500_000;
        RADIO_DATARATE              : in integer range 0 to 2 := 2;
        RETRANSMIT_PAUSE            : in STD_LOGIC_VECTOR(3 downto 0) := X"7";          
        MAX_RETRANSMITS             : in STD_LOGIC_VECTOR(3 downto 0) := X"8";          
        RF_CHANNEL                  : in STD_LOGIC_VECTOR(6 downto 0) := "0000010";     
        RF_POWER                    : in STD_LOGIC_VECTOR(1 downto 0) := "11";          
        THIS_RADIO_ADDRESS          : in STD_LOGIC_VECTOR(39 downto 0) := X"E7E7E7E7E7";
        TARGET_RADIO_ADDRESS        : in STD_LOGIC_VECTOR(39 downto 0) := X"1122334455";
        PAYLOAD_SIZE                : in STD_LOGIC_VECTOR(5 downto 0) := "100000"        
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;

        --- NRF24 port 
        o_SPI_mosi                  : out STD_LOGIC;
        i_SPI_miso                  : in STD_LOGIC;
        o_SPI_SCLK                  : out STD_LOGIC;
        o_SPI_CSn                   : out STD_LOGIC;
        i_radio_IRQ                 : in STD_LOGIC;
        o_radio_CE                  : out STD_LOGIC;

        --- Control Port
        o_connection_error          : out STD_LOGIC;
        o_missed_packets            : out STD_LOGIC_VECTOR(7 downto 0);
        o_connection_made           : out STD_LOGIC := '0';
        o_radio_started             : out STD_LOGIC := '0';
        o_status_register           : out STD_LOGIC_VECTOR(7 downto 0);

        --- Test port
        o_testbyte                  : out STD_LOGIC_VECTOR(7 downto 0);
        o_state_flag                : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture rtl of Remote_Radio_Controller is
    --- NRF registers and wires
    signal r_start_radio                : STD_LOGIC := '0';
    signal r_payload_byte_data          : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal r_payload_byte_address       : integer range 0 to 31 := 0;
    signal r_payload_byte_valid         : STD_LOGIC := '0';
    signal r_start_payload_loading      : STD_LOGIC := '0';
    signal w_connection_error           : STD_LOGIC;
    signal w_missed_packets             : integer range 0 to 255;
    signal w_ready_for_payload_data     : STD_LOGIC;
    signal w_payload_byte_data          : STD_LOGIC_VECTOR(7 downto 0);
    signal w_payload_byte_address       : integer range 0 to 31;
    signal w_payload_byte_valid         : STD_LOGIC;

    type TtestState is (s_idle, s_started, s_transmitting);
    signal state                        : TtestState := s_idle;

    signal w_clock_enable_seconds       : STD_LOGIC;    
    signal r_seconds_counter            : integer range 0 to 255 := 0;


    signal w_SPI_transmissions              : STD_LOGIC_VECTOR(7 downto 0);


begin
    o_connection_error <= w_connection_error;
    o_missed_packets <= STD_LOGIC_VECTOR(to_unsigned(w_missed_packets, 8));
    

    nRF24L01Plus_Controller_inst: entity work.nRF24L01Plus_Controller
        generic map (
            MAIN_CLOCK_FREQ          => MAIN_CLOCK_FREQ, 
            SCLOCK_TARGET_FREQ       => SCLOCK_TARGET_FREQ,
            RADIO_DATARATE           => RADIO_DATARATE,
            RETRANSMIT_PAUSE         => RETRANSMIT_PAUSE, 
            MAX_RETRANSMITS          => MAX_RETRANSMITS, 
            RF_CHANNEL               => RF_CHANNEL,
            RF_POWER                 => RF_POWER, 
            THIS_RADIO_ADDRESS       => THIS_RADIO_ADDRESS,
            TARGET_RADIO_ADDRESS     => TARGET_RADIO_ADDRESS,
            PAYLOAD_SIZE             => PAYLOAD_SIZE,
            RADIO_RX_MODE            => '1'
        )
        port map (
            clk                      => clk,
            rst                      => rst,
            i_start_radio            => r_start_radio,
            o_connection_error       => w_connection_error,
            o_missed_packets         => w_missed_packets,
            o_ready_for_payload_data => w_ready_for_payload_data,
            i_payload_byte_data      => r_payload_byte_data,
            i_payload_byte_address   => r_payload_byte_address,
            i_payload_byte_valid     => r_payload_byte_valid,
            i_start_payload_loading  => r_start_payload_loading,
            o_payload_byte_data      => w_payload_byte_data,
            o_payload_byte_address   => w_payload_byte_address,
            o_payload_byte_valid     => w_payload_byte_valid,
            o_status_register        => o_status_register, 
            o_SPI_transmissions      => w_SPI_transmissions,
            o_state_flag             => o_state_flag,
            o_SPI_MOSI               => o_SPI_MOSI,
            i_SPI_MISO               => i_SPI_MISO,
            o_SPI_SCLK               => o_SPI_SCLK,
            o_SPI_CSn                => o_SPI_CSn,
            i_radio_IRQ              => i_radio_IRQ,
            o_radio_CE               => o_radio_CE
        );

    ClockEnableGenerator_inst: entity work.ClockEnableGenerator
        generic map (
            DividerCount     => MAIN_CLOCK_FREQ
        )
        port map (
            clk              => clk,
            rst              => rst,
            clock_enable_out => w_clock_enable_seconds
        );



    my_process_sp: process (clk) is
    begin
        if rising_edge(clk) then
            r_start_payload_loading <= '0'; --Default
            r_payload_byte_valid <= '0'; --default
            case state is
                when s_idle =>
                    if r_seconds_counter = 5 then
                        state <= s_started;
                        r_start_radio <= '1';
                        o_radio_started <= '1';
                        r_seconds_counter <= 0;
                    else
                        state <= s_idle;
                    end if;

                when s_started =>
                    if w_ready_for_payload_data = '1' then
                        state <= s_transmitting;
                    else
                        state <= s_started;
                    end if;

                when s_transmitting =>
                    state <= s_transmitting;
                    if w_ready_for_payload_data = '1' then
                        r_payload_byte_data <= STD_LOGIC_VECTOR(to_unsigned(r_seconds_counter, 8));
                        r_payload_byte_address <= 0;
                        r_payload_byte_valid <= '1';
                        r_start_payload_loading <= '1'; 
                    else
                        r_payload_byte_valid <= '0';
                        r_start_payload_loading <= '0';                        
                    end if;
                    if w_payload_byte_valid = '1' and w_payload_byte_address = 0 then
                        o_testbyte <= w_payload_byte_data;
                        o_connection_made <= '1';
                    end if;
                

            end case;
            if w_clock_enable_seconds = '1' then
                r_seconds_counter <= r_seconds_counter + 1;
            end if;
            if (rst = '1') then
                state <= s_idle;
            end if;
        end if;
    end process;



end architecture;