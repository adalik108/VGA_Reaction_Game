----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2018 15:42:21
-- Design Name: 
-- Module Name: tb_display_top_level - Behavioral
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

entity tb_display_top_level is
--  Port ( );
end tb_display_top_level;

architecture Behavioral of tb_display_top_level is

component display_top_level is
    Port ( 
           clk: in std_logic;
           reset: in std_logic;
           dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           dig3 : in STD_LOGIC_VECTOR (3 downto 0);
           dig4 : in STD_LOGIC_VECTOR (3 downto 0);
           segC : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (3 downto 0);
           DP : out STD_LOGIC);
end component;

signal clk,reset: std_logic:='0';
signal dig1,dig2,dig3,dig4:std_logic_vector(3 downto 0);
signal segC:std_logic_Vector(6 downto 0);
signal AN: std_logic_vector(3 downto 0);
signal DP: std_logic;

begin

uut: display_top_level port map(clk,reset,dig1,dig2,dig3,dig4,segC,AN,DP);

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
wait for 10 ns;
dig1<="0001";
dig2<="0010";
dig3<="0011";
dig4<="0100";

wait;
end process;


end Behavioral;
