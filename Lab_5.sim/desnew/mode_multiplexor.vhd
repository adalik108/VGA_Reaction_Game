----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2018 01:09:06 PM
-- Design Name: 
-- Module Name: mode_multiplexor - Behavioral
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

entity mode_multiplexor is
Port (
        time_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
        time_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
        time_dig3 : in STD_LOGIC_VECTOR (3 downto 0);
        time_dig4 : in STD_LOGIC_VECTOR (3 downto 0);
        avg_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
        avg_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
        avg_dig3 : in STD_LOGIC_VECTOR (3 downto 0);
        avg_dig4 : in STD_LOGIC_VECTOR (3 downto 0);
        aux_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
        aux_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
        aux_dig3 : in STD_LOGIC_VECTOR (3 downto 0);
        aux_dig4 : in STD_LOGIC_VECTOR (3 downto 0);
        selector : in STD_LOGIC_VECTOR(1 downto 0);
        out_dig1 : out STD_LOGIC_VECTOR (3 downto 0);
        out_dig2 : out STD_LOGIC_VECTOR (3 downto 0);
        out_dig3 : out STD_LOGIC_VECTOR (3 downto 0);
        out_dig4 : out STD_LOGIC_VECTOR (3 downto 0)
      );
end mode_multiplexor;

architecture Behavioral of mode_multiplexor is

begin

MuxControl: process(selector,time_dig1,time_dig2,time_dig3,time_dig4,aux_dig1,aux_dig2,aux_dig3,aux_dig4,avg_dig1,avg_dig2,avg_dig3,avg_dig4)
begin
case selector is
    when "00"=>
        out_dig1<=time_dig1;
        out_dig2<=time_dig2;
        out_dig3<=time_dig3;
        out_dig4<=time_dig4;
    when "01"=>
        out_dig1<=aux_dig1;
        out_dig2<=aux_dig2;
        out_dig3<=aux_dig3;
        out_dig4<=aux_dig4;
    when "10"=>
        out_dig1<=avg_dig1;
        out_dig2<=avg_dig2;
        out_dig3<=avg_dig3;
        out_dig4<=avg_dig4;
    when others=>
        out_dig1<=(others=>'0');
        out_dig2<=(others=>'0');
        out_dig3<=(others=>'0');
        out_dig4<=(others=>'0');
    end case;
end process;

end Behavioral;
