LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_stopwatch_top_level IS
END tb_stopwatch_top_level;
 
ARCHITECTURE behavior OF tb_stopwatch_top_level IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT stopwatch_top_level
    PORT(
          clk      : IN  STD_LOGIC;
          reset    : IN  STD_LOGIC;
          SW_START : IN  STD_LOGIC;
          LAP_TIME : IN  STD_LOGIC;
          CA       : OUT STD_LOGIC;
          CB       : OUT STD_LOGIC;
          CC       : OUT STD_LOGIC;
          CD       : OUT STD_LOGIC;
          CE       : OUT STD_LOGIC;
          CF       : OUT STD_LOGIC;
          CG       : OUT STD_LOGIC;
          DP       : OUT STD_LOGIC;
          AN1      : OUT STD_LOGIC;
          AN2      : OUT STD_LOGIC;
          AN3      : OUT STD_LOGIC;
          AN4      : OUT STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i   : STD_LOGIC := '0';
   signal reset_i : STD_LOGIC := '0';
   signal LAP_TIME_i: STD_LOGIC := '0';

    --Outputs
   signal CA_i  : STD_LOGIC;
   signal CB_i  : STD_LOGIC;
   signal CC_i  : STD_LOGIC;
   signal CD_i  : STD_LOGIC;
   signal CE_i  : STD_LOGIC;
   signal CF_i  : STD_LOGIC;
   signal CG_i  : STD_LOGIC;
   signal DP_i  : STD_LOGIC;
   signal AN1_i : STD_LOGIC;
   signal AN2_i : STD_LOGIC;
   signal AN3_i : STD_LOGIC;
   signal AN4_i : STD_LOGIC;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: stopwatch_top_level 
   PORT MAP (
              clk      => clk_i,
              reset    => reset_i,
              SW_START => '1',
              LAP_TIME => LAP_Time_i,
              CA       => CA_i,
              CB       => CB_i,
              CC       => CC_i,
              CD       => CD_i,
              CE       => CE_i,
              CF       => CF_i,
              CG       => CG_i,
              DP       => DP_i,
              AN1      => AN1_i,
              AN2      => AN2_i,
              AN3      => AN3_i,
              AN4      => AN4_i
            );

   -- Clock process definitions
   clk_process :process
   begin
      clk_i <= '0';
      wait for clk_period/2;
      clk_i <= '1';
      wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin      
      -- hold reset state for 100 ns.
      reset_i <= '1';
      wait for 100 ns;   
      reset_i <= '0';
      -- insert stimulus here 

      wait;
   end process;
   
  lap_process: process
  begin
    wait for 10000 ns;
    lap_time_i<='1';
    wait for 10000 ns;
    lap_time_i<='0';    
  end process;

END;
