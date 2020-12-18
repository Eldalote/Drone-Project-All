--  Generic I2C master. Can be used by wrapper made for specific target, and/or by use with the com bus
--  Made with the BNO055 absolute direction chip in mind. Might need to change for other targets.

-- Made on 03-09-2019 by Jan Mart Liewes
-- Testbenched on       by Jan Mart Liewes



library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Generic_I2C_Master is
    generic(
        Entity_address          : in std_logic_vector(7 downto 0);
        System_clock_frequency  : in natural := 100_000_000;
        I2C_bus_clock_frequency : in natural := 400_000
    );
    port (
        clk                     : in std_logic;
        rst                     : in std_logic;
        CB_address              : in std_logic_vector(15 downto 0);
        CB_write                : in std_logic_vector(31 downto 0);
        CB_read                 : out std_logic_vector(31 downto 0);
        
        i_start_transmission    : in std_logic;
        i_I2C_address           : in std_logic_vector(6 downto 0);
        i_register_address      : in std_logic_vector(7 downto 0);
        i_write_read            : in std_logic;
        i_data_byte             : in std_logic_vector(7 downto 0); 
        i_number_to_read        : in integer range 0 to 15;
        
        o_busy                  : out std_logic;
        o_data_byte             : out std_logic_vector(7 downto 0);
        o_data_number           : out integer range 0 to 15;
        o_data_valid            : out std_logic;
        
        o_acknowledge_error     : out std_logic;
        io_I2C_SDA              : inout std_logic;
        io_I2C_SCL              : inout std_logic
    );
end entity;

architecture rtl of Generic_I2C_Master is
    --- Contstants ---
    constant c_clock_divider: integer := (System_clock_frequency / I2C_bus_clock_frequency) / 4;
    
    ---Types---
    type t_mem_I2C_bytes    is array (0 to 15) of std_logic_vector(7 downto 0);
    type t_state_CB         is (s_idle, s_idle_released, s_waiting_for_I2C_data);
    type t_state_I2C        is (s_idle, s_start, s_command, s_slave_acknowledge, s_writing, s_reading, 
                                s_slave_acknowledge2, s_master_acknowledge, s_stop);
    --- Registers --- 
    signal r_acknowledge_error      : std_logic := '0';    
    signal r_I2C_received_bytes     : t_mem_I2C_bytes := (others => (others => '0'));
    signal r_I2C_CB_I2C_address     : std_logic_vector(6 downto 0) := (others => '0');
    signal r_I2C_CB_register_address: std_logic_vector(7 downto 0) := (others => '0');
    signal r_I2C_CB_data_byte       : std_logic_vector(7 downto 0) := (others => '0');
    signal r_I2C_CB_read_write      : std_logic := '0';
    signal r_I2C_CB_read_count      : integer range 0 to 15 := 0;
    signal r_I2C_RX_read_count      : integer range 0 to 15 := 0;
    signal r_I2C_read_count         : integer range 0 to 15 := 0;
    signal r_I2C_TX_I2C_address     : std_logic_vector(6 downto 0) := (others => '0');
    signal r_I2C_RTX_register_address: std_logic_vector(7 downto 0) := (others => '0');
    signal r_I2C_TX_data_byte       : std_logic_vector(7 downto 0) := (others => '0');
    signal r_I2C_TX_address_and_wr  : std_logic_vector(7 downto 0) := (others => '0');
    signal r_I2C_RX_data_byte       : std_logic_vector(7 downto 0) := (others => '0');
    signal r_I2C_RX_reg_address_sent: std_logic := '0';
    signal r_I2C_RTX_read_write     : std_logic := '0';
    signal r_CB_start_transmission  : std_logic := '0';
    signal r_start_transmission     : std_logic := '0';
    signal r_I2C_done               : std_logic := '0';
   
    signal r_stretching_by_slave    : std_logic;
    --signal r_sclock_counter         : integer range 0 to c_clock_divider * 4;
    signal r_data_clock             : std_logic := '0';
    signal r_data_clock_previous    : std_logic := '0';
    signal r_sclock                 : std_logic := '0';
    signal r_sclock_enable          : std_logic := '0';
    signal r_SDA_internal           : std_logic := '1';
    signal r_SDA_enable_n            : std_logic := '0';
    signal r_transmission_bit_count : integer range 0 to 7 := 7;
    
    signal r_control_released       : std_logic := '0';
    
    
    
    --- States ---
    signal state_CB                 : t_state_CB := s_idle;
    signal state_I2C                : t_state_I2C := s_idle;
    
    
    --- wires ---
    --- CB_address sub wires ---
    signal w_CB_address             : std_logic_vector(7 downto 0);
    signal w_CB_write_read          : std_logic;
    signal w_CB_write_read_command  : std_logic;
    signal w_CB_release_command     : std_logic;
    signal w_CB_check_ready         : std_logic;
    signal w_CB_byte_count          : integer range 0 to 15;
    
    
begin
       
    --- CB_address splitting --- 
    w_CB_address <= CB_address(7 downto 0);
    w_CB_byte_count <= to_integer(unsigned(CB_address(11 downto 8)));
    w_CB_check_ready <= CB_address(12);
    w_CB_write_read_command <= CB_address(13);
    w_CB_release_command <= CB_address(14);
    w_CB_write_read <= CB_address(15);
    
    --- Processes ---
    
    CB_p: process (clk, rst) is
    begin
        if rst = '1' then
            CB_read <= X"00000100";
            state_CB <= s_idle;
            r_control_released <= '0';
            r_CB_start_transmission <= '0';
        elsif rising_edge(clk) then
            CB_read <= X"00000100"; -- default
            r_CB_start_transmission <= '0'; -- default
            case state_CB is
                when s_idle =>
                    state_cb <= s_idle; -- default
                    if w_CB_address = Entity_address then
                        if w_CB_write_read = '0' then
                            if w_CB_check_ready = '1' then
                                CB_read <= X"00000200";
                            else
                                CB_read <= X"000000" & r_I2C_received_bytes(w_CB_byte_count);
                            end if;
                        else
                            if w_CB_release_command = '1' then
                                r_control_released <= '1';
                                state_CB <= s_idle_released;
                            else                                
                                r_I2C_CB_I2C_address <= CB_write(22 downto 16); -------- !!!!!!! For the drivers!!!!!!!---
                                r_I2C_CB_register_address <= CB_write(15 downto 8);
                                r_I2C_CB_data_byte <= CB_write(7 downto 0);
                                r_I2C_CB_read_count <= w_CB_byte_count;
                                r_I2C_CB_read_write <= w_CB_write_read_command;
                                state_CB <= s_waiting_for_I2C_data;
                                r_CB_start_transmission <= '1';                                
                            end if;  
                        end if;
                    end if;

                when s_idle_released =>
                    state_CB <= s_idle_released; -- This is not changing.
                    if w_CB_address = Entity_address then
                        if w_CB_write_read = '0' then
                            if w_CB_check_ready = '1' then
                                CB_read <= X"00000201";                            
                            end if;
                        end if;
                    end if;

                when s_waiting_for_I2C_data =>
                    state_CB <= s_waiting_for_I2C_data; -- default
                    if r_I2C_done = '1' then
                        state_CB <= s_idle;
                    end if;

            end case;
        end if;
    end process;
    
    data_collection_p: process (clk, rst) is
    begin
        if rst = '1' then
            r_start_transmission <= '0';
        elsif rising_edge(clk) then
            if i_start_transmission = '1' and r_control_released = '1' then
                r_I2C_TX_data_byte <= i_data_byte;
                r_I2C_RTX_register_address <= i_register_address;
                r_I2C_TX_I2C_address <= i_I2C_address;
                r_I2C_read_count <= i_number_to_read;
                r_I2C_RTX_read_write <= i_write_read;
                r_start_transmission <= '1';                
            elsif r_CB_start_transmission = '1' then
                r_I2C_TX_data_byte <= r_I2C_CB_data_byte;
                r_I2C_RTX_register_address <= r_I2C_CB_register_address;
                r_I2C_TX_I2C_address <= r_I2C_CB_I2C_address;
                r_I2C_read_count <= r_I2C_CB_read_count;
                r_I2C_RTX_read_write <= r_I2C_CB_read_write;
                r_start_transmission <= '1';                             
            end if;
            
            if state_I2C = s_start then
                r_start_transmission <= '0';
            end if;
                
        end if;
    end process;


    --- !!!! Copied direcly (with more readable signal names) from example. Including use of variable. !!!! ---
    I2C_clock_p: process (clk, rst) is                      
        variable v_sclock_counter : integer range 0 to c_clock_divider * 4;
    begin
        if rst = '1' then
            r_stretching_by_slave <= '0';
            v_sclock_counter := 0;
        elsif rising_edge(clk) then
            r_data_clock_previous <= r_data_clock;                  --Store previous value
            if v_sclock_counter = (c_clock_divider * 4)-1 then
                v_sclock_counter := 0;
            elsif r_stretching_by_slave = '0' then                  --Only continue counting if the slave isn't stretching.
                v_sclock_counter := v_sclock_counter + 1;
            end if;
            case v_sclock_counter is
                when 0 to c_clock_divider -1 =>                     --First 1/4 cycle of clocking
                    r_sclock <= '0';
                    r_data_clock <= '0';
                    
                when c_clock_divider to (c_clock_divider*2)-1 =>    -- Second 1/4 cycle of clocking
                    r_sclock <= '0';
                    r_data_clock <= '1';
                    
                when c_clock_divider *2 to (c_clock_divider*3)-1 => -- Third 1/4 cycle of clocking
                    r_sclock <= '1';                                -- SClock is released to go high
                    if io_I2C_SCL = '0' then                        -- Detect if the slave is pulling the SClock low (stretching)
                        r_stretching_by_slave <= '1';
                    else
                        r_stretching_by_slave <= '0';
                    end if;
                    r_data_clock <= '1';
                    
                when others =>                                      -- Last 1/4 cycle of clocking
                    r_sclock <= '1';
                    r_data_clock <= '0';
                    
            end case;
        end if;
    end process;
    
    I2C_state_p: process (clk, rst) is
    begin
        if rst = '1' then
            o_busy <= '1'; -- Count as busy while resetting  
            o_data_byte <= (others => '0');            
            o_data_number <= 0;
            o_data_valid <= '0';
        elsif rising_edge(clk) then
            o_data_valid <= '0'; --Default (on the main clock!)
            r_I2C_done <= '0'; --Default
            if r_data_clock = '1' and r_data_clock_previous = '0' then      -- Rising edge of the data clock
                case state_I2C is
                    when s_idle => 
                       if r_start_transmission = '1' then
                            state_I2C <= s_start;
                            o_busy <= '1';
                            r_transmission_bit_count <= 7;
                            r_I2C_TX_address_and_wr <= r_I2C_TX_I2C_address & '0'; --The first is always a write, reading or writing
                            r_I2C_RX_reg_address_sent <= '0';
                            r_I2C_RX_read_count <= r_I2C_read_count;
                        else
                            state_I2C <= s_idle;    
                            o_busy <= '0';     
                        end if;

                    when s_start =>
                        o_busy <= '1';
                        r_SDA_internal <= r_I2C_TX_address_and_wr(r_transmission_bit_count);
                        state_I2C <= s_command;
                        
                    when s_command =>
                        if r_transmission_bit_count = 0 then
                            r_SDA_internal <= '1';                  -- A '1' releases the bus for the slave to acknowledge
                            r_transmission_bit_count <= 7;
                            state_I2C <= s_slave_acknowledge;
                        else
                            r_transmission_bit_count <= r_transmission_bit_count -1;
                            r_SDA_internal <= r_I2C_TX_address_and_wr(r_transmission_bit_count -1);
                            state_I2C <= s_command;
                        end if;

                    when s_slave_acknowledge =>
                        if r_I2C_TX_address_and_wr(0) = '0' then    --Write command
                            if r_I2C_RX_reg_address_sent = '0' then
                                r_SDA_internal <= r_I2C_RTX_register_address(r_transmission_bit_count);
                            else
                                r_SDA_internal <= r_I2C_TX_data_byte(r_transmission_bit_count);
                            end if;
                            state_I2C <= s_writing;
                        else                                        -- Read command
                            r_SDA_internal <= '1';                  --Release the bus for incomming data
                            state_I2C <= s_reading;
                        end if;

                    when s_writing =>
                        if r_transmission_bit_count = 0 then
                            r_SDA_internal <= '1';                  --release for slave ack
                            r_transmission_bit_count <= 7;
                            state_I2C <= s_slave_acknowledge2;
                        else
                            r_transmission_bit_count <= r_transmission_bit_count -1;
                            if r_I2C_RX_reg_address_sent = '0' then
                                r_SDA_internal <= r_I2C_RTX_register_address(r_transmission_bit_count -1);
                            else
                                r_SDA_internal <= r_I2C_TX_data_byte(r_transmission_bit_count -1);
                            end if;
                            state_I2C <= s_writing;
                        end if;

                    when s_reading =>
                        if r_transmission_bit_count = 0 then
                            if r_I2C_RX_read_count = 0 then         --No more reads
                                r_SDA_internal <= '1';              --Send a no-acknowledge before a stop
                            else
                                r_SDA_internal <= '0';              --Send an acknowledge 
                            end if;  
                            r_I2C_received_bytes(r_I2C_RX_read_count) <= r_I2C_RX_data_byte;
                            o_data_byte <= r_I2C_RX_data_byte;
                            o_data_number <= r_I2C_RX_read_count;
                            o_data_valid <= '1';                    --Will be defaulted back to 0 on the next main clock rising edge!
                            state_I2C <= s_master_acknowledge;
                            r_transmission_bit_count <= 7;
                        else
                            r_transmission_bit_count <= r_transmission_bit_count -1;
                            state_I2C <= s_reading;
                        end if;

                    when s_slave_acknowledge2 =>
                        if r_I2C_RX_reg_address_sent = '0' then
                            r_I2C_RX_reg_address_sent <= '1';
                            if r_I2C_RTX_read_write = '1' then      --If it is a read command
                                r_I2C_TX_address_and_wr <= r_I2C_TX_I2C_address & r_I2C_RTX_read_write;
                                state_I2C <= s_start;               -- Go to restart
                            else
                                r_SDA_internal <= r_I2C_TX_data_byte(r_transmission_bit_count);
                                state_I2C <= s_writing;             -- Go to writing, now write data
                            end if;                            
                        else
                            state_I2C <= s_stop;                    --Multiple writes currently not supported
                        end if; 
                        
                    when s_master_acknowledge =>
                        if r_I2C_RX_read_count = 0 then
                            state_I2C <= s_stop;
                        else
                            r_I2C_RX_read_count <= r_I2C_RX_read_count -1;
                            r_SDA_internal <= '1';                  --rerelease for incoming data
                            state_I2C <= s_reading;
                        end if;

                    when s_stop =>
                        o_busy <= '0';
                        r_I2C_done <= '1';
                        state_I2C <= s_idle;

                end case;
                
            elsif r_data_clock = '0' and r_data_clock_previous = '1' then   --Falling edge of the data clock
                case state_I2C is 
                    when s_start =>   
                        if r_sclock_enable = '0' then                   -- New transaction
                            r_sclock_enable <= '1';                     -- Enable the sclock output
                            r_acknowledge_error <= '0';                 -- Reset the error
                        end if;

                    when s_slave_acknowledge =>  
                        if io_I2C_SDA = '0' and r_acknowledge_error = '0' then
                            r_acknowledge_error <= '0';                 -- acknowledge received.
                        else
                            r_acknowledge_error <= '1';                 -- not received
                        end if;

                    when s_reading =>
                        r_I2C_RX_data_byte(r_transmission_bit_count) <= io_I2C_SDA;

                    when s_slave_acknowledge2 =>
                        if io_I2C_SDA = '0' and r_acknowledge_error = '0' then
                            r_acknowledge_error <= '0';                 -- acknowledge received.
                        else
                            r_acknowledge_error <= '1';                 -- not received
                        end if;
                   
                    when s_stop =>
                        r_sclock_enable <= '0';                         -- disable the sclock
                        
                    when others =>

                end case;


            end if;
        end if;
    end process;

    with state_I2C select
    r_SDA_enable_n <= r_data_clock_previous when s_start,
                    not r_data_clock_previous when s_stop,
                    r_SDA_internal when others;
    
    --- Direct assignments ---
    o_acknowledge_error <= '0' when r_acknowledge_error = '0' else '1';
    io_I2C_SCL <= '0' when (r_sclock_enable = '1' and r_sclock = '0') else 'Z';
    io_I2C_SDA <= '0' when r_SDA_enable_n = '0' else 'Z';

    
    
    
end architecture;