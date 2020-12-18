library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Remote is
    port (
        
        ---- FPGA components ----
        
        --- Clock ---
        clock_50        : in STD_LOGIC;
        
        --- buttons and LEDs ---
        KEY             : in STD_LOGIC_VECTOR(1 downto 0);
        LED             : out STD_LOGIC_VECTOR(7 downto 0);
        
        ---ADC SPI port ---
        ADC_CSn                     : out STD_LOGIC;
        ADC_SCLK                    : out STD_LOGIC;
        ADC_MISO                    : in STD_LOGIC;
        ADC_MOSI                    : out STD_LOGIC;
        
        ---2.4 GHz radio control signals ---
        GPIO_2_4G_CSn               : out STD_LOGIC;
        GPIO_2_4G_CE                : out STD_LOGIC;
        GPIO_2_4G_IRQ               : in STD_LOGIC;
        GPIO_2_4G_MISO              : in STD_LOGIC;
        GPIO_2_4G_MOSI              : out STD_LOGIC;
        GPIO_2_4G_SCLK              : out STD_LOGIC
    );
end entity;

architecture rtl of Remote is
    
    --- Signals---

    --- Standard system signals ---
    signal clock_50M            : std_logic;    
    signal rst                  : std_logic;
    signal rst_n                : std_logic;    
    
    --- Wires to pins ---
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
    --ADC
    signal w_ADC_SPI_CSn        : STD_LOGIC;
    signal w_ADC_SPI_SCLK       : STD_LOGIC;
    signal w_ADC_SPI_MOSI       : STD_LOGIC;
    signal w_ADC_SPI_MISO       : STD_LOGIC;
    signal w_ADC_analog_0       : STD_LOGIC_VECTOR(11 downto 0);
    signal w_ADC_analog_1       : STD_LOGIC_VECTOR(11 downto 0);
    signal w_ADC_analog_2       : STD_LOGIC_VECTOR(11 downto 0);
    signal w_ADC_analog_3       : STD_LOGIC_VECTOR(11 downto 0);
    signal w_ADC_analog_4       : STD_LOGIC_VECTOR(11 downto 0);
    signal w_ADC_analog_5       : STD_LOGIC_VECTOR(11 downto 0);
    signal w_ADC_analog_6       : STD_LOGIC_VECTOR(11 downto 0);
    signal w_ADC_analog_7       : STD_LOGIC_VECTOR(11 downto 0);
    signal w_ADC_analog_updated : STD_LOGIC;
    
    signal w_results            : STD_LOGIC_VECTOR(7 downto 0);
   
    
begin
    remote_radio_controller_inst: entity work.remote_radio_controller
        generic map (
            main_clock_freq    => 50_000_000,
            sclock_target_freq => 1_000_000,
            radio_datarate     => 2,
            retransmit_pause   => x"7",
            max_retransmits    => x"8",
            rf_channel         => "1101110",
            rf_power           => "11",
            this_radio_address   => x"0102030401",
            target_radio_address => X"0102030400",
            payload_size       => "000100"
        )
        port map (
            clk                => clock_50m,
            rst                => rst,
            o_spi_mosi         => w_radio_spi_mosi,
            i_spi_miso         => w_radio_spi_miso,
            o_spi_sclk         => w_radio_spi_sclk,
            o_spi_csn          => w_radio_spi_csn,
            i_radio_irq        => w_radio_irq,
            o_radio_ce         => w_radio_ce,
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
    --        clk                => clock_50M,
    --        rst                => rst,
    --        o_SPI_MOSI         => w_radio_SPI_MOSI,
    --        i_SPI_MISO         => w_radio_SPI_MISO,
    --        o_SPI_SCLK         => w_radio_SPI_SCLK,
    --        o_SPI_CSn          => w_radio_SPI_CSn,
    --        o_results          => w_results
    --    );

    
    ADC128S022_controller_inst: entity work.ADC128S022_controller
        generic map (
            MAIN_CLOCK_FREQ    => 50_000_000,
            SCLOCK_TARGET_FREQ => 5_000_000,
            SAMPLE_FREQ        => 200
        )
        port map (
            clk                => clock_50M,
            rst                => rst,
            o_SPI_MOSI         => w_ADC_SPI_MOSI,
            i_SPI_MISO         => w_ADC_SPI_MISO,
            o_SPI_SCLK         => w_ADC_SPI_SCLK,
            o_SPI_CSn          => w_ADC_SPI_CSn,
            o_Analog_0         => w_ADC_Analog_0,
            o_Analog_1         => w_ADC_Analog_1,
            o_Analog_2         => w_ADC_Analog_2,
            o_Analog_3         => w_ADC_Analog_3,
            o_Analog_4         => w_ADC_Analog_4,
            o_Analog_5         => w_ADC_Analog_5,
            o_Analog_6         => w_ADC_Analog_6,
            o_Analog_7         => w_ADC_Analog_7,
            o_analog_updated   => w_ADC_analog_updated
        );

    
    
    
    --- System signals ---
    clock_50M           <= clock_50;
    rst                 <= '0' when KEY(0) = '1' else '1';
    rst_n               <= '1' when KEY(0) = '1' else '0';
    
    --- LEDs ---
    
    LED(6 downto 0)         <= w_radio_testbyte(6 downto 0);
    LED(7)                  <= '1' when w_radio_IRQ = '0' else '0';
    --LED                 <= w_ADC_analog_2(11 downto 4);
    --LED                 <= w_results;
    
    
    --- NRF24 Radio ---
    GPIO_2_4G_CE        <= w_radio_CE;
    GPIO_2_4G_CSn       <= w_radio_SPI_CSn;
    GPIO_2_4G_SCLK      <= w_radio_SPI_SCLK;
    GPIO_2_4G_MOSI      <= w_radio_SPI_MOSI;
    w_radio_SPI_MISO    <= GPIO_2_4G_MISO;
    w_radio_IRQ         <= GPIO_2_4G_IRQ;
    
    --- ADC128s022 ---
    ADC_CSn             <= w_ADC_SPI_CSn;
    ADC_SCLK            <= w_ADC_SPI_SCLK;
    ADC_MOSI            <= w_ADC_SPI_MOSI;
    w_ADC_SPI_MISO      <= ADC_MISO;
    
    
end architecture;