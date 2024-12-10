----------------------------------------------------------------------------------
-- Company: Germanna CC EGR 271
-- Engineer: 
-- 
-- Create Date: 12/03/2024 07:33:20 PM
-- Design Name: 
-- Module Name: buhtb
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

entity buhtb is

end buhtb;

architecture behavioral of buhtb is

signal i:  unsigned(7 downto 0);
signal o1:  unsigned(3 downto 0);
signal o2:  unsigned(3 downto 0);
signal o3:  unsigned(3 downto 0);
signal isn :  std_logic;

component ToBCD_8bit is
port( i: in unsigned(7 downto 0);
		  o1: out unsigned(3 downto 0);
		  o2: out unsigned(3 downto 0);
		  o3: out unsigned(3 downto 0);
		  isn : out std_logic);
end component;

begin
	DUT: ToBCD_8bit
		port map( i => i,
				  o1 => o1,
				  o2 => o2,
				  o3 => o3,
				  isn => isn);
				  
	stim_proc: process
	begin
		i <= "11001010";
		wait for 10 ns;
		wait;
	end process;
end Behavioral;