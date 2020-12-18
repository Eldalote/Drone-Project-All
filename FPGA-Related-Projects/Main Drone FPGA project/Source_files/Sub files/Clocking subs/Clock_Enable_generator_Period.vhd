-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Clock enable signal generator, based on periods
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Logic generated clocks should not be used as actual clocks in FPGAs.
-- Use a clock enable generator instead. This generates a '1' on the "rising edge" of the desired clock, '0' anywhere else
-- Please be aware that asking for a period that is not a neat multiplication of the main clock will result in a different actual period.
--
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Made by Jan Mart Liewes
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity ClockEnableGenerator_Period is

    generic (
        MAIN_CLOCK_PERIOD     : in time := 10 ns;
        DESIRED_CLOCK_PERIOD  : in time := 100 ns
    );

    port (
        clk: in  std_logic;
        rst: in  std_logic;
        clock_enable_out: out std_logic

    );

end entity;

architecture rtl of ClockEnableGenerator_Period is
    constant COUNTINGTARGET: natural := DESIRED_CLOCK_PERIOD / MAIN_CLOCK_PERIOD;

    signal r_currentcount : integer range 0 to COUNTINGTARGET := 0;

begin


    generateClockEnable: process (clk, rst) is
    begin
        if rst = '1' then
            r_currentcount <= 0;
            clock_enable_out <= '0';
        elsif rising_edge(clk) then
            if r_currentcount = (COUNTINGTARGET -1) then
                clock_enable_out <= '1';
                r_currentcount <= 0;
            else
                clock_enable_out <= '0';
                r_currentcount <= r_currentcount + 1; 
            end if;
        end if;
    end process;

end architecture;