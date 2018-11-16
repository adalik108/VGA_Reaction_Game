----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2018 15:23:56
-- Design Name: 
-- Module Name: tb_Menu_Control - Behavioral
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

entity tb_Menu_Control is
--  Port ( );
end tb_Menu_Control;

architecture Behavioral of tb_Menu_Control is

component Menu_Control is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           winner_select: in STD_LOGIC_VECTOR(3 downto 0);
           button_1_score: in STD_LOGIC_VECTOR(3 downto 0);
           button_2_score: in STD_LOGIC_VECTOR(3 downto 0);
           button_3_score: in STD_LOGIC_VECTOR(3 downto 0);
           button_4_score: in STD_LOGIC_VECTOR(3 downto 0);
           dig1 : out STD_LOGIC_VECTOR (3 downto 0);
           dig2 : out STD_LOGIC_VECTOR (3 downto 0);
           dig3 : out STD_LOGIC_VECTOR (3 downto 0);
           dig4 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal clk,reset,enable:std_logic:='0';
signal winner_select,button_1_score,button_2_score,button_3_score,button_4_score:std_logic_vector(3 downto 0):="0000";
signal dig1,dig2,dig3,dig4:std_logic_vector(3 downto 0);

begin

uut: Menu_Control Port map(clk,reset,enable,winner_select,button_1_score,button_2_score,button_3_score,button_4_score,dig1,dig2,dig3,dig4);

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

score_control:process
begin
wait for 200 ns;
button_1_score<="0001";
button_2_score<="1000";
button_3_score<="0100";
button_4_score<="0010";
wait;
end process;

winner_control:process
begin
wait for 1060 ns;
winner_select<="1000";
wait;
end process;


end Behavioral;
