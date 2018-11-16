----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2018 02:49:14 PM
-- Design Name: 
-- Module Name: tb_PWM_DAC - Behavioral
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

entity tb_PWM_DAC is
--  Port ( );
end tb_PWM_DAC;

architecture Behavioral of tb_PWM_DAC is

component PWM_DAC is
    Generic ( 
period: integer:=256;
width : integer := 9);
Port ( 
       enable : in STD_LOGIC;
       reset : in STD_LOGIC;
       clk : in STD_LOGIC;
       pwm_out : out STD_LOGIC
      );
end component;

constant frequencywidth: integer:=6;
signal reset,clk,enable:std_logic:='0';
signal pwm_out: std_logic;

constant clk_period: time:= 10 ns;



begin

uut: PWM_DAC generic map(8,frequencywidth) port map(enable,reset,clk,pwm_out);

clk_cntrl:process
begin
    wait for clk_period/2;
    clk<='1';
    wait for clk_period/2;
    clk<='0';
end process;


reset_cntrl:process
begin
    wait for clk_period/2;
    reset<='1';
    wait for 100 ns;
    reset<='0';
    wait;
end process;

enable_cntrl:process
begin
    wait for 1000 ns;
    enable<='1';
    wait for 1000 ns;
    enable<='0';
end process;

end Behavioral;
