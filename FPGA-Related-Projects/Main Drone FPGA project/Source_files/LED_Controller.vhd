-- Simple LEDs controller for the cpu com bus.
-- created on 26-06-2019 by Jan Mart Liewes
-- verified by testbench on 26-06-2019


library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity LED_Controller is
    generic (
        Address : std_logic_vector(7 downto 0)
    );
    port (
        clk             : in std_logic;
        rst             : in std_logic;
        CB_address      : in std_logic_vector(15 downto 0);
        CB_write        : in std_logic_vector(31 downto 0);
        CB_read         : out std_logic_vector(31 downto 0);
        LED_Out         : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of LED_Controller is
    signal r_LEDs : std_logic_vector(7 downto 0) := X"00";
    
    
begin
    
    CPU_operation_p: process (clk, rst) is
    begin
        if rst = '1' then
            r_LEDs <= (others => '0') ;           
            CB_read <= (others => '0');
        elsif rising_edge(clk) then
            if CB_address(7 downto 0) = Address then
                CB_read <= X"000000" & r_LEDs;                
                if CB_address(15) = '1' then
                  r_LEDs <= CB_write(7 downto 0);                   
                end if;
            else
                CB_read <= (others => '0');
            end if;            
        end if;
    end process;
    
    LED_out <= r_LEDs;
    
    
end architecture;