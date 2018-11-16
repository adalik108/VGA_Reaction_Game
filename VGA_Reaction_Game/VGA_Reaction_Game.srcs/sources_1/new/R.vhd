library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity R is
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
end R;

architecture Behavioral of R is

component Diagonal4 is
    Generic ( 	d4_height: integer:= 10;
        d4_width: integer:= 10;
        d4_x_offset: integer:= 50;
        d4_y_offset: integer:= 50);
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

component Diagonal2 is
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
end component;

signal i_red1, i_green1, i_blue1: std_logic_vector(3 downto 0);
signal i_red2, i_green2, i_blue2: std_logic_vector(3 downto 0);
signal i_red3, i_green3, i_blue3: std_logic_vector(3 downto 0);
signal i_red4, i_green4, i_blue4: std_logic_vector(3 downto 0);
signal i_red5, i_green5, i_blue5: std_logic_vector(3 downto 0);
signal i_red6, i_green6, i_blue6: std_logic_vector(3 downto 0);

constant tail_height: integer:= 2;
constant tail_width: integer:= 1;
constant long: integer:= 10;
constant half_length: integer:= 5;
constant narrow: integer:= 2;


begin

Top: Rectangle
    Generic Map( 	
                rectangle_height    => narrow,
                rectangle_width     => long,
                x_offset            => px_offset,
                y_offset            => py_offset
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
      
Full_Left: Rectangle
      Generic Map(     
                  rectangle_height    => long + long,
                  rectangle_width     => narrow,
                  x_offset            => px_offset,
                  y_offset            => py_offset
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

Right: Rectangle
      Generic Map(     
                  rectangle_height    => long,
                  rectangle_width     => narrow,
                  x_offset            => px_offset + long,
                  y_offset            => py_offset
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red3,
                  blue            => i_blue3,
                  green           => i_green3
        );


Middle: Rectangle
      Generic Map(     
                  rectangle_height    => narrow,
                  rectangle_width     => long + narrow,
                  x_offset            => px_offset,
                  y_offset            => py_offset + long - narrow
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red4,
                  blue            => i_blue4,
                  green           => i_green4
        );
        
Tail_1: Diagonal2
      Generic Map(     
                  d2_height    => tail_height,
                  d2_width     => tail_width,
                  d2_x_offset            => px_offset + half_length,
                  d2_y_offset            => py_offset + long - narrow + tail_height
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red5,
                  blue            => i_blue5,
                  green           => i_green5
        );
        
Tail_2: Diagonal4
            Generic Map(     
                        d4_height    => tail_height,
                        d4_width     => tail_width,
                        d4_x_offset  => px_offset + half_length + tail_width + tail_width,
                        d4_y_offset  => py_offset + long + tail_height + tail_height
                        )
            Port Map(     
                        clk             => clk,
                        reset           => reset,
                        scan_line_x     => scan_line_x,
                        scan_line_y     => scan_line_y,
                        rectangle_color => rectangle_color,
                        --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                        kHz             => kHz,
                        red             => i_red6,
                        blue            => i_blue6,
                        green           => i_green6
              );
        
red   <= i_red1 and i_red2 and i_red3 and i_red4 and i_red5 and i_red6;
green <= i_green1 and i_green2 and i_green3 and i_green4 and i_green5 and i_green6;
blue  <= i_blue1 and i_blue2 and i_blue3 and i_blue4 and i_blue5 and i_blue6;

end Behavioral;