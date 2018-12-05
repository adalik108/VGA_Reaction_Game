library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity W is
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
end W;

architecture Behavioral of W is

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
signal i_red7, i_green7, i_blue7: std_logic_vector(3 downto 0);
signal i_red8, i_green8, i_blue8: std_logic_vector(3 downto 0);
signal i_red9, i_green9, i_blue9: std_logic_vector(3 downto 0);
signal i_red10, i_green10, i_blue10: std_logic_vector(3 downto 0);
signal i_red11, i_green11, i_blue11: std_logic_vector(3 downto 0);
signal i_red12, i_green12, i_blue12: std_logic_vector(3 downto 0);
signal i_red13, i_green13, i_blue13: std_logic_vector(3 downto 0);
signal i_red14, i_green14, i_blue14: std_logic_vector(3 downto 0);
signal i_red15, i_green15, i_blue15: std_logic_vector(3 downto 0);
signal i_red16, i_green16, i_blue16: std_logic_vector(3 downto 0);

constant angle_height: integer:= 2;
constant angle_width: integer:= 1;
constant long: integer:= 10;
constant half_length: integer:= 5;
constant narrow: integer:= 2;


begin

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
              red             => i_red1,
              blue            => i_blue1,
              green           => i_green1
    );
    
Full_Right: Rectangle
  Generic Map(     
              rectangle_height    => long + long,
              rectangle_width     => narrow,
              x_offset            => px_offset + long + 1,
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
    
up1_1: Rectangle
  Generic Map(     
              rectangle_height    => angle_height,
              rectangle_width     => angle_width,
              x_offset            => px_offset + narrow,
              y_offset            => py_offset + long + long - angle_height
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

up1_2: Rectangle
  Generic Map(     
              rectangle_height    => angle_height,
              rectangle_width     => angle_width,
              x_offset            => px_offset + narrow,
              y_offset            => py_offset + long + long - angle_height - angle_height
              )
  Port Map(     
              clk             => clk,
              reset           => reset,
              scan_line_x     => scan_line_x,
              scan_line_y     => scan_line_y,
              rectangle_color => rectangle_color,
              --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
              kHz             => kHz,
              red             => i_red9,
              blue            => i_blue9,
              green           => i_green9
    );
    
up2_1: Rectangle
  Generic Map(     
              rectangle_height    => angle_height,
              rectangle_width     => angle_width,
              x_offset            => px_offset + narrow + angle_width,
              y_offset            => py_offset + long + long - angle_height - angle_height
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
    
up2_2: Rectangle
  Generic Map(     
              rectangle_height    => angle_height,
              rectangle_width     => angle_width,
              x_offset            => px_offset + narrow + angle_width,
              y_offset            => py_offset + long + long - angle_height - angle_height - angle_height
              )
  Port Map(     
              clk             => clk,
              reset           => reset,
              scan_line_x     => scan_line_x,
              scan_line_y     => scan_line_y,
              rectangle_color => rectangle_color,
              --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
              kHz             => kHz,
              red             => i_red10,
              blue            => i_blue10,
              green           => i_green10
    );
    
up3_1: Rectangle
  Generic Map(     
              rectangle_height    => angle_height,
              rectangle_width     => angle_width,
              x_offset            => px_offset + narrow + angle_width + angle_width,
              y_offset            => py_offset + long + long - angle_height - angle_height - angle_height
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
    
up3_2: Rectangle
  Generic Map(     
              rectangle_height    => angle_height,
              rectangle_width     => angle_width,
              x_offset            => px_offset + narrow + angle_width + angle_width,
              y_offset            => py_offset + long + long - angle_height - angle_height - angle_height - angle_height
              )
  Port Map(     
              clk             => clk,
              reset           => reset,
              scan_line_x     => scan_line_x,
              scan_line_y     => scan_line_y,
              rectangle_color => rectangle_color,
              --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
              kHz             => kHz,
              red             => i_red11,
              blue            => i_blue11,
              green           => i_green11
    );
    
up4_1: Rectangle
  Generic Map(     
              rectangle_height    => angle_height,
              rectangle_width     => angle_width,
              x_offset            => px_offset + narrow + angle_width + angle_width + angle_width,
              y_offset            => py_offset + long + long - angle_height - angle_height - angle_height - angle_height
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

up4_2: Rectangle
  Generic Map(     
              rectangle_height    => angle_height,
              rectangle_width     => angle_width,
              x_offset            => px_offset + narrow + angle_width + angle_width + angle_width,
              y_offset            => py_offset + long + long - angle_height - angle_height - angle_height - angle_height - angle_height
              )
  Port Map(     
              clk             => clk,
              reset           => reset,
              scan_line_x     => scan_line_x,
              scan_line_y     => scan_line_y,
              rectangle_color => rectangle_color,
              --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
              kHz             => kHz,
              red             => i_red12,
              blue            => i_blue12,
              green           => i_green12
    );
        
Down1_1: Diagonal4
    Generic Map(     
              d4_height    => angle_height,
              d4_width     => angle_width,
              d4_x_offset  => px_offset + narrow + angle_width + angle_width + angle_width + angle_width,
              d4_y_offset  => py_offset + long + long - angle_height - angle_height - angle_height - angle_height - angle_height
              )
  Port Map(     
              clk             => clk,
              reset           => reset,
              scan_line_x     => scan_line_x,
              scan_line_y     => scan_line_y,
              rectangle_color => rectangle_color,
              --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
              kHz             => kHz,
              red             => i_red7,
              blue            => i_blue7,
              green           => i_green7
    );

Down1_2: Diagonal4
    Generic Map(     
              d4_height    => angle_height,
              d4_width     => angle_width,
              d4_x_offset  => px_offset + narrow + angle_width + angle_width + angle_width + angle_width,
              d4_y_offset  => py_offset + long + long - angle_height - angle_height - angle_height - angle_height - angle_height - angle_height
              )
  Port Map(     
              clk             => clk,
              reset           => reset,
              scan_line_x     => scan_line_x,
              scan_line_y     => scan_line_y,
              rectangle_color => rectangle_color,
              --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
              kHz             => kHz,
              red             => i_red13,
              blue            => i_blue13,
              green           => i_green13
    );
        
Down2_1: Rectangle
      Generic Map(     
                  rectangle_height    => angle_height,
                  rectangle_width     => angle_width,
                  x_offset            => px_offset + narrow + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width,
                  y_offset            => py_offset + long + long - angle_height - angle_height
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red8,
                  blue            => i_blue8,
                  green           => i_green8
        );

Down2_2: Rectangle
      Generic Map(     
                  rectangle_height    => angle_height,
                  rectangle_width     => angle_width,
                  x_offset            => px_offset + narrow + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width,
                  y_offset            => py_offset + long + long - angle_height - angle_height - angle_height
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red14,
                  blue            => i_blue14,
                  green           => i_green14
        );

Down3_1: Rectangle
      Generic Map(     
                  rectangle_height    => angle_height,
                  rectangle_width     => angle_width,
                  x_offset            => px_offset + narrow + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width,
                  y_offset            => py_offset + long + long - angle_height
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red15,
                  blue            => i_blue15,
                  green           => i_green15
        );

Down3_2: Rectangle
      Generic Map(     
                  rectangle_height    => angle_height,
                  rectangle_width     => angle_width,
                  x_offset            => px_offset + narrow + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width + angle_width,
                  y_offset            => py_offset + long + long - angle_height - angle_height
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  rectangle_color => rectangle_color,
                  --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
                  kHz             => kHz,
                  red             => i_red16,
                  blue            => i_blue16,
                  green           => i_green16
        );
    
process(clk, reset) begin

    if(reset = '1') then
        red   <= (others => '1');
        green <= (others => '1');
        blue  <= (others => '1');
        
    elsif(rising_edge(clk)) then
        if((scan_line_x >= (px_offset + narrow)) and (scan_line_x < (px_offset + long + 1))) then
            red   <= i_red3 and i_red4 and i_red5 and i_red6 and i_red7 and i_red8 and i_red9 and i_red10 and i_red11 and i_red12 and i_red13 and i_red14 and i_red15 and i_red16;
            green <= i_green3 and i_green4 and i_green5 and i_green6 and i_green7 and i_green8 and i_green9 and i_green10 and i_green11 and i_green12 and i_green13 and i_green14 and i_green15 and i_green16;
            blue  <= i_blue3 and i_blue4 and i_blue5 and i_blue6 and i_blue7 and i_blue8 and i_blue9 and i_blue10 and i_blue11 and i_blue12 and i_blue13 and i_blue14 and i_blue15 and i_blue16;
        else
            red   <= i_red1 and i_red2;
            green <= i_green1 and i_green2;
            blue  <= i_blue1 and i_blue2;
        end if;
        
        
--        red   <= i_red1 and i_red2 and i_red3 and i_red4 and i_red5;-- and i_red6;-- and i_red7 and i_red8;
--        green <= i_green1 and i_green2 and i_green3 and i_green4 and i_green5;-- and i_green6;-- and i_green7 and i_green8;
--        blue  <= i_blue1 and i_blue2 and i_blue3 and i_blue4 and i_blue5;-- and i_blue6;-- and i_blue7 and i_blue8;
        
    end if;
end process;


end Behavioral;
