----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2018 05:22:09 PM
-- Design Name: 
-- Module Name: tb_main_logic - Behavioral
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

entity tb_main_logic is
--  Port ( );
end tb_main_logic;

architecture Behavioral of tb_main_logic is

component main_logic is
    Port (  clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          enable : in STD_LOGIC;
          modecntrl : in STD_LOGIC;
          button_1  : in STD_LOGIC;
          button_2  : in STD_LOGIC;
          button_3  : in STD_LOGIC;
          button_4  : in STD_LOGIC;
          winner_select: out STD_LOGIC_VECTOR(3 downto 0);
          button_1_score: out STD_LOGIC_VECTOR(3 downto 0);
          button_2_score: out STD_LOGIC_VECTOR(3 downto 0);
          button_3_score: out STD_LOGIC_VECTOR(3 downto 0);
          button_4_score: out STD_LOGIC_VECTOR(3 downto 0);           
          delayed_enable: out STD_LOGIC;
          menu_enable : out STD_LOGIC;
          display_cntrl: out STD_LOGIC_Vector(1 downto 0));
end component;

signal clk,reset,enable,modecntrl,button_1,button_2,button_3,button_4:std_logic:='0';
signal delayed_enable,menu_enable:std_logic;
signal display_cntrl:std_logic_vector(1 downto 0);
signal winner_select,button_1_score,button_2_score,button_3_score,button_4_score:std_logic_vector(3 downto 0);

begin

uut: main_logic port map(clk,reset,enable,modecntrl,button_1,button_2,button_3,button_4,winner_select,button_1_score,button_2_score,button_3_score,button_4_score,delayed_enable,menu_enable,display_cntrl);
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

button1_control:process(clk,delayed_enable)
begin
    if(rising_edge(clk)) then
        if(delayed_enable='1') then
            button_1<='1';
        else
            button_1<='0';
        end if;
    end if;
end process;




end Behavioral;
