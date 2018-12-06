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

entity Horizontal_Border is
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
end Horizontal_Border;

architecture Behavioral of Horizontal_Border is

component Horizontal_Pulse is
    Generic ( 	pulse_height: integer:= 10;
                pulse_width: integer:= 10;
                px_offset: integer:= 50;
                py_offset: integer:= 50);
    Port ( 	clk : in  STD_LOGIC;
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
end component;

component Vertical_Pulse is
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
end component;

constant numb_pulse: integer:= 32;
constant numb_vert_pulse: integer:= 15;
constant pulse_width, pulse_height: integer:= 10;
constant right_shift: integer:= 5;
constant white: std_logic_vector(11 downto 0):= "111111111111";
--type colour is Array(3 downto 0) of std_logic;
type colour_line is array(integer range <>) of std_logic_vector(3 downto 0);
signal red_lines_i, red_lines_bottom, red_lines_top : colour_line(numb_pulse-1 downto 0);
signal green_lines_i, green_lines_bottom, green_lines_top : colour_line(numb_pulse-1 downto 0);
signal blue_lines_i, blue_lines_bottom, blue_lines_top : colour_line(numb_pulse-1 downto 0);
signal count: std_logic_vector(10 downto 0);
signal draw_pulse: integer range 0 to numb_pulse:= 0;
signal draw_vert_pulse: integer range 0 to numb_vert_pulse:= 0;

signal scan_line_y_i:std_logic_vector(10 downto 0);
signal scan_line_x_i:std_logic_vector(10 downto 0);


begin

scan_line_y_i<=scan_line_y;
scan_line_x_i<=scan_line_x;

Bottom_Pulses: for n in 0 to (numb_pulse - 1) generate
    pulse_n: Horizontal_Pulse Generic Map(pulse_height, pulse_width, ((2*pulse_width*n) + right_shift), 465)
                        Port Map(clk, reset, scan_line_x_i, scan_line_y_i, border_colour, kHz, red_lines_bottom(n), blue_lines_bottom(n), green_lines_bottom(n));
    end generate;
    
Top_Pulses: for n in 0 to (numb_pulse - 1) generate
    pulse_n: Horizontal_Pulse Generic Map(pulse_height, pulse_width, ((2*pulse_width*n) + right_shift), 5)
                        Port Map(clk, reset, scan_line_x_i, scan_line_y_i, border_colour, kHz, red_lines_top(n), blue_lines_top(n), green_lines_top(n));
    end generate;
    
    process(clk, reset, scan_line_x_i, scan_line_y_i)
    begin
    
    if(reset = '1') then
        red   <= white(11 downto 8);
        green <= white(7 downto 4);
        blue  <= white(3 downto 0);
        count <= (others => '0');
        draw_pulse <= 0;  
    elsif(rising_edge(clk)) then
        if(scan_line_x_i = 0) then
            count <= (others => '0');
            draw_pulse <= 0;
        elsif((scan_line_x_i - count) >= ((2*pulse_width))) then
            draw_pulse <= draw_pulse + 1;
            count <= scan_line_x_i;
            if(draw_pulse >= numb_pulse) then
                draw_pulse <= 0;
            end if;
        else
--            if(scan_line_x < 320) then
--                red <= red_lines_i(0) and red_lines_i(1) and red_lines_i(2) and red_lines_i(3) and red_lines_i(4) and red_lines_i(5) and red_lines_i(6) and red_lines_i(7) and red_lines_i(8) and red_lines_i(9) and red_lines_i(10) and red_lines_i(11) and red_lines_i(12) and red_lines_i(13) and red_lines_i(14) and red_lines_i(15) and red_lines_i(16) and red_lines_i(17);
--                blue <= blue_lines_i(0) and blue_lines_i(1) and blue_lines_i(2) and blue_lines_i(3) and blue_lines_i(4) and blue_lines_i(5) and blue_lines_i(6) and blue_lines_i(7) and blue_lines_i(8) and blue_lines_i(9) and blue_lines_i(10) and blue_lines_i(11) and blue_lines_i(12) and blue_lines_i(13) and blue_lines_i(14) and blue_lines_i(15) and blue_lines_i(16) and blue_lines_i(17);
--                green <= green_lines_i(0) and green_lines_i(1) and green_lines_i(2) and green_lines_i(3) and green_lines_i(4) and green_lines_i(5) and green_lines_i(6) and green_lines_i(7) and green_lines_i(8) and green_lines_i(9) and green_lines_i(10) and green_lines_i(11) and green_lines_i(12) and green_lines_i(13) and green_lines_i(14) and green_lines_i(15) and green_lines_i(16) and green_lines_i(17);
--            else
--                red <= red_lines_i(0 + 15) and red_lines_i(1 + 15) and red_lines_i(2 + 15) and red_lines_i(3 + 15) and red_lines_i(4 + 15) and red_lines_i(5 + 15) and red_lines_i(6 + 15) and red_lines_i(7 + 15) and red_lines_i(8 + 15) and red_lines_i(9 + 15) and red_lines_i(10 + 15) and red_lines_i(11 + 15) and red_lines_i(12 + 15) and red_lines_i(13 + 15) and red_lines_i(14 + 15) and red_lines_i(15 + 15) and red_lines_i(16 + 15) and red_lines_i(17 + 15);
--                blue <= blue_lines_i(0 + 15) and blue_lines_i(1 + 15) and blue_lines_i(2 + 15) and blue_lines_i(3 + 15) and blue_lines_i(4 + 15) and blue_lines_i(5 + 15) and blue_lines_i(6 + 15) and blue_lines_i(7 + 15) and blue_lines_i(8 + 15) and blue_lines_i(9 + 15) and blue_lines_i(10 + 15) and blue_lines_i(11 + 15) and blue_lines_i(12 + 15) and blue_lines_i(13 + 15) and blue_lines_i(14 + 15) and blue_lines_i(15 + 15) and blue_lines_i(16 + 15) and blue_lines_i(17 + 15);
--                green <= green_lines_i(0 + 15) and green_lines_i(1 + 15) and green_lines_i(2 + 15) and green_lines_i(3 + 15) and green_lines_i(4 + 15) and green_lines_i(5 + 15) and green_lines_i(6 + 15) and green_lines_i(7 + 15) and green_lines_i(8 + 15) and green_lines_i(9 + 15) and green_lines_i(10 + 15) and green_lines_i(11 + 15) and green_lines_i(12 + 15) and green_lines_i(13 + 15) and green_lines_i(14 + 15) and green_lines_i(15 + 15) and green_lines_i(16 + 15) and green_lines_i(17 + 15);
--            if(((scan_line_y_i < 15) and (scan_line_x_i < 15)) or (scan_line_x_i > 625) or ((scan_line_x_i >= 625) and (scan_line_y_i >= 465))) then
--                red   <= white(11 downto 8);
--                green <= white(7 downto 4);
--                blue  <= white(3 downto 0);
--            elsif(scan_line_y_i < 20) then
            if(scan_line_y_i < 20) then
                if(draw_pulse = 0) then
                    red <= red_lines_top(draw_pulse) and red_lines_top(draw_pulse + 1);
                    blue <= blue_lines_top(draw_pulse) and blue_lines_top(draw_pulse + 1);
                    green <= green_lines_top(draw_pulse) and green_lines_top(draw_pulse + 1);
                else
                    red <= red_lines_top(draw_pulse) and red_lines_top(draw_pulse - 1) and red_lines_top(draw_pulse + 1);
                    blue <= blue_lines_top(draw_pulse) and blue_lines_top(draw_pulse - 1) and blue_lines_top(draw_pulse + 1);
                    green <= green_lines_top(draw_pulse) and green_lines_top(draw_pulse - 1) and green_lines_top(draw_pulse + 1);
                end if;
                
            elsif(scan_line_y_i >= 464) then
                if(draw_pulse = 0) then
                    red <= red_lines_bottom(draw_pulse) and red_lines_bottom(draw_pulse + 1);
                    blue <= blue_lines_bottom(draw_pulse) and blue_lines_bottom(draw_pulse + 1);
                    green <= green_lines_bottom(draw_pulse) and green_lines_bottom(draw_pulse + 1);
                else
                    red <= red_lines_bottom(draw_pulse) and red_lines_bottom(draw_pulse - 1) and red_lines_bottom(draw_pulse + 1);
                    blue <= blue_lines_bottom(draw_pulse) and blue_lines_bottom(draw_pulse - 1) and blue_lines_bottom(draw_pulse + 1);
                    green <= green_lines_bottom(draw_pulse) and green_lines_bottom(draw_pulse - 1) and green_lines_bottom(draw_pulse + 1);
                end if;
            else
                red <= (others => '1');
                blue <= (others => '1');
                green <= (others => '1');
            end if;
        end if;

--        red <= red_lines_i(0) and red_lines_i(1) and red_lines_i(2) and red_lines_i(3) and red_lines_i(4) and red_lines_i(5) and red_lines_i(6);
--        blue <= blue_lines_i(0) and blue_lines_i(1) and blue_lines_i(2) and blue_lines_i(3) and blue_lines_i(4) and blue_lines_i(5) and blue_lines_i(6);
--        green <= green_lines_i(0) and green_lines_i(1) and green_lines_i(2) and green_lines_i(3) and green_lines_i(4) and green_lines_i(5) and green_lines_i(6);
--        red <= red_lines_i(draw_pulse) and red_lines_i(draw_pulse + 1) and red_lines_i(draw_pulse + 2);
--        blue <= blue_lines_i(draw_pulse) and blue_lines_i(draw_pulse + 1) and blue_lines_i(draw_pulse + 2);
--        green <= green_lines_i(draw_pulse) and green_lines_i(draw_pulse + 1) and green_lines_i(draw_pulse + 2);
    
    end if;
end process;

end Behavioral;
