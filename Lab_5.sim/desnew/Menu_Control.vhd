----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2018 01:36:50 PM
-- Design Name: 
-- Module Name: Menu_Control - Behavioral
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

entity Menu_Control is
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
end Menu_Control;

architecture Behavioral of Menu_Control is

begin

displaycase: process(winner_select,button_1_score,button_2_score,button_3_score,button_4_score)
begin
    case winner_select IS
        when "0001" =>  -- Player 1
            dig1<="1010";
            dig2<="1010";
            dig3<="1010";
            dig4<="1010";
        when "1000" =>  -- Player 2
            dig1<="1011";
            dig2<="1011";
            dig3<="1011";
            dig4<="1011";
        when "0100" =>  -- Player 3
            dig1<="1100";
            dig2<="1100";
            dig3<="1100";
            dig4<="1100";
        when "0010" =>  -- Player 4
            dig1<="1101";
            dig2<="1101";
            dig3<="1101";
            dig4<="1101"; 
        when "0000"=>   -- For unsure reasons, button 1 goes to dig1, button2 goes to dig4, & button 3 goes to dig3 & button 4 goes to dig2
            dig1<=button_1_score;
            dig2<=button_4_score;
            dig3<=button_3_score;
            dig4<=button_2_score;
        when others => 
            dig1<="1111";
            dig2<="1111";
            dig3<="1111";
            dig4<="1111";  
    end case;
end process;


end Behavioral;
