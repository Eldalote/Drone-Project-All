library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;


--System to create a functional reset signal 
--Both a button press, and the pll-locked output are used as reset components.
--The system only releases the reset once there were 16 clock cycles without reset input.
-- Created 25-06-2019 by Jan Mart Liewes
-- Verified by tesbench on 25-06-2019 by Jan Mart Liewes

entity System_Reset_creator is
    port (
        clk             : in  std_logic;
        pll_locked      : in  std_logic;
        reset_button    : in std_logic;
        system_reset    : out std_logic;
        system_reset_n  : out std_logic
    );
end entity;

architecture rtl of System_Reset_creator is
    signal r_reset_counter : std_logic_vector(15 downto 0) := (others => '0');
begin
    
    my_process_sp: process (clk, reset_button, pll_locked) is
    begin
        if reset_button = '0' or pll_locked = '0' then
            r_reset_counter <= (others => '0');
        elsif rising_edge(clk) then
            r_reset_counter <= r_reset_counter(14 downto 0) & '1';           
        end if;
    end process;
    
    system_reset <= '0' when r_reset_counter(15) = '1' else
                    '1';
    system_reset_n <= '1' when r_reset_counter(15) = '1' else
                      '0';
    
    
end architecture;