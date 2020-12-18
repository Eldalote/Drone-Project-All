library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Com_bus_read_mux is
    port (
        clk             : in  std_logic;
        rst             : in  std_logic;
        
        CB_address      : in std_logic_vector(15 downto 0);
        CB_read_out     : out std_logic_vector(31 downto 0);
        CB_read_in_1    : in std_logic_vector(31 downto 0);
        CB_read_in_2    : in std_logic_vector(31 downto 0);
        CB_read_in_3    : in std_logic_vector(31 downto 0);
        CB_read_in_4    : in std_logic_vector(31 downto 0);
        CB_read_in_5    : in std_logic_vector(31 downto 0);
        CB_read_in_6    : in std_logic_vector(31 downto 0);
        CB_read_in_7    : in std_logic_vector(31 downto 0);
        CB_read_in_8    : in std_logic_vector(31 downto 0)
        
    );
end entity;

architecture rtl of Com_bus_read_mux is
    signal r_address : std_logic_vector(7 downto 0) := x"00";
begin
    
    with r_address select
    CB_read_out <=
        CB_read_in_1 when x"01",
        CB_read_in_2 when x"02",
        CB_read_in_3 when x"03",
        CB_read_in_4 when x"04",
        CB_read_in_5 when x"05",
        CB_read_in_6 when x"06",
        CB_read_in_7 when x"07",
        CB_read_in_8 when x"08",
        X"00000000"  when others;
    
    
    
    
    get_address_p: process (clk, rst) is
    begin
        if rst = '1' then
            r_address <= X"00";
        elsif rising_edge(clk) then
            if CB_address = x"0000" then
                r_address <= r_address;
            else
                r_address <= CB_address(7 downto 0);
            end if;
        end if;
    end process;

end architecture;