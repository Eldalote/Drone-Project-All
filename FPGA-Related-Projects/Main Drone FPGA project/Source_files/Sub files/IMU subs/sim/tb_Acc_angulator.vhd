library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library std;
    use std.textio.all;

entity tb_Acc_angulator is
end entity;

architecture rtl_sim of tb_Acc_angulator is
    constant CLK_PERIOD: time := 10 ns;
    constant RST_HOLD_DURATION: time := 50 ns;
    signal clk: std_logic;
    signal rst: std_logic;
    signal i_acc_x: STD_LOGIC_VECTOR(15 downto 0);
    signal i_acc_y: STD_LOGIC_VECTOR(15 downto 0);
    signal i_acc_z: STD_LOGIC_VECTOR(15 downto 0);
    signal i_acc_valid: STD_LOGIC;
    signal o_acc_intangle_x: STD_LOGIC_VECTOR(31 downto 0);
    signal o_acc_intangle_y: STD_LOGIC_VECTOR(31 downto 0);
    signal o_acc_intangle_valid: STD_LOGIC;
    signal f_x      : real;
    signal f_y      : real;    
begin
    
    f_x <= real(to_integer(signed(o_acc_intangle_x))) * 180.0 / 2147483647.0;
    f_y <= real(to_integer(signed(o_acc_intangle_y))) * 180.0 / 2147483647.0;
    
    stimuli_p: process is
    begin
        i_acc_valid <= '0';
        i_acc_x <= (others => '0');
        i_acc_y <= (others => '0');
        i_acc_z <= (others => '0');
        wait for 70 ns;
        wait until rising_edge(clk);
        i_acc_x <= STD_LOGIC_VECTOR(to_signed(1600, 16));
        i_acc_y <= STD_LOGIC_VECTOR(to_signed(1600, 16));
        i_acc_z <= STD_LOGIC_VECTOR(to_signed(1600, 16));
        i_acc_valid <= '1';
        wait until rising_edge(clk);
        i_acc_valid <= '0';
       
        
        wait;
    end process;

    Acc_angulator_inst: entity work.Acc_angulator
        port map (
            clk                  => clk,
            rst                  => rst,
            i_acc_x              => i_acc_x,
            i_acc_y              => i_acc_y,
            i_acc_z              => i_acc_z,
            i_acc_valid          => i_acc_valid,
            o_acc_intangle_x     => o_acc_intangle_x,
            o_acc_intangle_y     => o_acc_intangle_y,
            o_acc_intangle_valid => o_acc_intangle_valid
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