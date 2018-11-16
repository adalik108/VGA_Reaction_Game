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

entity Growing_Rectangle is
    Generic ( 	box_width: integer:= 10;
                x_offset: integer:= 50);
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
end Growing_Rectangle;

architecture Behavioral of Growing_Rectangle is

signal redraw: std_logic_vector(5 downto 0):=(others=>'0');
constant rect_pos_x_min: std_logic_vector(9 downto 0) := "0000000000";
constant rect_pos_y_min: std_logic_vector(9 downto 0) := "0000000000";
constant rect_pos_x_max: std_logic_vector(9 downto 0) := "1010000000" - 1;
constant rect_pos_y_max: std_logic_vector(9 downto 0) := "0111100000" - 1;
signal pixel_color: std_logic_vector(11 downto 0);
signal rect_pos_x, rect_height: std_logic_vector(9 downto 0);
signal box_move_dir_x, box_move_dir_y: std_logic;


begin

process(reset)
begin	
    if (reset ='1') then
        
        rect_height <= "0001100010";
--        box_move_dir_x <= '0';
--        box_move_dir_y <= '0';
        --redraw <= (others=>'0');
	else    
        rect_height <= rectangle_height;
        
	end if;
end process;

rect_pos_x <= std_logic_vector(to_unsigned(x_offset, rect_pos_x'length));

pixel_color <= rectangle_color when     ((scan_line_x >= rect_pos_x) and 
								(scan_line_y >= rect_pos_y_max - rect_height) and 
								(scan_line_x < rect_pos_x+box_width) and 
								(scan_line_y < rect_pos_y_max)) 
					   else
				                "111111111111"; -- represents WHITE
								
red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);

--box_move_dir_x <= '1' and '1';



--box_loc_x_max <= "1010000000" - box_width - 1;
-- Describe the value for box_loc_y_max here:
-- Hint: In binary, 640 is 1010000000 and 480 is 0111100000
-- ADDED
--box_loc_y_max <= "0111100000" - box_width - 1;

end Behavioral;
