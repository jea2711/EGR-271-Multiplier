----------------------------------------------------------------------------------
-- Company: Germanna CC EGR 271
-- Engineer: 
-- 
-- Create Date: 12/03/2024 07:33:20 PM
-- Design Name: 
-- Module Name: ToBCD_16bit - Behavioral
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

entity ToBCD_16bit is
	port( i: in unsigned(15 downto 0);
		  o1: out unsigned(3 downto 0);
		  o2: out unsigned(3 downto 0);
		  o3: out unsigned(3 downto 0);
		  o4: out unsigned(3 downto 0);
		  o5: out unsigned(3 downto 0);
		  isn : out std_logic);
end ToBCD_16bit;

architecture behavioral of ToBCD_16bit is

signal ii0 : unsigned(15 downto 0);


begin
	
	magnitude : process(i)
	
	
	begin
		if i(15) = '1' then
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
	variable ii4 : integer;
	variable ot1 : integer;
	variable ot2 : integer;
	variable ot3 : integer;
	variable ot4 : integer;
	variable ot5 : integer;
	
	begin
		ii1 := to_integer(ii0);
		report "ii1 = " & integer'image(ii1);
		
		ot5 := ii1 / 10000;
		report "ot5 = " & integer'image(ot5);
		
		ii2 := ii1 mod 10000;
		report "ii2 = " & integer'image(ii2);
		
		ot4 := ii2 / 1000;
		report "ot4 = " & integer'image(ot4);
		
		ii3 := ii2 mod 1000;
		report "ii3 = " & integer'image(ii3);
		
		ot3 := ii3 / 100;
		report "ot3 = " & integer'image(ot3);
		
		ii4 := ii3 mod 100;
		report "ii4 = " & integer'image(ii4);
		
		ot2 := ii4 / 10 ;
		report "ot2 = " & integer'image(ot2);
		
		ot1 := ii4 mod 10;
		report "ot1 = " & integer'image(ot1);
		
		o1 <= to_unsigned(ot1 , 4);
		o2 <= to_unsigned(ot2 , 4);
		o3 <= to_unsigned(ot3 , 4);
		o4 <= to_unsigned(ot4 , 4);
		o5 <= to_unsigned(ot5 , 4);
	end process;
end behavioral;
		