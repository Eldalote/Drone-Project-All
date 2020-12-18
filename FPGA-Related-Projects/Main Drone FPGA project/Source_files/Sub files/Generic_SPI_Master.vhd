-- Generic SPI master. Implements the "simple" SPI master, and a Com-bus communication protocol.
-- Once released, a wrapper needs to send addresses of bytes to read. This will only read single bytes! (reworked version)

-- How to communicate with this entity:
-- For everything: entity address (7 - 0)must always match of course. Numbers indicated in parentesis are the bit number of the address.
-- First, always check ready: CB_check_ready (12) must be 1, CB_read_write(15) must be 0 (read). Will return 0x200 when ready, 0x201 when released, and 0x100 any other time. 
-- If you want to read registers: CB_write_read (15) must be 0 (read), and indicate with CB_byte_count (11 - 8) which byte you want to read. (0x0 through 0xF)
-- If you want to send a number of bytes via the SPI: CB_write_read (15) must be 1 (write), CB_release_command(14) must be 0. indicate with CB_byte_count
-- how many bytes you want to send: (0x0 + 1 through 0xF + 1). Provide the SPI address byte you want to send it to on the CB_write bus at this time.
-- If you want to write actual data to the SPI, CB_write_read_command(13) must be '1', if you just want to read a number of bytes while sending
-- 0's, it must be 0. In case of a 1, the interface will now to into a new state. if you want to send n bytes, now you need to write to the 
-- entity n times with a byte of data. Address must match, CB_write_read (15) must be '1', other signals are ignored.
-- Once n bytes have been written, the interface will go into another state, waiting for the SPI interface to handle the data.
-- Once this is completed, it will return to idle, and you can read the resulting receive bytes the normal way.
-- KEEP IN MIND: If you want to send/read multiple bytes in one go, you must make sure the auto-increase-address option has been enabled!

-- Created on 08-07-2019 by Jan Mart Liewes
-- Surface level testbench verification on 08-07-2019 by Jan Mart Liewes

-- Reworked! Finished rework on 20-08-2019 by Jan Mart Liewes
-- Testbenched rework on 23-08-2019 by Jan Mart Liewes



library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Generic_SPI_Master is
    generic (
        Entity_address : std_logic_vector(7 downto 0) := X"0F";
        CPOL_clock_polarity : std_logic := '0';
        CPHA_clock_phase : std_logic := '0';
        Serial_clock_divider : integer := 4       
    );
    port (
        --standard system ports
        clk: in  std_logic;
        rst: in  std_logic;

        --Com bus ports
        CB_address          : in std_logic_vector(15 downto 0);
        CB_write            : in std_logic_vector(31 downto 0);
        CB_read             : out std_logic_vector(31 downto 0);

        -- SPI port
        o_SPI_MOSI          : out std_logic;
        i_SPI_MISO          : in std_logic;
        o_SPI_SCLK          : out std_logic;
        o_SPI_CS_n          : out std_logic;       

        --Released ports  
        o_released_read_data    : out std_logic_vector(7 downto 0);
        o_released_data_valid   : out std_logic;
        i_released_read_address : in std_logic_vector(7 downto 0);
        i_released_start_read   : in std_logic
        
    );
end entity;

architecture rtl of Generic_SPI_Master is
    -- type
    type   t_mem_SPI_bytes is array (0 to 15) of std_logic_vector(7 downto 0);
    -- low level spi master registers and wires
    -- registers
    signal r_transmit_byte      : std_logic_vector(7 downto 0) := X"00";
    signal r_transmit_valid     : std_logic := '0';
        
    -- wires    
    signal w_transeiver_ready_for_new_byte  : std_logic;
    signal w_receive_byte       : std_logic_vector(7 downto 0);
    signal w_receive_valid      : std_logic;
    signal w_SPI_CS_n           : std_logic;
    
    -- Com bus registers, wires, and states
    -- registers
    signal r_CBW_SPI_address    : std_logic_vector(7 downto 0) := X"00";    
    signal r_CBW_SPI_bytes      : t_mem_SPI_bytes := (others => X"00");                
    signal r_CBW_byte_count     : integer range 0 to 15 := 0;
    signal r_control_released   : std_logic := '0';
    signal r_CBW_counter        : integer range 0 to 31 := 0;
    signal r_CBW_start_SPI      : std_logic := '0';
    
    -- wires
    signal w_CB_address             : std_logic_vector(7 downto 0);
    signal w_CB_write_read          : std_logic;
    signal w_CB_write_read_command  : std_logic;
    signal w_CB_release_command     : std_logic;
    signal w_CB_check_ready         : std_logic;
    signal w_CB_byte_count          : integer range 0 to 15;
    -- states
    Type t_state_CB is (s_idle, s_idle_released, s_waiting_for_CB_data, s_waiting_for_SPI_data);
    signal state_CB : t_state_CB := s_idle;
    
    -- SPI controlling logic registers, wires, and state
    -- registers
    signal r_SPI_received_data  : t_mem_SPI_bytes := (others => X"00");
    signal r_SPI_auto_read_data : std_logic_vector(7 downto 0) := (others => '0');
    signal r_SPI_done           : std_logic := '0'; 
    signal r_SPI_sent_counter   : integer range 0 to 31 := 0;
    signal r_SPI_read_counter   : integer range 0 to 31 := 0;
    signal r_SPI_got_address_return   : std_logic := '0';    
    
    
    -- states
    type t_state_SPI is (s_idle, s_idle_released, s_tranceive_data, s_tranceive_data_released, s_wait_for_idle);
    signal state_SPI : t_state_SPI := s_idle;
    
    
begin
    
    o_released_data_valid <= r_SPI_done when r_control_released = '1' else '0'; --Only output data valid on the output line once control has been released.
    o_released_read_data <= r_SPI_auto_read_data;
    o_SPI_CS_n <= w_SPI_CS_n;
    
    
    low_level_SPI_master: entity work.Simple_SPI_Master
        generic map (
            CPOL_clock_polarity  => CPOL_clock_polarity,
            CPHA_clock_phase     => CPHA_clock_phase,
            sclock_divider       => Serial_clock_divider
        )
        port map (
            clk                  => clk,
            rst                  => rst,
            i_TX_byte            => r_transmit_byte,
            i_TX_valid           => r_transmit_valid,
            o_ready_for_new_byte => w_transeiver_ready_for_new_byte,
            o_RX_byte            => w_receive_byte,
            o_RX_valid           => w_receive_valid,
            o_SPI_clock          => o_SPI_SCLK,
            o_CS_n               => w_SPI_CS_n,
            o_MOSI               => o_SPI_MOSI,
            i_MISO               => i_SPI_MISO
        );

    -- Com bus address into wires assignment:
    w_CB_address <= CB_address(7 downto 0);
    w_CB_byte_count <= to_integer(unsigned(CB_address(11 downto 8)));
    w_CB_check_ready <= CB_address(12);
    w_CB_write_read_command <= CB_address(13);
    w_CB_release_command <= CB_address(14);
    w_CB_write_read <= CB_address(15);
    
    -- How to communicate with this entity:
    -- For everything: entity address (7 - 0)must always match of course. Numbers indicated in parentesis are the bit number of the address.
    -- First, always check ready: CB_check_ready (12) must be 1, CB_read_write(15) must be 0 (read). Will return 0x200 when ready, 0x201 when released, and 0x100 any other time. 
    -- If you want to read registers: CB_write_read (15) must be 0 (read), and indicate with CB_byte_count (11 - 8) which byte you want to read. (0x0 through 0xF)
    -- If you want to send a number of bytes via the SPI: CB_write_read (15) must be 1 (write), CB_release_command(14) must be 0. indicate with CB_byte_count
    -- how many bytes you want to send: (0x0 + 1 through 0xF + 1). Provide the SPI address byte you want to send it to on the CB_write bus at this time.
    -- If you want to write actual data to the SPI, CB_write_read_command(13) must be '1', if you just want to read a number of bytes while sending
    -- 0's, it must be 0. In case of a 1, the interface will now to into a new state. if you want to send n bytes, now you need to write to the 
    -- entity n times with a byte of data. Address must match, CB_write_read (15) must be '1', other signals are ignored.
    -- Once n bytes have been written, the interface will go into another state, waiting for the SPI interface to handle the data.
    -- Once this is completed, it will return to idle, and you can read the resulting receive bytes the normal way.
    -- KEEP IN MIND: If you want to send/read multiple bytes in one go, you must make sure the auto-increase-address option has been enabled!
    
    com_bus_interface_p: process (clk, rst) is
    begin
        if rst = '1' then
            CB_read <= X"00000100";
            state_CB <= s_idle;
            r_control_released <= '0';
            r_CBW_start_SPI <= '0';
        elsif rising_edge(clk) then
            CB_read <= X"00000100"; -- default
            r_CBW_start_SPI <= '0'; --default
            case state_CB is
                when s_idle =>
                    state_cb <= s_idle; -- default
                    if w_CB_address = Entity_address then
                        if w_CB_write_read = '0' then
                            if w_CB_check_ready = '1' then
                                CB_read <= X"00000200";
                            else
                                CB_read <= X"000000" & r_SPI_received_data(w_CB_byte_count);
                            end if;
                        else
                            if w_CB_release_command = '1' then
                                r_control_released <= '1';
                                state_CB <= s_idle_released;
                            else
                                r_CBW_counter <= 0;
                                r_CBW_SPI_address <= CB_write(7 downto 0);
                                r_CBW_byte_count <= w_CB_byte_count;
                                if w_CB_write_read_command = '0' then
                                    state_CB <= s_waiting_for_SPI_data;
                                    r_CBW_start_SPI <= '1';
                                else
                                    state_CB <= s_waiting_for_CB_data;
                                end if;
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

                when s_waiting_for_CB_data =>
                    state_CB <= s_waiting_for_CB_data; -- default
                    if w_CB_address = Entity_address and w_CB_write_read = '1' then
                        r_CBW_SPI_bytes(r_CBW_counter) <= CB_write(7 downto 0);                        
                        if r_CBW_counter = r_CBW_byte_count then
                            state_CB <= s_waiting_for_SPI_data;
                            r_CBW_start_SPI <= '1';
                            r_CBW_counter <= 0;
                        else
                            r_CBW_counter <= r_CBW_counter +1;
                        end if;
                    end if;

                when s_waiting_for_SPI_data =>
                    state_CB <= s_waiting_for_SPI_data; -- default
                    if r_SPI_done = '1' then
                        state_CB <= s_idle;
                    end if;

            end case;
        end if;
    end process;
        
    SPI_state_logic_p: process (clk, rst) is
    begin
        if rst = '1' then
            state_SPI <= s_idle;           
        elsif rising_edge(clk) then
            r_transmit_valid <= '0'; --default
            r_SPI_done <= '0'; --default            
            case state_SPI is
                when s_idle =>
                    state_SPI <= s_idle; -- default
                    if r_control_released = '1' then
                        state_SPI <= s_idle_released;
                    elsif r_CBW_start_SPI = '1' then
                        state_SPI <= s_tranceive_data;
                        r_transmit_byte <= r_CBW_SPI_address;
                        r_transmit_valid <= '1';
                        r_SPI_sent_counter <= 0;  
                        r_SPI_read_counter <= 0;
                        r_SPI_got_address_return <= '0';
                    end if;

                when s_idle_released =>
                    state_SPI <= s_idle_released; --default
                    if i_released_start_read = '1' then
                        state_SPI <= s_tranceive_data_released;
                        r_transmit_byte <= i_released_read_address;
                        r_transmit_valid <= '1';
                        r_SPI_sent_counter <= 0;
                        r_SPI_got_address_return <= '0';
                    end if;

                when s_tranceive_data =>
                    state_SPI <= s_tranceive_data;--default
                    if w_transeiver_ready_for_new_byte = '1' and r_SPI_sent_counter <= r_CBW_byte_count then
                        r_transmit_byte <= r_CBW_SPI_bytes(r_SPI_sent_counter);
                        r_transmit_valid <= '1';
                        r_SPI_sent_counter <= r_SPI_sent_counter +1;
                    end if;
                    if w_receive_valid = '1' then
                        if r_SPI_got_address_return = '0' then
                            r_SPI_got_address_return <= '1';                       
                        else
                            r_SPI_received_data(r_SPI_read_counter) <= w_receive_byte;
                            r_SPI_read_counter <= r_SPI_read_counter + 1;
                            if r_SPI_read_counter = r_CBW_byte_count then
                                state_SPI <= s_wait_for_idle;                                
                            end if;
                        end if;
                    end if;    

                when s_tranceive_data_released =>
                    state_SPI <= s_tranceive_data_released;--default
                    if w_transeiver_ready_for_new_byte = '1' and r_SPI_sent_counter = 0 then
                        r_transmit_byte <= X"00";
                        r_transmit_valid <= '1';
                        r_SPI_sent_counter <= 1;
                    end if;
                    if w_receive_valid = '1' then
                        if r_SPI_got_address_return = '0' then
                            r_SPI_got_address_return <= '1';                       
                        else
                            r_SPI_auto_read_data <= w_receive_byte; -- Put the new byte to the auto read data.
                            state_SPI <= s_wait_for_idle;
                            
                        end if;
                    end if;   
                    
                when s_wait_for_idle => 
                    if w_SPI_CS_n = '1' then
                        r_SPI_done <= '1';
                        if r_control_released = '1' then
                            state_SPI <= s_idle_released;
                        else
                            state_SPI <= s_idle;
                        end if;
                    end if;

            end case;
        end if;
    end process;


end architecture;