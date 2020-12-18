library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity SPI_Data_logger is
    generic (
        LOGGING_DEPTH       : in natural := 1024;
        ENTITY_ADDRESS      : in STD_LOGIC_VECTOR(7 downto 0) := X"01"
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        ---SPI port
        i_SCLK              : in STD_LOGIC;
        i_CSn               : in STD_LOGIC;
        i_MISO              : in STD_LOGIC;
        i_MOSI              : in STD_LOGIC;
        
        --Com bus ports
        CB_address          : in std_logic_vector(15 downto 0);
        CB_write            : in std_logic_vector(31 downto 0);
        CBR_SPI_logger      : out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of SPI_Data_logger is
    signal w_new_transaction    : STD_LOGIC;
    signal w_end_transaction    : STD_LOGIC;
    signal w_master_out_byte    : STD_LOGIC_VECTOR(7 downto 0);
    signal w_slave_out_byte     : STD_LOGIC_VECTOR(7 downto 0);
    signal w_byte_number        : STD_LOGIC_VECTOR(7 downto 0);
    signal w_data_out_valid     : STD_LOGIC;
    
    Type Tmem    is array (0 to LOGGING_DEPTH -1) of STD_LOGIC_VECTOR(23 downto 0);
    signal r_mem                : Tmem := (others => (others => '0'));
    signal r_transfer_counter   : integer range 0 to LOGGING_DEPTH -1 := 0;
    signal r_read_address       : integer range 0 to LOGGING_DEPTH -1 := 0;
    signal r_NIOS_read_address  : integer := 0;
    signal w_NIOS_return        : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
begin
    Inferred_RAM_inst: entity work.Inferred_RAM
        generic map (
            ADDRESS_RANGE   => 1024,
            MEMORY_WIDTH    => 24
        )
        port map (
            clk             => clk,            
            i_write_data    => w_byte_number & w_master_out_byte & w_slave_out_byte,
            o_read_data     => w_nios_return,
            i_write_enable  => w_data_out_valid,
            i_write_address => r_transfer_counter,
            i_read_address  => r_read_address
        );

    SPI_snooper_inst: entity work.SPI_snooper
        generic map (
            CPOL_clock_polarity => '0',
            CPHA_clock_phase    => '0'
        )
        port map (
            clk                 => clk,
            rst                 => rst,
            i_SCLK              => i_SCLK,
            i_CSn               => i_CSn,
            i_MISO              => i_MISO,
            i_MOSI              => i_MOSI,
            o_new_transaction   => w_new_transaction,
            o_end_transaction   => w_end_transaction,
            o_master_out_byte   => w_master_out_byte,
            o_slave_out_byte    => w_slave_out_byte,
            o_byte_number       => w_byte_number,
            o_data_out_valid    => w_data_out_valid
        );
    
    my_process_sp: process (clk) is
    begin
        if rising_edge(clk) then
            if w_data_out_valid = '1' then               
                if r_transfer_counter /= LOGGING_DEPTH -1 then
                    r_transfer_counter <= r_transfer_counter + 1;
                end if;
            end if;
            
            if (rst = '1') then
                r_transfer_counter <= 0;
                r_mem <= (others => (others => '0'));
            end if;
        end if;
    end process;

    com_bus_p: process (clk) is
    begin        
        if rising_edge(clk) then
            CBR_SPI_logger <= (others => '0'); -- default
            if CB_address(7 downto 0) = Entity_address then                
                if CB_address(15) = '1' then
                    r_NIOS_read_address <= to_integer(unsigned(CB_write));
                else
                    CBR_SPI_logger <= X"00" & w_NIOS_return;
                end if;                
            end if;
            if rst = '1' then
                CBR_SPI_logger      <= (others => '0');                
            end if;
            
            if r_NIOS_read_address >= LOGGING_DEPTH then
                r_read_address <= LOGGING_DEPTH -1 ;
            elsif r_NIOS_read_address < 0 then
                r_read_address <= 0;
            else
                r_read_address <= r_NIOS_read_address;
            end if;
            
           
            
        end if;
    end process;

end architecture;