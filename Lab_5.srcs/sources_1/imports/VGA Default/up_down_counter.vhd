library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity up_down_counter is
	Generic ( WIDTH: integer:= 6);
	Port (
		up: in STD_LOGIC;
		down: in STD_LOGIC;
		clk: in std_logic;
		reset: in std_logic;
		enable: in std_logic;
        val: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end up_down_counter;

architecture Behavioral of up_down_counter is

signal current_val: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
signal enable_Q: std_logic;
signal up_Q: std_logic;

-- Create a logic vector of proper length filled with zeros (also done during synthesis)
constant zeros: 			std_logic_vector(WIDTH-1 downto 0) := (others => '0');

begin

    RisingEdge: process(clk,reset,enable)
    begin
        if(reset='1') then
            enable_Q<='0';
            up_Q<='0';
        elsif(rising_edge(clk)) then
            up_Q<=up;
            enable_Q<=enable;
        end if;
    end process;

	Count: process(clk, reset)
	begin
        -- Asynchronous reset
	    if (reset = '1') then
	       current_val <= zeros; -- Set output to 0
		elsif (rising_edge(clk)) then	
			if ((up and (not up_Q))='1' and (enable and (not enable_Q))='1') then
				current_val <= current_val + "101000";
			elsif ((up and (not up_Q))='1' and (enable and (not enable_Q))='1') then
				current_val <= current_val - "101000";
			end if;
		end if;
	end process Count;

val <= current_val;

end Behavioral;