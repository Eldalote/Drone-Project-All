

-- It supports all four SPI modes.
-- Generic options: CPOL and CHPA sets the 4 spi modes.
-- CPOL: Clock Polarity
-- CPOL=0 means clock idles at 0, leading edge is rising edge.
-- CPOL=1 means clock idles at 1, leading edge is falling edge.
-- CPHA: Clock Phase
-- CPHA=0 means the "out" side changes the data on trailing edge of clock
--              the "in" side captures data on leading edge of clock
-- CPHA=1 means the "out" side changes the data on leading edge of clock
--              the "in" side captures data on the trailing edge of clock




library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity SPI_snooper is
    generic(
        CPOL_clock_polarity     : std_logic := '0';
        CPHA_clock_phase        : std_logic := '0'
    );
    
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        ---SPI port
        i_SCLK              : in STD_LOGIC;
        i_CSn               : in STD_LOGIC;
        i_MISO              : in STD_LOGIC;
        i_MOSI              : in STD_LOGIC;
        
        --- Snooper output
        o_new_transaction   : out STD_LOGIC;
        o_end_transaction   : out STD_LOGIC;
        o_master_out_byte   : out STD_LOGIC_VECTOR(7 downto 0);        
        o_slave_out_byte    : out STD_LOGIC_VECTOR(7 downto 0);
        o_byte_number       : out STD_LOGIC_VECTOR(7 downto 0);
        o_data_out_valid    : out STD_LOGIC
        
    );
end entity;

architecture rtl of SPI_snooper is
    signal r_SCLK           : STD_LOGIC := CPOL_clock_polarity;
    signal r_last_SCLK      : STD_LOGIC := CPOL_clock_polarity;
    signal r_CSn            : STD_LOGIC := '1';
    signal r_last_CSn       : STD_LOGIC := '1';
    signal r_MISO           : STD_LOGIC := '0';
    signal r_MOSI           : STD_LOGIC := '0';
    
    signal r_master_out_byte    : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal r_slave_out_byte     : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal r_bit_counter        : integer range 0 to 7 := 7;
    signal r_first_clock_passed : STD_LOGIC := '0';
    signal r_byte_counter       : integer range 0 to 255 :=0;
    
    type Tstate is (s_idle, s_reading);
    signal state                : Tstate := s_idle;
    
    function select_edge return STD_LOGIC is        
    begin
        if (CPOL_clock_polarity = CPHA_clock_phase) then
            return '1';
        else
            return '0';
        end if;
    end function;
    
    constant READ_EDGE      : STD_LOGIC := select_edge;
    
begin
    
    my_process_sp: process (clk) is
    begin
        if rising_edge(clk) then
            ---Defaults:
            o_new_transaction <= '0'; 
            o_end_transaction <= '0';            
            o_data_out_valid <= '0';
            --- end defaults
            
            --- SPI signals synchronizing:
            r_SCLK <= i_SCLK;
            r_last_SCLK <= r_SCLK;
            r_CSn <= i_CSn;
            r_last_CSn <= r_CSn;
            r_MISO <= i_MISO;
            r_MOSI <= i_MOSI;
            
            case state is
                when s_idle =>
                    state <= s_idle;
                    if r_CSn = '0' and r_last_CSn = '1' then
                        state <= s_reading;                        
                        r_master_out_byte <= (others => '0');
                        r_slave_out_byte <= (others => '0');
                        r_bit_counter <= 7;
                        o_new_transaction <= '1';
                        r_first_clock_passed <= '0';
                        r_byte_counter <= 0;
                    end if;

                when s_reading =>
                    state <= s_reading;
                    if r_CSn = '1' then 
                        state <= s_idle;
                        o_master_out_byte <= r_master_out_byte;
                        o_slave_out_byte <= r_slave_out_byte;
                        o_data_out_valid <= '1';
                        o_byte_number <= STD_LOGIC_VECTOR(to_unsigned(r_byte_counter, 8));
                        o_end_transaction <= '1';
                    else
                        if r_SCLK = READ_EDGE and r_last_SCLK /= READ_EDGE then
                            r_master_out_byte(r_bit_counter) <= r_MOSI;
                            r_slave_out_byte(r_bit_counter) <= r_MISO;
                            r_bit_counter <= r_bit_counter - 1;
                            if r_bit_counter = 7 then
                                if r_first_clock_passed = '1' then
                                    o_master_out_byte <= r_master_out_byte;
                                    o_slave_out_byte <= r_slave_out_byte;
                                    o_data_out_valid <= '1';
                                    o_byte_number <= STD_LOGIC_VECTOR(to_unsigned(r_byte_counter, 8));
                                    r_byte_counter <= r_byte_counter + 1;
                                else
                                    r_first_clock_passed <= '1';
                                end if;
                            end if;                            
                        end if;                        
                    end if;            

            end case;
            
            
            if (rst = '1') then
                r_master_out_byte <= (others => '0');
                r_bit_counter <= 7;
                r_slave_out_byte <= (others => '0');
                state <= s_idle;
            end if;
        end if;
    end process;

end architecture;