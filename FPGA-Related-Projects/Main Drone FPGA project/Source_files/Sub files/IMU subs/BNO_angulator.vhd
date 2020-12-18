-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Angulators: Calculating the usable angle from the inputs.
-- All angulators output the same integer range angle data.
-- This means: int-max (2,147,483,647) equates to +180 degrees,
-- while int-min (-2,147,483,648) equates to -180 degrees.
-- This is called intangle internally.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- BNO055 heading angulator: This calculates the intangle from the heading output of the BNO055.
-- The BNO ouputs the heading in a 0-360 degree format, with 16 LSB per degree.
-- Meaning we can treat is as a unsigned number, with 5760 as the maximum output. this is 13 bits long.
-- To get the desired intangle range, we multiply the input with 745654. (Again, we actually multiply by half that, and add '0')
-- This results in a unsigned 33 bit number, and we drop the MSB, since this should always be '0'.
-- The result is such that if we treat the output as a signed number, it rolls over perfectly,
-- meaning that at the input of  > 180 degrees, it rolls over to int-min. 0 to 180 input corresponds to output 0 to 180 
-- while input 180 to 360 corresponds to -180 to 0, as it should be.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Verified by testbench, created and tested by Jan Mart Liewes
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity BNO_angulator is
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        i_BNO_heading   : in STD_LOGIC_VECTOR(15 downto 0);
        i_BNO_valid     : in STD_LOGIC;
        
        o_heading_intangle  : out STD_LOGIC_VECTOR(31 downto 0);
        o_heading_valid     : out STD_LOGIC
    );
end entity;

architecture rtl of BNO_angulator is
    type Tstate is (s_idle, s_output);
    signal state    : Tstate := s_idle;
    signal r_mult_out   : unsigned(31 downto 0) := (others => '0');
begin
    
    state_p: process (clk) is
    begin
        if rising_edge(clk) then
            o_heading_valid <= '0'; --Default
            case state is
                when s_idle =>
                    state <= s_idle; --Default
                    if i_BNO_valid = '1' then
                        state <= s_output;
                        r_mult_out <= unsigned(i_BNO_heading(12 downto 0)) * to_unsigned(372827, 19);
                    end if;

                when s_output =>
                    o_heading_intangle <= STD_LOGIC_VECTOR(r_mult_out(30 downto 0) & '0');
                    o_heading_valid <= '1';
                    state <= s_idle;

            end case;
            
            
            if rst = '1' then
                o_heading_valid <= '0';
                o_heading_intangle <= (others => '0');
            end if;
        end if;
    end process;

    
end architecture;