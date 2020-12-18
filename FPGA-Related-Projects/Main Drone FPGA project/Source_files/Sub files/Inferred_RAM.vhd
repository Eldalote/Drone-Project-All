library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Inferred_RAM is
    generic(
        ADDRESS_RANGE   : in natural := 1024;
        MEMORY_WIDTH    : in natural := 32
    );
    port (
        clk: in  std_logic;
        i_write_data    : in STD_LOGIC_VECTOR(MEMORY_WIDTH -1 downto 0);
        o_read_data     : out STD_LOGIC_VECTOR(MEMORY_WIDTH -1 downto 0);
        i_write_enable  : in STD_LOGIC;
        i_write_address : in integer range 0 to ADDRESS_RANGE -1;
        i_read_address  : in integer range 0 to ADDRESS_RANGE -1
    );
end entity;

architecture rtl of Inferred_RAM is
    type TMem is array(0 to ADDRESS_RANGE -1) of STD_LOGIC_VECTOR(MEMORY_WIDTH-1 downto 0);
    signal mem  : Tmem := (others => (others => '0'));
begin
    my_process_sp: process (clk) is
    begin
        if rising_edge(clk) then
            if i_write_enable = '1' then
                mem(i_write_address) <= i_write_data;
            end if;
            o_read_data <= mem(i_read_address);      
        end if;
    end process;

end architecture;