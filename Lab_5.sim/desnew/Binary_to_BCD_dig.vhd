----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 16:06:59
-- Design Name: 
-- Module Name: Binary_to_BCD_dig - Behavioral
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


-- Binary to BCD basic level logic
-- if current value >4  CO = 1 (to allow cascading)
-- lets say making 14 into 2 bcd digits, it needs the output to be 0001,0100
-- Therefore 1110 -> 0001,0100. To do this, we start with 0000 and shift in a 1 -> 0001 then shift in another 1
-- 0011 then another one -> 0111, now the value is greater than 4 so CO -> 1, 
-- now that CO is 1 we have 1,0111, now, instead of shifting in another value, we simply replace the current last bit
-- so we end up with 0110, which is not quite 0100, however using some logic we can make it so, 
-- for every possible number > 9 the last 4 digits will be 
-- 1010 -> 0100, 1011-> 0101, 1100->0110, 1101->0111, 1110->0110, 1111->0111
entity Binary_to_BCD_dig is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           CI : in STD_LOGIC;
           CO : out STD_LOGIC;
           bcd_out : out STD_LOGIC_VECTOR (3 downto 0));
end Binary_to_BCD_dig;

architecture Behavioral of Binary_to_BCD_dig is
signal CO_i: std_logic;
signal bcd_out_i:std_logic_vector(3 downto 0);
signal enable_Q:std_logic;

begin

CO_i<=(bcd_out_i(3) or (bcd_out_i(2) and bcd_out_i(0)) or (bcd_out_i(2) and bcd_out_i(1)) );

digitcontrol:process(clk,reset,enable,CI,bcd_out_i,enable_Q,CO_i)
begin
    if(reset='1') then
        enable_Q<='0';
        bcd_out_i<=(others=>'0');
    elsif(rising_edge(clk)) then
        enable_Q<=enable;
        if(enable='1') then
            if(not enable_Q)='1' then -- On rising edge of enable, output goes to 0
                bcd_out_i<=(others=>'0');
            elsif(CO_i='1') then
                bcd_out_i(0)<=CI;
                bcd_out_i(1)<=not bcd_out_i(0);
                bcd_out_i(2)<= not (bcd_out_i(0) xor bcd_out_i(1));
                bcd_out_i(3)<= bcd_out_i(3) and bcd_out_i(0);
            else
                bcd_out_i<=bcd_out_i(2 downto 0) & CI;
            end if;
        end if;
    end if;
end process;

CO<=CO_i;
bcd_out<=bcd_out_i;

end Behavioral;
