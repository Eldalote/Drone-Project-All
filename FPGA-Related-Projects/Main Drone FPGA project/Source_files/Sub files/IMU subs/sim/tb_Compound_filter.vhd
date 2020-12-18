library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library std;
    use std.textio.all;

entity tb_Compound_filter is
end entity;

architecture rtl_sim of tb_Compound_filter is
    constant entity_address: STD_LOGIC_VECTOR(7 downto 0) := X"09";

    constant CLK_PERIOD: time := 10 ns;
    constant RST_HOLD_DURATION: time := 50 ns;
    signal clk: std_logic;
    signal rst: std_logic;
    signal CB_address: STD_LOGIC_VECTOR(15 downto 0);
    signal CB_write: STD_LOGIC_VECTOR(31 downto 0);
    signal CBR_compound_filter: STD_LOGIC_VECTOR(31 downto 0);
    signal i_ACC_GYRO_valid: STD_LOGIC;
    signal i_ACC_x: STD_LOGIC_VECTOR(15 downto 0);
    signal i_ACC_y: STD_LOGIC_VECTOR(15 downto 0);
    signal i_ACC_z: STD_LOGIC_VECTOR(15 downto 0);
    signal i_GYRO_x: STD_LOGIC_VECTOR(15 downto 0);
    signal i_GYRO_y: STD_LOGIC_VECTOR(15 downto 0);
    signal i_GYRO_z: STD_LOGIC_VECTOR(15 downto 0);
    signal i_BNO_valid: STD_LOGIC;
    signal i_BNO_heading: STD_LOGIC_VECTOR(15 downto 0);
    signal o_compounded_intangle_x: STD_LOGIC_VECTOR(31 downto 0);
    signal o_compounded_intangle_y: STD_LOGIC_VECTOR(31 downto 0);
    signal o_compounded_XY_valid: STD_LOGIC;
    signal o_compounded_intangle_heading: STD_LOGIC_VECTOR(31 downto 0);
    signal o_compounded_heading_valid: STD_LOGIC;
    signal f_x : real;
    signal f_y : real;
    signal f_h : real;
    
    procedure inputs(
        accx    : in integer;
        accy    : in integer;
        accz    : in integer;
        gyrox   : in integer;
        gyroy   : in integer;
        gyroz   : in integer;
        bno     : in integer;
        signal i_acc_x  : out STD_LOGIC_VECTOR(15 downto 0);
        signal i_acc_y  : out STD_LOGIC_VECTOR(15 downto 0);
        signal i_acc_z  : out STD_LOGIC_VECTOR(15 downto 0);
        signal i_acc_gyro_valid     : out STD_LOGIC;
        signal i_gyro_x : out STD_LOGIC_VECTOR(15 downto 0);
        signal i_gyro_y : out STD_LOGIC_VECTOR(15 downto 0);
        signal i_gyro_z : out STD_LOGIC_VECTOR(15 downto 0);
        signal i_bno_heading    : out STD_LOGIC_VECTOR(15 downto 0);
        signal i_bno_valid      : out STD_LOGIC
    ) is
    begin
        wait until rising_edge(clk);
        i_acc_x <= STD_LOGIC_VECTOR(to_signed(accx, 16));
        i_acc_y <= STD_LOGIC_VECTOR(to_signed(accy, 16));
        i_acc_z <= STD_LOGIC_VECTOR(to_signed(accz, 16));
        i_gyro_x <= STD_LOGIC_VECTOR(to_signed(gyrox, 16));
        i_gyro_y <= STD_LOGIC_VECTOR(to_signed(gyroy, 16));
        i_gyro_z <= STD_LOGIC_VECTOR(to_signed(gyroz, 16));
        i_bno_heading <= STD_LOGIC_VECTOR(to_signed(bno, 16));
        i_acc_gyro_valid <= '1';
        i_bno_valid <= '1';
        wait until rising_edge(clk);
        i_acc_gyro_valid <= '0';
        i_bno_valid <= '0';
        
        wait for 400 ns;
        

    end procedure;
        
        
    
begin
    f_x <= real(to_integer(signed(o_compounded_intangle_x))) * 180.0 / 2147483647.0;
    f_y <= real(to_integer(signed(o_compounded_intangle_y))) * 180.0 / 2147483647.0;
    f_h <= real(to_integer(signed(o_compounded_intangle_heading))) * 180.0 / 2147483647.0;

    stimuli_p: process is
    begin
        CB_address <= (others => '0');
        CB_write <= (others => '0');
        i_ACC_GYRO_valid <= '0';
        i_ACC_x <= (others => '0');
        i_ACC_y <= (others => '0');
        i_ACC_z <= (others => '0');
        i_BNO_heading <= (others => '0');
        i_BNO_valid <= '0';
        i_GYRO_x <= (others => '0');
        i_GYRO_y <= (others => '0');
        i_GYRO_z <= (others => '0');
        
        wait for 60 ns;
        inputs(120, 0, 120, 50, 3, 5, 76, 
               i_acc_x, i_acc_y, i_acc_z, i_acc_gyro_valid, i_gyro_x, i_gyro_y, i_gyro_z, i_bno_heading, i_bno_valid);
        inputs(124, 0, 120, 50, 3, 5, 76, 
               i_acc_x, i_acc_y, i_acc_z, i_acc_gyro_valid, i_gyro_x, i_gyro_y, i_gyro_z, i_bno_heading, i_bno_valid);
        inputs(127, 0, 120, 50, 3, 5, 76, 
               i_acc_x, i_acc_y, i_acc_z, i_acc_gyro_valid, i_gyro_x, i_gyro_y, i_gyro_z, i_bno_heading, i_bno_valid);
        
        wait;
    end process;

    Compound_filter_inst: entity work.Compound_filter
        generic map (
            entity_address                => entity_address
        )
        port map (
            clk                           => clk,
            rst                           => rst,
            CB_address                    => CB_address,
            CB_write                      => CB_write,
            CBR_compound_filter           => CBR_compound_filter,
            i_ACC_GYRO_valid              => i_ACC_GYRO_valid,
            i_ACC_x                       => i_ACC_x,
            i_ACC_y                       => i_ACC_y,
            i_ACC_z                       => i_ACC_z,
            i_GYRO_x                      => i_GYRO_x,
            i_GYRO_y                      => i_GYRO_y,
            i_GYRO_z                      => i_GYRO_z,
            i_BNO_valid                   => i_BNO_valid,
            i_BNO_heading                 => i_BNO_heading,
            o_compounded_intangle_x       => o_compounded_intangle_x,
            o_compounded_intangle_y       => o_compounded_intangle_y,
            o_compounded_XY_valid         => o_compounded_XY_valid,
            o_compounded_intangle_heading => o_compounded_intangle_heading,
            o_compounded_heading_valid    => o_compounded_heading_valid
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