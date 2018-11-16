----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2018 15:37:16
-- Design Name: 
-- Module Name: tb_mode_multiplexor - Behavioral
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

entity tb_mode_multiplexor is
--  Port ( );
end tb_mode_multiplexor;

architecture Behavioral of tb_mode_multiplexor is
component mode_multiplexor is
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
end component;

signal time_dig1,time_dig2,time_dig3,time_dig4:std_logic_vector(3 downto 0):="1100";
signal aux_dig1,aux_dig2,aux_dig3,aux_dig4:std_logic_vector(3 downto 0):="1010";
signal avg_dig1,avg_dig2,avg_dig3,avg_dig4:std_logic_vector(3 downto 0):="1000";
signal selector:std_logic_vector(1 downto 0):="00";
signal out_dig1,out_dig2,out_dig3,out_dig4:std_logic_vector(3 downto 0);
begin

uut: mode_multiplexor port map(time_dig1,time_dig2,time_dig3,time_dig4,aux_dig1,aux_dig2,aux_dig3,aux_dig4,avg_dig1,avg_dig2,avg_dig3,avg_dig4,selector,out_dig1,out_dig2,out_dig3,out_dig4);

    selectortest: process
    begin
        selector <= "00";
        wait for 100 ns;
        selector <= "01";
        wait for 100 ns;
        selector <= "10";
        wait for 100 ns;
        selector <= "11";
        wait for 100 ns;
    end process;




end Behavioral;
