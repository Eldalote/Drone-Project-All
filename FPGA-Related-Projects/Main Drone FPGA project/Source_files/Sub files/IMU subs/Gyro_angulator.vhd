-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Angulators: Calculating the usable angle from the inputs.
-- All angulators output the same integer range angle data.
-- This means: int-max (2,147,483,647) equates to +180 degrees,
-- while int-min (-2,147,483,648) equates to -180 degrees.
-- This is called intangle internally.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Gyroscope anglulator: This calculates the change in angle over 1 sample, in intangle.
-- !!!Note: The calculations here-in assume a 9KSPS samplerate and 1000DPS max rate (32.8 LSB per DPS)!!!
-- Given that the maximum output is 1000 degrees per second, and we measure 9000 times a second, maximum output (32767)
-- corresponds to a change of 1/9 of a degree. A change of a whole degree would be an total input of 294903.
-- Multiplying the input by 40.555... results in the intangle range.
-- We will not be using floating point numbers, so in order to get close to the correct output, we will
-- multiply by 2589, and then divide by 64 (drop 6 bits).
-- We do this for all three axis. 
-- The resulting output is the changle in angle over the one sample, in intangle.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Verified by testbench, created and tested by Jan Mart Liewes
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Gyro_angulator is
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        
        i_gyro_x    : in STD_LOGIC_VECTOR(15 downto 0);
        i_gyro_y    : in STD_LOGIC_VECTOR(15 downto 0);
        i_gyro_z    : in STD_LOGIC_VECTOR(15 downto 0);
        i_gyro_valid: in STD_LOGIC;
        
        o_gyro_intangle_x   : out STD_LOGIC_VECTOR(31 downto 0);
        o_gyro_intangle_y   : out STD_LOGIC_VECTOR(31 downto 0);
        o_gyro_intangle_z   : out STD_LOGIC_VECTOR(31 downto 0);
        o_gyro_intangle_valid: out STD_LOGIC
        
    );
end entity;

architecture rtl of Gyro_angulator is
    
    signal r_multiplier_in  : signed(15 downto 0) := (others => '0');
    signal w_multiplier_out : signed(31 downto 0);
    signal r_gyro_in_y      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_gyro_in_z      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_gyro_intangle_x: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal r_gyro_intangle_y: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal r_gyro_intangle_z: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    
    type Tstate is (s_idle, s_calc_y, s_calc_z, s_hold, s_output);
    signal state : Tstate := s_idle;
    
    
begin
    
    w_multiplier_out <= r_multiplier_in * to_signed(2589, 16); --Inferring multiplier, multiplying by 2589.
    
    state_p: process (clk) is
    begin
        if rising_edge(clk) then
            o_gyro_intangle_valid <= '0'; --Default
            case state is
                when s_idle =>
                    state <= s_idle;
                    if i_gyro_valid = '1' then
                        state <= s_calc_y;
                        r_multiplier_in <= signed(i_gyro_x);
                        r_gyro_in_y <= i_gyro_y;
                        r_gyro_in_z <= i_gyro_z;
                    end if;

                when s_calc_y =>
                    state <= s_calc_z;
                    r_gyro_intangle_x <= STD_LOGIC_VECTOR(w_multiplier_out);
                    r_multiplier_in <= signed(r_gyro_in_y);

                when s_calc_z =>
                    state <= s_hold;
                    r_gyro_intangle_y <= STD_LOGIC_VECTOR(w_multiplier_out);
                    r_multiplier_in <= signed(r_gyro_in_z);

                when s_hold =>
                    r_gyro_intangle_z <= STD_LOGIC_VECTOR(w_multiplier_out);
                    state <= s_output;
                    
                when s_output =>
                    state <= s_idle;
                    o_gyro_intangle_valid <= '1';
                    if r_gyro_intangle_x(31) = '1' then
                        o_gyro_intangle_x <= r_gyro_intangle_x(31) & "111111" & r_gyro_intangle_x(30 downto 6); -- Divide by 64
                    else
                        o_gyro_intangle_x <= r_gyro_intangle_x(31) & "000000" & r_gyro_intangle_x(30 downto 6); -- Divide by 64
                    end if;
                    if r_gyro_intangle_y(31) = '1' then
                        o_gyro_intangle_y <= r_gyro_intangle_y(31) & "111111" & r_gyro_intangle_y(30 downto 6); -- Divide by 64
                    else
                        o_gyro_intangle_y <= r_gyro_intangle_y(31) & "000000" & r_gyro_intangle_y(30 downto 6); -- Divide by 64
                    end if;
                    if r_gyro_intangle_z(31) = '1' then
                        o_gyro_intangle_z <= r_gyro_intangle_z(31) & "111111" & r_gyro_intangle_z(30 downto 6); -- Divide by 64
                    else
                        o_gyro_intangle_z <= r_gyro_intangle_z(31) & "000000" & r_gyro_intangle_z(30 downto 6); -- Divide by 64
                    end if;
                    

            end case;
            
            
            if rst = '1' then
                o_gyro_intangle_valid <= '0';
                o_gyro_intangle_x <= (others => '0');
                o_gyro_intangle_y <= (others => '0');
                o_gyro_intangle_z <= (others => '0');
                state <= s_idle;
            end if;
        end if;
    end process;

    
end architecture;