----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2018 03:44:21 PM
-- Design Name: 
-- Module Name: Sound_Control - Behavioral
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

entity Sound_Control is
    Generic ( 
period: integer:=256;   -- Period is 10 ns * period generic. ex for 100 Hz period should be 1,000,000
width : integer := 9);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           winner_select: in STD_LOGIC_Vector(3 downto 0);
           buzzer_out : out STD_LOGIC
           );
end Sound_Control;

architecture Behavioral of Sound_Control is

component PWM_DAC is
    Generic ( 
period: integer:=256;   -- Period is 10 ns * period generic. ex for 100 Hz period should be 1,000,000
width : integer := 9);  -- Number of bits necessary to hold the above number
Port ( 
       enable : in STD_LOGIC;
       reset : in STD_LOGIC;
       clk : in STD_LOGIC;
       pwm_out : out STD_LOGIC
      );
end component;

    signal counter : STD_LOGIC_VECTOR (width-1 downto 0);
    constant max_count : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := STD_LOGIC_VECTOR(to_unsigned(period - 1, width)); 
    constant half_duty : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := STD_LOGIC_VECTOR(to_unsigned(period/2, width));
    constant quarter_duty : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := STD_LOGIC_VECTOR(to_unsigned(period/4, width));
    constant threequarter_duty : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := STD_LOGIC_VECTOR(to_unsigned(3*period/4, width));
    signal PWM1Buzzer: std_logic;
    signal PWM2Buzzer: std_logic;
    signal PWM3Buzzer: std_logic;
    signal PWM4Buzzer: std_logic;
    signal PWM5Buzzer: std_logic;
    signal PWM6Buzzer: std_logic;
    signal winning: std_logic;
begin

winning <= winner_select(3) or winner_select(2) or winner_select(1) or winner_select(0);
-- simply removed 3 zeros
PWM800Hz: PWM_DAC generic map(125000,20) port map(enable,reset,clk,PWM1Buzzer);
PWM1600Hz: PWM_DAC generic map(250000,20) port map(enable,reset,clk,PWM2Buzzer);
PWM2400Hz: PWM_DAC generic map(375000,20) port map(enable,reset,clk,PWM3Buzzer);
PWM3200Hz: PWM_DAC generic map(500000,20) port map(enable,reset,clk,PWM4Buzzer);
PWM4000Hz: PWM_DAC generic map(625000,20) port map(enable,reset,clk,PWM5Buzzer);
PWM4800Hz: PWM_DAC generic map(750000,20) port map(enable,reset,clk,PWM6Buzzer);

    count : process(clk,reset)
    begin
        if( reset = '1') then
            counter <= (others => '0');
        elsif (rising_edge(clk)) then 
            if(counter= max_count) then
                 counter <= (others=>'0');
            else
                 counter <= counter + '1';
            end if;
        end if;
    end process;
  
    compare : process(counter,enable,PWM1Buzzer,PWM2Buzzer,PWM3Buzzer,PWM4Buzzer,PWM5Buzzer,PWM6Buzzer,winning)
    begin
    if(enable='1') then
        if(winning='1') then
            if (counter > threequarter_duty) then
                buzzer_out <= PWM3Buzzer;
            elsif(counter> half_duty) then
                buzzer_out <= PWM4Buzzer;
            elsif(counter>quarter_duty) then
                buzzer_out <= PWM5Buzzer;
            else
                buzzer_out <= PWM6Buzzer;
            end if;
        else
            if (counter > threequarter_duty) then
                buzzer_out <= PWM1Buzzer;
            elsif(counter> half_duty) then
                buzzer_out <= PWM2Buzzer;
            elsif(counter>quarter_duty) then
                buzzer_out <= PWM3Buzzer;
            else
                buzzer_out <= PWM4Buzzer;
            end if;
        end if;
    else
        buzzer_out<='0';
    end if;
    end process;
  


end Behavioral;
