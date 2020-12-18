-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Clock enable signal generator, based on division
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Logic generated clocks should not be used as actual clocks in FPGAs.
-- Use a clock enable generator instead. This generates a '1' on the "rising edge" of the desired clock, '0' anywhere else
-- This will create a clock frequency that is a direct division of the main clock.
--
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Made by Jan Mart Liewes
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity ClockEnableGenerator is
    
    generic (
        DividerCount : in integer := 100
    );
    
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        clock_enable_out: out std_logic
                
    );
    
end entity;

architecture rtl of ClockEnableGenerator is
    
    signal r_currentcount : integer range 0 to DividerCount := 0;
    
begin
    
    
    generateClockEnable: process (clk, rst) is
    begin
        if rst = '1' then
            r_currentcount <= 0;
            clock_enable_out <= '0';
        elsif rising_edge(clk) then
            if r_currentcount = (DividerCount -1) then
                clock_enable_out <= '1';
                r_currentcount <= 0;
            else
                clock_enable_out <= '0';
                r_currentcount <= r_currentcount + 1; 
            end if;
        end if;
    end process;

end architecture;