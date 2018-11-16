----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2018 15:31:57
-- Design Name: 
-- Module Name: Debouncer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncer is
    Port ( Input : in STD_LOGIC;
           clk:    in STD_LOGIC;
           reset:  in STD_LOGIC;
           Input_DB : out STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is
signal Input_Q1,Input_Q2,Input_Q1Q2XOR,Cout,nCout: std_logic;


component upcounter is
   Generic ( period : integer:= 4;
             WIDTH  : integer:= 3
           );
      PORT (  clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              enable : in  STD_LOGIC;
              zero   : out STD_LOGIC;
              value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end component;

begin

first_DFF: process(clk,reset)
begin
    if(reset = '1') then
    input_Q1 <= '0';
    elsif (rising_edge(clk)) then
        input_Q1<=input;
    end if;
end process;

second_DFF: process(clk,reset)
begin
    if(reset = '1') then
        input_Q2 <= '0';
    elsif (rising_edge(clk)) then
        input_Q2<=input_Q1;
    end if;
end process;

Input_Q1Q2XOR<= (input_Q2 xor input_Q1);    

COUNTER: upcounter
generic map(
           period => (5),   -- divide by 100_000 to divide 100 MHz down to 1000 Hz (100 for tests)
           WIDTH  => 3             -- 20 bits are required to hold the binary value of 11000011010100000
          )
PORT MAP (
           clk    => clk,
           reset  => Input_Q1Q2XOR,
           enable => nCout,
           zero   => Cout, -- Proof code has been running for 1 ms 
           value  => open  -- Leave open since we won't display this value
        );

nCout <= not Cout;

third_DFF: process(clk,reset,Cout)
begin
    if(reset='1') then
    Input_DB <= '0';
    elsif (rising_edge(clk)) then
        if (Cout='1') then
           Input_DB <= Input_Q2;
        end if;
    end if;
end process;


end Behavioral;
