library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity BNO055_master is
    generic(
        Entity_address : in std_logic_vector(7 downto 0) := X"00"
    );
    port (
        ---System ports---
        clk: in  std_logic;
        rst: in  std_logic;
        CB_address      : in std_logic_vector(15 downto 0);
        CB_write        : in std_logic_vector(31 downto 0);
        CBR_BNO055      : out std_logic_vector(31 downto 0);
        
        ---I2C port---
        io_I2C_SDA      : inout std_logic;
        io_I2C_SCL      : inout std_logic;
        
        ---Data out port ---
        o_euler_heading : out std_logic_vector(15 downto 0);
        o_euler_pitch   : out std_logic_vector(15 downto 0);
        o_euler_roll    : out std_logic_vector(15 downto 0);        
        o_linear_acc_x  : out std_logic_vector(15 downto 0);
        o_linear_acc_y  : out std_logic_vector(15 downto 0);
        o_linear_acc_z  : out std_logic_vector(15 downto 0);
        o_gravity_vec_x : out std_logic_vector(15 downto 0);
        o_gravity_vec_y : out std_logic_vector(15 downto 0);
        o_gravity_vec_z : out std_logic_vector(15 downto 0);
        o_data_valid    : out std_logic;
        
        ---Acknowledge error---
        o_acknowledge_error : out std_logic
        
        
    );
end entity;

architecture rtl of BNO055_master is
    ---Combus reading options---
    signal w_CBR_I2C_master : std_logic_vector(31 downto 0);
    signal r_CBR_BNO_master : std_logic_vector(31 downto 0) := (others => '0');
    
    ---I2C master control wires and registers ---
    signal r_I2C_start_transmission : std_logic := '0';
    signal r_I2C_I2C_address        : std_logic_vector(6 downto 0) := (others => '0');
    signal r_I2C_register_address   : std_logic_vector(7 downto 0) := (others => '0');
    signal r_I2C_write_read         : std_logic := '0';
    signal r_I2C_data_byte_in       : std_logic_vector(7 downto 0) := (others => '0');
    signal r_I2C_number_to_read     : integer range 0 to 15 := 0;
    signal w_I2C_busy               : std_logic;
    signal w_I2C_data_byte_out      : std_logic_vector(7 downto 0);
    signal w_I2C_data_number        : integer range 0 to 15;
    signal w_I2C_data_valid         : std_logic;
    signal w_I2C_acknowledge_error  : std_logic;
    
    ---Data registers---
    type T_euler_array is array (0 to 5) of std_logic_vector(7 downto 0);
    type T_acceleration_array is array (0 to 11) of std_logic_vector(7 downto 0);
    signal r_euler_array        : T_euler_array := (others => (others => '0'));
    signal r_euler_array_get    : t_euler_array := (others => (others => '0')); -- Array used when getting the data, copied when data is done
    signal r_acceleration_array : T_acceleration_array := (others => (others => '0'));
    signal r_acceleration_array_get : T_acceleration_array := (others => (others => '0')); --same as euler_get
    signal w_euler_heading      : std_logic_vector(15 downto 0);
    signal w_euler_pitch        : std_logic_vector(15 downto 0);
    signal w_euler_roll         : std_logic_vector(15 downto 0);
    signal w_linear_acc_x       : std_logic_vector(15 downto 0);
    signal w_linear_acc_y       : std_logic_vector(15 downto 0);
    signal w_linear_acc_z       : std_logic_vector(15 downto 0);
    signal w_gravity_vector_x   : std_logic_vector(15 downto 0);
    signal w_gravity_vector_y   : std_logic_vector(15 downto 0);
    signal w_gravity_vector_z   : std_logic_vector(15 downto 0);
    
    ---control state and registers---
    type Tstate is (s_idle, s_get_euler, s_send_acceleration_command, s_get_acceleration, s_done);
    signal state                    : Tstate := s_idle;
    signal r_control_released       : std_logic := '0';
    signal w_100Hz_clock_en         : std_logic;
    signal r_byte_counter           : integer range 0 to 15 := 0;
    
    
begin    
    ---Data wires mapping---
    --The most significant byte is at the higher address, and since we read sequentially with increasing address
    --the most significant byte is higher in the array. This results in a slightly weird construction of the data as follows.
    --It is split into 2 arrays because we do two read actions. This is because the read addresses for the data we want is 
    --not contigueous. The Quaternion data is in between this in the BNO055 registers.
    w_euler_heading <= r_euler_array(1) & r_euler_array(0);
    w_euler_roll    <= r_euler_array(3) & r_euler_array(2);
    w_euler_pitch   <= r_euler_array(5) & r_euler_array(4);
    
    w_linear_acc_x  <= r_acceleration_array(1) & r_acceleration_array(0);
    w_linear_acc_y  <= r_acceleration_array(3) & r_acceleration_array(2);
    w_linear_acc_z  <= r_acceleration_array(5) & r_acceleration_array(4);
    
    w_gravity_vector_x  <= r_acceleration_array(7) & r_acceleration_array(6);
    w_gravity_vector_y  <= r_acceleration_array(9) & r_acceleration_array(8);
    w_gravity_vector_z  <= r_acceleration_array(11) & r_acceleration_array(10);   
    
    ---Com bus read mapping---    
    --As long as control has not been released, communication is with the I2C master. As soon as control is released
    --this master takes over combus control.
    CBR_BNO055 <= w_CBR_I2C_master when r_control_released = '0' else r_CBR_BNO_master;
    
    ---Data out mapping---
    o_euler_heading <= w_euler_heading;
    o_euler_pitch   <= w_euler_pitch;
    o_euler_roll    <= w_euler_roll;
    o_linear_acc_x  <= w_linear_acc_x;
    o_linear_acc_y  <= w_linear_acc_y;
    o_linear_acc_z  <= w_linear_acc_z;
    o_gravity_vec_x <= w_gravity_vector_x;
    o_gravity_vec_y <= w_gravity_vector_y;
    o_gravity_vec_z <= w_gravity_vector_z;
    
    
    ---I2C master---
    I2C_master: entity work.Generic_I2C_Master
        generic map (
            Entity_address          => Entity_address,
            System_clock_frequency  => 100_000_000,
            I2C_bus_clock_frequency => 400_000
        )
        port map (
            clk                     => clk,
            rst                     => rst,
            CB_address              => CB_address,
            CB_write                => CB_write,
            CB_read                 => w_CBR_I2C_master,
            i_start_transmission    => r_I2C_start_transmission,
            i_I2C_address           => r_I2C_I2C_address,
            i_register_address      => r_I2C_register_address,
            i_write_read            => r_I2C_write_read, --Read = '1' write = '0'
            i_data_byte             => r_I2C_data_byte_in,
            i_number_to_read        => r_I2C_number_to_read,
            o_busy                  => w_I2C_busy,
            o_data_byte             => w_I2C_data_byte_out,
            o_data_number           => w_I2C_data_number,
            o_data_valid            => w_I2C_data_valid,
            o_acknowledge_error     => w_I2C_acknowledge_error,
            io_I2C_SDA              => io_I2C_SDA,
            io_I2C_SCL              => io_I2C_SCL
        );
    
    ---Clock enable generator @ 100Hz---
    ClockEnableGenerator_inst: entity work.ClockEnableGenerator
        generic map (
            DividerCount     => 1_000_000
        )
        port map (
            clk              => clk,
            rst              => rst,
            clock_enable_out => w_100Hz_clock_en
        );

    ---Com bus process---
    Combus_process: process (clk, rst) is
    begin
        if rst = '1' then
            r_control_released <= '0';
            r_CBR_BNO_master <= (others => '0');
        elsif rising_edge(clk) then
            r_CBR_BNO_master <= (others => '0'); --Default
            if CB_address(7 downto 0) = Entity_address then
                if CB_address (15 downto 14) = "11" and r_control_released = '0' then
                    r_control_released <= '1';
                end if;
                if CB_address(15) = '0' then
                    if CB_address(12) = '1' then
                        r_CBR_BNO_master <= X"00000201";
                    else                        
                        if CB_address(11 downto 8) = X"1" then
                            r_CBR_BNO_master <= X"0000" & w_euler_heading;
                        elsif CB_address(11 downto 8) = X"2" then
                            r_CBR_BNO_master <= X"0000" & w_euler_roll;
                        elsif CB_address(11 downto 8) = X"3" then
                            r_CBR_BNO_master <= X"0000" & w_euler_pitch;
                        elsif CB_address(11 downto 8) = X"4" then
                            r_CBR_BNO_master <= X"0000" & w_linear_acc_x;
                        elsif CB_address(11 downto 8) = X"5" then
                            r_CBR_BNO_master <= X"0000" & w_linear_acc_y;
                        elsif CB_address(11 downto 8) = X"6" then
                            r_CBR_BNO_master <= X"0000" & w_linear_acc_z;
                        elsif CB_address(11 downto 8) = X"7" then
                            r_CBR_BNO_master <= X"0000" & w_gravity_vector_x;
                        elsif CB_address(11 downto 8) = X"8" then
                            r_CBR_BNO_master <= X"0000" & w_gravity_vector_y;
                        elsif CB_address(11 downto 8) = X"9" then
                            r_CBR_BNO_master <= X"0000" & w_gravity_vector_z;                            
                        end if;
                    end if;
                end if;                
            end if;
        end if;
    end process;
    
    ---Released data gathering process---
    data_gathering_p: process (clk, rst) is
    begin
        if rst = '1' then
            state <= s_idle;
        elsif rising_edge(clk) then
            ---Default statements---
            r_I2C_start_transmission <= '0';
            r_I2C_I2C_address <= (others => '0');
            r_I2C_register_address <= (others => '0');
            r_I2C_write_read <= '0';
            r_I2C_data_byte_in <= (others => '0');
            r_I2C_number_to_read <= 0; 
            o_data_valid <= '0';
            ---End default statements---
            if r_control_released = '1' then
                case state is
                    when s_idle =>
                        state <= s_idle;
                        if w_100Hz_clock_en = '1' and w_I2C_busy = '0' then
                            state <= s_get_euler;
                            r_I2C_start_transmission <= '1';
                            r_I2C_I2C_address <= "0101000"; -- 0x28 in 7 bits. The BNO055 I2C address.
                            r_I2C_register_address <= X"1A"; --The lowest address of the euler data. EUL_Heading_LSB to be precise.
                            r_I2C_write_read <= '1'; --Read
                            r_I2C_number_to_read <= 5; --We read 6 bytes in this batch. (including 0)
                            --We don't write to data byte in, since we dont intend to write any data.
                            r_byte_counter <= 0;
                        end if;

                    when s_get_euler =>
                        state <= s_get_euler;
                        if w_I2C_data_valid = '1' then
                            r_euler_array_get(r_byte_counter) <= w_I2C_data_byte_out; -- The data byte into the array.
                            if r_byte_counter = 5 then -- all six bytes have been read by now
                                state <= s_send_acceleration_command;
                                r_byte_counter <= 0;
                            else
                                r_byte_counter <= r_byte_counter + 1;
                            end if;
                        end if;

                    when s_send_acceleration_command =>
                        state <= s_send_acceleration_command;
                        if w_I2C_busy = '0' then
                            state <= s_get_acceleration;
                            r_I2C_start_transmission <= '1';
                            r_I2C_I2C_address <= "0101000"; -- 0x28 in 7 bits. The BNO055 I2C address.
                            r_I2C_register_address <= X"28"; --The lowest address of the acceleration data. LIA_data_X_LSB to be precise.
                            r_I2C_write_read <= '1'; --Read
                            r_I2C_number_to_read <= 11; --We read 12 bytes in this batch.
                            --We don't write to data byte in, since we dont intend to write any data.
                            r_euler_array <= r_euler_array_get; --Copy into the read-valid array
                        end if;

                    when s_get_acceleration =>
                        state <= s_get_acceleration;
                        if w_I2C_data_valid = '1' then
                            r_acceleration_array_get(r_byte_counter) <= w_I2C_data_byte_out; -- The data byte into the array.
                            if r_byte_counter = 11 then -- all twelve bytes have been read by now
                                state <= s_done;
                                r_byte_counter <= 0;  
                            else
                                r_byte_counter <= r_byte_counter + 1;
                            end if;
                        end if;

                    when s_done =>
                        r_acceleration_array <= r_acceleration_array_get; --Copy into the read-valid array
                        o_data_valid <= '1';
                        state <= s_idle;
                end case;    
            end if;
        end if;
    end process;
    
    Ack_error_p: process (clk, rst) is
    begin
        if rst = '1' then
            o_acknowledge_error <= '0';
        elsif rising_edge(clk) then
            if w_I2C_acknowledge_error = '1' then
                o_acknowledge_error <= '1';
            end if;
        end if;
    end process;




end architecture;