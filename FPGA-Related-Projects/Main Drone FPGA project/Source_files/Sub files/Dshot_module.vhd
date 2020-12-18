-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Dshot module for communication with Dshot capable ESCs. Transmit only for now.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- The module takes 2 inputs; 11 bits of throttle (or control signals) data to be sent, and 1 bit telemetry request. both must be valid at transmit_valid.
-- The module has 2 outputs; ready for data, for internal use, and the self clocking data output to the ESC.
-- Dshot uses a system of variable length pulses to denote 1's and 0's. 
-- https://dmrlawson.co.uk/index.php/2017/12/04/dshot-in-the-dark/ is an excelent source of detailed information on the protocol.
-- 
--
-- The statemachine has four states. In idle it waits for the transmit valid command. Once it is received, the transmission starts instantly.
-- The signal for the first bit goes high, and the complete message is calculated with CRC, all on the very first clock tick.
-- Then, the SM goes into regular transmission mode. For each bit to be sent, it will first sent out a '1' for a period of time. (dependant on which baud rate is chosen)
-- If the bit to be sent is a '0', after about 35% of the bit period, the signal goes low. If the bit to be sent is a '1', the output goes low after about 75% of the bit period.
-- Once the bit period is done, the process starts again for the next bit. Once all 16 bits have been sent, the module waits, going low, for another 21 bit periods. 
-- According to documentation I have found so far, it must go low for AT LEAST 2 bit periods, but 21 bit periods is recommended. 
-- With the recommended low period, Dshot 600 enables a loop frequency of 16KHz, more than enough for the used sensors in the drone project. Dshot 1200 is possible, but not needed, although, it could 
-- theoretically improve reaction time.
--
--
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Created by Jan Mart Liewes. Verified by testbench, limited tested in system.
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Dshot_module is
    generic(
        Main_clock_frequency: in natural := 100_000_000;
        Dshot_frequency     : in natural := 600
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        i_transmit_data     : in STD_LOGIC_VECTOR(10 downto 0);        
        i_telemetry_request : in STD_LOGIC;
        i_transmit_valid    : in STD_LOGIC;
        
        o_Dshot_output      : out STD_LOGIC;
        o_ready_for_data    : out STD_LOGIC
        
        
        
        
    );
end entity;

architecture rtl of Dshot_module is
    constant BIT_PERIOD         : natural := Main_clock_frequency / (Dshot_frequency * 1000);
    constant BIT_LOW_PERIOD     : natural := BIT_PERIOD * 35 / 100;
    constant BIT_HIGH_PERIOD    : natural := BIT_PERIOD * 75 / 100;    
    type Tstate is (s_idle, s_counting_high, s_counting_low, s_counting_pause);
    signal state                : Tstate := s_idle;
    signal r_message            : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_period_counter     : natural := 0;
    signal r_bit_counter        : integer range 0 to 31 := 0;
begin
    o_ready_for_data <= '1' when state = s_idle and i_transmit_valid = '0' else '0';
    
    my_process_sp: process (clk) is
    begin        
        if rising_edge(clk) then
            o_Dshot_output <= '0'; --Default
            case state is
                when s_idle =>
                    if i_transmit_valid = '1' then
                        r_message <= i_transmit_data & i_telemetry_request & 
                            ((i_transmit_data(10) xor i_transmit_data(6)) xor i_transmit_data(2)) &     --CRC
                            ((i_transmit_data(9) xor i_transmit_data(5)) xor i_transmit_data(1)) &      --CRC
                            ((i_transmit_data(8) xor i_transmit_data(4)) xor i_transmit_data(0)) &      --CRC
                            ((i_transmit_data(7) xor i_transmit_data(3)) xor i_telemetry_request);      --CRC
                        r_period_counter <= 1;
                        r_bit_counter <= 15;
                        o_Dshot_output <= '1'; --Start the transmission.
                        state <= s_counting_high;
                    else
                        state <= s_idle;
                    end if;
                        

                when s_counting_high =>
                    state <= s_counting_high;
                    r_period_counter <= r_period_counter + 1;
                    o_Dshot_output <= '1';
                    if (r_period_counter = BIT_LOW_PERIOD -1 and r_message(r_bit_counter) = '0') or r_period_counter = BIT_HIGH_PERIOD -1 then
                        if r_bit_counter = 0 then
                            state <= s_counting_pause;
                            r_bit_counter <= 21;                       
                        else                            
                            r_bit_counter <= r_bit_counter -1;
                            state <= s_counting_low;
                        end if;
                    end if;

                when s_counting_low =>
                    state <= s_counting_low;
                    r_period_counter <= r_period_counter + 1;
                    if r_period_counter = BIT_PERIOD -1 then
                        r_period_counter <= 0;                        
                        state <= s_counting_high;                        
                    end if;

                when s_counting_pause =>
                    state <= s_counting_pause;
                    r_period_counter <= r_period_counter +1;
                    if r_period_counter = BIT_PERIOD -1 then
                        r_bit_counter <= r_bit_counter -1;
                        r_period_counter <= 0;
                        if r_bit_counter = 0 then
                            state <= s_idle;
                        end if;
                    end if;
                    

            end case;
            
            if rst = '1' then
                o_Dshot_output <= '0';
                state <= s_idle;
            end if;
        end if;
    end process;

     
end architecture;