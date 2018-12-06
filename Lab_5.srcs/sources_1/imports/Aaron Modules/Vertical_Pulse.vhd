library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Vertical_Pulse is
    Generic ( 	pulse_height: integer:= 10;
            pulse_width: integer:= 10;
            px_offset: integer:= 50;
            py_offset: integer:= 50);
    Port (     clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
        scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        pulse_colour: in STD_LOGIC_VECTOR(11 downto 0);
        --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
        kHz: in STD_LOGIC;
        red: out STD_LOGIC_VECTOR(3 downto 0);
        blue: out STD_LOGIC_VECTOR(3 downto 0);
        green: out std_logic_vector(3 downto 0)
      );
end Vertical_Pulse;

architecture Behavioral of Vertical_Pulse is

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
signal i_red3, i_green3, i_blue3: std_logic_vector(3 downto 0);
signal i_red4, i_green4, i_blue4: std_logic_vector(3 downto 0);

constant long: integer:= 10;
constant short: integer:= 5;
constant narrow: integer:= 1;

signal scan_line_y_i:std_logic_vector(10 downto 0);
signal scan_line_x_i:std_logic_vector(10 downto 0);


begin

scan_line_y_i<=scan_line_y;
scan_line_x_i<=scan_line_x;

falling: Rectangle
      Generic Map(     
                  rectangle_height    => narrow,
                  rectangle_width     => pulse_height,
                  x_offset            => px_offset,
                  y_offset            => py_offset
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x_i,
                  scan_line_y     => scan_line_y_i,
                  rectangle_color => pulse_colour,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red1,
                  blue            => i_blue1,
                  green           => i_green1
        );

low: Rectangle
      Generic Map(     
                  rectangle_height    => pulse_width,
                  rectangle_width     => narrow,
                  x_offset            => px_offset,
                  y_offset            => py_offset + narrow
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x_i,
                  scan_line_y     => scan_line_y_i,
                  rectangle_color => pulse_colour,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red2,
                  blue            => i_blue2,
                  green           => i_green2
        );
        
rising: Rectangle
      Generic Map(     
                  rectangle_height    => narrow,
                  rectangle_width     => pulse_height,
                  x_offset            => px_offset,
                  y_offset            => py_offset + pulse_width
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x_i,
                  scan_line_y     => scan_line_y_i,
                  rectangle_color => pulse_colour,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red3,
                  blue            => i_blue3,
                  green           => i_green3
        );    

high: Rectangle
      Generic Map(     
                  rectangle_height    => pulse_width,
                  rectangle_width     => narrow,
                  x_offset            => px_offset + pulse_height - narrow,
                  y_offset            => py_offset + pulse_width + narrow
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x_i,
                  scan_line_y     => scan_line_y_i,
                  rectangle_color => pulse_colour,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red4,
                  blue            => i_blue4,
                  green           => i_green4
        );
        
red   <= i_red1 and i_red2 and i_red3 and i_red4;
green <= i_green1 and i_green2 and i_green3 and i_green4;
blue  <= i_blue1 and i_blue2 and i_blue3 and i_blue4;
        
end Behavioral;
