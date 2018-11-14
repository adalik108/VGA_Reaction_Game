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
    Port (  clk : in  STD_LOGIC;
            buttons: in STD_LOGIC_VECTOR(2 downto 0);
            switches: in STD_LOGIC_VECTOR(13 downto 0);
            red: out STD_LOGIC_VECTOR(3 downto 0);
            green: out STD_LOGIC_VECTOR(3 downto 0);
            blue: out STD_LOGIC_VECTOR(3 downto 0);
            hsync: out STD_LOGIC;
            vsync: out STD_LOGIC
	 );
end vga_module;

architecture Behavioral of vga_module is
-- Components:
component sync_signals_generator is
    Port ( pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           hor_sync: out STD_LOGIC;
           ver_sync: out STD_LOGIC;
           blank: out STD_LOGIC;
           scan_line_x: out STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: out STD_LOGIC_VECTOR(10 downto 0)
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
component clock_divider is
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

component vga_stripes_dff2 is
    Port ( pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           next_pixel : in  STD_LOGIC;
		   mode: in STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (3 downto 0);
           G : out  STD_LOGIC_VECTOR (3 downto 0);
           R : out  STD_LOGIC_VECTOR (3 downto 0)
         );
 end component;
 
 component bouncing_box is
 Port (  clk : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
         scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
         box_color: in STD_LOGIC_VECTOR(11 downto 0);
         box_width: in STD_LOGIC_VECTOR(8 downto 0);
         kHz: in STD_LOGIC;
         red: out STD_LOGIC_VECTOR(3 downto 0);
         blue: out STD_LOGIC_VECTOR(3 downto 0);
         green: out std_logic_vector(3 downto 0)
      );
end component;
-- END ADDED

-- Signals:
signal reset: std_logic;
signal vga_select: std_logic;

signal disp_blue: std_logic_vector(3 downto 0);
signal disp_red: std_logic_vector(3 downto 0);
signal disp_green: std_logic_vector(3 downto 0);

-- Stripe block signals:
signal show_stripe: std_logic;

-- Clock divider signals:
signal i_kHz, i_hHz, i_pixel_clk: std_logic;

-- Sync module signals:
signal vga_blank : std_logic;
signal scan_line_x, scan_line_y: STD_LOGIC_VECTOR(10 downto 0);

-- Box size signals:
signal inc_box, dec_box: std_logic;
signal box_size: std_logic_vector(8 downto 0);

-- Bouncing box signals:
signal box_color: std_logic_vector(11 downto 0);
signal box_red: std_logic_vector(3 downto 0);
signal box_green: std_logic_vector(3 downto 0);
signal box_blue: std_logic_vector(3 downto 0);

-- ADDED
signal stripe_red: std_logic_vector(3 downto 0);
signal stripe_green: std_logic_vector(3 downto 0);
signal stripe_blue: std_logic_vector(3 downto 0);

begin

VGA_SYNC: sync_signals_generator
    Port map( 	pixel_clk   => i_pixel_clk,
                reset       => reset,
                hor_sync    => hsync,
                ver_sync    => vsync,
                blank       => vga_blank,
                scan_line_x => scan_line_x,
                scan_line_y => scan_line_y
			  );

CHANGE_BOX_SIZE: up_down_counter
	Generic map( 	WIDTH => 9)
	Port map(
					up 	   => inc_box,
					down   => dec_box,
					clk	   => clk,
					reset  => reset,
					enable => i_hHz,
                    val    => box_size
	);

-- ADDED	
DIVIDER: clock_divider
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
		  
STRIPES_DFF: vga_stripes_dff2
	Port map ( pixel_clk  => i_pixel_clk,
               reset      => reset,
               next_pixel => show_stripe,
               mode       => switches(0), -- can be a different switch
               B          => stripe_blue,
               G          => stripe_green,
               R          => stripe_red
             );
             
BOX: bouncing_box
    Port map ( clk         => clk,
               reset       => reset,
               scan_line_x => scan_line_x,
               scan_line_y => scan_line_y,
               box_color   => box_color,
               box_width   => box_size,
               kHz         => i_kHz,
               red         => box_red,
               blue        => box_blue,
               green       => box_green
           );
-- END ADDED

show_stripe <= not vga_blank;

-- BLANKING:
-- Follow this syntax to assign other colors when they are not being blanked
red <= "0000" when (vga_blank = '1') else disp_red;
-- ADDED:
blue  <= "0000" when (vga_blank = '1') else disp_blue;
green <= "0000" when (vga_blank = '1') else disp_green;

-- Connect input buttons and switches:
-- ADDED
-- These can be assigned to different switches/buttons
reset <= buttons(0);
box_color <= switches(13 downto 2);
vga_select <= switches(1);
inc_box <= buttons(1);
dec_box <= buttons(2);

-----------------------------------------------------------------------------
-- OUTPUT SELECTOR:
-- Select which component to display - stripes or bouncing box
selectOutput: process(box_red, box_blue, box_green, stripe_blue, stripe_red, stripe_green, vga_select)
begin
	case (vga_select) is
		-- Select which input gets written to disp_red, disp_blue and disp_green
		-- ADDED
		when '0' => disp_red <= box_red; disp_blue <= box_blue; disp_green <= box_green;
		when '1' => disp_red <= stripe_red; disp_blue <= stripe_blue; disp_green <= stripe_green;
		when others => disp_red <= "0000"; disp_blue <= "0000"; disp_green <= "0000";
	end case;
end process selectOutput;
-----------------------------------------------------------------------------

end Behavioral;

