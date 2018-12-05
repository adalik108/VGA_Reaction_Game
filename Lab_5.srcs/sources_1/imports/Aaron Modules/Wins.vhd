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
entity Wins is
    Generic ( 	
        x_offset: integer:= 50;
        y_offset: integer:= 50);
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
end Wins;

architecture Behavioral of Wins is

component W is
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

component I is
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

component N is
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

component S is
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

constant long: integer:= 10;
constant narrow: integer:= 2;
constant space: integer:= long + 5;

signal w_red, i_red, n_red, s_red: std_logic_vector(3 downto 0);
signal w_blue, i_blue, n_blue, s_blue: std_logic_vector(3 downto 0);
signal w_green, i_green, n_green, s_green: std_logic_vector(3 downto 0);


begin

Letter_W: W
    Generic Map( x_offset, y_offset)
    Port Map(clk, reset, scan_line_x, scan_line_y, rectangle_color, kHz, w_red, w_blue, w_green);

Letter_I: I
    Generic Map( (x_offset + space), y_offset)
    Port Map(clk, reset, scan_line_x, scan_line_y, rectangle_color, kHz, i_red, i_blue, i_green);

Letter_N: N
    Generic Map( (x_offset + space + space - narrow), y_offset)
    Port Map(clk, reset, scan_line_x, scan_line_y, rectangle_color, kHz, n_red, n_blue, n_green);

Letter_S: S
    Generic Map( (x_offset + space + space + space - narrow), y_offset)
    Port Map(clk, reset, scan_line_x, scan_line_y, rectangle_color, kHz, s_red, s_blue, s_green);
    
process (clk, reset) begin

    if(reset = '1') then
        red   <= (others => '1');
        green <= (others => '1');
        blue  <= (others => '1');
        
    elsif(rising_edge(clk)) then
        if((scan_line_x >= x_offset) and (scan_line_x < (x_offset + space + space + space + space)) and (scan_line_y >= y_offset) and (scan_line_y < (y_offset + long + long + 2))) then
            red <= w_red and i_red and n_red and s_red;
            green <= w_green and i_green and n_green and s_green;
            blue <= w_blue and i_blue and n_blue and s_blue;
            
        else
            red   <= (others => '1');
            green <= (others => '1');
            blue  <= (others => '1');
        end if;
    end if;
end process;

end Behavioral;
