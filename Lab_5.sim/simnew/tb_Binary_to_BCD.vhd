----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 18:12:54
-- Design Name: 
-- Module Name: tb_Binary_to_BCD - Behavioral
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

entity tb_Binary_to_BCD is
--  Port ( );
end tb_Binary_to_BCD;

architecture Behavioral of tb_Binary_to_BCD is

component Binary_to_BCD is
    Generic(
            WIDTH: integer:= 14;
            digits: integer:=4
            );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           binary_in : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           done : out STD_LOGIC;
           bcd_out : out STD_LOGIC_VECTOR (digits*4-1 downto 0));
end component;

constant WIDTH:integer:=14;
constant digits:integer:=4;
constant clk_period: time:= 10 ns;

signal clk,reset,enable:std_logic:='0';
signal binary_in: std_logic_vector(Width-1 downto 0):="00100001000001";
signal done:std_logic;
signal bcd_out: std_logic_vector(digits*4-1 downto 0);

begin

uut: Binary_to_BCD port map(clk,reset,enable,binary_in,done,bcd_out);

   clk_process :process
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;


   reset_proc: process
   begin      
      reset <= '1';
      wait for clk_period*10;
      reset <= '0';
      wait;
   end process;
   
   enable_proc: process
   begin  
      wait for clk_period*11;    
      enable <= '1';
      wait for clk_period*100;
      enable <= '0';
      wait;
   end process;
   

end Behavioral;
