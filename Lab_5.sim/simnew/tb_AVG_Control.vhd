----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2018 04:06:28 PM
-- Design Name: 
-- Module Name: tb_AVG_Control - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_AVG_Control is
--  Port ( );
end tb_AVG_Control;

architecture Behavioral of tb_AVG_Control is
component AVG_Control is
Port (
    clk: in std_logic;
reset: in std_logic;
enable: in std_logic;
winner_select: in STD_LOGIC_VECTOR(3 downto 0);
round_winner: in STD_LOGIC_VECTOR(3 downto 0);
binary_time: in STD_LOGIC_VECTOR(13 downto 0);
dig1: out std_logic_vector(3 downto 0);
dig2: out std_logic_vector(3 downto 0);
dig3: out std_logic_vector(3 downto 0);
dig4: out std_logic_vector(3 downto 0));
end component;

signal clk,reset,enable:std_logic:='0';
signal winner_select,round_winner:STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');
signal binary_time:std_logic_vector(13 downto 0):=(7=>'1', others=>'0');
signal dig1,dig2,dig3,dig4:STD_LOGIC_VECTOR(3 downto 0);



begin

uut: AVG_Control Port Map(clk,reset,enable,winner_select,round_winner,binary_time,dig1,dig2,dig3,dig4);

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

enable_control:process
begin
wait for 250 ns;
enable<='1';
--wait for 100 ns;
--reset<='0';
wait;
end process;

round_control:process
begin
wait for 120 ns;
for i in 0 to 9 loop
    round_winner<="1000";
    wait for 20 ns;
    round_winner<="0000";
    wait for 80 ns;
end loop;

wait;
end process;

winner_control:process
begin
wait for 1060 ns;
winner_select<="1000";
wait;
end process;



end Behavioral;
