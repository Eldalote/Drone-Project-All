-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Compound filter for the x and y axis: This compound filter is designed to work with the intangle angle system,
-- and with the ICM 20948, and BNO055 sensors.
-- Intangles means an angle system using the full integer range: int-max (2,147,483,647) equates to +180 degrees,
-- while int-min (-2,147,483,648) equates to -180 degrees.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- This compound filter uses the three angulators to calculate the correct intangle angles.
-- The three filters are split into two processes, 1 for the two x and y angles, and 1 for the heading.
-- a single multiplier is used, with an input mux, to reduce component usage.
--
--
-- X and Y angles process:
-- These filters rely on two inputs; the gyroscope and the accelerometer. The angulators receive the data from these sensors
-- at the same time. However, the gyroscope angulator is significantly faster, and it will be done first.
-- The Gyro delta is added to the running total, to create the new angle according to the gyroscope. (done for both)
-- The next step is to multiply the running total by the gyro factor (this is generally accepted around 98%)
-- The total of the two factors is 1024, and we divide the output by 1024 (10 bits), to get the desired percentage multiplication.
-- Once the two gyro factors have been calculated, the statemachine waits for the accelerometer angulator data.
-- During this waiting period, the multiplier is released for the other process to use.
-- Once the accelerometer angulator is done, the results from that are multiplied with the corresponding factor too.
-- The two multiplication results are added together (making the full 1024 (100%) ) and outputted as the correct angle.
--
--
-- Heading process:
-- The heading process is fairly similar to the XY process. It only calculates one axis, and uses the BNO input in stead of the 
-- accelerometer. The other difference is that it waits to do it's calculations until the XY process is waiting for
-- the accelerometer data. It is done with the multiplier well before the other process needs it again.
--
--
-- CB process:
-- Via the com bus the CPU can set the ratios of the two processes. It is also possible to read the internal data of the 
-- function block via the com bus. (to do)
--
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Verified by testbench, created and tested by Jan Mart Liewes
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Compound_filter is
    generic (
        entity_address  : in STD_LOGIC_VECTOR(7 downto 0) := X"09"
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        CB_address              : in STD_LOGIC_VECTOR(15 downto 0);
        CB_write                : in STD_LOGIC_VECTOR(31 downto 0);
        CBR_compound_filter     : out STD_LOGIC_VECTOR(31 downto 0);
        
        i_ACC_GYRO_valid        : in STD_LOGIC;
        i_ACC_x                 : in STD_LOGIC_VECTOR(15 downto 0);
        i_ACC_y                 : in STD_LOGIC_VECTOR(15 downto 0);
        i_ACC_z                 : in STD_LOGIC_VECTOR(15 downto 0);
        i_GYRO_x                : in STD_LOGIC_VECTOR(15 downto 0);
        i_GYRO_y                : in STD_LOGIC_VECTOR(15 downto 0);
        i_GYRO_z                : in STD_LOGIC_VECTOR(15 downto 0);
        
        i_BNO_valid             : in STD_LOGIC;
        i_BNO_heading           : in STD_LOGIC_VECTOR(15 downto 0);
        
        o_compounded_intangle_x         : out STD_LOGIC_VECTOR(31 downto 0);
        o_compounded_intangle_y         : out STD_LOGIC_VECTOR(31 downto 0);        
        o_compounded_XY_valid           : out STD_LOGIC;
        o_compounded_intangle_heading   : out STD_LOGIC_VECTOR(31 downto 0);
        o_compounded_heading_valid      : out STD_LOGIC
    );
end entity;

architecture rtl of Compound_filter is
    -- Angulator Wires
    signal w_acc_IA_x               : STD_LOGIC_VECTOR(31 downto 0);
    signal w_acc_IA_y               : STD_LOGIC_VECTOR(31 downto 0);
    signal w_acc_IA_valid           : STD_LOGIC;
    signal w_gyro_IA_x              : STD_LOGIC_VECTOR(31 downto 0);
    signal w_gyro_IA_y              : STD_LOGIC_VECTOR(31 downto 0);
    signal w_gyro_IA_z              : STD_LOGIC_VECTOR(31 downto 0);
    signal w_gyro_IA_valid          : STD_LOGIC;
    signal w_heading_IA             : STD_LOGIC_VECTOR(31 downto 0);
    signal w_heading_IA_valid       : STD_LOGIC;
    -- Com bus related registers
    signal r_XY_GYRO_ratio          : integer range 0 to 1023 := 1000;
    signal r_XY_ACC_ratio           : integer range 0 to 1023 := 24;
    signal r_heading_GYRO_ratio     : integer range 0 to 1023 := 800;
    signal r_heading_BNO_ratio      : integer range 0 to 1023 := 224;
    -- Processing flags    
    signal r_heading_to_process     : STD_LOGIC := '0';
    -- Intermediate storage registers
    signal r_ACC_IA_x               : signed(31 downto 0) := (others => '0');
    signal r_ACC_IA_y               : signed(31 downto 0) := (others => '0');
    signal r_GYRO_delta_IA_x        : signed(31 downto 0) := (others => '0');
    signal r_GYRO_delta_IA_y        : signed(31 downto 0) := (others => '0');
    signal r_GYRO_delta_IA_z        : signed(31 downto 0) := (others => '0');
    signal r_BNO_heading_IA         : signed(31 downto 0) := (others => '0');
    signal r_running_total_x        : signed(31 downto 0) := (others => '0');
    signal r_running_total_y        : signed(31 downto 0) := (others => '0');
    signal r_running_total_heading  : signed(31 downto 0) := (others => '0');
    signal r_BNO_multiplied         : signed(31 downto 0) := (others => '0');
    signal r_acc_multiplied_x       : signed(31 downto 0) := (others => '0');
    signal r_acc_multiplied_y       : signed(31 downto 0) := (others => '0');
    
    signal r_compounded_x           : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal r_compounded_y           : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal r_compounded_heading     : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    
    -- States
    Type Tstate_XY is (s_idle, s_multiply_running_x, s_multiply_running_y, s_get_multiply_ry, s_wait_for_acc, s_Multiply_acc_y,
                        s_get_multiply_acc_y, s_add_together, s_output);
    Type Tstate_heading is (s_idle, s_wait_for_multiplier_free, s_multiply_running, s_get_multiply, s_add_together, s_output);
    signal state_XY                 : Tstate_XY := s_idle;
    signal state_heading            : Tstate_heading := s_idle;
    -- Multiplier
    signal r_multiplier_in          : signed(31 downto 0) := (others => '0');
    signal r_multiplier_factor      : signed(10 downto 0) := (others => '0');
    signal r_multiplier_in_XY       : signed(31 downto 0) := (others => '0');
    signal r_multiplier_factor_XY   : signed(10 downto 0) := (others => '0');
    signal r_multiplier_in_heading  : signed(31 downto 0) := (others => '0');
    signal r_multiplier_factor_heading : signed(10 downto 0) := (others => '0');
    signal r_using_mult_XY          : STD_LOGIC := '0';
    signal r_using_mult_heading     : STD_LOGIC := '0';
    signal w_multiplier_out         : signed(42 downto 0);
    
    
begin    
    
    o_compounded_intangle_x <= r_compounded_x;
    o_compounded_intangle_y <= r_compounded_y;
    o_compounded_intangle_heading <= r_compounded_heading;
    
    w_multiplier_out <= r_multiplier_in * r_multiplier_factor; --Should infer multiplier.
    
    r_multiplier_in <= r_multiplier_in_XY when r_using_mult_XY = '1' else 
                       r_multiplier_in_heading when r_using_mult_heading = '1' else
                       (others => '0');
    r_multiplier_factor <= r_multiplier_factor_XY when r_using_mult_XY = '1' else
                           r_multiplier_factor_heading when r_using_mult_heading = '1' else
                           (others => '0');
    
    Acc_angulator_inst: entity work.Acc_angulator
        port map (
            clk                  => clk,
            rst                  => rst,
            i_acc_x              => i_ACC_x,
            i_acc_y              => i_ACC_y,
            i_acc_z              => i_ACC_z,
            i_acc_valid          => i_ACC_GYRO_valid,
            o_acc_intangle_x     => w_acc_IA_x,
            o_acc_intangle_y     => w_acc_IA_y,
            o_acc_intangle_valid => w_acc_IA_valid
        );
    Gyro_angulator_inst: entity work.Gyro_angulator
        port map (
            clk                   => clk,
            rst                   => rst,
            i_gyro_x              => i_GYRO_x,
            i_gyro_y              => i_GYRO_y,
            i_gyro_z              => i_GYRO_z,
            i_gyro_valid          => i_ACC_GYRO_valid,
            o_gyro_intangle_x     => w_gyro_IA_x,
            o_gyro_intangle_y     => w_gyro_IA_y,
            o_gyro_intangle_z     => w_gyro_IA_z,
            o_gyro_intangle_valid => w_gyro_IA_valid
        );
    BNO_angulator_inst: entity work.BNO_angulator
        port map (
            clk                => clk,
            rst                => rst,
            i_BNO_heading      => i_BNO_heading,
            i_BNO_valid        => i_BNO_valid,
            o_heading_intangle => w_heading_IA,
            o_heading_valid    => w_heading_IA_valid
        );

    CB_process: process (clk) is
    begin
        if rising_edge(clk) then
            CBR_compound_filter <= (others => '0'); --Default.
            if CB_address(7 downto 0) = entity_address then
                if CB_address(15) = '1' then --Write
                    if CB_address(11 downto 8) = X"0" then
                        if to_integer(unsigned(CB_write(9 downto 0))) > 0 then                  -- Each ration should be at least 1.             
                            r_XY_GYRO_ratio <= to_integer(unsigned(CB_write(9 downto 0)));      -- Set the GYRO ratio
                            r_XY_ACC_ratio <= 1024 - to_integer(unsigned(CB_write(9 downto 0)));-- Calculate the ACC ratio. 
                                                                                --Due to logical limits, will be at least 1, max 1023
                        end if;
                    elsif CB_address(11 downto 8) = X"1" then
                        if to_integer(unsigned(CB_write(9 downto 0))) > 0 then                            
                            r_heading_GYRO_ratio <= to_integer(unsigned(CB_write(9 downto 0)));
                            r_heading_BNO_ratio <= 1024 - to_integer(unsigned(CB_write(9 downto 0)));
                        end if;
                    end if;
                else 
                    case CB_address(11 downto 8) is
                        when X"1" =>
                            CBR_compound_filter <= r_compounded_x; 

                        when X"2" =>
                            CBR_compound_filter <= r_compounded_y; 

                        when X"3" =>
                            CBR_compound_filter <= r_compounded_heading;                       

                        when others =>
                            
                    end case;
                    
                end if;
            end if;    
            if rst = '1' then
                CBR_compound_filter <= (others => '0');
            end if;
        end if;
    end process;

    Filter_XY_P: process (clk) is
    begin
        if rising_edge(clk) then
            o_compounded_XY_valid <= '0'; --Default
            r_using_mult_XY <= '0'; --Default
            case state_XY is
                when s_idle =>
                    state_XY <= s_idle;
                    if w_gyro_IA_valid = '1' then
                        r_GYRO_delta_IA_x <= signed(w_gyro_IA_x);
                        r_GYRO_delta_IA_y <= signed(w_gyro_IA_y);
                        r_running_total_x <= r_running_total_x + signed(w_gyro_IA_x);
                        r_running_total_y <= r_running_total_y + signed(w_gyro_IA_y);
                        state_XY <= s_multiply_running_x;
                    end if;

                when s_multiply_running_x =>
                    state_XY <= s_multiply_running_y;
                    r_multiplier_factor_XY <= to_signed(r_XY_GYRO_ratio, 11);
                    r_multiplier_in_XY <= r_running_total_x;
                    r_using_mult_XY <= '1';

                when s_multiply_running_y =>
                    state_XY <= s_get_multiply_ry;
                    r_running_total_x <= w_multiplier_out(42) & w_multiplier_out(40 downto 10);
                    r_multiplier_factor_XY <= to_signed(r_XY_GYRO_ratio,11);
                    r_multiplier_in_XY <= r_running_total_y;
                    r_using_mult_XY <= '1';

                when s_get_multiply_ry =>
                    state_XY <= s_wait_for_acc;
                    r_running_total_y <= w_multiplier_out(42) & w_multiplier_out(40 downto 10);

                when s_wait_for_acc =>
                    state_XY <= s_wait_for_acc;
                    if w_acc_IA_valid = '1' then
                        r_ACC_IA_x <= signed(w_acc_IA_x);
                        r_ACC_IA_y <= signed(w_acc_IA_y);
                        r_multiplier_factor_XY <= to_signed(r_XY_ACC_ratio,11);
                        r_multiplier_in_XY <= signed(w_acc_IA_x);
                        r_using_mult_XY <= '1';
                        state_XY <= s_Multiply_acc_y;
                    end if;

                when s_Multiply_acc_y =>
                    state_XY <= s_get_multiply_acc_y;
                    r_acc_multiplied_x <= w_multiplier_out(42) & w_multiplier_out(40 downto 10);
                    r_multiplier_factor_XY <= to_signed(r_XY_ACC_ratio,11);
                    r_multiplier_in_XY <= r_ACC_IA_y;
                    r_using_mult_XY <= '1';

                when s_get_multiply_acc_y =>
                    r_acc_multiplied_y <= w_multiplier_out(42) & w_multiplier_out(40 downto 10);
                    state_XY <= s_add_together;

                when s_add_together =>
                    state_XY <= s_output;
                    r_running_total_x <= r_running_total_x + r_acc_multiplied_x;
                    r_running_total_y <= r_running_total_y + r_acc_multiplied_y;

                when s_output =>
                    state_XY <= s_idle;
                    o_compounded_XY_valid <= '1';
                    r_compounded_x <= STD_LOGIC_VECTOR(r_running_total_x);
                    r_compounded_y <= STD_LOGIC_VECTOR(r_running_total_y);

            end case;
            if rst = '1' then
                r_compounded_x <= (others => '0');
                r_compounded_y <= (others => '0');
                o_compounded_XY_valid <= '0';
            end if;
        end if;
    end process;

    Filter_Heading_p: process (clk) is
    begin
        if rising_edge(clk) then
            o_compounded_heading_valid <= '0'; -- Default
            r_using_mult_heading <= '0'; --default
            case state_heading is
                when s_idle =>
                    state_heading <= s_idle;
                    if w_gyro_IA_valid = '1' then
                        r_GYRO_delta_IA_z <= signed(w_gyro_IA_z);
                        r_running_total_heading <= r_running_total_heading + signed(w_gyro_IA_z);
                        if r_heading_to_process = '1' then
                            state_heading <= s_wait_for_multiplier_free;  
                        else
                            state_heading <= s_output;
                        end if;
                    end if;
                    
                when s_wait_for_multiplier_free => 
                    state_heading <= s_wait_for_multiplier_free;
                    if state_XY = s_wait_for_acc then
                        state_heading <= s_multiply_running;
                        r_multiplier_factor_heading <= to_signed(r_heading_BNO_ratio, 11);
                        r_multiplier_in_heading <= r_BNO_heading_IA;
                        r_using_mult_heading <= '1';
                    end if;

                when s_multiply_running =>
                    state_heading <= s_get_multiply;
                    r_BNO_multiplied <= w_multiplier_out(42) & w_multiplier_out(40 downto 10);
                    r_multiplier_factor_heading <= to_signed(r_heading_GYRO_ratio, 11);
                    r_multiplier_in_heading <= r_running_total_heading;
                    r_using_mult_heading <= '1';
                    
                when s_get_multiply =>
                    state_heading <= s_add_together;
                    r_running_total_heading <= w_multiplier_out(42) & w_multiplier_out(40 downto 10);

                when s_add_together =>
                    state_heading <= s_output;
                    r_running_total_heading <= r_running_total_heading + r_BNO_multiplied;

                when s_output =>
                    state_heading <= s_idle;
                    o_compounded_heading_valid <= '1';
                    r_compounded_heading <= STD_LOGIC_VECTOR(r_running_total_heading);
                    
            end case;
            if rst = '1' then
                o_compounded_heading_valid <= '0';
                r_compounded_heading <= (others => '0');
            end if;
        end if;
    end process;

    Get_BNO_Data_P: process (clk) is
    begin
        if rising_edge(clk) then
            if w_heading_IA_valid = '1' then --When a new BNO dataset has been processed, store data and set flag
                r_BNO_heading_IA <= signed(w_heading_IA);
                r_heading_to_process <= '1';
            elsif state_heading = s_multiply_running then -- When processing of BNO started, and no new data is ready 
                                                                --at the same time
                r_heading_to_process <= '0'; --Clear the flag
            end if;
            if rst = '1' then
                r_heading_to_process <= '0';
                r_BNO_heading_IA <= (others => '0');
            end if;
        end if;
    end process;


end architecture;