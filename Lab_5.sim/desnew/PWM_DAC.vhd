----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2018 02:44:51 PM
-- Design Name: 
-- Module Name: PWM_DAC - Behavioral
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

entity PWM_DAC is
    Generic ( 
    period: integer:=256;   -- Period is 10 ns * period generic. ex for 100 Hz period should be 1,000,000
    width : integer := 9);
    Port ( 
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           pwm_out : out STD_LOGIC
          );
end PWM_DAC;

architecture Behavioral of PWM_DAC is
    signal counter : STD_LOGIC_VECTOR (width-1 downto 0);
    
    constant max_count : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := STD_LOGIC_VECTOR(to_unsigned(period - 1, width)); 
    constant half_duty : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := STD_LOGIC_VECTOR(to_unsigned(period/2, width));
    
begin
    count : process(clk,reset,enable)
    begin
        if( reset = '1') then
            counter <= (others => '0');
        elsif (rising_edge(clk)) then 
            if(enable='1') then
                if(counter= max_count) then
                     counter <= (others=>'0');
                else
                     counter <= counter + '1';
                end if;
            else
                counter<= (others=>'0');
            end if;
        end if;
    end process;
  
    compare : process(counter)
    begin    
        if (counter > half_duty) then
            pwm_out <= '1';
        else 
            pwm_out <= '0';
        end if;
    end process;
  
end Behavioral;