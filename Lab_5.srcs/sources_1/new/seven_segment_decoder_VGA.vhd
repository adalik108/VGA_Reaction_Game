----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2018 04:43:29 PM
-- Design Name: 
-- Module Name: seven_segment_decoder_VGA - Behavioral
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

entity seven_segment_decoder_VGA is
    PORT 
     (
       data  : in  STD_LOGIC_VECTOR (3 downto 0);
       seg7: out std_logic_vector(6 downto 0)
     );
end seven_segment_decoder_VGA;

architecture Behavioral of seven_segment_decoder_VGA is
   signal decoded_bits : STD_LOGIC_VECTOR(6 downto 0);
begin


   Decoding: process(data) begin
                                      -- ABCDEFG         7-segment LED pattern for reference
      case data is                    -- 6543210 
         when "0000" => decoded_bits <= "1111110"; -- 0  --      A-6
         when "0001" => decoded_bits <= "0110000"; -- 1  --  F-1     B-5
         when "0010" => decoded_bits <= "1101101"; -- 2  --      G-0
         when "0011" => decoded_bits <= "1111001"; -- 3  --  E-2     C-4
         when "0100" => decoded_bits <= "0110011"; -- 4  --      D-3      DP
         when "0101" => decoded_bits <= "1011011"; -- 5
         when "0110" => decoded_bits <= "1011111"; -- 6
         when "0111" => decoded_bits <= "1110000"; -- 7
         when "1000" => decoded_bits <= "1111111"; -- 8
         when "1001" => decoded_bits <= "1110011"; -- 9
         when "1010" => decoded_bits <= "1110111"; -- A -- don't need hexadecimal display values for stopwatch
         when "1011" => decoded_bits <= "1111111"; -- B -- don't need hexadecimal display values for stopwatch
         when "1100" => decoded_bits <= "1001110"; -- C -- don't need hexadecimal display values for stopwatch
         when "1101" => decoded_bits <= "1111110"; -- D -- don't need hexadecimal display values for stopwatch
         when "1110" => decoded_bits <= "1001111"; -- E -- don't need hexadecimal display values for stopwatch
         when "1111" => decoded_bits <= "1000111"; -- F -- don't need hexadecimal display values for stopwatch
         when others => decoded_bits <= "0000000"; -- all LEDS off
      end case;
      
   end process;

seg7<=decoded_bits;

end Behavioral;
