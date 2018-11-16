----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 15:35:10
-- Design Name: 
-- Module Name: tb_BCD_to_Binary - Behavioral
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

entity tb_BCD_to_Binary is
--  Port ( );
end tb_BCD_to_Binary;

architecture Behavioral of tb_BCD_to_Binary is

component BCD_to_Binary is
    Port ( 
       clk: in STD_Logic;
       reset: in std_logic;
       dig1 : in STD_LOGIC_VECTOR (3 downto 0);
       dig2 : in STD_LOGIC_VECTOR (3 downto 0);
       dig3 : in STD_LOGIC_VECTOR (3 downto 0);
       dig4 : in STD_LOGIC_VECTOR (3 downto 0);
       binary : out STD_LOGIC_VECTOR (13 downto 0));
end component;
signal clk,reset:std_logic;
signal dig1,dig2,dig3,dig4:std_logic_vector(3 downto 0):=(others=>'0');
signal binary:std_logic_vector(13 downto 0);
begin

uut: BCD_to_Binary port map (clk,reset,dig1,dig2,dig3,dig4,binary);

clk_control:process
begin
wait for 10 ns;
clk<='1';
wait for 10 ns;
clk<='0';
end process;

reset_control:process
begin
wait for 10 ns;
reset<='1';
wait for 100 ns;
reset<='0';
wait;
end process;

input_control:process
begin
dig1<=x"1";
dig2<=x"2";
dig3<=x"3";
dig4<=x"4";
wait for 20ns;
dig1<=x"4";
dig2<=x"3";
dig3<=x"6";
dig4<=x"7";
wait for 20ns;
dig1<=x"3";
dig2<=x"4";
dig3<=x"5";
dig4<=x"1";
wait;
end process;

end Behavioral;
