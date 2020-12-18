library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity System_controls_and_flags is
    generic(
        Entity_address : in std_logic_vector(7 downto 0) := X"01"
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        CB_address  : in std_logic_vector(15 downto 0);
        CB_write    : in std_logic_vector(31 downto 0);
        CB_read     : out std_logic_vector(31 downto 0);
        
        i_flags_bus : in std_logic_vector(31 downto 0);
        o_control_bus: out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of System_controls_and_flags is
    signal r_control_bus : std_logic_vector(31 downto 0) := (others => '0');
begin
    o_control_bus <= r_control_bus;
    
    CB_p: process (clk, rst) is
    begin
        if rst = '1' then
            r_control_bus <= (others => '0');
        elsif rising_edge(clk) then
            if CB_address(7 downto 0) = Entity_address then
                if CB_address(15) = '0' then
                    CB_read <= i_flags_bus;
                else
                    if to_integer(unsigned(CB_write)) <= 31 then
                        r_control_bus(to_integer(unsigned(CB_write))) <= CB_address(14);                         
                    end if;                        
                end if;
            end if;
        end if;
    end process;

    
    
end architecture;