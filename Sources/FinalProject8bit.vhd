----------------------------------------------------------------------------------
-- Company: Germanna CC EGR 271
-- Engineer: 
-- 
-- Create Date: 12/03/2024 07:33:20 PM
-- Design Name: 
-- Module Name: ToBCD_8bit - Behavioral
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

entity ToBCD_8bit is
	port( i: in unsigned(7 downto 0);
		  o1: out unsigned(3 downto 0);
		  o2: out unsigned(3 downto 0);
		  o3: out unsigned(3 downto 0);
		  isn : out std_logic);
end ToBCD_8bit;

architecture behavioral of ToBCD_8bit is

signal ii0 : unsigned(7 downto 0);


begin
	
	magnitude : process(i)
	
	
	begin
		if i(7) = '1' then
			ii0 <= not(i) + 1;
			isn <= '1';
			report "ii0 (negative case) = " & integer'image(to_integer(ii0));
			
		else
			ii0 <= i;
			isn <= '0';
			report "ii0 (positive case) = " & integer'image(to_integer(ii0));
			
		end if;
	end process;
	
	main : process(ii0)
	
	variable ii1 : integer;
	variable ii2 : integer;
	variable ii3 : integer;
	variable ot1 : integer;
	variable ot2 : integer;
	variable ot3 : integer;
	
	begin
	ii1 := to_integer(ii0);
	report "ii1 = " & integer'image(ii1);
	
	ot3 := ii1/100;
	report "ot3 (hundreds) = " & integer'image(ot3);
	
	ii2 := ii1 mod 100;
	report "ii2 (remaining) = " & integer'image(ii2);
	
	ot2 := ii2/10;
	report "ot2 (tens) = " & integer'image(ot2);
	
	ot1 := ii2 mod 10;
	report "ot1 (ones) = " & integer'image(ot1);
	
	o1 <= to_unsigned(ot1, 4);
	o2 <= to_unsigned(ot2, 4);
	o3 <= to_unsigned(ot3, 4);
	end process;
end behavioral;