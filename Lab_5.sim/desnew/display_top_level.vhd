----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2018 12:35:26 PM
-- Design Name: 
-- Module Name: display_top_level - Behavioral
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

entity display_top_level is
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
end display_top_level;

architecture Behavioral of display_top_level is

component digit_multiplexor is
    Port ( dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           dig3 : in STD_LOGIC_VECTOR (3 downto 0);
           dig4 : in STD_LOGIC_VECTOR (3 downto 0);
           selector : in STD_LOGIC_VECTOR (3 downto 0);
           out_digit : out STD_LOGIC_VECTOR (3 downto 0));
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

component seven_segment_digit_selector is
    PORT ( clk          : in  STD_LOGIC;
           digit_select : out STD_LOGIC_VECTOR (3 downto 0);
           an_outputs   : out STD_LOGIC_VECTOR (3 downto 0);
           reset        : in  STD_LOGIC
		 );
end component;
signal dp_in_i: std_logic;
signal AN_i: std_logic_vector(3 downto 0);
signal out_digit_i,digit_select_i: std_logic_vector(3 downto 0);

begin

AN<= AN_i;

DIGITMUX: digit_multiplexor
    Port Map ( dig1,dig2,dig3,dig4,digit_select_i,out_digit_i);

DECODER: seven_segment_decoder
Port Map(segC(0),segC(1),segC(2),segC(3),segC(4),segC(5),segC(6),DP,AN_i(3),out_digit_i);

SELECTOR: seven_segment_digit_selector
Port Map(clk,digit_select_i,AN_i,reset);



end Behavioral;
