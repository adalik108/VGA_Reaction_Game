----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2018 01:38:28 PM
-- Design Name: 
-- Module Name: PRNG_Delay - Behavioral
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

entity PRNG_Delay is
    generic( RandomWidth:integer:= 16);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           outreset: in STD_LOGIC;
           enable: in STD_LOGIC;
           prngdelay : out STD_LOGIC);
end PRNG_Delay;



architecture Behavioral of PRNG_Delay is
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
signal fourhertz : std_logic;
signal PRNGNumber: std_logic_vector(RandomWidth-1 downto 0);
signal intermediate: std_logic;
begin

   fourHzClock: upcounter
   generic map(
               --period=> 12, -- FOR TEST
               period => (100000000),   -- divide by 100_000_000 to divide 100 MHz down to 4 Hz 
               --WIDTH=> 4-- FOR TEST
               WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable,
               zero   => fourhertz, -- this is a 1 Hz clock signal
               value  => open  -- Leave open since we won't display this value
            );

    LSFR: process(reset,clk,fourhertz,intermediate,PRNGNUMBER,outreset)
    begin
        if(reset='1') then
            PRNGNumber<=(10=>'1',7=>'1',3=>'1',2=>'1',others=>'0');
            intermediate<='0';
            prngdelay<='0';
        elsif (outreset='1') then   -- BROKEN FIX WITH TODO
            prngdelay<='0';
            PRNGNUMBER(RandomWidth-1)<='0';
            PRNGNUMBER(8)<='1';
        elsif (rising_edge(clk)) then
            if(enable='1') then
                if(fourhertz='1') then
                   intermediate<= (PRNGNUMBER(5)xor(PRNGNumber(3) xor(PRNGNumber(2) xor PRNGNumber(0))));
                   PRNGNUMBER<=intermediate & PRNGNUMBER(RandomWidth-1 downto 1);
                end if;
                prngdelay<= PRNGNUMBER(RandomWidth-1);
            else
                prngdelay<= '0';
            end if;
        end if;
    end process;
    

end Behavioral;
