
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_clock_divider IS
END tb_clock_divider;
 
ARCHITECTURE behavior OF tb_clock_divider IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_divider
    PORT(
         clk      : IN  STD_LOGIC;
         reset    : IN  STD_LOGIC;
         enable   : in  STD_LOGIC;
         msec_dig1 : OUT STD_LOGIC_VECTOR(3 downto 0);
         msec_dig2 : OUT STD_LOGIC_VECTOR(3 downto 0);
         msec_dig3 : OUT STD_LOGIC_VECTOR(3 downto 0);
         msec_dig4 : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk    : STD_LOGIC := '0';
   signal reset  : STD_LOGIC := '0';
   signal enable : STD_LOGIC := '0';

    --Outputs
   signal msec_dig1 : STD_LOGIC_VECTOR(3 downto 0);
   signal msec_dig2 : STD_LOGIC_VECTOR(3 downto 0);
   signal msec_dig3 : STD_LOGIC_VECTOR(3 downto 0);
   signal msec_dig4 : STD_LOGIC_VECTOR(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: clock_divider 
   PORT MAP (
              clk      => clk,
              reset    => reset,
              enable   => enable,
              msec_dig1 => msec_dig1,
              msec_dig2 => msec_dig2,
              msec_dig3 => msec_dig3,
              msec_dig4 => msec_dig4
            );

   -- Clock process definitions
   clk_process :process
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin      
      -- hold reset state for 100 ns.
      reset <= '1';
      wait for 100 ns;   
      reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 
      enable <= '0';
      wait for clk_period*10;
      enable <= '1';
      wait for clk_period*10;
      enable <= '0';
      wait for clk_period*10;
      enable <= '1';
      wait;
   end process;

END;
