----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 15:59:03
-- Design Name: 
-- Module Name: Binary_to_BCD - Behavioral
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

entity Binary_to_BCD is
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
end Binary_to_BCD;

architecture Behavioral of Binary_to_BCD is
TYPE STATE_MACHINE is (hold, shift);
signal current_state: STATE_MACHINE;
signal next_state: STATE_MACHINE;
signal current_binary: std_logic_vector(WIDTH-1 downto 0);
signal current_CI: std_logic_vector(digits downto 0);   -- Ignoring overall carryout - It's simply current_CI(4)
signal current_bcd:std_logic_vector(digits*4-1 downto 0);
signal shift_enable:std_logic;
constant max_count : STD_LOGIC_VECTOR(4-1 downto 0) := STD_LOGIC_VECTOR(to_unsigned(Width, 4));
signal current_count : STD_LOGIC_VECTOR(4-1 downto 0);
signal enable_Q: std_logic;

component Binary_to_BCD_dig is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           CI : in STD_LOGIC;
           CO : out STD_LOGIC;
           bcd_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

begin


FSM_Seq: process(clk,reset,enable)
begin
if reset = '1' then
   enable_Q <= '0';
elsif rising_edge(clk) then
   enable_Q <= enable;
end if;
end process;

FSM: process(reset,clk,current_state,enable,binary_in,current_count,next_state)
begin
    if(reset='1') then
        current_count<=(others=>'0');
        done<='0';
        shift_enable<='0';
        --current_CI(0)<='0';
        current_binary<=(others=>'0');
        current_state<= hold;
    elsif (rising_edge(clk)) then
        case current_state is 
            when hold=>
            current_count<=(others=>'0');
                if(enable and not enable_Q)='1' then
                    done<='0';
                    shift_enable<='1';  -- Has to be turned one 1 clock cycle earlier, handling on rising edge.
                    current_binary<=binary_in;
                    current_state<=shift;
                    current_CI(0)<='0';
                else
                    done<='0';
                    shift_enable<='0';
                    current_state<=hold;
                    current_binary<=(others=>'0');
                    current_CI(0)<='0';
                end if;
            when shift=>
                if(current_count=max_count) then
                    current_count<=(others=>'0');
                    shift_enable<='0';
                    current_CI(0)<='0';
                    current_binary<=(others=>'0');
                    done<='1';
                    current_state<=hold;
                else
                    current_count<=current_count + 1;
                    shift_enable<='1';
                    current_CI(0)<=current_binary(width-1);
                    current_binary<=current_binary(width-2 downto 0) & '0';
                    done<='0';
                    current_state<=shift;
                end if;
        end case;
    end if;
end process;

digits_mapping:for i in 1 to digits generate
    digit_bcd: Binary_to_BCD_dig port map(clk,reset,shift_enable,current_CI(i-1),current_CI(i),current_bcd(4*i -1 downto 4*(i-1)));
end generate;

bcd_out<=current_bcd;

end Behavioral;
