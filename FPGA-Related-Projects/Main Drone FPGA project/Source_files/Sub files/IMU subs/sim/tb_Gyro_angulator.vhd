library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library std;
    use std.textio.all;

entity tb_Gyro_angulator is
end entity;

architecture rtl_sim of tb_Gyro_angulator is
    constant CLK_PERIOD: time := 10 ns;
    constant RST_HOLD_DURATION: time := 50 ns;
    signal clk: std_logic;
    signal rst: std_logic;
    signal i_gyro_x: STD_LOGIC_VECTOR(15 downto 0);
    signal i_gyro_y: STD_LOGIC_VECTOR(15 downto 0);
    signal i_gyro_z: STD_LOGIC_VECTOR(15 downto 0);
    signal i_gyro_valid: STD_LOGIC;
    signal o_gyro_intangle_x: STD_LOGIC_VECTOR(31 downto 0);
    signal o_gyro_intangle_y: STD_LOGIC_VECTOR(31 downto 0);
    signal o_gyro_intangle_z: STD_LOGIC_VECTOR(31 downto 0);
    signal o_gyro_intangle_valid: STD_LOGIC;
    signal f_x      : real;
    signal f_y      : real;    
    signal f_z      : real;
begin
    f_x <= real(to_integer(signed(o_gyro_intangle_x))) * 180.0 / 2147483647.0;
    f_y <= real(to_integer(signed(o_gyro_intangle_y))) * 180.0 / 2147483647.0;
    f_z <= real(to_integer(signed(o_gyro_intangle_z))) * 180.0 / 2147483647.0;
    
    
    stimuli_p: process is
    begin
        
        i_gyro_valid <= '0';
        i_gyro_x <= (others => '0');
        i_gyro_y <= (others => '0');
        i_gyro_z <= (others => '0');
        wait for 70 ns;
        wait until rising_edge(clk);
        i_gyro_x <= STD_LOGIC_VECTOR(to_signed(-32768, 16));
        i_gyro_y <= STD_LOGIC_VECTOR(to_signed(16384, 16));
        i_gyro_z <= STD_LOGIC_VECTOR(to_signed(-8192, 16));
        i_gyro_valid <= '1';
        wait until rising_edge(clk);
        i_gyro_valid <= '0';
        wait;
    end process;

    Gyro_angulator_inst: entity work.Gyro_angulator
        port map (
            clk                   => clk,
            rst                   => rst,
            i_gyro_x              => i_gyro_x,
            i_gyro_y              => i_gyro_y,
            i_gyro_z              => i_gyro_z,
            i_gyro_valid          => i_gyro_valid,
            o_gyro_intangle_x     => o_gyro_intangle_x,
            o_gyro_intangle_y     => o_gyro_intangle_y,
            o_gyro_intangle_z     => o_gyro_intangle_z,
            o_gyro_intangle_valid => o_gyro_intangle_valid
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