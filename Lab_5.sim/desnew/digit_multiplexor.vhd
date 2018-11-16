----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2018 09:40:18
-- Design Name: 
-- Module Name: digit_multiplexor - Behavioral
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

entity digit_multiplexor is
    Port ( dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           dig3 : in STD_LOGIC_VECTOR (3 downto 0);
           dig4 : in STD_LOGIC_VECTOR (3 downto 0);
           selector : in STD_LOGIC_VECTOR (3 downto 0);
           out_digit : out STD_LOGIC_VECTOR (3 downto 0));
end digit_multiplexor;

architecture Behavioral of digit_multiplexor is

begin
Selection: process(selector,dig1,dig2,dig3,dig4)
    begin
        case selector is 
            when "0001" => out_digit <= dig1;
            when "0010" => out_digit <= dig2;
            when "0100" => out_digit <= dig3;
            when "1000" => out_digit <= dig4;
            when others => out_digit <= "1111"; -- when random display seconds
        end case;
end process;

end Behavioral;
