----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2018 02:30:01 PM
-- Design Name: 
-- Module Name: tb_PRNG_Delay - Behavioral
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

entity tb_PRNG_Delay is
--  Port ( );
end tb_PRNG_Delay;

architecture Behavioral of tb_PRNG_Delay is
component PRNG_Delay is
    generic( RandomWidth:integer:= 16);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           outreset: in STD_LOGIC;
           enable: in STD_LOGIC;
           prngdelay : out STD_LOGIC);
end component;
signal clk_tb,reset_tb,enable_tb,outreset_tb:std_logic:='0';
signal prngdelay_tb:std_logic;
begin
uut: PRNG_DELAY Port Map(clk_tb,reset_tb,outreset_tb,enable_tb,prngdelay_tb);

clk_control:process
begin
wait for 10 ns;
clk_tb<='1';
wait for 10 ns;
clk_tb<='0';
end process;

reset_control:process
begin
wait for 10 ns;
reset_tb<='1';
wait for 100 ns;
reset_tb<='0';
wait;
end process;

outreset_control:process
begin
wait for 200 ns;
outreset_tb<='1';
wait for 10 ns;
outreset_tb<='0';
wait;
end process;


enable_control:process
begin
wait for 120 ns;
enable_tb<='1';
wait for 2000 ns;
enable_tb<='0';
end process;
end Behavioral;
