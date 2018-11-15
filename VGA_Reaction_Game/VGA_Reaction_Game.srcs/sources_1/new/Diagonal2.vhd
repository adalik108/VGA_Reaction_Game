library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity Diagonal2 is
    Generic ( 	d2_height: integer:= 10;
        d2_width: integer:= 10;
        d2_x_offset: integer:= 50;
        d2_y_offset: integer:= 50);
    Port (     clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
        scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        rectangle_color: in STD_LOGIC_VECTOR(11 downto 0);
        --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
        kHz: in STD_LOGIC;
        red: out STD_LOGIC_VECTOR(3 downto 0);
        blue: out STD_LOGIC_VECTOR(3 downto 0);
        green: out std_logic_vector(3 downto 0)
);
end Diagonal2;

architecture Behavioral of Diagonal2 is

component Rectangle is
    Generic ( 	rectangle_height: integer:= 10;
                rectangle_width: integer:= 10;
                x_offset: integer:= 50;
                y_offset: integer:= 50);
    Port ( 	clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
        scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        rectangle_color: in STD_LOGIC_VECTOR(11 downto 0);
        --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
        kHz: in STD_LOGIC;
        red: out STD_LOGIC_VECTOR(3 downto 0);
        blue: out STD_LOGIC_VECTOR(3 downto 0);
        green: out std_logic_vector(3 downto 0)
      );
end component;

signal i_red1, i_green1, i_blue1: std_logic_vector(3 downto 0);
signal i_red2, i_green2, i_blue2: std_logic_vector(3 downto 0);
--signal i_red3, i_green3, i_blue3: std_logic_vector(3 downto 0);
--signal i_red4, i_green4, i_blue4: std_logic_vector(3 downto 0);

begin

Top: Rectangle
    Generic Map( 	
                rectangle_height    => d2_height,
                rectangle_width     => d2_width,
                x_offset            => d2_x_offset,
                y_offset            => d2_y_offset
                )
    Port Map( 	
                clk             => clk,
                reset           => reset,
                scan_line_x     => scan_line_x,
                scan_line_y     => scan_line_y,
                rectangle_color => rectangle_color,
                --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                kHz             => kHz,
                red             => i_red1,
                blue            => i_blue1,
                green           => i_green1
      );
      
Bottom: Rectangle
      Generic Map(     
                  rectangle_height    => d2_height,
                  rectangle_width     => d2_width,
                  x_offset            => d2_x_offset + d2_width,
                  y_offset            => d2_y_offset + d2_height
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red2,
                  blue            => i_blue2,
                  green           => i_green2
        );

        
red   <= i_red1 and i_red2;
green <= i_green1 and i_green2;
blue  <= i_blue1 and i_blue2;

end Behavioral;
