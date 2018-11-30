----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2018 01:35:22 PM
-- Design Name: 
-- Module Name: main_logic - Behavioral
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

entity main_logic is
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
end main_logic;

architecture Behavioral of main_logic is

component upcounter is
   Generic ( period : integer:= 4;
             WIDTH  : integer:= 3
           );
      PORT (  clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              enable : in  STD_LOGIC;
              zero   : out STD_LOGIC;
              value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end component;

component Debouncer is
    Port ( Input : in STD_LOGIC;
           clk:    in STD_LOGIC;
           reset:  in STD_LOGIC;
           Input_DB : out STD_LOGIC);
end component;

component PRNG_Delay is
    generic( RandomWidth:integer:= 16);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           outreset: in STD_LOGIC;
           enable: in STD_LOGIC;
           prngdelay : out STD_LOGIC);
end component;

signal sec: std_logic;
signal halfsec: std_logic;

signal button_1_win: std_logic;
signal button_2_win: std_logic;
signal button_3_win: std_logic;
signal button_4_win: std_logic;

signal button_1_enable: std_logic;
signal button_2_enable: std_logic;
signal button_3_enable: std_logic;
signal button_4_enable: std_logic;


signal button_1_reset: std_logic;
signal button_2_reset: std_logic;
signal button_3_reset: std_logic;
signal button_4_reset: std_logic;

signal button_1_score_i: std_logic_vector(3 downto 0);
signal button_2_score_i: std_logic_vector(3 downto 0);
signal button_3_score_i: std_logic_vector(3 downto 0);
signal button_4_score_i: std_logic_vector(3 downto 0);

signal reset_scores: std_logic;

signal waitenable:std_logic;

signal prng_reset,prng_enable,prng_delayed_enable: std_logic;
--125000000
constant halfrounddelay: integer:= 125000000;

TYPE STATE_TYPE is (Initial_State, Random_Wait,Game_Start,Round_Win,Time_Disp,Average_Disp,Winner_Mode);
signal FSM_STATE: STATE_TYPE;
signal nextFSM_STATE: STATE_TYPE;


begin


Clock: upcounter
generic map(
       period => halfrounddelay,   -- divide by 25000000 to divide 100 MHz down to 1 Hz 
       WIDTH  =>   28           -- 28 bits are required to hold the binary value of 101111101011110000100000000
      )
PORT MAP (
       clk    => clk,
       reset  => reset,
       enable => waitenable,
       zero   => sec, -- this is a 1 Hz clock signal
       value  => open  -- Leave open since we won't display this value
    );

button1counter: upcounter
generic map(
       period => (9),   -- divide by 100_000 to divide 100 MHz down to 1 Hz 
       WIDTH  => 4             -- 28 bits are required to hold the binary value of 101111101011110000100000000
      )
PORT MAP (
       clk    => clk,
       reset  => button_1_reset,
       enable => button_1_enable,
       zero   => open, -- this is a 1 Hz clock signal
       value  => button_1_score_i
    );
    
button2counter: upcounter
generic map(
       period => (9),   -- divide by 100_000 to divide 100 MHz down to 1 Hz 
       WIDTH  => 4             -- 28 bits are required to hold the binary value of 101111101011110000100000000
      )
PORT MAP (
       clk    => clk,
       reset  => button_2_reset,
       enable => button_2_enable,
       zero   => open, -- this is a 1 Hz clock signal
       value  => button_2_score_i
    ); 
    
button3counter: upcounter
    generic map(
           period => (9),   -- divide by 100_000 to divide 100 MHz down to 1 Hz 
           WIDTH  => 4             -- 28 bits are required to hold the binary value of 101111101011110000100000000
          )
    PORT MAP (
           clk    => clk,
           reset  => button_3_reset,
           enable => button_3_enable,
           zero   => open, -- this is a 1 Hz clock signal
           value  => button_3_score_i
        );  
button4counter: upcounter
        generic map(
               period => (9),   -- divide by 100_000 to divide 100 MHz down to 1 Hz 
               WIDTH  => 4             -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
        PORT MAP (
               clk    => clk,
               reset  => button_4_reset,
               enable => button_4_enable,
               zero   => open, -- this is a 1 Hz clock signal
               value  => button_4_score_i
            );  
     

button_1_reset<= reset or reset_scores;
button_2_reset<= reset or reset_scores;
button_3_reset<= reset or reset_scores;
button_4_reset<= reset or reset_scores;

Delayer: PRNG_DELAY port map (clk,reset,prng_reset,prng_enable,prng_delayed_enable);

FSM_Combinational: process(FSM_STATE,nextFSM_STATE,button_1,button_2,button_3,button_4,enable,modecntrl,sec,prng_delayed_enable,button_1_win,button_2_win,button_3_win,button_4_win)
begin
    case FSM_STATE IS
        when Initial_State=>
             display_cntrl<="01";        -- 1 on display_cntrl is menu
             menu_enable<='1';
             prng_enable<='0';
             prng_reset<='0';
             button_1_enable<='0';
             button_2_enable<='0';
             button_3_enable<='0';
             button_4_enable<='0';
             reset_scores<='0';
             if((enable and sec)='1') then
                nextFSM_STATE<=Random_Wait;
                waitenable<='0';
             else
                nextFSM_STATE<=Initial_State;
                waitenable<='1';
             end if;
        when Random_Wait=>
            prng_reset<='1';
            prng_enable<='0';
            menu_enable<='1';
            waitenable<='0';
            display_cntrl<="01";
            button_1_enable<='0';
            button_2_enable<='0';
            button_3_enable<='0';
            button_4_enable<='0';
            reset_scores<='0';
            nextFSM_STATE<=Game_Start;
        when Game_Start=>
            prng_reset<='0';
            prng_enable<='1' and enable;
            menu_enable<='0';
            waitenable<='0';
            display_cntrl<="00";
            reset_scores<='0';
            if(((button_1 or button_2 or button_3 or button_4)and not prng_delayed_enable)='1') then
                button_1_enable<='0';
                button_2_enable<='0';
                button_3_enable<='0';
                button_4_enable<='0';
                nextFSM_STATE<=Random_Wait;
            elsif((button_1 and prng_delayed_enable )='1') then
                button_1_enable<='1';
                button_2_enable<='0';
                button_3_enable<='0';
                button_4_enable<='0';
                nextFSM_STATE<=Time_Disp;
            elsif((button_2 and prng_delayed_enable)='1') then
                button_1_enable<='0';
                button_2_enable<='1';
                button_3_enable<='0';
                button_4_enable<='0';
                nextFSM_STATE<=Time_Disp;
            elsif((button_3 and prng_delayed_enable)='1') then
                button_1_enable<='0';
                button_2_enable<='0';
                button_3_enable<='1';
                button_4_enable<='0';
                nextFSM_STATE<=Time_Disp;
            elsif((button_4 and prng_delayed_enable)='1') then
                button_1_enable<='0';
                button_2_enable<='0';
                button_3_enable<='0';
                button_4_enable<='1';
                nextFSM_STATE<=Time_Disp;
            else
                nextFSM_STATE<=Game_Start;
                button_1_enable<='0';
                button_2_enable<='0';
                button_3_enable<='0';
                button_4_enable<='0';
            end if;
        when Time_Disp =>
            display_cntrl<="00";        -- 1 on display_cntrl is menu
            menu_enable<='0';
            prng_enable<='0';
            prng_reset<='0';
            button_1_enable<='0';
            button_2_enable<='0';
            button_3_enable<='0';
            button_4_enable<='0';
            reset_scores<='0';
            if(sec='1') then
                waitenable<='0';
                nextFSM_STATE<=Round_Win;
            else
                waitenable<='1';
                nextFSM_STATE<=Time_Disp;
            end if;
        when Round_Win=>
            display_cntrl<="01";        -- 1 on display_cntrl is menu
            menu_enable<='1';
            prng_enable<='0';
            prng_reset<='0';
            button_1_enable<='0';
            button_2_enable<='0';
            button_3_enable<='0';
            button_4_enable<='0';
            reset_scores<='0';
            if((button_1_win or button_2_win or button_3_win or button_4_win)='1') then
                waitenable<='0';
                nextFSM_STATE<=Average_Disp;
            elsif(sec='1') then
                waitenable<='0';
                nextFSM_STATE<=Random_Wait;
            else
                waitenable<='1';
                nextFSM_STATE<=Round_Win;
            end if;
        when Average_Disp=>
            prng_reset<='0';
            prng_enable<='0';
            menu_enable<='0';
            display_cntrl<="10";
            button_1_enable<='0';
            button_2_enable<='0';
            button_3_enable<='0';
            button_4_enable<='0';
            reset_scores<='0';
            if(sec='1') then
                waitenable<='0';
                nextFSM_STATE<=Winner_Mode;
            else  
                waitenable<='1';  
                nextFSM_STATE<=Average_Disp;
            end if;
        when Winner_Mode=>   
            prng_reset<='0';
            prng_enable<='0';
            menu_enable<='1';
            display_cntrl<="01";
            button_1_enable<='0';
            button_2_enable<='0';
            button_3_enable<='0';
            button_4_enable<='0';
            if(sec='1') then
                reset_scores<='1';
                waitenable<='0';
                nextFSM_STATE<=Initial_State;
            else  
                reset_scores<='0';
                waitenable<='1';  
                nextFSM_STATE<=Winner_Mode;
            end if;
    end case;
end process;

FSM_Seq: process(clk,reset,enable)
begin
if reset = '1' then
   FSM_STATE <= Initial_State;
elsif rising_edge(clk) then
    if(enable='1') then
        FSM_STATE <= nextFSM_STATE;
    end if;
end if;
end process;

ScoreWinner:process(button_1_score_i,button_2_score_i,button_3_score_i,button_4_score_i)
begin
    if(button_1_score_i="1000") then
        button_1_win <= '1';
    else
        button_1_win <= '0';
    end if;
    if(button_2_score_i="1000") then
        button_2_win <= '1';
    else
        button_2_win <= '0';
    end if;
    if(button_3_score_i="1000") then
        button_3_win <= '1';
    else
        button_3_win <= '0';
    end if;
    if(button_4_score_i="1000") then
        button_4_win <= '1';
    else
        button_4_win <= '0';
    end if;
end process;

-- Connecting internal signals to outputss
round_winner<=button_4_enable & button_3_enable & button_2_enable & button_1_enable;
winner_select<= button_4_win & button_3_win & button_2_win & button_1_win;
reset_scores_out<=reset_scores;
button_1_score<=button_1_score_i;
button_2_score<=button_2_score_i;
button_3_score<=button_3_score_i;
button_4_score<=button_4_score_i;
delayed_enable<=prng_delayed_enable;
end Behavioral;
