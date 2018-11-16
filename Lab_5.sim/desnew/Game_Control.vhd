----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2018 01:14:53 PM
-- Design Name: 
-- Module Name: Game_Control - Behavioral
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

entity Game_Control is
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
end Game_Control;

architecture Behavioral of Game_Control is

component clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           msec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           msec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           msec_dig3 : out STD_LOGIC_VECTOR(3 downto 0);
           msec_dig4 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end component;

component BCD_to_Binary is
    Port ( 
       clk: in STD_Logic;
       reset: in std_logic;
       dig1 : in STD_LOGIC_VECTOR (3 downto 0);
       dig2 : in STD_LOGIC_VECTOR (3 downto 0);
       dig3 : in STD_LOGIC_VECTOR (3 downto 0);
       dig4 : in STD_LOGIC_VECTOR (3 downto 0);
       binary : out STD_LOGIC_VECTOR (13 downto 0));
end component;

TYPE RISEDGESTATE is (A,B);

signal enable_state:RISEDGESTATE;
signal enable_nextstate:RISEDGESTATE;
signal resetonstart: std_logic;
signal clockdividereset: std_logic;

signal dig1_i,dig2_i,dig3_i,dig4_i:std_logic_vector(3 downto 0);

begin
clockdividereset<= resetonstart or reset;

CLK_DIVIDE: clock_divider Port Map(clk,clockdividereset,enable,dig1_i,dig2_i,dig3_i,dig4_i);
BCDBINARY: BCD_to_Binary Port Map(clk,reset,dig1_i,dig2_i,dig3_i,dig4_i,binary_time);


enable_risingedge: process(clk,reset,enable)
begin
    if(reset ='1') then
        enable_state<=A;
        resetonstart<='0';
    elsif (rising_edge(clk)) then
        case enable_state is
            when A=>
                if(enable='1') then
                    resetonstart<='1';
                    enable_nextstate<=B;
                else
                    enable_nextstate<=A;
                    resetonstart<='0';
                end if;
            when B=> 
                if(enable='0') then
                    enable_nextstate<=A;
                else
                    resetonstart<='0';
                    enable_nextstate<=B;
                end if;
        end case;
        enable_state<=enable_nextstate;
    end if;
end process;

dig1<=dig1_i;
dig2<=dig2_i;
dig3<=dig3_i;
dig4<=dig4_i;

ledflash<=enable;

end Behavioral;
