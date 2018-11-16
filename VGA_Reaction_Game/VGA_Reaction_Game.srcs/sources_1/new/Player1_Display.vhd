library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity Player1_Display is
    Generic ( 	--p1_height: integer:= 10;
                p1_width: integer:= 100;
                p1_x_offset: integer:= 50;
                p1_y_offset: integer:= 50);
                
    Port (     clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
        scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        char_colour: in std_logic_vector(11 downto 0);
        rectangle_colour: in STD_LOGIC_VECTOR(11 downto 0);
        rectangle_height: in STD_LOGIC_VECTOR(9 downto 0);
        kHz: in STD_LOGIC;
        red: out STD_LOGIC_VECTOR(3 downto 0);
        blue: out STD_LOGIC_VECTOR(3 downto 0);
        green: out std_logic_vector(3 downto 0)
      );
end Player1_Display;

architecture Behavioral of Player1_Display is

component Player_Display is
    Generic ( 	--display_height: integer:= 10;
            --display_width: integer:= 10;
            display_x_offset: integer:= 50;
            display_y_offset: integer:= 50);
Port (     clk : in  STD_LOGIC;
    reset : in  STD_LOGIC;
    scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
    scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
    rectangle_colour: in STD_LOGIC_VECTOR(11 downto 0);
    --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
    kHz: in STD_LOGIC;
    red: out STD_LOGIC_VECTOR(3 downto 0);
    blue: out STD_LOGIC_VECTOR(3 downto 0);
    green: out std_logic_vector(3 downto 0)
  );
end component;

component Num1 is
    Generic ( 	--display_height: integer:= 10;
        --display_width: integer:= 10;
        px_offset: integer:= 50;
        py_offset: integer:= 50);
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
end component;

component Growing_Rectangle is
    Generic ( 	box_width: integer:= 10;
                x_offset: integer:= 50;
                y_offset: integer:= 50);
    Port ( 	clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
        scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        rectangle_color: in STD_LOGIC_VECTOR(11 downto 0);
        rectangle_height: in STD_LOGIC_VECTOR(9 downto 0);
        kHz: in STD_LOGIC;
        red: out STD_LOGIC_VECTOR(3 downto 0);
        blue: out STD_LOGIC_VECTOR(3 downto 0);
        green: out std_logic_vector(3 downto 0)
      );
end component;

signal rectangle_red: std_logic_vector(3 downto 0);
signal rectangle_green: std_logic_vector(3 downto 0);
signal rectangle_blue: std_logic_vector(3 downto 0);

signal char_red: std_logic_vector(3 downto 0);
signal char_green: std_logic_vector(3 downto 0);
signal char_blue: std_logic_vector(3 downto 0);

signal i_red1, i_green1, i_blue1: std_logic_vector(3 downto 0);
signal i_red2, i_green2, i_blue2: std_logic_vector(3 downto 0);
signal i_red3, i_green3, i_blue3: std_logic_vector(3 downto 0);
signal i_red4, i_green4, i_blue4: std_logic_vector(3 downto 0);
--signal i_red5, i_green5, i_blue5: std_logic_vector(3 downto 0);
--signal i_red6, i_green6, i_blue6: std_logic_vector(3 downto 0);
--signal i_red7, i_green7, i_blue7: std_logic_vector(3 downto 0);

constant long: integer:= 10;
constant narrow: integer:= 5;
constant space: integer:= long + 5;
constant half_width: integer:= 60;
constant white: std_logic_vector(11 downto 0):= "111111111111";

begin

Player: Player_Display
    Generic Map( 	
    
                display_x_offset  => p1_x_offset,
                display_y_offset  => p1_y_offset
                )
    Port Map( 	
                clk             => clk,
                reset           => reset,
                scan_line_x     => scan_line_x,
                scan_line_y     => scan_line_y,
                rectangle_colour => char_colour,
                --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                kHz             => kHz,
                red             => i_red1,
                blue            => i_blue1,
                green           => i_green1
      );
      
Number: Num1
      Generic Map(     
                  px_offset  => p1_x_offset + space + space + space + space + space + space + space,
                  py_offset  => p1_y_offset
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => char_colour,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red2,
                  blue            => i_blue2,
                  green           => i_green2
        );
        
Rectangle: Growing_Rectangle
        Generic Map (   box_width => 10,
                x_offset => p1_x_offset + half_width,
                y_offset => p1_y_offset - narrow
                )
                
        Port map ( clk         => clk,
                   reset       => reset,
                   scan_line_x => scan_line_x,
                   scan_line_y => scan_line_y,
                   rectangle_color   => rectangle_colour,
                   rectangle_height   => rectangle_height,
                   kHz         => kHz,
                   red         => rectangle_red,
                   blue        => rectangle_blue,
                   green       => rectangle_green
               );

process(clk, scan_line_x, scan_line_y)
begin
    if(rising_edge(clk)) then
        if((scan_line_x >= p1_x_offset) and (scan_line_x < p1_x_offset + p1_width) and (scan_line_y >= p1_y_offset - narrow - rectangle_height)) then
            if(scan_line_y >= p1_y_offset) then
                red   <= char_red;
                green <= char_green;
                blue  <= char_blue;
            else
                red <= rectangle_red;
                blue <= rectangle_blue;
                green <= rectangle_green;
            end if; 
        else    
            red   <= white(11 downto 8);
            green <= white(7 downto 4);
            blue  <= white(3 downto 0);
        end if;
    end if;
end process;

char_red   <= i_red1 and i_red2;
char_green <= i_green1 and i_green2;
char_blue  <= i_blue1 and i_blue2;

end Behavioral;
