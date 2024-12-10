----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2024 07:50:14 PM
-- Design Name: 
-- Module Name: Multiplier_TB - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier_tb is
end;

architecture bench of Multiplier_tb is
  -- Clock period
 -- constant clk_period : time := 5 ns;
  -- Generics
  -- Ports
  signal multiplicand_in : std_logic_vector (7 downto 0);
  signal multiplier_in : std_logic_vector (7 downto 0);
  signal Output : std_logic_vector (15 downto 0);
begin

  Multiplier_inst : entity work.Multiplier
  port map (
    multiplicand_in => multiplicand_in,
    multiplier_in => multiplier_in,
    Output => Output
  );
-- clk <= not clk after clk_period/2;

DUT : process
    begin
    wait for 10 ns;
    multiplicand_in <= "11101111";
    multiplier_in <= "00000010";
    wait for 10 ns;
    end process DUT;

end;