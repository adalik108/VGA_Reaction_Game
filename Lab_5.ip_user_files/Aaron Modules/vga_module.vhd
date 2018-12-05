-- This is the top-level module
-- The functions of the buttons and switches are below

--                     Buttons
-- XDC name      XDC pin     Board label    Purpose
-----------------------------------------------------
-- buttons(0)     U18           BTNC   - Increase box size
-- buttons(2)     T18           BTNU   - Resets system
-- buttons(3)     U17           BTND   - Decrease box size

--                    Switches
-- XDC name      XDC pin     Board label    Purpose
------------------------------------------------------
-- switches(0)    SW0           V17    - Changes stripes pattern in stripes mode
-- switches(1)    SW1           V16    - Changes mode between   : 0 = bouncing box; 1 = stripes 
-- switches(2)    SW2           W16    - Box mode: Blue(0) LSB  : 0 = OFF; 1 = ON
-- switches(3)    SW3           W17    - Box mode: Blue(1)      : 0 = OFF; 1 = ON
-- switches(4)    SW4           W15    - Box mode: Blue(2)      : 0 = OFF; 1 = ON
-- switches(5)    SW5           V15    - Box mode: Blue(3) MSB  : 0 = OFF; 1 = ON
-- switches(6)    SW6           W14    - Box mode: Green(0) LSB : 0 = OFF; 1 = ON
-- switches(7)    SW7           W13    - Box mode: Green(1)     : 0 = OFF; 1 = ON
-- switches(8)    SW8           V2     - Box mode: Green(2)     : 0 = OFF; 1 = ON
-- switches(9)    SW9           T3     - Box mode: Green(3) MSB : 0 = OFF; 1 = ON
-- switches(10)   SW10          T2     - Box mode: Red(0) LSB   : 0 = OFF; 1 = ON
-- switches(11)   SW11          R3     - Box mode: Red(1)       : 0 = OFF; 1 = ON
-- switches(12)   SW12          W2     - Box mode: Red(2)       : 0 = OFF; 1 = ON
-- switches(13)   SW13          U1     - Box mode: Red(3) MSB   : 0 = OFF; 1 = ON

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_module is
    Port (  
        clk : in  STD_LOGIC;
        reset: in STD_LOGIC;
        enable: in STD_LOGIC;
        reset_scores: in STD_LOGIC;
        game_delayed_enable: in STD_LOGIC;
        red: out STD_LOGIC_VECTOR(3 downto 0);
        green: out STD_LOGIC_VECTOR(3 downto 0);
        blue: out STD_LOGIC_VECTOR(3 downto 0);
        round_winner: in STD_LOGIC_VECTOR(3 downto 0);
        winner_select: in STD_LOGIC_VECTOR(3 downto 0);
        dig1:   in STD_LOGIC_VECTOR(3 downto 0);
        dig2:   in STD_LOGIC_VECTOR(3 downto 0);
        dig3:   in STD_LOGIC_VECTOR(3 downto 0);
        dig4:   in STD_LOGIC_VECTOR(3 downto 0);
        button_1_score: in STD_LOGIC_VECTOR(3 downto 0);
        button_2_score: in STD_LOGIC_VECTOR(3 downto 0);
        button_3_score: in STD_LOGIC_VECTOR(3 downto 0);
        button_4_score: in STD_LOGIC_VECTOR(3 downto 0);       
        hsync: out STD_LOGIC;
        vsync: out STD_LOGIC
 );
end vga_module;

architecture Behavioral of vga_module is
-- Components:
component sync_signals_generator is
    Port ( 
           clk: in STD_LOGIC;
           pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           hor_sync: out STD_LOGIC;
           ver_sync: out STD_LOGIC;
           blank: out STD_LOGIC;
           scan_line_x: out STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: out STD_LOGIC_VECTOR(10 downto 0)
          );
end component;


component Time_Display_VGA is
    Generic (
           x_offset: integer:= 50;
           y_offset: integer:= 50);
            
Port (     
    clk : in  STD_LOGIC;
    reset : in  STD_LOGIC;
    scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
    scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
    dig1:   in STD_LOGIC_VECTOR(3 downto 0);
    dig2:   in STD_LOGIC_VECTOR(3 downto 0);
    dig3:   in STD_LOGIC_VECTOR(3 downto 0);
    dig4:   in STD_LOGIC_VECTOR(3 downto 0);
    kHz: in STD_LOGIC;
    red: out STD_LOGIC_VECTOR(3 downto 0);
    blue: out STD_LOGIC_VECTOR(3 downto 0);
    green: out std_logic_vector(3 downto 0)
  );
end component;

component up_down_counter is
	Generic ( WIDTH: integer:= 6);
	Port (
		up: in STD_LOGIC;
		down: in STD_LOGIC;
        clk: in std_logic;
		reset: in std_logic;
		enable: in std_logic;
        val: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end component;

-- ADDED
component clock_divider_VGA is
Port (  clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        enable: in STD_LOGIC;
        kHz: out STD_LOGIC;	  
        seconds_port: out STD_LOGIC_VECTOR(4-1 downto 0);     -- unused
        ten_seconds_port: out STD_LOGIC_VECTOR(3-1 downto 0); -- unused
        minutes_port: out STD_LOGIC_VECTOR(4-1 downto 0);     -- unused
        ten_minutes_port: out STD_LOGIC_VECTOR(3-1 downto 0); -- unused
        twentyfive_MHz: out STD_LOGIC;
        hHz: out STD_LOGIC
	  );
end component;

--component vga_stripes_dff2 is
--    Port ( pixel_clk : in  STD_LOGIC;
--           reset : in  STD_LOGIC;
--           next_pixel : in  STD_LOGIC;
--		   mode: in STD_LOGIC;
--           B : out  STD_LOGIC_VECTOR (3 downto 0);
--           G : out  STD_LOGIC_VECTOR (3 downto 0);
--           R : out  STD_LOGIC_VECTOR (3 downto 0)
--         );
-- end component;
 
 component Growing_Rectangle is
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
end component;

component Player1_Display is
    Generic ( 	--p1_height: integer:= 10;
            p1_width: integer:= 120;
            p1_x_offset: integer:= 50;
            p1_y_offset: integer:= 50);
            
Port (     clk : in  STD_LOGIC;
    reset : in  STD_LOGIC;
    scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
    scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
    char_colour: in std_logic_vector(11 downto 0);
    rectangle_colour: in STD_LOGIC_VECTOR(11 downto 0);
    rectangle_height: in STD_LOGIC_VECTOR(9 downto 0);
    button_score: in STD_LOGIC_VECTOR(3 downto 0);
    seg7: std_logic_vector(6 downto 0);
    kHz: in STD_LOGIC;
    red: out STD_LOGIC_VECTOR(3 downto 0);
    blue: out STD_LOGIC_VECTOR(3 downto 0);
    green: out std_logic_vector(3 downto 0)
  );
end component;


component Player_Display_Winner is
   Generic ( 	--p1_height: integer:= 10;
             p1_width: integer:= 360;
             p1_x_offset: integer:= 0;
             p1_y_offset: integer:= 180);
             
 Port (     clk : in  STD_LOGIC;
     reset : in  STD_LOGIC;
     scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
     scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
     char_colour: in std_logic_vector(11 downto 0);
     rectangle_colour: in STD_LOGIC_VECTOR(11 downto 0);
     rectangle_height: in STD_LOGIC_VECTOR(9 downto 0);
     seg7: std_logic_vector(6 downto 0);
     kHz: in STD_LOGIC;
     red: out STD_LOGIC_VECTOR(3 downto 0);
     blue: out STD_LOGIC_VECTOR(3 downto 0);
     green: out std_logic_vector(3 downto 0)
   );
end component;

component VGA_Border is
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
-- END ADDED

-- Signals:
signal vga_select: std_logic;

signal disp_blue: std_logic_vector(3 downto 0);
signal disp_red: std_logic_vector(3 downto 0);
signal disp_green: std_logic_vector(3 downto 0);

-- Player Display Signals
signal player1_disp_red: std_logic_vector(3 downto 0);
signal player1_disp_blue: std_logic_vector(3 downto 0);
signal player1_disp_green: std_logic_vector(3 downto 0);
signal player1_seg7: std_logic_vector(6 downto 0);

signal player2_disp_red: std_logic_vector(3 downto 0);
signal player2_disp_blue: std_logic_vector(3 downto 0);
signal player2_disp_green: std_logic_vector(3 downto 0);
signal player2_seg7: std_logic_vector(6 downto 0);

signal player3_disp_red: std_logic_vector(3 downto 0);
signal player3_disp_blue: std_logic_vector(3 downto 0);
signal player3_disp_green: std_logic_vector(3 downto 0);
signal player3_seg7: std_logic_vector(6 downto 0);

signal player4_disp_red: std_logic_vector(3 downto 0);
signal player4_disp_blue: std_logic_vector(3 downto 0);
signal player4_disp_green: std_logic_vector(3 downto 0);
signal player4_seg7: std_logic_vector(6 downto 0);

signal player_winner_disp_red: std_logic_vector(3 downto 0);
signal player_winner_disp_blue: std_logic_vector(3 downto 0);
signal player_winner_disp_green: std_logic_vector(3 downto 0);
signal player_winner_seg7:std_logic_vector(6 downto 0);

-- Timer Display Signals
signal time_disp_red: std_logic_vector (3 downto 0);
signal time_disp_blue: std_logic_vector (3 downto 0);
signal time_disp_green: std_logic_vector (3 downto 0);

-- Stripe block signals:
signal show_stripe: std_logic;

-- Clock divider signals:
signal i_kHz, i_hHz, i_pixel_clk: std_logic;

-- Sync module signals:
signal vga_blank : std_logic;
signal scan_line_x, scan_line_y: STD_LOGIC_VECTOR(10 downto 0);

-- Rectangle size signals:
signal inc_rectangle, dec_rectangle: std_logic;
signal growth_reset: std_logic;
signal player1_rectangle_size: std_logic_vector(9 downto 0);
signal player2_rectangle_size: std_logic_vector(9 downto 0);
signal player3_rectangle_size: std_logic_vector(9 downto 0);
signal player4_rectangle_size: std_logic_vector(9 downto 0);

-- Rectangle signals:
signal player1_rectangle_color: std_logic_vector(11 downto 0):= (11 downto 8 => '1', others => '0');
signal player2_rectangle_color: std_logic_vector(11 downto 0):= (7 downto 4 => '1', others => '0');
signal player3_rectangle_color: std_logic_vector(11 downto 0):= (3 downto 0 => '1', others => '0');
signal player4_rectangle_color: std_logic_vector(11 downto 0):= (11 downto 6 => '1', others => '0');
signal border_color: std_logic_vector(11 downto 0):= (11 downto 4 => '0', others => '1');
signal rectangle_red: std_logic_vector(3 downto 0);
signal rectangle_green: std_logic_vector(3 downto 0);
signal rectangle_blue: std_logic_vector(3 downto 0);

signal border_red: std_logic_vector(3 downto 0);
signal border_green: std_logic_vector(3 downto 0);
signal border_blue: std_logic_vector(3 downto 0);

-- Letter signals:
signal letter_color: std_logic_vector(11 downto 0) := (others => '0');
signal letter_red: std_logic_vector(3 downto 0);
signal letter_green: std_logic_vector(3 downto 0);
signal letter_blue: std_logic_vector(3 downto 0);
-- ADDED
--signal stripe_red: std_logic_vector(3 downto 0);
--signal stripe_green: std_logic_vector(3 downto 0);
--signal stripe_blue: std_logic_vector(3 downto 0);



begin

VGA_SYNC: sync_signals_generator
    Port map( 	
                clk=>clk,
                pixel_clk   => i_pixel_clk,
                reset       => reset,
                hor_sync    => hsync,
                ver_sync    => vsync,
                blank       => vga_blank,
                scan_line_x => scan_line_x,
                scan_line_y => scan_line_y
			  );


growth_reset<= reset or reset_scores;
CHANGE_Rectangle_Height_1: up_down_counter
	Generic map( 	WIDTH => 10)
	Port map(
					up 	   => round_winner(0),
					down   => dec_rectangle,
					clk	   => clk,
					reset  => growth_reset,
					enable => round_winner(0),
                    val    => player1_rectangle_size
	);
	
CHANGE_Rectangle_Height_2: up_down_counter  -- For unknown reasons player 2 and player 4 are swapped from exit signals in main logic - bandaid fixing 
    Generic map(     WIDTH => 10)
    Port map(
                    up        => round_winner(3),
                    down   => dec_rectangle,
                    clk       => clk,
                    reset  => growth_reset,
                    enable => round_winner(3),
                    val    => player2_rectangle_size
    );

CHANGE_Rectangle_Height_3: up_down_counter
	Generic map( 	WIDTH => 10)
	Port map(
					up 	   => round_winner(2),
					down   => dec_rectangle,
					clk	   => clk,
					reset  => growth_reset,
					enable => round_winner(2),
                    val    => player3_rectangle_size
	);
	
CHANGE_Rectangle_Height_4: up_down_counter
    Generic map(     WIDTH => 10)
    Port map(
                    up        => round_winner(1),
                    down   => dec_rectangle,
                    clk       => clk,
                    reset  => growth_reset,
                    enable => round_winner(1),
                    val    => player4_rectangle_size
    );

-- ADDED	
DIVIDER: clock_divider_VGA
    Port map (  clk              => clk,
                reset            => reset,
                kHz              => i_kHz,
                twentyfive_MHz   => i_pixel_clk,
                enable           => '1',
                seconds_port     => open,
                ten_seconds_port => open,
                minutes_port     => open,
                ten_minutes_port => open,
                hHz              => i_hHz
		  );

TIMER: Time_Display_VGA -- Invert Time digits
    Port map (     
    clk=>clk,
    reset=>reset,
    scan_line_x=>scan_line_x,
    scan_line_y=>scan_line_y,
    dig1=>dig1,
    dig2=>dig2,
    dig3=>dig3,
    dig4=>dig4,
    kHz=>i_kHz,
    red=>time_disp_red,
    blue=>time_disp_blue,
    green=>time_disp_green
  );

--STRIPES_DFF: vga_stripes_dff2
--	Port map ( pixel_clk  => i_pixel_clk,
--               reset      => reset,
--               next_pixel => show_stripe,
--               mode       => switches(0), -- can be a different switch
--               B          => stripe_blue,
--               G          => stripe_green,
--               R          => stripe_red
--             );
             
--Rectangle: Growing_Rectangle
--    Port map ( clk         => clk,
--               reset       => reset,
--               scan_line_x => scan_line_x,
--               scan_line_y => scan_line_y,
--               rectangle_color   => rectangle_color,
--               rectangle_height   => rectangle_size,
--               kHz         => i_kHz,
--               red         => rectangle_red,
--               blue        => rectangle_blue,
--               green       => rectangle_green
--           );
-- END ADDED


-- Off for timer testing


PlayerNo1: Player1_Display
      Generic Map(     
                  p1_x_offset  => 30,
                  p1_y_offset  => 450
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  char_colour       => letter_color,
                  rectangle_colour => player1_rectangle_color,
                  rectangle_height => player1_rectangle_size,
                  button_score=>button_1_score,
                  seg7=>"0110000",  -- Seg7 for 1
                  kHz             => i_kHz,
                  red             => player1_disp_red,
                  blue            => player1_disp_blue,
                  green           => player1_disp_green
        );
        
PlayerNo2: Player1_Display
      Generic Map(     
                  p1_x_offset  => 180,
                  p1_y_offset  => 450
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  char_colour       => letter_color,
                  rectangle_colour => player2_rectangle_color,
                  rectangle_height => player2_rectangle_size,
                  button_score=>button_2_score,
                  seg7=>"1101101",-- Seg7 for 2
                  kHz             => i_kHz,
                  red             => player2_disp_red,
                  blue            => player2_disp_blue,
                  green           => player2_disp_green
        );
                
PlayerNo3: Player1_Display
  Generic Map(     
              p1_x_offset  => 330,
              p1_y_offset  => 450
              )
  Port Map(     
              clk             => clk,
              reset           => reset,
              scan_line_x     => scan_line_x,
              scan_line_y     => scan_line_y,
              char_colour       => letter_color,
              rectangle_colour => player3_rectangle_color,
              rectangle_height => player3_rectangle_size,
              button_score=>button_3_score,
              seg7=>"1111001",-- Seg7 for 3
              kHz             => i_kHz,
              red             => player3_disp_red,
              blue            => player3_disp_blue,
              green           => player3_disp_green
    );
            

PlayerNo4: Player1_Display
      Generic Map(     
                  p1_x_offset  => 480,
                  p1_y_offset  => 450
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  char_colour       => letter_color,
                  rectangle_colour => player4_rectangle_color,
                  rectangle_height => player4_rectangle_size,
                  button_score=>button_4_score,
                  seg7=>"0110011",-- Seg7 for 4
                  kHz             => i_kHz,
                  red             => player4_disp_red,
                  blue            => player4_disp_blue,
                  green           => player4_disp_green
        );

PlayerWinner: Player_Display_Winner
      Generic Map(     
                  p1_x_offset  => 160,
                  p1_y_offset  => 180
                  )
      Port Map(     
                  clk             => clk,
                  reset           => reset,
                  scan_line_x     => scan_line_x,
                  scan_line_y     => scan_line_y,
                  char_colour       => letter_color,
                  rectangle_colour => player1_rectangle_color,
                  rectangle_height => player1_rectangle_size,
                  seg7=>player_winner_seg7,
                  kHz             => i_kHz,
                  red             => player_winner_disp_red,
                  blue            => player_winner_disp_blue,
                  green           => player_winner_disp_green
        );
        
Border: VGA_Border
    Port Map(clk, reset, scan_line_x, scan_line_y, border_color, i_kHz, border_red, border_blue, border_green);

show_stripe <= not vga_blank;

-- Combining Current Outputs
Display_Select: process(enable,player1_disp_red,player2_disp_red,player3_disp_red,player4_disp_red,time_disp_red,player1_disp_green,player2_disp_green,player3_disp_green,player4_disp_green,time_disp_green,player1_disp_blue,player2_disp_blue,player3_disp_blue,player4_disp_blue,time_disp_blue,player_winner_disp_red,player_winner_disp_blue,player_winner_disp_green)
begin
if(enable='1') then
    if(winner_select(0) or winner_select(1) or winner_select(2) or winner_select(3))='1' then
        disp_red<=player1_disp_red and player2_disp_red and player3_disp_red and player4_disp_red and time_disp_red and player_winner_disp_red;
        disp_blue<=player1_disp_blue and player2_disp_blue and player3_disp_blue and player4_disp_blue and time_disp_blue and player_winner_disp_blue;
        disp_green<=player1_disp_green and player2_disp_green and player3_disp_green and player4_disp_green and time_disp_green and player_winner_disp_green;
    elsif(game_delayed_enable='1') then
        disp_red<=not(player1_disp_red and player2_disp_red and player3_disp_red and player4_disp_red and time_disp_red);
        disp_blue<=not(player1_disp_blue and player2_disp_blue and player3_disp_blue and player4_disp_blue and time_disp_blue);
        disp_green<=not(player1_disp_green and player2_disp_green and player3_disp_green and player4_disp_green and time_disp_green);
    else
        disp_red<=player1_disp_red and player2_disp_red and player3_disp_red and player4_disp_red and time_disp_red;
        disp_blue<=player1_disp_blue and player2_disp_blue and player3_disp_blue and player4_disp_blue and time_disp_blue;
        disp_green<=player1_disp_green and player2_disp_green and player3_disp_green and player4_disp_green and time_disp_green;
    end if;
else    -- Plug in menu Art here when ready 
disp_red<=time_disp_red and border_red;
disp_blue<=time_disp_blue and border_blue;
disp_green<=time_disp_green and border_green;
end if;
end process;

Winner_Seg: process(winner_select) 
begin
case(winner_select) is
    when "0001"=> player_winner_seg7<="0110000";    -- Seg7 for 1
    when "1000"=>player_winner_seg7<="1101101";-- Seg7 for 2
    when "0100"=>player_winner_seg7<="1111001";-- Seg7 for 3
    when "0010"=>player_winner_seg7<="0110011";-- Seg7 for 4
    when others=>player_winner_seg7<="1111111";
end case;
end process;


-- BLANKING:
-- Follow this syntax to assign other colors when they are not being blanked
red <= "0000" when (vga_blank = '1') else disp_red;
-- ADDED:
blue  <= "0000" when (vga_blank = '1') else disp_blue;
green <= "0000" when (vga_blank = '1') else disp_green;

-- Connect input buttons and switches:
-- ADDED
-- These can be assigned to different switches/buttons
--box_color <= switches(13 downto 2);
--vga_select <= switches(1);
dec_rectangle <='0';

-----------------------------------------------------------------------------
-- OUTPUT SELECTOR:
-- Select which component to display - stripes or bouncing box
--selectOutput: process(box_red, box_blue, box_green, stripe_blue, stripe_red, stripe_green, vga_select)
--begin
--	case (vga_select) is
--		-- Select which input gets written to disp_red, disp_blue and disp_green
--		-- ADDED
--		when '0' => 
		--disp_red <= rectangle_red and letter_red; disp_blue <= rectangle_blue and letter_blue; disp_green <= rectangle_green and letter_green;
--		when '1' => disp_red <= stripe_red; disp_blue <= stripe_blue; disp_green <= stripe_green;
--		when others => disp_red <= "0000"; disp_blue <= "0000"; disp_green <= "0000";
--	end case;
--end process selectOutput;
-----------------------------------------------------------------------------

end Behavioral;
