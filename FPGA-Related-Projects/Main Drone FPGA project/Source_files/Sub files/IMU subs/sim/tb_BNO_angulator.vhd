library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library std;
    use std.textio.all;

entity tb_BNO_angulator is
end entity;

architecture rtl_sim of tb_BNO_angulator is
    constant CLK_PERIOD: time := 10 ns;
    constant RST_HOLD_DURATION: time := 50 ns;
    signal clk: std_logic;
    signal rst: std_logic;
    signal i_BNO_heading: STD_LOGIC_VECTOR(15 downto 0);
    signal i_BNO_valid: STD_LOGIC;
    signal o_heading_intangle: STD_LOGIC_VECTOR(31 downto 0);
    signal o_heading_valid: STD_LOGIC;
    signal f_heading : real;
    signal heading_int : integer;
    
    procedure set_BNO(
        heading : in integer;
        
        signal i_BNO_heading    : out STD_LOGIC_VECTOR(15 downto 0);
        signal i_BNO_valid      : out STD_LOGIC
    ) is
    begin
        wait until rising_edge(clk);
        i_BNO_heading <= STD_LOGIC_VECTOR(to_signed(heading * 16, 16));
        i_BNO_valid <= '1';
        wait until rising_edge(clk);
        i_BNO_valid <= '0';
        wait for 40 ns;
    end procedure;
    
begin

    f_heading <= real(to_integer(signed(o_heading_intangle))) * 180.0 / 2147483647.0;
    
    stimuli_p: process is
    begin
        i_BNO_valid <= '0';
        i_BNO_heading <= (others => '0');
        heading_int <= 0;
        
        for ii in 0 to 361 loop
            set_BNO(ii, i_BNO_heading, i_BNO_valid);
            heading_int <= heading_int + 1;
        end loop;
        
        wait;
    end process;

    BNO_angulator_inst: entity work.BNO_angulator
        port map (
            clk                => clk,
            rst                => rst,
            i_BNO_heading      => i_BNO_heading,
            i_BNO_valid        => i_BNO_valid,
            o_heading_intangle => o_heading_intangle,
            o_heading_valid    => o_heading_valid
        );

    clock_p: process is
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    reset_p: process is
    begin
        rst <= '1';
        wait for RST_HOLD_DURATION;
        wait until rising_edge(clk);
        rst <= '0';
        wait;
    end process;
end architecture;