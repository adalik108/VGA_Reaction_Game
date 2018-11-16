----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2018 10:06:23
-- Design Name: 
-- Module Name: tb_digit_multiplexor - Behavioral
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

entity tb_digit_multiplexor is
--  Port ( );
end tb_digit_multiplexor;

architecture Behavioral of tb_digit_multiplexor is

    component digit_multiplexor is
    Port ( sec_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           sec_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           min_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           min_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           selector : in STD_LOGIC_VECTOR (3 downto 0);
           time_digit : out STD_LOGIC_VECTOR (3 downto 0)
           );
    end component;
    
    signal sec_dig1 : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    signal sec_dig2 : STD_LOGIC_VECTOR(3 downto 0):= "0010";
    signal min_dig1 : STD_LOGIC_VECTOR(3 downto 0):= "0011";
    signal min_dig2 : STD_LOGIC_VECTOR(3 downto 0):= "0100";
    signal selector: STD_LOGIC_VECTOR(3 downto 0);
    signal time_digit: STD_LOGIC_VECTOR(3 downto 0);
    
begin

    uut: digit_multiplexor
    PORT MAP
    (
       sec_dig1 =>sec_dig1,
       sec_dig2=>sec_dig2,
       min_dig1=>min_dig1,
       min_dig2=>min_dig2,
       selector=>selector,
       time_digit=>time_digit
    );
    
    selectortest: process
    begin
        selector <= "0001";
        wait for 100 ns;
        selector <= "0010";
        wait for 100 ns;
        selector <= "0100";
        wait for 100 ns;
        selector <= "1000";
        wait for 100 ns;
    end process;


end Behavioral;
