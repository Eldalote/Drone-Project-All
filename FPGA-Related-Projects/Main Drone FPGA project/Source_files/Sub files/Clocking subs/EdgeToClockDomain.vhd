-- Simple function get an "edge" of a slow signal onto the main clock domain.
-- It will generate a single clock width pulse each time the slow signal goes from low to high.
-- created on ??-06-2019 by Jan Mart Liewes
-- Verified on 29-06-2019 by Jan Mart Liewes


library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity EdgeToClockDomain is
	port (
		clk: in  std_logic;
		rst: in  std_logic;
		to_detect: in std_logic;
		edge_out: out std_logic
	);
end entity;

architecture rtl of EdgeToClockDomain is
	type Tstate is (state_wait, state_high);
	signal state : Tstate := state_wait;
begin
	edge_detection: process (clk, rst) is
	begin
		if rst = '1' then
			state <= state_wait;
			edge_out <= '0';
		elsif rising_edge(clk) then
			case state is
				when state_wait =>
					
					if to_detect = '1' then
						state <= state_high;
						edge_out <= '1';
					else
						state <= state_wait;
						edge_out <= '0';
					end if;
						
				
				when state_high =>
					edge_out <= '0';
					if to_detect = '1' then
						state <= state_high;
						
					else
						state <= state_wait;
						
					end if;

			end case;
		end if;
	end process;

end architecture;