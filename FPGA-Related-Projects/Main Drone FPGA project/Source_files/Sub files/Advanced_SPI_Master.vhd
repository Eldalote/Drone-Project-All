-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- More advanced wrapper for the simple SPI master, with multi-byte read and write options
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--
-- Generic configuration:
-- MAIN_CLOCK_FREQ is the frequency of 'clk' clock input
-- SCLOCK_TARGET_FREQ is the target frequency of the slck. Note: If the main clock frequency/target frequency is not a whole number
-- the actual sclk frequency will be lower than targeted.
-- MAXIMUM_BYTE_TRANSFERS is the maximum number of bytes that will be transmitted/received in a single transmission window.
-- keeping this number higher has no adverse effect on functionality, but it may result in higher resource usage.
-- CPOL and CPHA: see the simple SPI master for clear explanation.
--
-- Mode of operation: 
-- The SPI master will only respond to control port signals while system_ready_for_commands is '1', else all singals are discarded.
-- This is done partially for simplicity, partially to prevent data errors by changing the transmission data during transmissions.
--
-- Before a transmission is started, the transmission bytes storage must be filled. This is done by presenting bytes at TX_byte_data,
-- the address of the byte (in which order are the bytes sent) and a byte valid signal. This can be done any number of times, until 
-- all the required bytes are in the storage. No bytes actually have to be filled to start a transmission, but generally, even for read
-- operations the first byte is the address, and probably should be set.
-- If multiple writes or reads happen back to back with exactly the same data, nothing has to be changed in between.
-- If multiple reads are done back to back, and only the address has to be changed, changing only byte 0 between transmissions is valid.
--
-- Once the transmission storage has been sufficently filled, a transmission can be started by presenting TX_transmit_count_min_1 
-- with a number of bytes to transmit (minus 1. 8 bytes to send(including address) is 7, 1 byte is 0, etc) and set TX_start to '1'.
--
-- Once the transmission had started, system_ready_for_commands will go low. Whenever a byte transfer has happened RX_byte_data will
-- present the data read back from the slave. RX_byte_number indicates which byte it is (for ease of storage) and TX_byte_valid is the 
-- signal that RX_byte_data is valid and can be read.
--
-- Once the transmission is fully complete, the system will return to start, and system_ready_for_commands will go high again.
--
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Created by Jan Mart Liewes. Verified by testbench, not yet tested in system.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Advanced_SPI_Master is
    Generic(
        MAIN_CLOCK_FREQ                 : in natural := 100_000_000;
        SCLOCK_TARGET_FREQ              : in natural := 25_000_000;
        MAXIMUM_BYTE_TRANSFERS          : in natural := 128;
        CPOL_clock_polarity             : in std_logic := '0';
        CPHA_clock_phase                : in std_logic := '0'
    );
    port (
        --- Standard system port ---     
        clk                             : in  std_logic;
        rst                             : in  std_logic;

        --- SPI Wires port ---
        o_SPI_MOSI                      : out STD_LOGIC;
        i_SPI_MISO                      : in STD_LOGIC;
        o_SPI_SCLK                      : out STD_LOGIC;
        o_SPI_CSn                       : out STD_LOGIC;

        --- Control port ---
        i_TX_byte_data                  : in STD_LOGIC_VECTOR(7 downto 0);
        i_TX_byte_address               : in integer range 0 to MAXIMUM_BYTE_TRANSFERS -1;
        i_TX_byte_valid                 : in STD_LOGIC;
        i_TX_transmit_count_min_1       : in integer range 0 to MAXIMUM_BYTE_TRANSFERS -1;
        i_TX_start                      : in STD_LOGIC;

        o_RX_byte_data                  : out STD_LOGIC_VECTOR(7 downto 0);
        o_RX_byte_number                : out integer range 0 to MAXIMUM_BYTE_TRANSFERS -1;
        o_RX_byte_valid                 : out STD_LOGIC;

        o_system_ready_for_commands     : out STD_LOGIC
        
        
        
    );
end entity;

architecture rtl of Advanced_SPI_Master is
    -- Ram block and orders -- 
    type t_transmit_bytes is array(0 to MAXIMUM_BYTE_TRANSFERS -1) of STD_LOGIC_VECTOR(7 downto 0);
    signal r_transmit_bytes         : t_transmit_bytes := (others => (others => '0'));
    signal r_transmit_count_target  : integer range 0 to MAXIMUM_BYTE_TRANSFERS -1 := 0;
    signal r_tranmitting_done       : STD_LOGIC := '0';
    
    -- Registers and wires for communication with simple SPI master -- 
    signal r_simple_TX_byte         : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal r_simple_TX_valid        : STD_LOGIC := '0';
    signal w_simple_ready_for_data  : STD_LOGIC;
    signal w_simple_RX_byte         : STD_LOGIC_VECTOR(7 downto 0);
    signal w_simple_RX_valid        : STD_LOGIC;
    signal w_simple_CSn             : STD_LOGIC;
    
    -- State machine, and registers for state machine operations -- 
    type t_state is (s_idle, s_tranceiving, s_wait_for_idle);
    signal state                    : t_state := s_idle;
    signal r_transmit_count         : integer range 0 to MAXIMUM_BYTE_TRANSFERS -1 := 0;
    signal r_receive_count          : integer range 0 to MAXIMUM_BYTE_TRANSFERS -1 := 0;
    
begin
    
    Simple_SPI_Master_inst: entity work.Simple_SPI_Master
        generic map (
            CPOL_clock_polarity  => CPOL_clock_polarity,
            CPHA_clock_phase     => CPHA_clock_phase,
            sclock_divider       => MAIN_CLOCK_FREQ / SCLOCK_TARGET_FREQ
        )
        port map (
            clk                  => clk,
            rst                  => rst,
            i_TX_byte            => r_simple_TX_byte,
            i_TX_valid           => r_simple_TX_valid,
            o_ready_for_new_byte => w_simple_ready_for_data,
            o_RX_byte            => w_simple_RX_byte,
            o_RX_valid           => w_simple_RX_valid,
            o_SPI_clock          => o_SPI_SCLK,
            o_CS_n               => w_simple_CSn,
            o_MOSI               => o_SPI_MOSI,
            i_MISO               => i_SPI_MISO
        );    
    
    o_SPI_CSn       <= w_simple_CSn;
    o_RX_byte_data  <= w_simple_RX_byte;
    o_RX_byte_valid <= w_simple_RX_valid;
    o_system_ready_for_commands <= '1' when (state = s_idle and i_TX_start = '0') else '0';

    State_p: process (clk) is
    begin
        if rising_edge(clk) then
            o_RX_byte_number <= r_receive_count; -- Done on clock.
            r_simple_TX_valid <= '0'; --Default
            case state is
                when s_idle =>
                    state <= s_idle; -- Default
                    if i_TX_byte_valid = '1' then
                        r_transmit_bytes(i_TX_byte_address) <= i_TX_byte_data;
                    end if;
                    if i_TX_start = '1' then
                        r_transmit_count_target <= i_TX_transmit_count_min_1;
                        r_transmit_count <= 0;
                        r_receive_count <= 0;
                        r_tranmitting_done <= '0';
                        state <= s_tranceiving;
                    end if;

                when s_tranceiving =>
                    state <= s_tranceiving; -- default
                    if w_simple_ready_for_data = '1' and r_transmit_count <= r_transmit_count_target and r_tranmitting_done = '0' then
                        r_simple_TX_byte <= r_transmit_bytes(r_transmit_count);
                        r_simple_TX_valid <= '1';
                        if r_transmit_count < r_transmit_count_target then
                            r_transmit_count <= r_transmit_count + 1;
                        else 
                            r_tranmitting_done <= '1';
                        end if;
                    end if;
                    if w_simple_RX_valid = '1' then                        
                        if r_receive_count = r_transmit_count_target then -- -1????
                            state <= s_wait_for_idle;
                        else
                            r_receive_count <= r_receive_count + 1;
                        end if;
                    end if;
                    
                when s_wait_for_idle =>
                    state <= s_wait_for_idle; --Default
                    if w_simple_CSn = '1' then
                        state <= s_idle;                       
                    end if;                    

            end case;            
            if rst = '1' then
                state <= s_idle;
            end if;
        end if;
    end process;

    
    
    
    
end architecture;