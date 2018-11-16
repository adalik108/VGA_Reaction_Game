----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2018 16:29:14
-- Design Name: 
-- Module Name: tb_Debouncer - Behavioral
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

entity tb_Debouncer is
--  Port ( );
end tb_Debouncer;

architecture Behavioral of tb_Debouncer is
signal ShakyInput: std_logic;
signal clk,reset: std_logic;
signal DBOutput: std_logic;

constant clk_period: time:= 10 ns;

component Debouncer is
    Port ( Input : in STD_LOGIC;
           clk:    in STD_LOGIC;
           reset:  in STD_LOGIC;
           Input_DB : out STD_LOGIC);
end component;
begin

clk_control: process
begin
    clk<='1';
    wait for clk_period;
    clk<='0';
    wait for clk_period;
end process;

reset_control: process
begin
    reset<='0';
    wait for 100ns;
    reset<='1';
    wait for 100ns;
    reset<='0';
    wait for 100ns;
    wait;
end process;

Shake_control:process
begin
    ShakyInput<='0';
    wait for clk_period*2;
    ShakyInput<='1';
    wait for clk_period*2;
    ShakyInput<='0';
    wait for clk_period*2;
    ShakyInput<='1';
    wait for clk_period*2;
    ShakyInput<='0';
    wait for clk_period*2;
    ShakyInput<='1';
    wait for clk_period*2;
    ShakyInput<='0';
    wait for clk_period*2;
    ShakyInput<='1';
    wait for clk_period*1000;
    ShakyInput<='0';
    wait for clk_period*2;
    ShakyInput<='1';
    wait for clk_period*2;
    ShakyInput<='0';
    wait for clk_period*2;
    ShakyInput<='1';
    wait for clk_period*2;
    ShakyInput<='0';
    wait for clk_period*2;
    ShakyInput<='1';
    wait for clk_period*2;
    ShakyInput<='0';
    wait for clk_period*1000;
end process;


uut: Debouncer
PORT MAP
(
    Input=>ShakyInput,
    clk=>clk,
    reset=>reset,
    Input_DB=>DBOutput
);

end Behavioral;
