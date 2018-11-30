----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2018 04:19:31 PM
-- Design Name: 
-- Module Name: Time_Display_VGA - Behavioral
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

entity Time_Display_VGA is
Port (     
    clk : in  STD_LOGIC;
    reset : in  STD_LOGIC;
    scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
    scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
    dig1:   in STD_LOGIC_VECTOR(3 downto 0);
    dig2:   in STD_LOGIC_VECTOR(3 downto 0);
    dig3:   in STD_LOGIC_VECTOR(3 downto 0);
    dig4:   in STD_LOGIC_VECTOR(3 downto 0);
    kHz: in STD_LOGIC;
    red: out STD_LOGIC_VECTOR(3 downto 0);
    blue: out STD_LOGIC_VECTOR(3 downto 0);
    green: out std_logic_vector(3 downto 0)
  );
end Time_Display_VGA;

architecture Behavioral of Time_Display_VGA is

component Num1 is
    Generic ( 	--display_height: integer:= 10;
    --display_width: integer:= 10;
    px_offset: integer:= 50;
    py_offset: integer:= 50);
Port (     
    clk : in  STD_LOGIC;
    reset : in  STD_LOGIC;
    scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
    scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
    rectangle_color: in STD_LOGIC_VECTOR(11 downto 0);
    Seg7: in STD_LOGIC_VECTOR(6 downto 0);
    DP: in std_logic;
    kHz: in STD_LOGIC;
    red: out STD_LOGIC_VECTOR(3 downto 0);
    blue: out STD_LOGIC_VECTOR(3 downto 0);
    green: out std_logic_vector(3 downto 0)
);
end component;


component seven_segment_decoder_VGA is
    PORT 
     (
       data  : in  STD_LOGIC_VECTOR (3 downto 0);
       seg7: out std_logic_vector(6 downto 0)
     );
end component;

constant long: integer:= 10;
constant narrow: integer:= 5;
constant space: integer:= long + 5;
constant half_width: integer:= 50;
constant screen_mid: integer:= 400-long*4-space*4;
constant white: std_logic_vector(11 downto 0):= "111111111111";

signal Segdig1,Segdig2,Segdig3,Segdig4: std_logic_vector(6 downto 0);

signal i_red1, i_green1, i_blue1: std_logic_vector(3 downto 0);
signal i_red2, i_green2, i_blue2: std_logic_vector(3 downto 0);
signal i_red3, i_green3, i_blue3: std_logic_vector(3 downto 0);
signal i_red4, i_green4, i_blue4: std_logic_vector(3 downto 0);

begin

Seg7Dig1: seven_segment_decoder_VGA Port map(dig1,Segdig4);
Seg7Dig2: seven_segment_decoder_VGA Port map(dig2,Segdig3);
Seg7Dig3: seven_segment_decoder_VGA Port map(dig3,Segdig2);
Seg7Dig4: seven_segment_decoder_VGA Port map(dig4,Segdig1);

Dig1Num: Num1
Generic Map(     
          px_offset  => screen_mid,
          py_offset  => long
          )
Port Map(     
          clk             => clk,
          reset           => reset,
          scan_line_x     => scan_line_x,
          scan_line_y     => scan_line_y,
          rectangle_color => (others=>'0'),
          Seg7=>Segdig1,
          DP=>'1',
          --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
          kHz             => kHz,
          red             => i_red1,
          blue            => i_blue1,
          green           => i_green1
);
        
Dig2Num: Num1
Generic Map(     
          px_offset  => screen_mid + long + space,
          py_offset  => long
          )
Port Map(     
          clk             => clk,
          reset           => reset,
          scan_line_x     => scan_line_x,
          scan_line_y     => scan_line_y,
          rectangle_color => (others=>'0'),
          Seg7=>Segdig2,
          DP=>'0',
          kHz             => kHz,
          red             => i_red2,
          blue            => i_blue2,
          green           => i_green2
);
                
Dig3Num: Num1
      Generic Map(     
                  px_offset  => screen_mid + long + space+long + space,
                  py_offset  => long
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => (others=>'0'),
                  Seg7=>Segdig3,
                  DP=>'0',
                  kHz             => kHz,
                  red             => i_red3,
                  blue            => i_blue3,
                  green           => i_green3
        );
                        
Dig4Num: Num1
      Generic Map(     
                  px_offset  => screen_mid + long + space+long + space+long + space,
                  py_offset  => long
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => (others=>'0'),
                  Seg7=>Segdig4,
                  DP=>'0',
                  kHz             => kHz,
                  red             => i_red4,
                  blue            => i_blue4,
                  green           => i_green4
        );


red<= i_red1 and i_red2 and i_red3 and i_red4;
green<= i_green1 and i_green2 and i_green3 and i_green4;
blue<= i_blue1 and i_blue2 and i_blue3 and i_blue4;

end Behavioral;
