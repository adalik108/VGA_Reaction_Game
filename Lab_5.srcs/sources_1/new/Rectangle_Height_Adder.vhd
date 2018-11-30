----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2018 11:10:00 AM
-- Design Name: 
-- Module Name: Rectangle_Height_Adder - Behavioral
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

entity Rectangle_Height_Adder is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           add_enable: in STD_LOGIC;
           rectangle_height : out STD_LOGIC_VECTOR (9 downto 0));
end Rectangle_Height_Adder;

architecture Behavioral of Rectangle_Height_Adder is

begin

clk_process: process
begin
if(reset='1') then
    rectangle_height<=(3=>'1',others=>'0');
elsif(rising_edge(clk)) then
    if(add_enable='1') then
        rectangle_height<=rectangle_height+
    
    else
    
    
    end if;
end if;
end process;



end Behavioral;
