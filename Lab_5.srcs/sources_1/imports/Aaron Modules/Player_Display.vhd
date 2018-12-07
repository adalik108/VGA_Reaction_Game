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

entity Player_Display is
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
end Player_Display;

architecture Behavioral of Player_Display is

component P is
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

component L is
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

component A is
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

component Y is
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

component E is
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

component R is
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

signal i_red1, i_green1, i_blue1: std_logic_vector(3 downto 0);
signal i_red2, i_green2, i_blue2: std_logic_vector(3 downto 0);
signal i_red3, i_green3, i_blue3: std_logic_vector(3 downto 0);
signal i_red4, i_green4, i_blue4: std_logic_vector(3 downto 0);
signal i_red5, i_green5, i_blue5: std_logic_vector(3 downto 0);
signal i_red6, i_green6, i_blue6: std_logic_vector(3 downto 0);
--signal i_red7, i_green7, i_blue7: std_logic_vector(3 downto 0);
constant long: integer:= 10;
constant space: integer:= long + 5;

begin

Letter_P: P
      Generic Map(     
                  px_offset            => display_x_offset,
                  py_offset            => display_y_offset
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_colour,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red1,
                  blue            => i_blue1,
                  green           => i_green1
        );

Letter_L: L
      Generic Map(     
                  px_offset            => display_x_offset + space,
                  py_offset            => display_y_offset
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_colour,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red2,
                  blue            => i_blue2,
                  green           => i_green2
        );
        
Letter_A: A
              Generic Map(     
                          px_offset            => display_x_offset + space + space,
                          py_offset            => display_y_offset
                          )
              Port Map(     
                          clk             => clk,
                          reset           => reset,
                          scan_line_x     => scan_line_x,
                          scan_line_y     => scan_line_y,
                          rectangle_color => rectangle_colour,
                          --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                          kHz             => kHz,
                          red             => i_red3,
                          blue            => i_blue3,
                          green           => i_green3
                );

Letter_Y: Y
              Generic Map(     
                          px_offset            => display_x_offset + space + space + space,
                          py_offset            => display_y_offset
                          )
              Port Map(     
                          clk             => clk,
                          reset           => reset,
                          scan_line_x     => scan_line_x,
                          scan_line_y     => scan_line_y,
                          rectangle_color => rectangle_colour,
                          --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                          kHz             => kHz,
                          red             => i_red4,
                          blue            => i_blue4,
                          green           => i_green4
                );

Letter_E: E
              Generic Map(     
                          px_offset            => display_x_offset + space + space + space + space,
                          py_offset            => display_y_offset
                          )
              Port Map(     
                          clk             => clk,
                          reset           => reset,
                          scan_line_x     => scan_line_x,
                          scan_line_y     => scan_line_y,
                          rectangle_color => rectangle_colour,
                          --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                          kHz             => kHz,
                          red             => i_red5,
                          blue            => i_blue5,
                          green           => i_green5
                );
                
Letter_R: R
              Generic Map(     
                          px_offset            => display_x_offset + space + space + space + space + space,
                          py_offset            => display_y_offset
                          )
              Port Map(     
                          clk             => clk,
                          reset           => reset,
                          scan_line_x     => scan_line_x,
                          scan_line_y     => scan_line_y,
                          rectangle_color => rectangle_colour,
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