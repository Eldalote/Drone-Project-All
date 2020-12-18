-- "simple" SPI master. Simple in the sense that it does not include a chip select signal (and needs a higher level entity to do this, and multiple slaves on the lines)
-- It is designed to send a byte at a time. A second byte can be stored in this, so it is immediately send after the first. 
---------------
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
--
-- sclock_divider will dictate the clockrate of the sclock. a divider of 4 with a main clock of 100MHz will result in an sclock of 25MHz. Divider must be minimum of 4, and always a multiple of 2.
--------------
-- Created on 29-06-2019 by Jan Mart Liewes
-- Verified on 01-07-2019 by Jan Mart Liewes --verified for cpol 0 and cpha 0 only. assumed the others work too. Please verify before using other modes.




library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity Simple_SPI_Master is
    generic(
        CPOL_clock_polarity     : std_logic := '0';
        CPHA_clock_phase        : std_logic := '0';
        sclock_divider          : integer  := 4 -- minimum 4, multiple of 2!
    );
    port (
        --clock and reset
        clk     : in  std_logic;
        rst     : in  std_logic;
        
        --Data to send, and its control
        i_TX_byte           : in std_logic_vector(7 downto 0);
        i_TX_valid          : in std_logic;
        o_ready_for_new_byte: out std_logic;
        
        --Received data and control
        o_RX_byte           : out std_logic_vector(7 downto 0);
        o_RX_valid          : out std_logic;
        
        -- SPI interface
        o_SPI_clock         : out std_logic;
        o_CS_n              : out std_logic; --If this master is used as a single slave spi, this can be directly exported. If used with more than 1 slave, this can be muxed in the upper level entity.
        o_MOSI              : out std_logic;
        i_MISO              : in std_logic
        
        
        
    );
end entity;

architecture rtl of Simple_SPI_Master is
    
    --Data bytes, and signals to control them.
    signal r_transmit_byte_1, r_transmit_byte_2 : std_logic_vector(7 downto 0) := X"00"; -- controlled by new bytes process
    signal r_byte_1_filled, r_byte_2_filled     : std_logic := '0'; -- controlled by new bytes process
    signal r_done_with_byte                     : std_logic := '0'; -- controlled by tranciever process
    signal r_receive_byte                       : std_logic_vector(7 downto 0) := X"00";
    signal r_bitcounter                         : integer range 0 to 7 := 7;
    
    --Signals to do with the serial clock.
    signal w_sclk_change_polarity   : std_logic;
    signal r_sclk_changed_polarity  : std_logic := '0';
    
    --State machine
    type Tstate_tranceiver is (s_idle, s_transmitting, s_reading);
    signal state : Tstate_tranceiver := s_idle;
    
    
begin
    
    sclock_change_polarity: entity work.ClockEnableGenerator
        generic map (
            DividerCount     => sclock_divider / 2 -- will generate a pure '1' at sclock_diver = 2. this causes a problem. Thus, minimum of 4.
        )
        port map (
            clk              => clk,
            rst              => rst,
            clock_enable_out => w_sclk_change_polarity
        );
    
    o_SPI_clock <= '1' when (CPOL_clock_polarity = '1' and r_sclk_changed_polarity = '0') or (CPOL_clock_polarity = '0' and r_sclk_changed_polarity = '1') else '0'; -- Output the sclock. 
    o_ready_for_new_byte <= '0' when (i_TX_valid = '1'  or r_byte_2_filled = '1') else '1';    -- Output if there is room for a new byte. Directly goes to 0 when a new byte is presented, to prevent accidental dubblewrite when there is not room for 2 bytes.
    o_RX_byte <= r_receive_byte; --Only read when valid!
                                                                                                                       
    
    processing_new_bytes_p: process (clk, rst) is
    begin
        if rst = '1' then
            r_transmit_byte_1 <= X"00";
            r_transmit_byte_2 <= X"00";
            r_byte_1_filled <= '0';
            r_byte_2_filled <= '0';
            
        elsif rising_edge(clk) then
            if i_TX_valid = '1' then -- receive new byte
                if r_byte_1_filled = '0' then
                    r_transmit_byte_1 <= i_TX_byte;
                    r_byte_1_filled <= '1';
                else
                    r_transmit_byte_2 <= i_TX_byte;
                    r_byte_2_filled <= '1';
                end if;
            end if;
            if r_done_with_byte = '1' then -- shift bytes over if the tranceiver is done with a byte.
                if r_byte_2_filled = '1' then
                    r_transmit_byte_1 <= r_transmit_byte_2;
                    r_byte_1_filled <= '1';
                    r_byte_2_filled <= '0';
                else
                    r_byte_1_filled <= '0';
                end if;
            end if;           
            
            
        end if;
    end process;
    
    
    tranceiver_process: process (clk, rst) is
    begin
        if rst = '1' then
            r_done_with_byte <= '0';
            r_sclk_changed_polarity <= '0';
            r_bitcounter <= 7;
            r_receive_byte <= X"00";
            state <= s_idle;
            o_RX_valid <= '0';
            o_MOSI <= '0';
            o_CS_n <= '1';
        elsif rising_edge(clk) then
            o_RX_valid <= '0'; --default option
            r_done_with_byte <= '0'; --Default
            if w_sclk_change_polarity = '1' then
                case state is
                    when s_idle =>
                        r_bitcounter <= 7;
                        r_sclk_changed_polarity <= '0'; -- when idle, clock is at CPOL polarity.
                        if r_byte_1_filled = '1' then
                            o_CS_n <= '0';
                            if CPHA_clock_phase = '0' then --if 0, imediately set data on mosi. on next sclock phase change, read. 
                                o_MOSI <= r_transmit_byte_1(r_bitcounter);
                                state <= s_reading;
                            else --if 1, wait a tiny bit before changing the sclock phase, and present data on mosi with sclock phase change
                                state <= s_transmitting;
                            end if;
                        else
                            state <= s_idle;
                            o_CS_n <= '1';
                        end if;
                        
                    when s_transmitting =>
                        state <= s_reading; -- after a bit is transmitted, always go to the reading
                        r_sclk_changed_polarity <= not r_sclk_changed_polarity;
                        o_MOSI <= r_transmit_byte_1(r_bitcounter);
                        if r_bitcounter = 0 then
                            r_done_with_byte <= '1';
                        end if;
                        
                    when s_reading =>
                        r_sclk_changed_polarity <= not r_sclk_changed_polarity;                        
                        r_receive_byte(r_bitcounter) <= i_MISO;
                        if r_bitcounter = 0 then --last bit read.
                            o_RX_valid <= '1'; --override default. back to '0' on next main clock tick.
                            if r_byte_1_filled = '1' then --if the next byte has been loaded already
                                r_bitcounter <= 7;
                                state <= s_transmitting;
                            else
                                state <= s_idle;
                            end if;
                        else
                            r_bitcounter <= r_bitcounter -1;
                            state <= s_transmitting;
                        end if;
                        
                        
                end case;
                

            end if;
            
        end if;
    end process;


    
    
    
    
    
    

end architecture;