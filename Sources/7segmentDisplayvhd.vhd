----------------------------------------------------------------------------------
-- Company: Germanna CC EGR 271
-- Engineer: 
-- 
-- Create Date: 12/03/2024 07:33:20 PM
-- Design Name: 
-- Module Name: display - Behavioral
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity display is
  port (
    i : in unsigned(3 downto 0);
    a : out std_logic;
    b : out std_logic;
    c : out std_logic;
    d : out std_logic;
    e : out std_logic;
    f : out std_logic;
    g : out std_logic);
end display;

architecture behavioral of display is
  --set outputs to HIGH
begin
  process (i)
  begin
    if i = "1111" then --if 15 then display a nothing
      a <= '0';
      b <= '0';
      c <= '0';
      d <= '0';
      e <= '0';
      f <= '0';
      g <= '0';
    elsif i = "1010" then --if 11 then display a dash
      a <= '0';
      b <= '0';
      c <= '0';
      d <= '0';
      e <= '0';
      f <= '0';
      g <= '1';
    else
      a <= i(3) or i(1) or (i(2) and i(0)) or (not(i(2)) and not(i(0)));
      b <= i(3) or not(i(2)) or (not(i(1)) and not(i(0))) or (i(1) and i(0));
      c <= i(3) or i(2) or not(i(1)) or i(0);
      d <= i(3) or (i(1) and not(i(0))) or (not(i(2)) and i(1)) or (i(2) and not(i(1)) and i(0)) or (not(i(2)) and not(i(1)) and not(i(0)));
      e <= (i(1) and not(i(0))) or (not(i(2)) and not(i(0)));
      f <= (i(3)) or ((not(i(1)) and not(i(0))) or (i(2) and not(i(0))) or (i(2) and not(i(1)) and i(0)));
      g <= (i(3)) or (i(2) xor i(1)) or (i(1) and not(i(0)));
    end if;
  end process;
end behavioral;