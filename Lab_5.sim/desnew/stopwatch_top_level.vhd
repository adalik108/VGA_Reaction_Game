-- This file needs editing by students

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stopwatch_top_level is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           SW_START : in  STD_LOGIC;
           LAP_TIME : in  STD_LOGIC;
           CD_MODE  : in  STD_LOGIC;
           Buttons  : in  STD_LOGIC_VECTOR(3 downto 0);
           CA       : out STD_LOGIC;
           CB       : out STD_LOGIC;
           CC       : out STD_LOGIC;
           CD       : out STD_LOGIC;
           CE       : out STD_LOGIC;
           CF       : out STD_LOGIC;
           CG       : out STD_LOGIC;
           DP       : out STD_LOGIC;
           AN1      : out STD_LOGIC;
           AN2      : out STD_LOGIC;
           AN3      : out STD_LOGIC;
           AN4      : out STD_LOGIC;
           LEDFLASH : out STD_LOGIC_VECTOR(15 downto 0)
		 );
end stopwatch_top_level;

architecture Behavioral of stopwatch_top_level is
-- Internal signal names have to go here
signal in_DP, out_DP : STD_LOGIC;
signal an_i : STD_LOGIC_VECTOR(3 downto 0);
signal digit_to_display : STD_LOGIC_VECTOR(3 downto 0);
signal sec_dig1_i, sec_dig2_i, min_dig1_i, min_dig2_i, digit_select_i : STD_LOGIC_VECTOR(3 downto 0);
signal L_sec_dig1_i, L_sec_dig2_i, L_min_dig1_i, L_min_dig2_i: STD_LOGIC_VECTOR(3 downto 0);
signal CA_i, CB_i, CC_i, CD_i, CE_i, CF_i, CG_i: STD_LOGIC;
signal m_sec_dig1_i, m_sec_dig2_i, m_min_dig1_i, m_min_dig2_i: STD_LOGIC_VECTOR(3 downto 0);
signal CD_sec_dig1_i, CD_sec_dig2_i, CD_min_dig1_i, CD_min_dig2_i: STD_LOGIC_VECTOR(3 downto 0);
signal SW_sec_dig1_i, SW_sec_dig2_i, SW_min_dig1_i, SW_min_dig2_i: STD_LOGIC_VECTOR(3 downto 0);
signal OUT_sec_dig1_i, OUT_sec_dig2_i, OUT_min_dig1_i, OUT_min_dig2_i: STD_LOGIC_VECTOR(3 downto 0);
signal CD_START: std_logic;
signal COUNT_DONE_i: std_logic;
signal LED_FLASH_Sig: std_logic_vector(15 downto 0);

-- Declare components here:
component seven_segment_digit_selector is
    PORT ( clk          : in  STD_LOGIC;
           digit_select : out  STD_LOGIC_VECTOR (3 downto 0);
           an_outputs : out  STD_LOGIC_VECTOR (3 downto 0);
           reset        : in  STD_LOGIC
          );
end component;

component clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)     
         );
end component;

component seven_segment_decoder is
    PORT ( CA    : out STD_LOGIC;
           CB    : out STD_LOGIC;
           CC    : out STD_LOGIC;
           CD    : out STD_LOGIC;
           CE    : out STD_LOGIC;
           CF    : out STD_LOGIC;
           CG    : out STD_LOGIC;
           DP    : out STD_LOGIC;
           dp_in : in  STD_LOGIC;
           data  : in  STD_LOGIC_VECTOR (3 downto 0)
         );
end component;

component digit_multiplexor is
  PORT ( 
          sec_dig1   : in  STD_LOGIC_VECTOR(3 downto 0);
          sec_dig2   : in  STD_LOGIC_VECTOR(3 downto 0);
          min_dig1   : in  STD_LOGIC_VECTOR(3 downto 0);
          min_dig2   : in  STD_LOGIC_VECTOR(3 downto 0);
          selector   : in  STD_LOGIC_VECTOR(3 downto 0);
          time_digit : out STD_LOGIC_VECTOR(3 downto 0)
        );
end component;

component sw_lap_multiplexor is
    Port ( sec_dig1      : in STD_LOGIC_VECTOR (3 downto 0);
           sec_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           min_dig1      : in STD_LOGIC_VECTOR (3 downto 0);
           min_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           L_sec_dig1   : in STD_LOGIC_VECTOR (3 downto 0);
           L_sec_dig2   : in STD_LOGIC_VECTOR (3 downto 0);
           L_min_dig1    : in STD_LOGIC_VECTOR (3 downto 0);
           L_min_dig2    : in STD_LOGIC_VECTOR (3 downto 0);
           selector     :in STD_LOGIC;
           m_sec_dig1    : out STD_LOGIC_VECTOR (3 downto 0);
           m_sec_dig2 : out STD_LOGIC_VECTOR (3 downto 0);
           m_min_dig1   : out STD_LOGIC_VECTOR (3 downto 0);
           m_min_dig2 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component lap_register is
    Port ( 
           clk:       in STD_LOGIC;
           reset:     in STD_LOGIC;
           load:      in STD_LOGIC;
           sec_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           sec_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           min_dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           min_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           L_sec_dig1 : out STD_LOGIC_VECTOR (3 downto 0);
           L_sec_dig2 : out STD_LOGIC_VECTOR (3 downto 0);
           L_min_dig1 : out STD_LOGIC_VECTOR (3 downto 0);
           L_min_dig2 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component countdown_timer_top_level is
Port ( 
        clk: in std_logic;
        reset: in std_logic;
        START_CD: in std_logic;
        button_inputs: in std_logic_vector(3 downto 0);
        cd_sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
        cd_sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
        cd_min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
        cd_min_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
        COUNT_DONE  :   out STD_LOGIC
);
end component;

component LED_PARTY is

Port ( 
        clk: in std_logic;
        reset : in std_logic;
        COUNT_DONE: in std_logic;
        LEDFLASH : out STD_LOGIC_VECTOR(15 downto 0)
    );
end component;

-- Students fill in the VHDL code between these two lines
-- The missing code is component declarations, as needed.
-- Hint, follow the pattern above.
--==============================================
component cd_sw_multiplexor is
    Port ( SW_sec_dig1      : in STD_LOGIC_VECTOR (3 downto 0);
           SW_sec_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           SW_min_dig1      : in STD_LOGIC_VECTOR (3 downto 0);
           SW_min_dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           CD_sec_dig1   : in STD_LOGIC_VECTOR (3 downto 0);
           CD_sec_dig2   : in STD_LOGIC_VECTOR (3 downto 0);
           CD_min_dig1    : in STD_LOGIC_VECTOR (3 downto 0);
           CD_min_dig2    : in STD_LOGIC_VECTOR (3 downto 0);
           selector     :in STD_LOGIC;
           out_sec_dig1    : out STD_LOGIC_VECTOR (3 downto 0);
           out_sec_dig2 : out STD_LOGIC_VECTOR (3 downto 0);
           out_min_dig1   : out STD_LOGIC_VECTOR (3 downto 0);
           out_min_dig2 : out STD_LOGIC_VECTOR (3 downto 0));
end component;
--============================================== 

BEGIN

CD_START <= SW_START and CD_Mode;
              
  CLOCK_DIVID:  clock_divider 
      PORT MAP ( 
             clk =>clk,
             reset=>reset,
             enable=>SW_START,
             sec_dig1   => sec_dig1_i,  
             sec_dig2   => sec_dig2_i, 
             min_dig1   => min_dig1_i,  
             min_dig2   => min_dig2_i  
           );
  LAP_MUX: sw_lap_multiplexor
   PORT MAP(
              sec_dig1=>sec_dig1_i,
              sec_dig2=>sec_dig2_i,
              min_dig1=>min_dig1_i,
              min_dig2=>min_dig2_i,
              L_sec_dig1=>L_sec_dig1_i,
              L_sec_dig2=>L_sec_dig2_i,
              L_min_dig1=>L_min_dig1_i,
              L_min_dig2=>L_min_dig2_i,
              selector=>LAP_TIME,
              m_sec_dig1=>m_sec_dig1_i,
              m_sec_dig2=>m_sec_dig2_i,
              m_min_dig1=>m_min_dig1_i,
              m_min_dig2=>m_min_dig2_i
            );  
      DIGIT_MUX : digit_multiplexor
    PORT MAP( 
             sec_dig1   => out_sec_dig1_i,  
             sec_dig2   => out_sec_dig2_i, 
             min_dig1   => out_min_dig1_i,  
             min_dig2   => out_min_dig2_i,  
             selector   => digit_select_i,  
             time_digit => digit_to_display
    
           );
      SELECTOR : seven_segment_digit_selector
   PORT MAP( clk          => clk,
             digit_select => digit_select_i, 
             an_outputs   => an_i,
             reset        => reset
           );
           
   DECODER: seven_segment_decoder
   PORT MAP( 
              CA=>CA_i,
              CB=>CB_i,
              CC=>CC_i,
              CD=>CD_i,
              CE=>CE_i,
              CF=>CF_i,
              CG=>CG_i,
              DP=>out_dp,
              dp_in=>IN_DP,
              data=>digit_to_display
              );
   
            
   LAP_REG: lap_register
   PORT MAP 
   (
      clk=>clk,
      reset=>reset,
      load=>LAP_TIME,
      sec_dig1=>sec_dig1_i,
      sec_dig2=>sec_dig2_i,
      min_dig1=>min_dig1_i,
      min_dig2=>min_dig2_i,
      L_sec_dig1=>L_sec_dig1_i,
      L_sec_dig2=>L_sec_dig2_i,
      L_min_dig1=>L_min_dig1_i,
      L_min_dig2=>L_min_dig2_i
      );     
-- Students fill in the VHDL code between these two lines
-- The missing code is component instantiations, as needed.
-- Hint, follow the pattern above.
--==============================================
COUNTDOWN: countdown_timer_top_level
Port map( 
        clk=>clk,
        reset=>reset,
        START_CD=>CD_START,
        button_inputs=>BUTTONS,
        cd_sec_dig1=>CD_sec_dig1_i,
        cd_sec_dig2=>CD_sec_dig2_i,
        cd_min_dig1=>CD_min_dig1_i,
        cd_min_dig2=>CD_min_dig2_i,
        COUNT_DONE=>COUNT_DONE_i
);
LEDFLASHERS:LED_PARTY
Port MAP ( 
        clk=>clk,
        reset=>reset,
        COUNT_DONE=>COUNT_DONE_i,
        LEDFLASH=>LED_Flash_Sig
    );

COUNT_MUX: cd_sw_multiplexor
    Port Map 
         ( SW_sec_dig1=> m_sec_dig1_i, 
           SW_sec_dig2=> m_sec_dig2_i,
           SW_min_dig1=> m_min_dig1_i,
           SW_min_dig2=> m_min_dig2_i,
           cd_sec_dig1=>CD_sec_dig1_i,
           cd_sec_dig2=>CD_sec_dig2_i,
           cd_min_dig1=>CD_min_dig1_i,
           cd_min_dig2=>CD_min_dig2_i,
           selector=>CD_MODE,
           out_sec_dig1=>out_sec_dig1_i,
           out_sec_dig2=>out_sec_dig2_i,
           out_min_dig1=>out_min_dig1_i,
           out_min_dig2=>out_min_dig2_i
           );

--============================================== 
   
   
   -- Connect internal signals to outputs here:
   DP <= out_dp;
   CA <= CA_i;
   CB <= CB_i;
   CC <= CC_i;
   CD <= CD_i;
   CE <= CE_i;
   CF <= CF_i;
   CG <= CG_i;
   LEDFLASH<=LED_FLASH_Sig;
   
   in_dp <= an_i(2); -- have the decimal point light up in the third digit of the 7-segment display (i.e. minutes digit)
 
   AN1 <= an_i(0); -- seconds digit
   AN2 <= an_i(1); -- tens of seconds digit
   AN3 <= an_i(2); -- minutes digit
   AN4 <= an_i(3); -- tens of minutes digit

END Behavioral;

