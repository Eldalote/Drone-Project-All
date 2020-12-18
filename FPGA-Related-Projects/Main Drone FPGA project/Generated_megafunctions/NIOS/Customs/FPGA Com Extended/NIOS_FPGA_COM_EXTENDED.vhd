-- Custom instruction set for the NIOS 2 processor. It is designed to read, write, or both to FPGA entity slaves in a single NIOS instruction.
-- It is a Multicycle extended instruction, with a 2 bit n.
-- N = 00 => read only
-- N = 01 => write only
-- N = 10 => Write and read
-- This is a redesign of the older system already in use, to correct a weird timing issue, which results in a double write action.
-- The communication bus on the FPGA side consists of 3 busses, CB_address (16 bits), CB_write(32 bits) and CB_read(32 bits)
-- Since tri-stating nodes within the FPGA is not possible, and there is only 1 input into the instruction, a read mux must be implemented. (already implemented in the design)
-- Created on 12-07-2019 by Jan Mart Liewes





library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity NIOS_FPGA_COM_EXTENDED is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        clk_en  : in std_logic;
        dataa   : in std_logic_vector(31 downto 0);
        datab   : in std_logic_vector(31 downto 0);
        result  : out std_logic_vector(31 downto 0);
        start   : in std_logic;
        done    : out std_logic;
        n       : in std_logic_vector(1 downto 0);

        CB_address  : out std_logic_vector(15 downto 0);
        CB_write    : out std_logic_vector(31 downto 0);
        CB_read     : in std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of NIOS_FPGA_COM_EXTENDED is
    type Tstate is (s_idle, s_wait_for_read, s_read_in, s_wait_for_done);
    signal state                    : Tstate := s_idle;
    signal r_read_data_capture      : std_logic_vector(31 downto 0) := (others => '0');
    signal r_done_with_operations   : std_logic := '0';
    signal r_should_send_done       : std_logic := '0';
    signal r_done_signal            : std_logic := '0';
    
    constant READ_ONLY: std_logic_vector(1 downto 0) := "00";
    constant WRITE_ONLY: std_logic_vector(1 downto 0) := "01";
    constant WRITE_READ: std_logic_vector(1 downto 0) := "10";
begin
    
    done <= r_done_signal;
    
    --This process handles the communication back to the NIOS. is cares about the clk_en signal, since it should wait with outputting 
    --As long as clk_en is low.
    present_done_and_data_p: process (clk, rst) is
    begin
        if rst = '1' then
            r_done_signal <= '0';
            result <= (others => '0');
        elsif rising_edge(clk) then
            r_done_signal <= '0'; --Default
            result <= (others => '0'); --Default
            if r_done_with_operations = '1' then -- If the CB process is done, check if clk_en is on or not
                if clk_en = '1' then
                    r_done_signal <= '1'; --If it is, send out the captured data, and the done signal
                    result <= r_read_data_capture;
                else
                    r_should_send_done <= '1'; --If not, set a reminder to send out done and data at the earliest possible moment
                end if;
            elsif clk_en = '1' and r_should_send_done = '1' then --If clk_en is 1, and the reminder is set
                r_done_signal <= '1'; --Send out the done and data, and clear the reminder.
                result <= r_read_data_capture;
                r_should_send_done <= '0';
            end if;
        end if;
    end process;

    
    --This process does the communications with the FPGA entities. Is does not concern itself with the clk_en signal, since the com bus is timing
    --sensitive. It asserts a done with operations signal, telling the process above to communicate to the NIOS that the instruction is done.
    CB_process: process (clk, rst) is
    begin
        if rst = '1' then
            CB_address <= (others => '0');
            CB_write <= (others => '0');
        elsif rising_edge(clk) then
            CB_address <= (others => '0'); --Defaults
            CB_write <= (others => '0'); --Defaults
            r_done_with_operations <= '0'; --Defaults
            case state is
                when s_idle =>
                    state <= s_idle; --Default
                    if start = '1' then --If the start signal is given, check which mode is selected.
                        if n = READ_ONLY then --If read only, set the addres, data can keep 0's. Go to wait for read state.
                            CB_address <= '0' & dataa(14 downto 0);
                            state <= s_wait_for_read;
                        elsif n = WRITE_ONLY then --If write only, set address and data, and we're done, go to wait for done state.
                            CB_address <= '1' & dataa(14 downto 0);
                            CB_write <= datab;
                            state <= s_wait_for_done;
                            r_read_data_capture <= (others => '0');
                            r_done_with_operations <= '1';
                        elsif n = WRITE_READ then --If write and read, set address and data, and go to wait for read state.
                            CB_address <= '1' & dataa(14 downto 0);
                            CB_write <= datab;
                            state <= s_wait_for_read; 
                        else --Wait, this shouldn't ever happen right? We're done (else we're gonna hold up the instruction forever) and send out some sort of error code.
                            r_done_with_operations <= '1';
                            r_read_data_capture <= X"F0F0F0F0";
                        end if;
                    end if;
            
                when s_wait_for_read =>
                    state <= s_read_in; --We're just waitin a single clock cycle for the FPGA entities to present data on the read line.
                    --Because of the default statements, address and data are now back to 0's.

                when s_read_in =>
                    r_done_with_operations <= '1'; --We clock in the data on the readline, and we're done with operations. Go to wait for done state.
                    r_read_data_capture <= CB_read;
                    state <= s_wait_for_done;
                    
                when s_wait_for_done =>
                    state <= s_wait_for_done; --Default
                    if r_done_signal = '1' then --If the done signal is being sent out, return to the idle state.
                        state <= s_idle; --If everything goes right, this is not needed. But, this makes sure we can't accidentally go back to idle
                        --And somehow send out some data again, before the done signal is given. We're just taking weird timing into account.
                    end if;
            end case;
        end if;
    end process;
end architecture;