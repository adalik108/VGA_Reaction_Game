----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 16:59:19
-- Design Name: 
-- Module Name: tb_Binary_to_BCD_dig - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Binary_to_BCD_dig is
--  Port ( );
end tb_Binary_to_BCD_dig;

architecture Behavioral of tb_Binary_to_BCD_dig is
component Binary_to_BCD_dig is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           CI : in STD_LOGIC;
           CO : out STD_LOGIC;
           bcd_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

constant clk_period: time:= 10 ns;
signal clk,reset,enable,CI:std_logic:='0';
signal bitvector:std_logic_vector(3 downto 0):="1111";
signal CO:std_logic;
signal bcd_out:std_logic_vector(3 downto 0);

begin

uut: Binary_to_BCD_dig port map(clk,reset,enable,CI,CO,bcd_out);

   clk_process :process
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;


   -- Stimulus process
   reset_proc: process
   begin      
      -- hold reset state for 100 ns.
      reset <= '0';
      wait for 100 ns;   
      reset <= '1';
      wait for clk_period*10;
      reset <= '0';
      
     
      wait;
   end process;
   
   value_control:process
   begin
   
   wait for clk_period*20;
   enable<='1';
   wait for clk_period;
--    for i in 0 to 1 loop
--        for j in 0 to 1 loop
--            for k in 0 to 1 loop
--                for q in 0 to 1 loop
--                    bitvector<=bitvector+'1';
--                    for l in 0 to 3 loop
--                        CI<=bitvector(l);
--                        wait for clk_period;
--                    end loop;
--                end loop;
--            end loop;
--        end loop;
--    end loop;
    for l in 3 downto 0 loop
        CI<=bitvector(l);
        wait for clk_period;
    end loop;
    enable<='0';
    wait;
   end process;
   
end Behavioral;
