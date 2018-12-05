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

entity Vertical_Border is
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
end Vertical_Border;

architecture Behavioral of Vertical_Border is

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

--constant numb_pulse: integer:= 33;
constant numb_pulse: integer:= 23;
constant pulse_width, pulse_height: integer:= 10;
constant white: std_logic_vector(11 downto 0):= "111111111111";
--type colour is Array(3 downto 0) of std_logic;
type colour_line is array(integer range <>) of std_logic_vector(3 downto 0);
signal red_lines_left, red_lines_right : colour_line(numb_pulse-1 downto 0);
signal green_lines_left, green_lines_right : colour_line(numb_pulse-1 downto 0);
signal blue_lines_left, blue_lines_right : colour_line(numb_pulse-1 downto 0);
signal count: std_logic_vector(10 downto 0) := (others => '0');
signal draw_pulse: integer range 0 to numb_pulse:= 0;
--signal draw_vert_pulse: integer range 0 to numb_vert_pulse:= 0;

begin

Left_Pulses: for n in 0 to (numb_pulse - 1) generate
    pulse_n: Vertical_Pulse Generic Map(pulse_height, pulse_width, 5, ((2*pulse_width*n) + 5 + pulse_height))
                Port Map(clk, reset, scan_line_x, scan_line_y, border_colour, kHz, red_lines_left(n), blue_lines_left(n), green_lines_left(n));
    end generate;
    
Right_Pulses: for n in 0 to (numb_pulse - 1) generate
    pulse_n: Vertical_Pulse Generic Map(pulse_height, pulse_width, 625, ((2*pulse_width*n) + 5 + pulse_height))
                Port Map(clk, reset, scan_line_x, scan_line_y, border_colour, kHz, red_lines_right(n), blue_lines_right(n), green_lines_right(n));
    end generate;
    
    process(clk, reset, scan_line_x, scan_line_y)
    begin
    
    if(reset = '1') then
        red   <= white(11 downto 8);
        green <= white(7 downto 4);
        blue  <= white(3 downto 0);
        count <= (others => '0');
        draw_pulse <= 0;  
    elsif(rising_edge(clk)) then
--        if(scan_line_y = 3) then
--            count <= (others => '0');
--            draw_pulse <= 0;
--        elsif((scan_line_y - count) >= ((2*pulse_width))) then
--            draw_pulse <= draw_pulse + 1;
--            count <= scan_line_y;
----            if(draw_pulse >= numb_pulse) then
----                draw_pulse <= 0;
----            end if;
--        else
            if(((scan_line_y <= 15) and (scan_line_x > 625)) or (scan_line_y >= 465)) then
                red   <= white(11 downto 8);
                green <= white(7 downto 4);
                blue  <= white(3 downto 0);
            elsif(scan_line_x < 30) then
                red <= red_lines_left(0) and red_lines_left(1) and red_lines_left(2) and red_lines_left(3) and red_lines_left(4) and red_lines_left(5) and red_lines_left(6) and red_lines_left(7) and red_lines_left(8) and red_lines_left(9) and red_lines_left(10) and red_lines_left(11) and red_lines_left(12) and red_lines_left(13) and red_lines_left(14) and red_lines_left(15) and red_lines_left(16) and red_lines_left(17) and red_lines_left(18) and red_lines_left(19) and red_lines_left(20) and red_lines_left(21) and red_lines_left(22);
                blue <= blue_lines_left(0) and blue_lines_left(1) and blue_lines_left(2) and blue_lines_left(3) and blue_lines_left(4) and blue_lines_left(5) and blue_lines_left(6) and blue_lines_left(7) and blue_lines_left(8) and blue_lines_left(9) and blue_lines_left(10) and blue_lines_left(11) and blue_lines_left(12) and blue_lines_left(13) and blue_lines_left(14) and blue_lines_left(15) and blue_lines_left(16) and blue_lines_left(17) and blue_lines_left(18) and blue_lines_left(19) and blue_lines_left(20) and blue_lines_left(21) and blue_lines_left(22);
                green <= green_lines_left(0) and green_lines_left(1) and green_lines_left(2) and green_lines_left(3) and green_lines_left(4) and green_lines_left(5) and green_lines_left(6) and green_lines_left(7) and green_lines_left(8) and green_lines_left(9) and green_lines_left(10) and green_lines_left(11) and green_lines_left(12) and green_lines_left(13) and green_lines_left(14) and green_lines_left(15) and green_lines_left(16) and green_lines_left(17) and green_lines_left(18) and green_lines_left(19) and green_lines_left(20) and green_lines_left(21) and green_lines_left(22);
            elsif(scan_line_x > 620) then
                red <= red_lines_right(0) and red_lines_right(1) and red_lines_right(2) and red_lines_right(3) and red_lines_right(4) and red_lines_right(5) and red_lines_right(6) and red_lines_right(7) and red_lines_right(8) and red_lines_right(9) and red_lines_right(10) and red_lines_right(11) and red_lines_right(12) and red_lines_right(13) and red_lines_right(14) and red_lines_right(15) and red_lines_right(16) and red_lines_right(17) and red_lines_right(18) and red_lines_right(19) and red_lines_right(20) and red_lines_right(21) and red_lines_right(22);
                blue <= blue_lines_right(0) and blue_lines_right(1) and blue_lines_right(2) and blue_lines_right(3) and blue_lines_right(4) and blue_lines_right(5) and blue_lines_right(6) and blue_lines_right(7) and blue_lines_right(8) and blue_lines_right(9) and blue_lines_right(10) and blue_lines_right(11) and blue_lines_right(12) and blue_lines_right(13) and blue_lines_right(14) and blue_lines_right(15) and blue_lines_right(16) and blue_lines_right(17) and blue_lines_right(18) and blue_lines_right(19) and blue_lines_right(20) and blue_lines_right(21) and blue_lines_right(22);
                green <= green_lines_right(0) and green_lines_right(1) and green_lines_right(2) and green_lines_right(3) and green_lines_right(4) and green_lines_right(5) and green_lines_right(6) and green_lines_right(7) and green_lines_right(8) and green_lines_right(9) and green_lines_right(10) and green_lines_right(11) and green_lines_right(12) and green_lines_right(13) and green_lines_right(14) and green_lines_right(15) and green_lines_right(16) and green_lines_right(17) and green_lines_right(18) and green_lines_right(19) and green_lines_right(20) and green_lines_right(21) and green_lines_right(22);
            else
                red <= white(11 downto 8);
                blue <= white(7 downto 4);
                green <= white(3 downto 0);
--                red <= red_lines_right(0) and red_lines_right(1) and red_lines_right(2) and red_lines_right(3) and red_lines_right(4) and red_lines_left(5) and red_lines_left(6) and red_lines_left(7) and red_lines_left(8) and red_lines_left(9);-- and red_lines_left(10) and red_lines_left(11) and red_lines_left(12) and red_lines_left(13) and red_lines_left(14) and red_lines_left(15) and red_lines_left(16) and red_lines_left(17);
--                blue <= blue_lines_left(0) and blue_lines_left(1) and blue_lines_left(2) and blue_lines_left(3) and blue_lines_left(4) and blue_lines_left(5) and blue_lines_left(6) and blue_lines_left(7) and blue_lines_left(8) and blue_lines_left(9);-- and blue_lines_left(10) and blue_lines_left(11) and blue_lines_left(12) and blue_lines_left(13) and blue_lines_left(14) and blue_lines_i(15) and blue_lines_i(16) and blue_lines_i(17);
--                green <= green_lines_left(0) and green_lines_left(1) and green_lines_left(2) and green_lines_left(3) and green_lines_left(4) and green_lines_left(5) and green_lines_left(6) and green_lines_left(7) and green_lines_left(8) and green_lines_left(9);
--                red <= red_lines_left(0 + 15) and red_lines_i(1 + 15) and red_lines_i(2 + 15) and red_lines_i(3 + 15) and red_lines_i(4 + 15) and red_lines_i(5 + 15) and red_lines_i(6 + 15) and red_lines_i(7 + 15) and red_lines_i(8 + 15) and red_lines_i(9 + 15) and red_lines_i(10 + 15) and red_lines_i(11 + 15) and red_lines_i(12 + 15) and red_lines_i(13 + 15) and red_lines_i(14 + 15) and red_lines_i(15 + 15) and red_lines_i(16 + 15) and red_lines_i(17 + 15);
--                blue <= blue_lines_i(0 + 15) and blue_lines_i(1 + 15) and blue_lines_i(2 + 15) and blue_lines_i(3 + 15) and blue_lines_i(4 + 15) and blue_lines_i(5 + 15) and blue_lines_i(6 + 15) and blue_lines_i(7 + 15) and blue_lines_i(8 + 15) and blue_lines_i(9 + 15) and blue_lines_i(10 + 15) and blue_lines_i(11 + 15) and blue_lines_i(12 + 15) and blue_lines_i(13 + 15) and blue_lines_i(14 + 15) and blue_lines_i(15 + 15) and blue_lines_i(16 + 15) and blue_lines_i(17 + 15);
--                green <= green_lines_i(0 + 15) and green_lines_i(1 + 15) and green_lines_i(2 + 15) and green_lines_i(3 + 15) and green_lines_i(4 + 15) and green_lines_i(5 + 15) and green_lines_i(6 + 15) and green_lines_i(7 + 15) and green_lines_i(8 + 15) and green_lines_i(9 + 15) and green_lines_i(10 + 15) and green_lines_i(11 + 15) and green_lines_i(12 + 15) and green_lines_i(13 + 15) and green_lines_i(14 + 15) and green_lines_i(15 + 15) and green_lines_i(16 + 15) and green_lines_i(17 + 15);
--            if(scan_line_x < 40) then
--                if(draw_pulse = 0) then
--                    red <= red_lines_left(draw_pulse) and red_lines_left(draw_pulse + 1) and red_lines_left(draw_pulse + 2);
--                    blue <= blue_lines_left(draw_pulse) and blue_lines_left(draw_pulse + 1) and blue_lines_left(draw_pulse + 2);
--                    green <= green_lines_left(draw_pulse) and green_lines_left(draw_pulse + 1) and green_lines_left(draw_pulse + 2);
--                elsif(draw_pulse = 1) then
--                    red <= red_lines_left(draw_pulse) and red_lines_left(draw_pulse - 1) and red_lines_left(draw_pulse + 1);
--                    blue <= blue_lines_left(draw_pulse) and blue_lines_left(draw_pulse - 1) and blue_lines_left(draw_pulse + 1);
--                    green <= green_lines_left(draw_pulse) and green_lines_left(draw_pulse - 1) and green_lines_left(draw_pulse + 1);
--                else
--                    red <= red_lines_left(draw_pulse) and red_lines_left(draw_pulse - 1) and red_lines_left(draw_pulse + 1) and red_lines_left(draw_pulse - 2) and red_lines_left(draw_pulse + 2);
--                    blue <= blue_lines_left(draw_pulse) and blue_lines_left(draw_pulse - 1) and blue_lines_left(draw_pulse + 1) and blue_lines_left(draw_pulse - 2) and blue_lines_left(draw_pulse + 2);
--                    green <= green_lines_left(draw_pulse) and green_lines_left(draw_pulse - 1) and green_lines_left(draw_pulse + 1) and green_lines_left(draw_pulse - 2) and green_lines_left(draw_pulse + 2);
--                end if;
                
--            else
--                red <= white(11 downto 8);
--                blue <= white(7 downto 4);
--                green <= white(3 downto 0);
--            else
--                if(draw_pulse = 0) then
--                    red <= red_lines_right(draw_pulse) and red_lines_right(draw_pulse + 1);
--                    blue <= blue_lines_right(draw_pulse) and blue_lines_right(draw_pulse + 1);
--                    green <= green_lines_right(draw_pulse) and green_lines_right(draw_pulse + 1);
--                else
--                    red <= red_lines_right(draw_pulse) and red_lines_right(draw_pulse - 1) and red_lines_right(draw_pulse + 1);
--                    blue <= blue_lines_right(draw_pulse) and blue_lines_right(draw_pulse - 1) and blue_lines_right(draw_pulse + 1);
--                    green <= green_lines_right(draw_pulse) and green_lines_right(draw_pulse - 1) and green_lines_right(draw_pulse + 1);
--                end if;
            --end if;
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
