----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2018 14:15:13
-- Design Name: 
-- Module Name: tb_Game_Control - Behavioral
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

entity tb_Game_Control is
--  Port ( );
end tb_Game_Control;

architecture Behavioral of tb_Game_Control is

component Game_Control is
    Port ( 
    clk: in std_logic;
    reset: in std_logic;
    enable: in std_logic;
    dig1: out std_logic_vector(3 downto 0);
    dig2: out std_logic_vector(3 downto 0);
    dig3: out std_logic_vector(3 downto 0);
    dig4: out std_logic_vector(3 downto 0);
    binary_time: out std_logic_vector(13 downto 0);
    ledflash: out std_logic
    );
end component;

signal clk,reset,enable:std_logic:='0';
signal dig1,dig2,dig3,dig4:std_logic_Vector(3 downto 0);
signal binary_time:std_logic_Vector(13 downto 0);
signal ledflash:std_logic;

begin

uut: Game_Control port map(clk,reset,enable,dig1,dig2,dig3,dig4,binary_time,ledflash);

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
wait for 250 ns;
enable<='0';
--wait for 100 ns;
--reset<='0';

end process;


end Behavioral;
