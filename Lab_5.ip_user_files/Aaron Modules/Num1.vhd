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

entity Num1 is
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
end Num1;

architecture Behavioral of Num1 is

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
    Port ( 	
        clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
        scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        rectangle_color: in STD_LOGIC_VECTOR(11 downto 0);
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
signal i_red7, i_green7, i_blue7: std_logic_vector(3 downto 0);
signal i_red8, i_green8, i_blue8: std_logic_vector(3 downto 0);

signal rectangle_color_i1: std_logic_vector(11 downto 0);
signal rectangle_color_i2: std_logic_vector(11 downto 0);
signal rectangle_color_i3: std_logic_vector(11 downto 0);
signal rectangle_color_i4: std_logic_vector(11 downto 0);
signal rectangle_color_i5: std_logic_vector(11 downto 0);
signal rectangle_color_i6: std_logic_vector(11 downto 0);
signal rectangle_color_i7: std_logic_vector(11 downto 0);
signal rectangle_color_i8: std_logic_vector(11 downto 0);

constant backgroundcolor: std_logic_vector(11 downto 0):=(others=>'1');
constant long: integer:= 10;
constant narrow: integer:= 2;

begin

--rectcolor 0-3 BLUE, 4-7 Green, 11-8 red
    rectangle_color_i1<= rectangle_color when (seg7(6)='1') else (others=>'1');
    rectangle_color_i2<= rectangle_color when (seg7(5)='1') else (others=>'1');
    rectangle_color_i3<= rectangle_color when (seg7(4)='1') else (others=>'1');
    rectangle_color_i4<= rectangle_color when (seg7(3)='1') else (others=>'1');
    rectangle_color_i5<= rectangle_color when (seg7(2)='1') else (others=>'1');
    rectangle_color_i6<= rectangle_color when (seg7(1)='1') else (others=>'1');
    rectangle_color_i7<= rectangle_color when (seg7(0)='1') else (others=>'1');
    rectangle_color_i8<= rectangle_color when (DP='1') else (others=>'1');



CA: Rectangle
    Generic Map( 	
                rectangle_height    => narrow,
                rectangle_width     => long+narrow,
                x_offset            => px_offset,
                y_offset            => py_offset
                )
    Port Map( 	
                clk             => clk,
                reset           => reset,
                scan_line_x     => scan_line_x,
                scan_line_y     => scan_line_y,
                rectangle_color => rectangle_color_i1,
                --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                kHz             => kHz,
                red             => i_red1,
                blue            => i_blue1,
                green           => i_green1
      );
      



CB: Rectangle
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
                  rectangle_color => rectangle_color_i2,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red2,
                  blue            => i_blue2,
                  green           => i_green2
        );
 
CC: Rectangle
              Generic Map(     
                          rectangle_height    => long,
                          rectangle_width     => narrow,
                          x_offset            => px_offset + long,
                          y_offset            => py_offset+long
                          )
              Port Map(     
                          clk             => clk,
                          reset           => reset,
                          scan_line_x     => scan_line_x,
                          scan_line_y     => scan_line_y,
                          rectangle_color => rectangle_color_i3,
                          --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                          kHz             => kHz,
                          red             => i_red3,
                          blue            => i_blue3,
                          green           => i_green3
                );
CD: Rectangle
          Generic Map(     
                      rectangle_height    => narrow,
                      rectangle_width     => long+narrow,
                      x_offset            => px_offset,
                      y_offset            => py_offset + long+long-narrow
                      )
          Port Map(     
                      clk             => clk,
                      reset           => reset,
                      scan_line_x     => scan_line_x,
                      scan_line_y     => scan_line_y,
                      rectangle_color => rectangle_color_i4,
                      --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                      kHz             => kHz,
                      red             => i_red4,
                      blue            => i_blue4,
                      green           => i_green4
            );
                
CE: Rectangle
              Generic Map(     
                          rectangle_height    => long,
                          rectangle_width     => narrow,
                          x_offset            => px_offset,
                          y_offset            => py_offset + long
                          )
              Port Map(     
                          clk             => clk,
                          reset           => reset,
                          scan_line_x     => scan_line_x,
                          scan_line_y     => scan_line_y,
                          rectangle_color => rectangle_color_i5,
                          --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                          kHz             => kHz,
                          red             => i_red5,
                          blue            => i_blue5,
                          green           => i_green5
                );

CF: Rectangle
      Generic Map(     
                  rectangle_height    => long,
                  rectangle_width     => narrow,
                  x_offset            => px_offset,
                  y_offset            => py_offset
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color_i6,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red6,
                  blue            => i_blue6,
                  green           => i_green6
        );

CG: Rectangle
      Generic Map(     
                  rectangle_height    => narrow,
                  rectangle_width     => long+narrow,
                  x_offset            => px_offset,
                  y_offset            => py_offset + long-narrow
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color_i7,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red7,
                  blue            => i_blue7,
                  green           => i_green7
        );


        
        
DP_D: Rectangle
              Generic Map(     
                          rectangle_height    => narrow,
                          rectangle_width     => narrow,
                          x_offset            => px_offset+long+narrow+narrow,
                          y_offset            => py_offset + long+long-narrow
                          )
              Port Map(     
                          clk             => clk,
                          reset           => reset,
                          scan_line_x     => scan_line_x,
                          scan_line_y     => scan_line_y,
                          rectangle_color => rectangle_color_i8,
                          --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                          kHz             => kHz,
                          red             => i_red8,
                          blue            => i_blue8,
                          green           => i_green8
                );
        
red   <= i_red1 and i_red2 and i_red3 and i_red4 and i_red5 and i_red6 and i_red7 and i_red8;
green <= i_green1 and i_green2 and i_green3 and i_green4 and i_green5 and i_green6 and i_green7 and i_green8;
blue  <= i_blue1 and i_blue2 and i_blue3 and i_blue4 and i_blue5 and i_blue6 and i_blue7 and i_blue8;

end Behavioral;