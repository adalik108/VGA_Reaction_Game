----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2018 14:02:38
-- Design Name: 
-- Module Name: tb_Game_Top_Level - Behavioral
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

entity tb_Game_Top_Level is
--  Port ( );
end tb_Game_Top_Level;

architecture Behavioral of tb_Game_Top_Level is

component Game_Top_Level is
    Port ( 
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        modecntrl: in std_logic;
        button_1: in std_logic;
        button_2: in std_logic;
        button_3: in std_logic;
        button_4: in std_logic;
        ledout: out std_logic;
        buzzerout: out std_logic;
        CA: out std_logic;
        CB: out std_logic;
        CC: out std_logic;
        CD: out std_logic;
        CE: out std_logic;
        CF: out std_logic;
        CG: out std_logic;
        DP: out std_logic;
        AN1: out std_logic;
        AN2: out std_logic;
        AN3: out std_logic;
        AN4: out std_logic
    );
end component;

signal ledout,buzzerout,CA,CB,CC,CD,CE,CF,CG,DP,AN1,AN2,AN3,AN4:Std_logic;
signal clk,reset,enable,modecntrl,button_1,button_2,button_3,button_4:std_logic:='0';
begin


uut: Game_Top_Level port map(clk,reset,enable,modecntrl,button_1,button_2,button_3,button_4,ledout,buzzerout,CA,CB,CC,CD,CE,CF,CG,DP,AN1,AN2,AN3,AN4);

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

button1_control:process
begin
    wait for 100ns;
    button_1<=ledout;
    wait for 100ns;
    button_1<='0';
end process;


end Behavioral;
