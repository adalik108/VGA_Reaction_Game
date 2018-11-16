----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2018 15:48:44
-- Design Name: 
-- Module Name: tb_Sound_Control - Behavioral
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

entity tb_Sound_Control is
--  Port ( );
end tb_Sound_Control;

architecture Behavioral of tb_Sound_Control is
component Sound_Control is
    Generic ( 
period: integer:=256;   -- Period is 10 ns * period generic. ex for 100 Hz period should be 1,000,000
width : integer := 9);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           winner_select: in STD_LOGIC_Vector(3 downto 0);
           buzzer_out : out STD_LOGIC
           );
end component;
signal clk,reset,enable:std_logic:='0';
signal winner_select:std_logic_vector(3 downto 0):="0000";
signal buzzer_out: std_logic;
begin

uut: Sound_Control port map(clk,reset,enable,winner_select,buzzer_out);

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
wait;
end process;

winner_control:process
begin
wait for 10000 ns;
winner_select<="0001";
wait for 10000 ns;
winner_select<="0010";
wait for 10000 ns;
winner_select<="0011";
wait for 10000 ns;
winner_select<="0100";
wait for 10000 ns;
winner_select<="1000";
wait for 10000 ns;
winner_select<="0000";
wait;

end process;

end Behavioral;
