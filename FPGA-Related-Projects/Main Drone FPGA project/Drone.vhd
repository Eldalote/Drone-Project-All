-- Main project top file
-- All entities, connections, output, input, etc. are made here.



library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Drone is
    port (
        --------FPGA Components----------
        
        ---Clocks---
        FPGA_CLK1_50    :in std_logic;
        --FPGA_CLK2_50    :in std_logic;
        --FPGA_CLK3_50    :in std_logic;
        
        ---ADC---
        --ADC_CONVST      : out std_logic;
        --ADC_SCK         : out std_logic;
        --ADC_SDI         : out std_logic;
        --ADC_SDO         : in std_logic;
        
        
        ---Buttons(key), leds, switches---
        KEY             : in std_logic_vector(1 downto 0);
        LED             : out std_logic_vector(7 downto 0);
        --SW          : in std_logic_vector(3 downto 0);
        
        ---GPIO Assignment and naming---
      
        ---Gyroscope SPI interface on GPIO---
        --GPIO_ICM_SPI_CS_n           : out std_logic;
        --GPIO_ICM_SPI_MOSI           : out std_logic;
        --GPIO_ICM_SPI_SCLOCK         : out std_logic;
        --GPIO_ICM_SPI_MISO           : in std_logic;
        
        -----Engine control signals ---
        --GPIO_ENGINE_ONE_CONTROL     : out std_logic;       
        --GPIO_ENGINE_TWO_CONTROL     : out std_logic;        
        --GPIO_ENGINE_THREE_CONTROL   : out std_logic;        
        --GPIO_ENGINE_FOUR_CONTROL    : out std_logic;
        --GPIO_ENGINE_ONE_TELEMETRY   : in STD_LOGIC;
        --GPIO_ENGINE_TWO_TELEMETRY   : in STD_LOGIC;
        --GPIO_ENGINE_THREE_TELEMETRY : in STD_LOGIC;
        --GPIO_ENGINE_FOUR_TELEMETRY  : in STD_LOGIC;      
        
        ---2.4 GHz radio control signals ---
        GPIO_2_4G_CSn               : out STD_LOGIC;
        GPIO_2_4G_CE                : out STD_LOGIC;
        GPIO_2_4G_IRQ               : in STD_LOGIC;
        GPIO_2_4G_MISO              : in STD_LOGIC;
        GPIO_2_4G_MOSI              : out STD_LOGIC;
        GPIO_2_4G_SCLK              : out STD_LOGIC;
        
        --- test port radio
        --test_CSn                    : out STD_LOGIC;
        --test_CE                     : out STD_LOGIC;
        --test_IRQ                    : in STD_LOGIC;
        --test_MISO                   : in STD_LOGIC;
        --test_MOSI                   : out STD_LOGIC;
        --test_SCLK                   : out STD_LOGIC;
        
        --- SPI snooper Port        
        Snooper_SCLK                : in STD_LOGIC;
        Snooper_CSn                 : in STD_LOGIC;
        Snooper_MOSI                : in STD_LOGIC;
        Snooper_MISO                : in STD_LOGIC;
        
        --- Buzzer (NC)---
        --GPIO_BUZZER_OUT             : out STD_LOGIC;
        
        ---BNO055 Abs orientation sensor ---
        --GPIO_BNO055_SDA             : inout std_logic;
        --GPIO_BNO055_SCLK            : inout std_logic;
        
        ---Board LEDs---
        GPIO_LED_RED                : out STD_LOGIC;
        GPIO_LED_YELLOW             : out STD_LOGIC;
        GPIO_LED_GREEN              : out STD_LOGIC     
        
     
        
       
        
        
        

        
    );
end entity;

architecture rtl of Drone is
    
    --- Components ---        
    component NIOS is
        port (
            clk_clk                                       : in  std_logic                     := 'X';             -- clk
            nios_to_fpga_com_bus_0_conduit_end_cb_address : out std_logic_vector(15 downto 0);                    -- cb_address
            nios_to_fpga_com_bus_0_conduit_end_cb_read    : in  std_logic_vector(31 downto 0) := (others => 'X'); -- cb_read
            nios_to_fpga_com_bus_0_conduit_end_cb_write   : out std_logic_vector(31 downto 0);                    -- cb_write
            reset_reset_n                                 : in  std_logic                     := 'X'              -- reset_n
        );
    end component NIOS;
    
    --- Signals---
    
    --- Standard system signals ---
    signal clock_50M           : std_logic;    
    signal rst                  : std_logic;
    signal rst_n                : std_logic;    
    --- Com bus signals ---
    signal CB_address           : std_logic_vector(15 downto 0);
    signal CB_write             : std_logic_vector(31 downto 0);
    signal CB_read              : std_logic_vector(31 downto 0);
    --- Wires to pins ---
    --signal w_leds_out           : std_logic_vector(7 downto 0);
        --ICM
    --signal w_ICM_SPI_CS_n       : std_logic;
    --signal w_ICM_SPI_MOSI       : std_logic;
    --signal w_ICM_SPI_MISO       : std_logic;
    --signal w_ICM_sclock         : std_logic;
    --    --Engines
    --signal w_engine_1_DSHOT     : std_logic;
    --signal w_engine_2_DSHOT     : std_logic;
    --signal w_engine_3_DSHOT     : std_logic;
    --signal w_engine_4_DSHOT     : std_logic;
        --Radio
    signal w_radio_SPI_CSn      : STD_LOGIC;
    signal w_radio_SPI_MOSI     : STD_LOGIC;
    signal w_radio_SPI_MISO     : STD_LOGIC;
    signal w_radio_SPI_SCLK     : STD_LOGIC;
    signal w_radio_CE           : STD_LOGIC;
    signal w_radio_IRQ          : STD_LOGIC;
    signal w_radio_connection_error : STD_LOGIC;
    signal w_radio_lost_packets : STD_LOGIC_VECTOR(7 downto 0);
    signal w_radio_testbyte     : STD_LOGIC_VECTOR(7 downto 0);
    signal w_radio_connection_made  : STD_LOGIC;
    signal w_radio_started      : STD_LOGIC;
    signal w_radio_status_reg   : STD_LOGIC_VECTOR(7 downto 0);
    signal w_radio_states       : STD_LOGIC_VECTOR(7 downto 0);
    
    signal w_results            : STD_LOGIC_VECTOR(7 downto 0);
    
    --- SPI Snooper
    signal w_Snooper_new_transaction    : STD_LOGIC;
    signal w_Snooper_end_transaction    : STD_LOGIC;
    signal w_Snooper_master_out_byte    : STD_LOGIC_VECTOR(7 downto 0);    
    signal w_Snooper_slave_out_byte     : STD_LOGIC_VECTOR(7 downto 0);
    signal w_Snooper_data_out_valid    : STD_LOGIC;
    signal w_Snooper_byte_counter       : STD_LOGIC_VECTOR(7 downto 0);
   
    
    
    --- Internal Wires ---
    --- General Systems wires
    signal w_button_reset       : std_logic;
    signal w_clock_in_1         : std_logic;   
    --- Com bus read wires ---
    signal w_CBR_ICM20948       : std_logic_vector(31 downto 0);    
    signal w_CBR_LED            : std_logic_vector(31 downto 0);
    signal w_CBR_System_control : std_logic_vector(31 downto 0);
    signal w_CBR_BNO055         : std_logic_vector(31 downto 0); 
    signal w_CBR_compound_filter: STD_LOGIC_VECTOR(31 downto 0);
    signal w_CBR_pulse_counter  : std_logic_vector(31 downto 0);
    signal w_CBR_SPI_logger     : STD_LOGIC_VECTOR(31 downto 0);
    
    -----BNO outputs ---
    --signal w_BNO_heading        : std_logic_vector(15 downto 0);
    --signal w_BNO_roll           : std_logic_vector(15 downto 0);
    --signal w_BNO_pitch          : std_logic_vector(15 downto 0);
    --signal w_BNO_data_valid     : std_logic;
    
    ----- ICM outputs ---
    --signal w_ICM_acc_x          : STD_LOGIC_VECTOR(15 downto 0);
    --signal w_ICM_acc_y          : STD_LOGIC_VECTOR(15 downto 0);
    --signal w_ICM_acc_z          : STD_LOGIC_VECTOR(15 downto 0);
    --signal w_ICM_gyro_x         : STD_LOGIC_VECTOR(15 downto 0);
    --signal w_ICM_gyro_y         : STD_LOGIC_VECTOR(15 downto 0);
    --signal w_ICM_gyro_heading   : STD_LOGIC_VECTOR(15 downto 0);
    --signal w_ICM_temperature    : STD_LOGIC_VECTOR(15 downto 0);
    --signal w_ICM_data_valid     : STD_LOGIC;
    
    ----- Compound filter outputs --- 
    --signal w_compound_intangle_x: STD_LOGIC_VECTOR(31 downto 0);
    --signal w_compound_intangle_y: STD_LOGIC_VECTOR(31 downto 0);
    --signal w_compound_XY_valid  : STD_LOGIC;
    --signal w_compound_intangle_h: STD_LOGIC_VECTOR(31 downto 0);
    --signal w_compound_H_valid   : STD_LOGIC;
    
    
    -----ComBus controlled outputs---
    
    
    ----- Control and flag signals (System control SC)---
    --signal w_SC_control_bus     : std_logic_vector(31 downto 0);
    --signal w_SC_flags_bus       : std_logic_vector(31 downto 0);
    ---- Control signals--
    --signal w_SC_power_supply    : std_logic;
    ---- Flags--
    --signal w_SCF_BNO_ack_error  : std_logic;
    
    
    ----- Test signals ---
    
    --signal w_dshot_test_data    : STD_LOGIC_VECTOR(31 downto 0);
    --signal w_dshot_test_valid   : STD_LOGIC;
    
    
    ----- Com bus addresses---
    --constant LED_CONTROLLER_ADDRESS     : std_logic_vector(7 downto 0) := X"01";
    --constant ICM20948_MASTER_ADDRESS    : std_logic_vector(7 downto 0) := X"02";
    --constant SYSTEM_CONTROL_ADDRESS     : std_logic_vector(7 downto 0) := X"03";    
    --constant BNO055_ADDRESS             : std_logic_vector(7 downto 0) := X"04"; 
    constant SPI_LOGGER_ADDRESS    : std_logic_vector(7 downto 0) := X"01";
    
    --constant PULSE_COUNTER_ADDRESS      : std_logic_vector(7 downto 0) := X"07"; 
    
    
    
    
begin
       
    --- Entities ---    
    nios_inst : component nios
        port map (
            clk_clk                 => clock_50M,              --          clk.clk
            nios_to_fpga_com_bus_0_conduit_end_cb_address => CB_address,              -- nios_fpga_cb.cb_address
            nios_to_fpga_com_bus_0_conduit_end_cb_read    => CB_read,                 --             .cb_read
            nios_to_fpga_com_bus_0_conduit_end_cb_write   => CB_write,                --             .cb_write
            reset_reset_n           => rst_n                    --        reset.reset_n
        );
    Com_bus_read_mux_inst: entity work.Com_bus_read_mux
        port map (
            clk          => clock_50M,
            rst          => rst,
            CB_address   => CB_address,
            CB_read_out  => CB_read,
            CB_read_in_1 => w_CBR_SPI_logger,
            CB_read_in_2 => X"2f000000",
            CB_read_in_3 => X"3f000000",
            CB_read_in_4 => X"4f000000",
            CB_read_in_5 => X"5f000000",
            CB_read_in_6 => X"6f000000",
            CB_read_in_7 => X"7f000000",
            CB_read_in_8 => w_radio_states & w_radio_status_reg & w_radio_lost_packets & w_radio_testbyte
        );
    
        
        Drone_Radio_Controller_inst: entity work.Drone_Radio_Controller
            generic map (
                MAIN_CLOCK_FREQ    => 50_000_000,
                SCLOCK_TARGET_FREQ => 2_000_000,
                RADIO_DATARATE     => 2,
                RETRANSMIT_PAUSE   => X"1",
                MAX_RETRANSMITS    => X"8",
                RF_CHANNEL         => "1100100",
                RF_POWER           => "11",
                THIS_RADIO_ADDRESS   => X"0102030400",
                TARGET_RADIO_ADDRESS => X"E7E7E7E7E7",
                PAYLOAD_SIZE       => "100000"
            )
            port map (
                clk                => clock_50M,
                rst                => rst,
                o_SPI_mosi         => w_radio_SPI_MOSI,
                i_SPI_miso         => w_radio_SPI_MISO,
                o_SPI_SCLK         => w_radio_SPI_SCLK,
                o_SPI_CSn          => w_radio_SPI_CSn,
                i_radio_IRQ        => w_radio_IRQ,
                o_radio_CE         => w_radio_CE,
                o_connection_error => w_radio_connection_error,
                o_missed_packets   => w_radio_lost_packets,
                o_connection_made  => w_radio_connection_made,
                o_radio_started    => w_radio_started,
                o_status_register  => w_radio_status_reg,
                o_testbyte         => w_radio_testbyte,
                o_state_flag       => w_radio_states
            ); 

        --SPI_tester_inst: entity work.SPI_tester
        --    generic map (
        --        MAIN_CLOCK_FREQ    => 50_000_000,
        --        SCLOCK_TARGET_FREQ => 5_000_000
        --    )
        --    port map (
        --        clk                => clock_100M,
        --        rst                => rst,
        --        o_SPI_MOSI         => w_radio_SPI_MOSI,
        --        i_SPI_MISO         => w_radio_SPI_MISO,
        --        o_SPI_SCLK         => w_radio_SPI_SCLK,
        --        o_SPI_CSn          => w_radio_SPI_CSn,
        --        o_results          => w_results
        --    );
        
        

        SPI_Data_logger_inst: entity work.SPI_Data_logger
            generic map (
                LOGGING_DEPTH  => 1024,
                ENTITY_ADDRESS => X"01"
            )
            port map (
                clk                 => clock_50M,
                rst                 => rst,
                i_SCLK              => Snooper_SCLK,
                i_CSn               => Snooper_CSn,
                i_MISO              => Snooper_MISO,
                i_MOSI              => Snooper_MOSI,
                CB_address          => CB_address,
                CB_write            => CB_write,
                CBR_SPI_logger      => w_CBR_SPI_logger
            );


        
        
    ----- System control and flags assignments ---
    ---- Controls    
    
    
    ---- Flags
    --w_SC_flags_bus(0)       <= w_SCF_BNO_ack_error;
     

   

    


    ---Direct output assignments ---
    --- General systems ---
    w_button_reset <= KEY(0);
    w_clock_in_1 <= FPGA_CLK1_50;
    
    --- Leds ---
    --LED <= w_leds_out;  
    --LED <= w_radio_testbyte;
    LED <= w_radio_lost_packets;
    --LED <= w_results;
    
    
    
    ----- Gyroscope SPI interface ---
    --GPIO_ICM_SPI_CS_n <= w_ICM_SPI_CS_n;  
    --GPIO_ICM_SPI_MOSI <= w_ICM_SPI_MOSI;
    --w_ICM_SPI_MISO <= GPIO_ICM_SPI_MISO;
    --GPIO_ICM_SPI_SCLOCK <= w_ICM_sclock;
    
    ----- Engine controllers ---
    --GPIO_ENGINE_ONE_CONTROL     <= w_engine_1_DSHOT;
    --GPIO_ENGINE_TWO_CONTROL     <= w_engine_2_DSHOT;
    --GPIO_ENGINE_THREE_CONTROL   <= w_engine_3_DSHOT;
    --GPIO_ENGINE_FOUR_CONTROL    <= w_engine_4_DSHOT;
    
    ----- NRF24 Radio ---
    GPIO_2_4G_CE        <= w_radio_CE;
    GPIO_2_4G_CSn       <= w_radio_SPI_CSn;
    GPIO_2_4G_SCLK      <= w_radio_SPI_SCLK;
    GPIO_2_4G_MOSI      <= w_radio_SPI_MOSI;
    w_radio_SPI_MISO    <= GPIO_2_4G_MISO;
    w_radio_IRQ         <= GPIO_2_4G_IRQ;
    
    --- NRF24 Radio ---
    --test_CE        <= w_radio_CE;
    --test_CSn       <= w_radio_SPI_CSn;
    --test_SCLK      <= w_radio_SPI_SCLK;
    --test_MOSI      <= w_radio_SPI_MOSI;
    --w_radio_SPI_MISO    <= test_MISO;
    --w_radio_IRQ         <= test_IRQ;
    
    --- board LEDs ---
    GPIO_LED_GREEN      <= '0' when w_radio_connection_made = '1' and w_radio_connection_error = '0' else '1';
    GPIO_LED_RED        <= '1' when w_radio_states(0) = '0' else '0'; --'0' when w_radio_connection_error = '1' else 
    GPIO_LED_YELLOW     <= '0' when w_radio_IRQ = '0' else '1';  
    
    
    rst                 <= '0' when KEY(0) = '1' else '1';
    rst_n               <= '1' when KEY(0) = '1' else '0';
    clock_50M          <= FPGA_CLK1_50;
   


end architecture;