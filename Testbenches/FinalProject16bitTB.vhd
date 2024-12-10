----------------------------------------------------------------------------------
-- Company: Germanna CC EGR 271
-- Engineer: 
-- 
-- Create Date: 12/03/2024 07:33:20 PM
-- Design Name: 
-- Module Name: ddTB
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

entity ddtb is

end ddtb;

architecture behavioral of ddtb is

signal i:  unsigned(15 downto 0);
signal o1:  unsigned(3 downto 0);
signal o2:  unsigned(3 downto 0);
signal o3:  unsigned(3 downto 0);
signal o4:  unsigned(3 downto 0);
signal o5:  unsigned(3 downto 0);
signal isn :  std_logic;

component ToBCD_16bit is
port( i: in unsigned(15 downto 0);
		  o1: out unsigned(3 downto 0);
		  o2: out unsigned(3 downto 0);
		  o3: out unsigned(3 downto 0);
		  o4: out unsigned(3 downto 0);
		  o5: out unsigned(3 downto 0);
		  isn : out std_logic);
end component;

begin
	DUT: ToBCD_16bit
		port map( i => i,
				  o1 => o1,
				  o2 => o2,
				  o3 => o3,
				  o4 => o4,
				  o5 => o5,
				  isn => isn);
				  
	stim_proc: process
	begin
		for j in 0 to 100 loop
		i <= to_unsigned(j + 100, 16);
		wait for 10 ns;
		end loop;
	end process;
end Behavioral;