-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Angulators: Calculating the usable angle from the inputs.
-- All angulators output the same integer range angle data.
-- This means: int-max (2,147,483,647) equates to +180 degrees,
-- while int-min (-2,147,483,648) equates to -180 degrees.
-- This is called intangle internally.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Accelerometer angulator: Calculates the usable x and y angles from the gravity vector.
-- The operation starts by calculating the pythagorean length of the combined z and (x/y) components.
-- This is done by taking the square root of z^2 + (x or y^)^2. A square root megafunction is used.
-- Then the arc-tan of (x, sqrt(z^2 + y^2))  and (y, sqrt(z^2 + x^2)) is calculated.
-- The pythagorean length is used rather than just z, because z is only usable if the other angle is 0
-- (The z changes too if the device is tilted in the other axis.)
-- The arc-tan output is in radians, and we want intangles, so we multiply the output with 83442,
-- to get the desired unit. 
-- in actuallity we multiply by 41721, and then add another '0' at the end, to get the same result.
-- The result of the multiplication is slightly to long, and we need to drop two bits to make it fit.
-- The 2nd and 3rd (bit 31 and 30) are always the same as the 1st (32) bit, due to the input limits,
-- so we can safely drop them. The arc-tan should never output a value that would make this a problem.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Verified by testbench, created and tested by Jan Mart Liewes
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Acc_angulator is
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        i_acc_x     : in STD_LOGIC_VECTOR(15 downto 0);
        i_acc_y     : in STD_LOGIC_VECTOR(15 downto 0);
        i_acc_z     : in STD_LOGIC_VECTOR(15 downto 0);
        i_acc_valid : in STD_LOGIC;
        
        o_acc_intangle_x    : out STD_LOGIC_VECTOR(31 downto 0);
        o_acc_intangle_y    : out STD_LOGIC_VECTOR(31 downto 0);
        o_acc_intangle_valid: out STD_LOGIC
    );
end entity;

architecture rtl of Acc_angulator is
    component Accelerator_arctan is
        port (
            clk    : in  std_logic                     := 'X';             -- clk
            areset : in  std_logic                     := 'X';             -- reset
            x      : in  std_logic_vector(16 downto 0) := (others => 'X'); -- x
            y      : in  std_logic_vector(16 downto 0) := (others => 'X'); -- y
            q      : out std_logic_vector(15 downto 0)                     -- q
        );
    end component Accelerator_arctan;
    
    Type Tstate is (s_idle, s_square_y, s_square_x, s_sum_ZY, s_root_ZY, s_root_ZX, s_wait_for_root, s_atan_x, s_atan_y, s_wait_for_atan,
                s_get_final_x, s_get_final_y);
    signal state        : Tstate := s_idle;
    signal r_counter    : integer range 0 to 15;
    
    signal r_acc_in_x       : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_acc_in_y       : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_acc_in_z       : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_atan_in_x      : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
    signal r_atan_in_y      : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
    signal w_atan_out       : STD_LOGIC_VECTOR(15 downto 0);
    signal r_mult_in_1      : signed(15 downto 0) := (others => '0');
    signal r_mult_in_2      : signed(16 downto 0) := (others => '0');
    signal w_mult_out       : signed(32 downto 0);
    signal r_square_x       : signed(31 downto 0) := (others => '0');
    signal r_square_y       : signed(31 downto 0) := (others => '0');
    signal r_square_z       : signed(31 downto 0) := (others => '0');
    signal r_sum_squares    : signed(32 downto 0) := (others => '0');
    signal r_SQRT_in        : STD_LOGIC_VECTOR(39 downto 0) := (others => '0');
    signal w_SQRT_out       : STD_LOGIC_VECTOR(19 downto 0);  
    signal r_SQRT_out_store : integer := 0;
    signal r_acc_intangle_x : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal r_acc_intangle_y : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    constant c_multiplier   : signed(16 downto 0) := to_signed(41721, 17);
    
    
    
    
begin        
    o_acc_intangle_x <= r_acc_intangle_x;
    o_acc_intangle_y <= r_acc_intangle_y;
    
    w_mult_out <= r_mult_in_1 * r_mult_in_2; --Should infer a DSP multiplier. if used clocked, storing into register directly, should be good.
    
    
    Accelerator_arctan_inst: Accelerator_arctan
        port map (
            clk    => clk,
            areset => rst,
            x      => r_atan_in_x, 
            y      => r_atan_in_y,
            q      => w_atan_out
        );    
    ACC_SQRT_inst: entity work.ACC_SQRT
        port map (
            clk       => clk,
            radical   => r_SQRT_in,
            q         => w_SQRT_out,
            remainder => open
        );


    state_process: process (clk) is
    begin
        if rising_edge(clk) then
            o_acc_intangle_valid <= '0'; --Default
            case state is
                when s_idle =>
                    state <= s_idle;-- Default
                    if i_acc_valid = '1' then
                        state <= s_square_y;            --Next state
                        r_acc_in_x <= i_acc_x;          --Store x,y,z values.
                        r_acc_in_y <= i_acc_y;
                        r_acc_in_z <= i_acc_z;
                        r_mult_in_1 <= signed(i_acc_z); --Start square of Z.
                        r_mult_in_2 <= signed(i_acc_z(15) & i_acc_z); --Input 2 is one bit longer(for later). Add first (signed) bit, keeps the value the same for signed.                      
                    end if;

                when s_square_y =>
                    state <= s_square_x;
                    r_square_z <= w_mult_out(32) & w_mult_out(30 downto 0);
                    r_mult_in_1 <= signed(r_acc_in_y);
                    r_mult_in_2 <= signed(r_acc_in_y(15) & r_acc_in_y);

                when s_square_x =>
                    state <= s_sum_ZY;
                    r_square_y <= w_mult_out(32) & w_mult_out(30 downto 0);
                    r_mult_in_1 <= signed(r_acc_in_x);
                    r_mult_in_2 <= signed(r_acc_in_x(15) & r_acc_in_x);

                when s_sum_ZY =>
                    state <= s_root_ZY;
                    r_square_x <= w_mult_out(32) & w_mult_out(30 downto 0);
                    r_sum_squares <= to_signed( to_integer(r_square_z) + to_integer(r_square_y) ,33);                   
               
                when s_root_ZY =>
                    state <= s_root_ZX;
                    r_SQRT_in <= STD_LOGIC_VECTOR("0000000" & r_sum_squares);
                    r_sum_squares <= to_signed( to_integer(r_square_z) + to_integer(r_square_x) ,33);

                when s_root_ZX =>
                    state <= s_wait_for_root;
                    r_SQRT_in <= STD_LOGIC_VECTOR("0000000" & r_sum_squares);
                    r_counter <= 0;

                when s_wait_for_root =>
                    state <= s_wait_for_root; --Default
                    if r_counter = 9 then
                        state <= s_atan_x;
                        r_SQRT_out_store <= to_integer(unsigned(w_SQRT_out));
                    end if;
                    r_counter <= r_counter + 1;
                    
                when s_atan_x =>
                    state <= s_atan_y;
                    if r_acc_in_z(15) = '1' then
                        r_atan_in_x <= STD_LOGIC_VECTOR(to_signed(0 - r_SQRT_out_store , 17));
                    else
                        r_atan_in_x <= STD_LOGIC_VECTOR(to_signed(r_SQRT_out_store , 17));
                    end if;                    
                    r_atan_in_y <= r_acc_in_x(15) & r_acc_in_x;
                    r_SQRT_out_store <= to_integer(unsigned(w_SQRT_out));
                    
                when s_atan_y =>
                    state <= s_wait_for_atan;
                    if r_acc_in_z(15) = '1' then
                        r_atan_in_x <= STD_LOGIC_VECTOR(to_signed(0 - r_SQRT_out_store , 17));
                    else
                        r_atan_in_x <= STD_LOGIC_VECTOR(to_signed(r_SQRT_out_store , 17));
                    end if;   
                    r_atan_in_y <= r_acc_in_y(15) & r_acc_in_y;
                    r_counter <= 0;

                when s_wait_for_atan =>
                    state <= s_wait_for_atan; --Default
                    if r_counter = 8 then
                        state <= s_get_final_x;
                        r_mult_in_1 <= signed(w_atan_out);
                        r_mult_in_2 <= c_multiplier;
                    end if;
                    r_counter <= r_counter + 1;

                when s_get_final_x =>
                    state <= s_get_final_y;
                    r_acc_intangle_x <= STD_LOGIC_VECTOR(w_mult_out(32) & w_mult_out(29 downto 0) & '0'); --Drop bits 30 and 31, and multiply by 2.
                    r_mult_in_1 <= signed(w_atan_out);
                    r_mult_in_2 <= c_multiplier;
                    
                when s_get_final_y =>
                    r_acc_intangle_y <= STD_LOGIC_VECTOR(w_mult_out(32) & w_mult_out(29 downto 0) & '0');
                    o_acc_intangle_valid <= '1';
                    state <= s_idle;

            end case;
                       
            if rst = '1' then
                r_acc_intangle_x <= (others => '0');
                r_acc_intangle_y <= (others => '0');
                state <= s_idle;
                o_acc_intangle_valid <= '0';
            end if;
        end if;
    end process;



    
end architecture;