----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 15:31:56
-- Design Name: 
-- Module Name: BCD_to_Binary - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_to_Binary is
    Port ( 
           clk: in STD_Logic;
           reset: in std_logic;
           dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           dig3 : in STD_LOGIC_VECTOR (3 downto 0);
           dig4 : in STD_LOGIC_VECTOR (3 downto 0);
           binary : out STD_LOGIC_VECTOR (13 downto 0));
end BCD_to_Binary;

architecture Behavioral of BCD_to_Binary is

begin
    calc:process(clk,reset,dig1,dig2,dig3,dig4)
    begin
        if(reset='1') then
            binary <= (others=>'0');
        elsif(rising_edge(clk)) then
            binary <= (dig1)+(dig2*"1010")+(dig3*"1100100")+(dig4*"1111101000");
        end if;
    end process;

end Behavioral;
