----------------------------------------------------------------------------------
-- Company: Germanna CC EGR 271
-- Engineer: 
-- 
-- Create Date: 12/03/2024 07:33:20 PM
-- Design Name: 
-- Module Name: displayTB
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
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity displayTB is

end displayTB;

architecture behavioral of displayTB is 
	signal i: unsigned(3 downto 0);
	signal a: std_logic;
	signal b: std_logic;
	signal c: std_logic;
	signal d: std_logic;
	signal e: std_logic;
	signal f: std_logic;
	signal g: std_logic;
	
	component display is
		port( i: in unsigned(3 downto 0);
		  a: out std_logic;
		  b: out std_logic;
		  c: out std_logic;
		  d: out std_logic;
		  e: out std_logic;
		  f: out std_logic;
		  g: out std_logic);
	end component;
begin
	DUT: display
		port map( i => i,
				  a => a,
				  b => b,
				  c => c,
				  d => d,
				  e => e,
				  f => f,
				  g => g);
	
	stim_proc: process
		begin
		--i <= "1010";
		--wait for 10ns;
		--i <= "1011";
		--wait for 10ns; 
        for j in 0 to 15 loop
		i <= to_unsigned(j, 4);
		wait for 10 ns;
		end loop;
	end process;
end behavioral;