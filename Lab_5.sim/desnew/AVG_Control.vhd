----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2018 03:03:55 PM
-- Design Name: 
-- Module Name: AVG_Control - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AVG_Control is
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
end AVG_Control;

architecture Behavioral of AVG_Control is
-- Signals:
signal hundredhertz : STD_LOGIC;
signal thousandhertz, singlemsec: STD_LOGIC;
signal averagevalue1: STD_LOGIC_VECTOR(10 downto 0);
signal averagevalue2: STD_LOGIC_VECTOR(10 downto 0);
signal averagevalue3: STD_LOGIC_VECTOR(10 downto 0);
signal averagevalue4: STD_LOGIC_VECTOR(10 downto 0);
signal sumvalue1: STD_LOGIC_VECTOR(13 downto 0);
signal sumvalue2: STD_LOGIC_VECTOR(13 downto 0);
signal sumvalue3: STD_LOGIC_VECTOR(13 downto 0);
signal sumvalue4: STD_LOGIC_VECTOR(13 downto 0);
--signal multvalue1: STD_LOGIC_VECTOR(15 downto 0);
--signal multvalue2: STD_LOGIC_VECTOR(15 downto 0);
--signal multvalue3: STD_LOGIC_VECTOR(15 downto 0);
--signal multvalue4: STD_LOGIC_VECTOR(15 downto 0);
signal bcdaverageinput: std_logic_vector(10 downto 0);
signal done: std_logic; -- doing nothign with it atm
signal bcdaverageoutput: std_logic_Vector(15 downto 0);
signal bcd_enable: std_logic;
signal winner_select_q:std_logic_vector(3 downto 0);
-- Components declarations

 component Binary_to_BCD is
              Generic(
                      WIDTH: integer:= 14;
                      digits: integer:=4
                      );
              Port ( clk : in STD_LOGIC;
                     reset : in STD_LOGIC;
                     enable : in STD_LOGIC;
                     binary_in : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
                     done : out STD_LOGIC;
                     bcd_out : out STD_LOGIC_VECTOR (digits*4-1 downto 0));
          end component;

--score<=("0000" & button_1_score)+("0000" & button_2_score)+("0000" & button_3_score)+("0000" & button_4_score);
begin

BCDConversion: Binary_to_BCD Generic Map(11,4) Port Map(clk,reset,bcd_enable,bcdaverageinput,done,bcdaverageoutput);



averagecalc: process(clk,reset,enable,round_winner,binary_time)
begin
if(reset='1') then
    sumvalue1<=(others=>'0');
    sumvalue2<=(others=>'0');
    sumvalue3<=(others=>'0');
    sumvalue4<=(others=>'0');
--    multvalue1<=(others=>'0');
--    multvalue2<=(others=>'0');
--    multvalue3<=(others=>'0');
--    multvalue4<=(others=>'0');
    averagevalue1<=(others=>'0');
    averagevalue2<=(others=>'0');
    averagevalue3<=(others=>'0');
    averagevalue4<=(others=>'0');
elsif(rising_edge(clk)) then
    if(enable='1') then
            case round_winner IS
                when "0001" =>  -- Player 1
                    sumvalue1<=binary_time+sumvalue1;
                when "0010" =>  -- Player 2
                    sumvalue2<=binary_time+sumvalue2;
                when "0100" =>  -- Player 3
                    sumvalue3<=binary_time+sumvalue3;
                when "1000" =>  -- Player 4
                    sumvalue4<=binary_time+sumvalue4;
                when others =>  -- Multiplying by 3 then shifting by 5 so 3/32
                    --multvalue1<=sumvalue1*"11";
                    averagevalue1<=sumvalue1(13 downto 3);
                    --multvalue2<=sumvalue2*"11";
                    averagevalue2<=sumvalue2(13 downto 3);
                    --multvalue3<=sumvalue3*"11";
                    averagevalue3<=sumvalue3(13 downto 3);
                    --multvalue4<=sumvalue4*"11";
                    averagevalue4<=sumvalue4(13 downto 3);
            end case;
    end if;    
end if;
end process;
 
winnerdisp:process(clk,reset,enable,winner_select)
begin
if(reset='1') then
    bcdaverageinput<=(others=>'0');
    bcd_enable<='0';
    winner_select_q<=(others=>'0');
elsif(rising_edge(clk)) then
    if(enable='1') then
    winner_select_q<=winner_select;
    case winner_select_q IS
        when "0001" =>  -- Player 1
            bcd_enable<=winner_select_q(0);
            bcdaverageinput<=averagevalue1;
        when "0010" =>  -- Player 2
            bcd_enable<=winner_select_q(1);
            bcdaverageinput<=averagevalue2;
        when "0100" =>  -- Player 3
            bcd_enable<=winner_select_q(2);
            bcdaverageinput<=averagevalue3;
        when "1000" =>  -- Player 4
            bcd_enable<=winner_select_q(3);
            bcdaverageinput<=averagevalue4;
        when others => 
            bcdaverageinput<=(others=>'0');
            bcd_enable<='0';
    end case;    
    end if;
end if;
end process;
 

-- Students fill in the VHDL code between these two lines
-- The missing code is instantiations of upcounter (like above) as needed.
-- Take a hint from the clock_divider entity description's port map.
--==============================================

--============================================== 
 
 -- Connect internal signals to outputs
 
-- Students fill in the VHDL code between these two lines
-- The missing code is internal signal conections to outputs as needed, following the pattern of the previous statement.
-- Take a hint from the signal declarartions below architecture.
--==============================================
dig1<=bcdaverageoutput(3 downto 0);
dig2<=bcdaverageoutput(7 downto 4);
dig3<=bcdaverageoutput(11 downto 8);
dig4<=bcdaverageoutput(15 downto 12);
--============================================== 
 

end Behavioral;
