library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_Border is
    Port (     clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
        scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        border_colour: in STD_LOGIC_VECTOR(11 downto 0);
        --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
        kHz: in STD_LOGIC;
        red: out STD_LOGIC_VECTOR(3 downto 0);
        blue: out STD_LOGIC_VECTOR(3 downto 0);
        green: out std_logic_vector(3 downto 0)
      );
end VGA_Border;

architecture Behavioral of VGA_Border is

component Horizontal_Border is
    Port (     clk : in  STD_LOGIC;
    reset : in  STD_LOGIC;
    scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
    scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
    border_colour: in STD_LOGIC_VECTOR(11 downto 0);
    --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
    kHz: in STD_LOGIC;
    red: out STD_LOGIC_VECTOR(3 downto 0);
    blue: out STD_LOGIC_VECTOR(3 downto 0);
    green: out std_logic_vector(3 downto 0)
  );
end component;



component Vertical_Border is
    Port (     clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
        scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        border_colour: in STD_LOGIC_VECTOR(11 downto 0);
        --rectangle_height: in STD_LOGIC_VECTOR(8 downto 0);
        kHz: in STD_LOGIC;
        red: out STD_LOGIC_VECTOR(3 downto 0);
        blue: out STD_LOGIC_VECTOR(3 downto 0);
        green: out std_logic_vector(3 downto 0)
        );
end component;

constant numb_hor_pulse: integer:= 33;
constant numb_vert_pulse: integer:= 15;
constant pulse_width, pulse_height: integer:= 10;
constant white: std_logic_vector(11 downto 0):= "111111111111";
--type colour is Array(3 downto 0) of std_logic;
type colour_line is array(integer range <>) of std_logic_vector(3 downto 0);
signal red_i, red_vert, red_hor : std_logic_vector(3 downto 0);
signal green_i, green_vert, green_hor : std_logic_vector(3 downto 0);
signal blue_i, blue_vert, blue_hor : std_logic_vector(3 downto 0);
signal count: std_logic_vector(10 downto 0);
signal draw_hor_pulse: integer range 0 to numb_hor_pulse:= 0;
signal draw_vert_pulse: integer range 0 to numb_vert_pulse:= 0;

begin

Horizontal: Horizontal_Border Port Map(clk, reset, scan_line_x, scan_line_y, border_colour, kHz, red_hor, blue_hor, green_hor);

Vertical: Vertical_Border Port Map(clk, reset, scan_line_x, scan_line_y, border_colour, kHz, red_vert, blue_vert, green_vert);

red   <= red_vert and red_hor;
green <= green_vert and green_hor;
blue  <= blue_vert and blue_hor;


end Behavioral;
