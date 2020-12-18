library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity SPI_tester is
    generic(
        MAIN_CLOCK_FREQ         : in natural := 50_000_000;
        SCLOCK_TARGET_FREQ      : in natural := 5_000_000
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        o_SPI_MOSI          : out STD_LOGIC;
        i_SPI_MISO          : in STD_LOGIC;
        o_SPI_SCLK          : out STD_LOGIC;
        o_SPI_CSn           : out STD_LOGIC;
        
        o_results           : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture rtl of SPI_tester is
    signal r_SPI_TX_byte_data               : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal r_SPI_TX_byte_address            : integer range 0 to 32 := 0;
    signal r_SPI_TX_byte_valid              : STD_LOGIC := '0';
    signal r_SPI_TX_transmit_count_min_1    : integer range 0 to 32 := 0;
    signal r_SPI_TX_start                   : STD_LOGIC := '0';
    signal w_SPI_RX_byte_data               : STD_LOGIC_VECTOR(7 downto 0);
    signal w_SPI_RX_byte_number             : integer range 0 to 32;
    signal w_SPI_RX_byte_valid              : STD_LOGIC;
    signal w_SPI_system_ready_for_commands  : STD_LOGIC;
    
    signal r_delay_counter, r_wrong_counter, r_right_counter : integer := 0;
    signal r_check_byte, r_check_byte2      : integer range 0 to  255 := 0;
    signal r_tick_tock                      : STD_LOGIC := '0';
    
    
    type tstate is (s_idle, s_send1, s_send2, s_read1, s_check1, s_read2, s_check2, s_delay);
    signal state, next_state                : tstate := s_idle;
begin
    
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
    o_results <= STD_LOGIC_VECTOR(to_unsigned(r_right_counter,32))(31 downto 28) & STD_LOGIC_VECTOR(to_unsigned(r_wrong_counter,32))(31 downto 28);
    my_process_sp: process (clk) is
    begin
        if rising_edge(clk) then
            r_SPI_TX_start <= '0';
            case state is
                when s_idle =>
                    state <= s_idle;
                    r_delay_counter <= r_delay_counter + 1;
                    if r_delay_counter = 300_000_000 then
                        state <= s_send1;
                        r_delay_counter <= 0; 
                        r_tick_tock <= '0';
                        r_check_byte <= 0;
                        r_check_byte2 <= 45;
                    end if;

                when s_send1 =>
                    state <= s_send1;
                    if w_SPI_system_ready_for_commands = '1' then 
                        r_SPI_TX_byte_valid <= '1';
                        if (r_tick_tock = '0' ) then                               
                            r_tick_tock <= '1';
                            r_SPI_TX_byte_address <= 0;
                            r_SPI_TX_byte_data <= X"24";
                        else       
                            r_tick_tock <= '0';
                            r_SPI_TX_byte_address <= 1;
                            r_SPI_TX_byte_data <= STD_LOGIC_VECTOR(to_unsigned(r_check_byte,8));
                            r_SPI_TX_transmit_count_min_1 <= 1;
                            r_SPI_TX_start <= '1';
                            state <= s_delay;
                            next_state <= s_send2;                            
                        end if; 
                    end if;

                when s_send2 =>
                    state <= s_send2;
                    if w_SPI_system_ready_for_commands = '1' then      
                        r_SPI_TX_byte_valid <= '1';
                        if (r_tick_tock = '0' ) then                               
                            r_tick_tock <= '1';
                            r_SPI_TX_byte_address <= 0;
                            r_SPI_TX_byte_data <= X"2F";
                        else       
                            r_tick_tock <= '0';
                            r_SPI_TX_byte_address <= 1;
                            r_SPI_TX_byte_data <= STD_LOGIC_VECTOR(to_unsigned(r_check_byte2,8));
                            r_SPI_TX_transmit_count_min_1 <= 1;
                            r_SPI_TX_start <= '1';
                            state <= s_delay;
                            next_state <= s_read1;                            
                        end if; 
                    end if;

                when s_read1 =>
                    state <= s_read1;
                    if w_SPI_system_ready_for_commands = '1' then                        
                        r_SPI_TX_byte_address <= 0;
                        r_SPI_TX_byte_valid <= '1';
                        if (r_tick_tock = '0' ) then                               
                            r_tick_tock <= '1';
                            r_SPI_TX_byte_address <= 0;
                            r_SPI_TX_byte_data <= X"04";
                        else       
                            r_tick_tock <= '0';
                            r_SPI_TX_byte_address <= 1;
                            r_SPI_TX_byte_data <= X"00";
                            r_SPI_TX_transmit_count_min_1 <= 1;
                            r_SPI_TX_start <= '1';
                            state <= s_check1;                                                  
                        end if; 
                    end if;
                    
                when s_check1 =>
                    state <= s_check1;
                    if w_SPI_system_ready_for_commands = '1' then
                       state <= s_delay;
                       next_state <= s_read2;
                    end if;
                    if (w_SPI_RX_byte_valid = '1' and w_SPI_RX_byte_number = 1) then
                        if w_SPI_RX_byte_data = STD_LOGIC_VECTOR(to_unsigned(r_check_byte,8)) then
                            r_right_counter <= r_right_counter + 1;
                        else
                            r_wrong_counter <= r_wrong_counter + 1;
                        end if;
                    end if;
                    

                when s_read2 =>
                    state <= s_read2;
                    if w_SPI_system_ready_for_commands = '1' then                        
                        r_SPI_TX_byte_address <= 0;
                        r_SPI_TX_byte_valid <= '1';
                        if (r_tick_tock = '0' ) then                               
                            r_tick_tock <= '1';
                            r_SPI_TX_byte_address <= 0;
                            r_SPI_TX_byte_data <= X"0F";
                        else       
                            r_tick_tock <= '0';
                            r_SPI_TX_byte_address <= 1;
                            r_SPI_TX_byte_data <= X"00";
                            r_SPI_TX_transmit_count_min_1 <= 1;
                            r_SPI_TX_start <= '1';
                            state <= s_check2;                         
                        end if; 
                    end if;
                    
                when s_check2 =>
                    state <= s_check2;
                    if w_SPI_system_ready_for_commands = '1' then
                        state <= s_delay;
                        next_state <= s_send1;
                        r_check_byte <= r_check_byte + 1;
                        r_check_byte2 <= r_check_byte2 + 1;
                    end if;
                    if (w_SPI_RX_byte_valid = '1' and w_SPI_RX_byte_number = 1) then
                        if w_SPI_RX_byte_data = STD_LOGIC_VECTOR(to_unsigned(r_check_byte2,8)) then
                            r_right_counter <= r_right_counter + 1;
                        else
                            r_wrong_counter <= r_wrong_counter + 1;
                        end if;
                    end if;

                when s_delay =>
                    state <= s_delay;
                    r_delay_counter <= r_delay_counter + 1;
                    if r_delay_counter = 10_000 then
                        state <= next_state;
                        r_delay_counter <= 0;
                    end if;
                    

            end case;
            
            if (rst = '1') then
                state <= s_idle;
            end if;
        end if;
    end process;

    
end architecture;