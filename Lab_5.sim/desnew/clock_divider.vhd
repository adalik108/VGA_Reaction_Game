-- This file needs editing by students

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           msec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           msec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           msec_dig3 : out STD_LOGIC_VECTOR(3 downto 0);
           msec_dig4 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end clock_divider;

architecture Behavioral of clock_divider is
-- Signals:
signal hundredhertz : STD_LOGIC;
signal thousandhertz, tensmsec, hundredmsec, singlemsec : STD_LOGIC;
signal singlemSeconds, tensmSeconds: STD_LOGIC_VECTOR(3 downto 0);
signal hundredmSeconds, thousandmSeconds : STD_LOGIC_VECTOR(3 downto 0);

-- Components declarations
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

BEGIN
   
   oneHzClock: upcounter
   generic map(
               period => (100000),   -- divide by 100_000 to divide 100 MHz down to 1 Hz 
               WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable,
               zero   => thousandhertz, -- this is a 1 Hz clock signal
               value  => open  -- Leave open since we won't display this value
            );
   
   singleSecondsClock: upcounter
   generic map(
               period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => thousandhertz,
               zero   => singlemsec,
               value  => singlemSeconds -- binary value of seconds we decode to drive the 7-segment display        
            );
     tenSecondsClock: upcounter
    generic map(
                period => (10),   -- Counts numbers between 0 and 5 -> that's 6 values!
                WIDTH  => 4
               )
    PORT MAP (
                clk    => clk,
                reset  => reset,
                enable => singlemsec,
                zero   => tensmsec,
                value  => tensmSeconds -- binary value of seconds we decode to drive the 7-segment display        
             );
      SingleMinutesClock: upcounter
    generic map(
                period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
                WIDTH  => 4
               )
    PORT MAP (
                clk    => clk,
                reset  => reset,
                enable => tensmsec,
                zero   => hundredmsec,
                value  => hundredmSeconds -- binary value of seconds we decode to drive the 7-segment display        
             );
       tenMinutesClock: upcounter
       generic map(
                   period => (10),   -- Counts numbers between 0 and 5 -> that's 6 values!
                   WIDTH  => 4
                  )
       PORT MAP (
                   clk    => clk,
                   reset  => reset,
                   enable => hundredmsec,
                   zero   => open,
                   value  => thousandmseconds  -- binary value of seconds we decode to drive the 7-segment display        
                );
   
-- Students fill in the VHDL code between these two lines
-- The missing code is instantiations of upcounter (like above) as needed.
-- Take a hint from the clock_divider entity description's port map.
--==============================================

--============================================== 
   
   -- Connect internal signals to outputs
   msec_dig1 <= singlemSeconds;
   msec_dig2 <=tensmSeconds;
   msec_dig3 <= hundredmSeconds;
   msec_dig4 <= thousandmseconds ;
   
-- Students fill in the VHDL code between these two lines
-- The missing code is internal signal conections to outputs as needed, following the pattern of the previous statement.
-- Take a hint from the signal declarartions below architecture.
--==============================================

--============================================== 
   
END Behavioral;