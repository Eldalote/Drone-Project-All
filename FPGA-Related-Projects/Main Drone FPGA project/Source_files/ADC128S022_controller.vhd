library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity ADC128S022_controller is
    generic(
        MAIN_CLOCK_FREQ             : in natural := 100_000_000;
        SCLOCK_TARGET_FREQ          : in natural := 3_000_000;
        SAMPLE_FREQ                 : in natural := 200
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        --- SPI port
        o_SPI_MOSI                  : out STD_LOGIC;
        i_SPI_MISO                  : in STD_LOGIC;
        o_SPI_SCLK                  : out STD_LOGIC;
        o_SPI_CSn                   : out STD_LOGIC;
        
        --- Data output 
        o_Analog_0                  : out STD_LOGIC_VECTOR(11 downto 0);
        o_Analog_1                  : out STD_LOGIC_VECTOR(11 downto 0);
        o_Analog_2                  : out STD_LOGIC_VECTOR(11 downto 0);
        o_Analog_3                  : out STD_LOGIC_VECTOR(11 downto 0);
        o_Analog_4                  : out STD_LOGIC_VECTOR(11 downto 0);
        o_Analog_5                  : out STD_LOGIC_VECTOR(11 downto 0);
        o_Analog_6                  : out STD_LOGIC_VECTOR(11 downto 0);
        o_Analog_7                  : out STD_LOGIC_VECTOR(11 downto 0);
        o_analog_updated            : out STD_LOGIC
                
    );
end entity;

architecture rtl of ADC128S022_controller is
    signal r_channel_counter        : integer range 0 to 7 := 1;
    signal r_tick_tock              : STD_LOGIC := '0';
    signal r_SPI_address_counter    : integer range 0 to 15 := 0;
    
    signal w_conversion_clock       : STD_LOGIC;
    
    type Tstate is (s_idle, s_sending_data, s_waiting_for_data, s_output);
    signal state                    : Tstate := s_idle;
    
    signal r_SPI_TX_byte            : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal r_SPI_TX_address         : integer range 0 to 15 := 0;
    signal r_SPI_TX_data_valid      : STD_LOGIC := '0';
    signal r_SPI_TX_start           : STD_LOGIC := '0';
    signal w_SPI_RX_byte            : STD_LOGIC_VECTOR(7 downto 0);
    signal w_SPI_RX_address         : integer range 0 to 15;
    signal w_SPI_RX_valid           : STD_LOGIC;
    signal w_SPI_ready              : STD_LOGIC;
    
    type Toutputmem is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
    signal r_outputmem              : Toutputmem := (others => (others => '0'));
    
begin
    ClockEnableGenerator_Frequency_inst: entity work.ClockEnableGenerator_Frequency
        generic map (
            MAIN_CLOCK_FREQ    => MAIN_CLOCK_FREQ,
            DESIRED_CLOCK_FREQ => SAMPLE_FREQ
        )
        port map (
            clk                => clk,
            rst                => rst,
            clock_enable_out   => w_conversion_clock
        );

    Advanced_SPI_Master_inst: entity work.Advanced_SPI_Master
        generic map (
            MAIN_CLOCK_FREQ             => MAIN_CLOCK_FREQ,
            SCLOCK_TARGET_FREQ          => SCLOCK_TARGET_FREQ,
            MAXIMUM_BYTE_TRANSFERS      => 16,
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
            i_TX_byte_data              => r_SPI_TX_byte,
            i_TX_byte_address           => r_SPI_TX_address,
            i_TX_byte_valid             => r_SPI_TX_data_valid,
            i_TX_transmit_count_min_1   => 15,
            i_TX_start                  => r_SPI_TX_start,
            o_RX_byte_data              => w_SPI_RX_byte,
            o_RX_byte_number            => w_SPI_RX_address,
            o_RX_byte_valid             => w_SPI_RX_valid,
            o_system_ready_for_commands => w_SPI_ready
        );

    State_P: process (clk) is
    begin
        if rising_edge(clk) then
            r_SPI_TX_data_valid <= '0'; --Default
            r_SPI_TX_start <= '0'; --default
            o_analog_updated <= '0'; --default
            
            case state is
                when s_idle =>
                    state <= s_idle;
                    if w_conversion_clock = '1' and w_SPI_ready = '1' then
                        state <= s_sending_data;
                        r_channel_counter <= 1;
                        r_SPI_address_counter <= 0;
                    end if;

                when s_sending_data =>
                    state <= s_sending_data;
                    r_SPI_TX_data_valid <= '1';
                    if r_tick_tock = '0' then
                        r_tick_tock <= '1';
                        r_SPI_TX_byte <= "00" & STD_LOGIC_VECTOR(to_unsigned(r_channel_counter,3)) & "000";
                        r_channel_counter <= r_channel_counter + 1;
                        r_SPI_TX_address <= r_SPI_address_counter;
                        r_SPI_address_counter <= r_SPI_address_counter + 1;
                    else
                        r_tick_tock <= '0';
                        r_SPI_TX_byte <= (others => '0');
                        r_SPI_TX_address <= r_SPI_address_counter;
                        if r_SPI_address_counter = 15 then
                            state <= s_waiting_for_data;
                            r_SPI_address_counter <= 0;
                            r_SPI_TX_start <= '1';
                        else                            
                            r_SPI_address_counter <= r_SPI_address_counter + 1;
                        end if;
                    end if;          

                when s_waiting_for_data =>
                    state <= s_waiting_for_data;
                    if w_SPI_RX_valid = '1' then
                        r_outputmem(w_SPI_RX_address) <= w_SPI_RX_byte;
                        if w_SPI_RX_address = 15 then
                            state <= s_output;
                        end if;
                    end if;                        

                when s_output =>
                    state <= s_idle;
                    o_analog_updated <= '1';
                    o_analog_0 <= r_outputmem(0)(3 downto 0) & r_outputmem(1);
                    o_analog_1 <= r_outputmem(2)(3 downto 0) & r_outputmem(3);
                    o_analog_2 <= r_outputmem(4)(3 downto 0) & r_outputmem(5);
                    o_analog_3 <= r_outputmem(6)(3 downto 0) & r_outputmem(7);
                    o_analog_4 <= r_outputmem(8)(3 downto 0) & r_outputmem(9);
                    o_analog_5 <= r_outputmem(10)(3 downto 0) & r_outputmem(11);
                    o_analog_6 <= r_outputmem(12)(3 downto 0) & r_outputmem(13);
                    o_analog_7 <= r_outputmem(14)(3 downto 0) & r_outputmem(15);

            end case;
            if (rst = '1') then
                state <= s_idle;
            end if;
        end if;
    end process;

    
end architecture;