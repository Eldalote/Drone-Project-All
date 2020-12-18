library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity DShot_wrapper is
    generic(
        Main_clock_frequency: in natural := 100_000_000;
        Dshot_frequency     : in natural := 600
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        --- Data inputs to be summed --- 
        i_throttle_data         : in STD_LOGIC_VECTOR(10 downto 0);
        i_throttle_valid        : in STD_LOGIC;
        i_pitch_control_data    : in STD_LOGIC_VECTOR(11 downto 0);
        i_pitch_valid           : in STD_LOGIC;
        i_roll_control_data     : in STD_LOGIC_VECTOR(11 downto 0);
        i_roll_valid            : in STD_LOGIC;    
        i_heading_control_data  : in STD_LOGIC_VECTOR(11 downto 0);
        i_heading_valid         : in STD_LOGIC;
        
        --- Control signals --- 
        i_arming_sequence       : in STD_LOGIC;
        i_enable_output         : in STD_LOGIC;
        
        --- Output --- 
        o_Dshot_output          : out STD_LOGIC
    );
end entity;

architecture rtl of DShot_wrapper is
    signal r_DS_transmit_data       : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
    signal r_DS_transmit_valid      : STD_LOGIC := '0';
    signal w_DS_ready_for_data      : STD_LOGIC;
    signal r_int_throttle           : integer := 0;
    signal r_int_pitch_data         : integer := 0;
    signal r_int_roll_data          : integer := 0;
    signal r_int_heading_data       : integer := 0;
    signal r_int_total_data         : integer := 0;
    
    type Tstate is (s_idle, s_arming, s_adding_throttle, s_adding_roll, s_adding_pitch, s_adding_heading, s_limiting, s_sending);
    signal state                    : Tstate := s_idle;
    
begin
    Dshot_module_inst: entity work.Dshot_module
        generic map (
            Main_clock_frequency => Main_clock_frequency,
            Dshot_frequency      => Dshot_frequency
        )
        port map (
            clk                  => clk,
            rst                  => rst,
            i_transmit_data      => r_DS_transmit_data,
            i_telemetry_request  => '0',
            i_transmit_valid     => r_DS_transmit_valid,
            o_Dshot_output       => o_Dshot_output,
            o_ready_for_data     => w_DS_ready_for_data
        );
    
    Data_acq_p: process (clk) is
    begin
        if rising_edge(clk) then
            if (i_throttle_valid = '1') then
                r_int_throttle <= to_integer(unsigned(i_throttle_data));
            end if;
            if (i_pitch_valid = '1') then
                r_int_pitch_data <= to_integer(signed(i_pitch_control_data));
            end if;
            if (i_roll_valid = '1') then
                r_int_roll_data <= to_integer(signed(i_roll_control_data));
            end if;
            if (i_heading_valid = '1') then
                r_int_heading_data <= TO_INTEGER(signed(i_heading_control_data));
            end if;
            if rst = '1' then
            end if;
        end if;
    end process;

    State_p: process (clk) is
    begin
        if rising_edge(clk) then
            r_DS_transmit_data <= (others => '0'); --Default
            r_DS_transmit_valid <= '0'; --Default
            case state is
                when s_idle =>
                    state <= s_idle;
                    if (i_arming_sequence = '1') then
                        state <= s_arming;
                    elsif (i_enable_output = '1' and w_DS_ready_for_data = '1') then
                        state <= s_adding_throttle;
                    end if;

                when s_arming =>
                    if (i_arming_sequence = '1') then
                        state <= s_arming;
                        if (w_DS_ready_for_data = '1') then
                            r_DS_transmit_data <= (others => '0');
                            r_DS_transmit_valid <= '1';
                        end if;
                    else
                        state <= s_idle;
                    end if;

                when s_adding_throttle =>
                    state <= s_adding_roll;
                    r_int_total_data <= r_int_throttle;

                when s_adding_roll =>
                    state <= s_adding_pitch;
                    r_int_total_data <= r_int_total_data + r_int_roll_data;

                when s_adding_pitch =>
                    state <= s_adding_heading;
                    r_int_total_data <= r_int_total_data + r_int_pitch_data;

                when s_adding_heading =>
                    state <= s_limiting;
                    r_int_total_data <= r_int_total_data + r_int_heading_data;

                when s_limiting =>
                    state <= s_sending;
                    if (r_int_total_data < 1) then
                        r_int_total_data <= 48;
                    elsif r_int_total_data > 2000 then
                        r_int_total_data <= 2047;
                    else
                        r_int_total_data <= r_int_total_data + 47;
                    end if;

                when s_sending =>
                    state <= s_idle;
                    r_DS_transmit_data <= STD_LOGIC_VECTOR(to_unsigned(r_int_total_data, 11));
                    r_DS_transmit_valid <= '1';

            end case;
            if rst = '1' then
            end if;
        end if;
    end process;


    
end architecture;