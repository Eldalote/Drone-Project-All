--Super simple com bus output block. No feedback, just output.
-- Created on 23-08-2019 by Jan Mart Liewes

library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Com_bus_output is
    generic( 
        Entity_address : in std_logic_vector(7 downto 0) := X"f1";
        output_width : in natural := 32
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        CB_address  : in std_logic_vector(15 downto 0);
        CB_write    : in std_logic_vector(31 downto 0);
        
        CB_output   : out std_logic_vector(output_width -1 downto 0);
        CB_output_valid : out STD_LOGIC
       
       
    );
end entity;

architecture rtl of Com_bus_output is
    signal r_CB_output : std_logic_vector(31 downto 0);
begin
    
    CB_output <= r_CB_output(output_width -1 downto 0);
    
    CB_p: process (clk, rst) is
    begin
        if rst = '1' then
            r_CB_output <= (others => '0');
        elsif rising_edge(clk) then
            CB_output_valid <= '0';
            if CB_address(15) = '1' and CB_address(7 downto 0) = Entity_address then
                r_CB_output <= CB_write;
                CB_output_valid <= '1';
            end if;
        end if;
    end process;

end architecture;