----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2018 01:46:21 PM
-- Design Name: 
-- Module Name: Game_Top_Level - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Fix rectangle not using the signals ti gets
-- Improve VGA connections 
-- Fix the inverted number handler

entity Game_Top_Level is
    Port ( 
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        modecntrl: in std_logic;
        button_1: in std_logic;
        button_2: in std_logic;
        button_3: in std_logic;
        button_4: in std_logic;
        button_1_BT: in std_logic;
        button_2_BT: in std_logic;
        button_3_BT: in std_logic;
        button_4_BT: in std_logic;
        ledout: out std_logic;
        buzzerout: out std_logic;
        CA: out std_logic;
        CB: out std_logic;
        CC: out std_logic;
        CD: out std_logic;
        CE: out std_logic;
        CF: out std_logic;
        CG: out std_logic;
        DP: out std_logic;
        AN1: out std_logic;
        AN2: out std_logic;
        AN3: out std_logic;
        AN4: out std_logic;
        red: out STD_LOGIC_VECTOR(3 downto 0);
        green: out STD_LOGIC_VECTOR(3 downto 0);
        blue: out STD_LOGIC_VECTOR(3 downto 0);
        hsync: out std_logic;
        vsync: out std_logic
    );
end Game_Top_Level;

architecture Behavioral of Game_Top_Level is

component main_logic is
    Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       enable : in STD_LOGIC;
       modecntrl : in STD_LOGIC;
       button_1  : in STD_LOGIC;
       button_2  : in STD_LOGIC;
       button_3  : in STD_LOGIC;
       button_4  : in STD_LOGIC;
       round_winner: out STD_LOGIC_VECTOR(3 downto 0);
       winner_select: out STD_LOGIC_VECTOR(3 downto 0);
       button_1_score: out STD_LOGIC_VECTOR(3 downto 0);
       button_2_score: out STD_LOGIC_VECTOR(3 downto 0);
       button_3_score: out STD_LOGIC_VECTOR(3 downto 0);
       button_4_score: out STD_LOGIC_VECTOR(3 downto 0);           
       delayed_enable: out STD_LOGIC;
       menu_enable : out STD_LOGIC;
       display_cntrl: out STD_LOGIC_VECTOR(1 downto 0);
       reset_scores_out: out STD_LOGIC);
end component;

component vga_module is
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
end component;

component AVG_Control is
Port (
    clk: in std_logic;
reset: in std_logic;
enable: in std_logic;
winner_select: in STD_LOGIC_VECTOR(3 downto 0);
round_winner: in STD_LOGIC_VECTOR(3 downto 0);
binary_time: in STD_LOGIC_VECTOR(13 downto 0);
dig1: out std_logic_vector(3 downto 0);
dig2: out std_logic_vector(3 downto 0);
dig3: out std_logic_vector(3 downto 0);
dig4: out std_logic_vector(3 downto 0));
end component;

component Game_Control is
    Port ( 
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        dig1: out std_logic_vector(3 downto 0);
        dig2: out std_logic_vector(3 downto 0);
        dig3: out std_logic_vector(3 downto 0);
        dig4: out std_logic_vector(3 downto 0);
        binary_time: out std_logic_vector(13 downto 0);
        ledflash: out std_logic
);
end component;

component Sound_Control is
    Generic ( 
period: integer:=256;   -- Period is 10 ns * period generic. ex for 100 Hz period should be 1,000,000
width : integer := 9);
Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       enable : in STD_LOGIC;
       winner_select: in STD_LOGIC_Vector(3 downto 0);
       buzzer_out : out STD_LOGIC
       );
end component;

component mode_multiplexor is
Port (
        time_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
        time_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
        time_dig3 : in STD_LOGIC_VECTOR (3 downto 0);
        time_dig4 : in STD_LOGIC_VECTOR (3 downto 0);
        avg_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
        avg_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
        avg_dig3 : in STD_LOGIC_VECTOR (3 downto 0);
        avg_dig4 : in STD_LOGIC_VECTOR (3 downto 0);
        aux_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
        aux_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
        aux_dig3 : in STD_LOGIC_VECTOR (3 downto 0);
        aux_dig4 : in STD_LOGIC_VECTOR (3 downto 0);
        selector : in STD_LOGIC_VECTOR(1 downto 0);
        out_dig1 : out STD_LOGIC_VECTOR (3 downto 0);
        out_dig2 : out STD_LOGIC_VECTOR (3 downto 0);
        out_dig3 : out STD_LOGIC_VECTOR (3 downto 0);
        out_dig4 : out STD_LOGIC_VECTOR (3 downto 0)
      );
end component;

component Menu_Control is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           winner_select: in STD_LOGIC_VECTOR(3 downto 0);
           button_1_score: in STD_LOGIC_VECTOR(3 downto 0);
           button_2_score: in STD_LOGIC_VECTOR(3 downto 0);
           button_3_score: in STD_LOGIC_VECTOR(3 downto 0);
           button_4_score: in STD_LOGIC_VECTOR(3 downto 0);
           dig1 : out STD_LOGIC_VECTOR (3 downto 0);
           dig2 : out STD_LOGIC_VECTOR (3 downto 0);
           dig3 : out STD_LOGIC_VECTOR (3 downto 0);
           dig4 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component display_top_level is
    Port ( 
           clk: in std_logic;
           reset: in std_logic;
           dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           dig3 : in STD_LOGIC_VECTOR (3 downto 0);
           dig4 : in STD_LOGIC_VECTOR (3 downto 0);
           segC : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (3 downto 0);
           DP : out STD_LOGIC);
end component;


signal menu_enable_ml: std_logic;
signal reset_scores_out_ml: std_logic;
signal display_cntrl_ml:std_logic_vector(1 downto 0);
signal delayed_enable_game:std_logic;
signal game_dig1,game_dig2,game_dig3,game_dig4: std_logic_vector(3 downto 0);
signal menu_dig1,menu_dig2,menu_dig3,menu_dig4: std_logic_vector(3 downto 0);
signal player1_score_ml,player2_score_ml,player3_score_ml,player4_score_ml,winner_select_ml,round_winner_ml: std_logic_vector(3 downto 0);
signal avg_dig1,avg_dig2,avg_dig3,avg_dig4: std_logic_vector(3 downto 0);
signal out_dig1,out_dig2,out_dig3,out_dig4: std_logic_vector(3 downto 0);
signal out_segC:STD_LOGIC_VECTOR (6 downto 0);
signal out_AN:STD_LOGIC_VECTOR (3 downto 0);
signal binary_time_i:std_logic_vector(13 downto 0);
signal sound_enable:std_logic;

signal button_1_Combined,button_2_Combined,button_3_Combined,button_4_Combined: std_logic;

begin

button_1_Combined<=button_1 or button_1_BT;
button_2_Combined<=button_2 or button_2_BT;
button_3_Combined<=button_3 or button_3_BT;
button_4_Combined<=button_4 or button_4_BT;

sound_enable<=delayed_enable_game and modecntrl;

MAINFSM:main_logic port map (clk,reset,enable,modecntrl,button_1_Combined,button_2_Combined,button_3_Combined,button_4_Combined,round_winner_ml,winner_select_ml,player1_score_ml,player2_score_ml,player3_score_ml,player4_score_ml,delayed_enable_game,menu_enable_ml,display_cntrl_ml,reset_scores_out_ml);
AVERAGE: AVG_Control port map(clk,reset,enable,winner_select_ml,round_winner_ml,binary_time_i,avg_dig1,avg_dig2,avg_dig3,avg_dig4);
GAME:Game_Control port map(clk,reset,delayed_enable_game,game_dig1,game_dig2,game_dig3,game_dig4,binary_time_i,ledout);
MENU: Menu_Control port map(clk,reset,menu_enable_ml,winner_select_ml,player1_score_ml,player2_score_ml,player3_score_ml,player4_score_ml,menu_dig1,menu_dig2,menu_dig3,menu_dig4);
MUXMODE: mode_multiplexor port map(game_dig1,game_dig2,game_dig3,game_dig4,avg_dig1,avg_dig2,avg_dig3,avg_dig4,menu_dig1,menu_dig2,menu_dig3,menu_dig4,display_cntrl_ml,out_dig1,out_dig2,out_dig3,out_dig4);
DISP:display_top_level port map(clk,reset,out_dig1,out_dig2,out_dig3,out_dig4,out_segC,out_AN,DP);
SOUND:Sound_Control generic map(62500000,28) port map(clk,reset,sound_enable,winner_select_ml,buzzerout);    -- Should be a component of main_logic probably?
VGA:vga_module port map(clk,reset,enable,reset_scores_out_ml,delayed_enable_game,red,green,blue,round_winner_ml,winner_select_ml,out_dig1,out_dig2,out_dig3,out_dig4,player1_score_ml,player2_score_ml,player3_score_ml,player4_score_ml,hsync,vsync); -- TEMP SHOULD BE IMPROVED


CA<=out_segC(0);
CB<=out_segC(1);
CC<=out_segC(2);
CD<=out_segC(3);
CE<=out_segC(4);
CF<=out_segC(5);
CG<=out_segC(6);

AN1<=out_AN(0);
AN2<=out_AN(1);
AN3<=out_AN(2);
AN4<=out_AN(3);


end Behavioral;
