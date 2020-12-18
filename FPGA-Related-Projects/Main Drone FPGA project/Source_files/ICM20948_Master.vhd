library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity ICM20948_Master is
    generic (
        Entity_address : in STD_LOGIC_VECTOR(7 downto 0) := X"06"
    );
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        
        CB_address  : in STD_LOGIC_VECTOR(15 downto 0);
        CB_write    : in STD_LOGIC_VECTOR(31 downto 0);
        CBR_ICM20948: out STD_LOGIC_VECTOR(31 downto 0);
        
        o_SPI_MOSI  : out STD_LOGIC;
        i_SPI_MISO  : in STD_LOGIC;
        o_SPI_SCLK  : out STD_LOGIC;
        o_SPI_CS_n  : out STD_LOGIC;
        
        o_ACC_x     : out STD_LOGIC_VECTOR(15 downto 0);
        o_ACC_y     : out STD_LOGIC_VECTOR(15 downto 0);
        o_ACC_z     : out STD_LOGIC_VECTOR(15 downto 0);
        o_GYRO_x    : out STD_LOGIC_VECTOR(15 downto 0);
        o_GYRO_y    : out STD_LOGIC_VECTOR(15 downto 0);
        o_GYRO_z    : out STD_LOGIC_VECTOR(15 downto 0);
        o_temp      : out STD_LOGIC_VECTOR(15 downto 0);
        o_data_valid: out STD_LOGIC
    );
end entity;

architecture rtl of ICM20948_Master is
    signal w_SPI_released_read_data     : STD_LOGIC_VECTOR(7 downto 0);
    signal w_SPI_released_read_valid    : STD_LOGIC;
    signal w_CBR_SPI_master             : STD_LOGIC_VECTOR(31 downto 0);
    signal r_SPI_released_read_address  : STD_LOGIC_VECTOR(7 downto 0) := X"00";
    signal r_SPI_released_read_start    : STD_LOGIC := '0';
    signal r_control_released           : STD_LOGIC := '0';
    signal r_CBR_ICM20948               : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    type data_array is array (0 to 13) of STD_LOGIC_VECTOR(7 downto 0);
    signal r_data_array                 : data_array := (others => (others => '0'));
    signal r_ready_status               : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal r_counter                    : integer range 0 to 511 := 0;
    signal r_address_has_been_sent      : STD_LOGIC := '0';
    signal r_ACC_x                      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_ACC_y                      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_ACC_z                      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_GYRO_x                     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_GYRO_y                     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_GYRO_z                     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_temp                       : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    
    
    type Tstate is (s_idle, s_poll, s_wait, s_get_data, s_output);
    signal state                        : Tstate := s_idle;
    
    
    constant RDY_STATUS_REG: std_logic_vector(7 downto 0) := X"F4";
    constant START_READING_REG: std_logic_vector(7 downto 0) := X"AD";
    
begin
    
    CBR_ICM20948 <= r_CBR_ICM20948 when r_control_released = '1' else w_CBR_SPI_master;
    
    o_ACC_x <= r_ACC_x;
    o_ACC_y <= r_ACC_y;
    o_ACC_z <= r_ACC_z;
    o_GYRO_x <= r_GYRO_x;
    o_GYRO_y <= r_GYRO_y;
    o_GYRO_z <= r_GYRO_z;
    o_temp <= r_temp;
    
    
    Generic_SPI_Master_inst: entity work.Generic_SPI_Master
        generic map (
            Entity_address          => Entity_address,
            CPOL_clock_polarity     => '1',
            CPHA_clock_phase        => '1',
            Serial_clock_divider    => 16
        )
        port map (
            clk                     => clk,
            rst                     => rst,
            CB_address              => CB_address,
            CB_write                => CB_write,
            CB_read                 => w_CBR_SPI_master,
            o_SPI_MOSI              => o_SPI_MOSI,
            i_SPI_MISO              => i_SPI_MISO,
            o_SPI_SCLK              => o_SPI_SCLK,
            o_SPI_CS_n              => o_SPI_CS_n,
            o_released_read_data    => w_SPI_released_read_data,
            o_released_data_valid   => w_SPI_released_read_valid,
            i_released_read_address => r_SPI_released_read_address,
            i_released_start_read   => r_SPI_released_read_start
        );

    com_bus_p: process (clk) is
    begin        
        if rising_edge(clk) then
            r_CBR_ICM20948 <= X"00000000"; -- default
            if CB_address(7 downto 0) = Entity_address then
                if CB_address (15 downto 14) = "11" and r_control_released = '0' then
                    r_control_released <= '1';
                end if;
                if CB_address(15) = '0' then
                    if CB_address(12) = '1' then
                        r_CBR_ICM20948 <= X"00000201";
                    else                        
                        case CB_address(11 downto 8) is
                            when X"1" =>
                                r_CBR_ICM20948 <= X"000000" & r_ready_status; 
                                
                            when X"2" =>
                                r_CBR_ICM20948 <= X"0000" & r_ACC_x; 
                                
                            when X"3" =>
                                r_CBR_ICM20948 <= X"0000" & r_ACC_y; 
                                
                            when X"4" =>
                                r_CBR_ICM20948 <= X"0000" & r_ACC_z; 
                                
                            when X"5" =>
                                r_CBR_ICM20948 <= X"0000" & r_GYRO_x; 
                                
                            when X"6" =>
                                r_CBR_ICM20948 <= X"0000" & r_GYRO_y; 
                                
                            when X"7" =>
                                r_CBR_ICM20948 <= X"0000" & r_GYRO_z; 
                                
                            when X"8" =>
                                r_CBR_ICM20948 <= X"0000" & r_temp; 
                                
                            when others =>
                                
                        end case;
                    end if;
                end if;                
            end if;
            if rst = '1' then
                r_CBR_ICM20948      <= (others => '0');
                r_control_released  <= '0';
            end if;
        end if;
    end process;
    
    
    State_process: process (clk) is
    begin
        if rising_edge(clk) then
            o_data_valid <= '0'; --Default
            r_SPI_released_read_start <= '0'; --Default
            r_SPI_released_read_address <= (others => '0'); --Default
            case state is
                when s_idle =>
                    if r_control_released = '1' then
                        state <= s_poll;
                    else
                        state <= s_idle;
                    end if;

                when s_poll =>
                    state <= s_poll; --Default
                    if r_address_has_been_sent = '0' then --If the address has not be sent yet, send it, to start the read procedure.
                        r_SPI_released_read_address <= RDY_STATUS_REG;
                        r_SPI_released_read_start <= '1';
                        r_address_has_been_sent <= '1';
                    else
                        if w_SPI_released_read_valid = '1' then
                            r_address_has_been_sent <= '0';
                            r_ready_status <= w_SPI_released_read_data;
                            if w_SPI_released_read_data(3 downto 0) = X"0" then -- If there is no new data , go to wait.
                                state <= s_wait;     
                                r_counter <= 0;
                            else
                                state <= s_get_data; -- else go get data.
                            end if;
                        end if;
                    end if;

                when s_wait =>  --The expected sample rate is 9ksps. That means 1 sample roughly every 111 us. 
                                --polling every 5 us should be more than enough.
                    if r_counter = 500 then
                        r_counter <= 0;
                        state <= s_poll;
                    else
                        r_counter <= r_counter + 1;
                        state <= s_wait;
                    end if;

                when s_get_data =>
                    if r_counter = 14 then
                        state <= s_output;
                        r_counter <= 0;
                    else
                        if r_address_has_been_sent = '0' then --If the address has not be sent yet, send it, to start the read procedure.
                            r_SPI_released_read_address <= STD_LOGIC_VECTOR(to_unsigned(r_counter + 
                                                 to_integer(unsigned(START_READING_REG)),8)); -- starting address plus counter.
                            r_SPI_released_read_start <= '1';
                            r_address_has_been_sent <= '1';
                        else
                            if w_SPI_released_read_valid = '1' then
                                r_address_has_been_sent <= '0';
                                r_data_array(r_counter) <= w_SPI_released_read_data;
                                r_counter <= r_counter + 1;                                
                            end if;
                        end if;
                        state <= s_get_data;
                    end if;
                    

                when s_output =>
                    state <= s_idle;
                    r_ACC_x     <= r_data_array(0) & r_data_array(1);
                    r_ACC_y     <= r_data_array(2) & r_data_array(3);
                    r_ACC_z     <= r_data_array(4) & r_data_array(5);
                    r_GYRO_x    <= r_data_array(6) & r_data_array(7);
                    r_GYRO_y    <= r_data_array(8) & r_data_array(9);
                    r_GYRO_z    <= r_data_array(10) & r_data_array(11);
                    r_temp      <= r_data_array(12) & r_data_array(13);
                    o_data_valid <= '1';

            end case;
            
            if rst = '1' then
                r_ACC_x <= (others => '0');
                r_ACC_y <= (others => '0');
                r_ACC_z <= (others => '0');
                r_GYRO_x <= (others => '0');
                r_GYRO_y <= (others => '0');
                r_GYRO_z <= (others => '0');
                r_temp <= (others => '0');
                o_data_valid <= '0';
                state <= s_idle;
            end if;
        end if;
    end process;

    
    
    
end architecture;