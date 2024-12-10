----------------------------------------------------------------------------------
-- Company: Germanna CC EGR 271
-- Engineer: 
-- 
-- Create Date: 12/03/2024 07:33:20 PM
-- Design Name: 
-- Module Name: Multiplier - Behavioral
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplier is
  port (
    multiplicand_in : in std_logic_vector (7 downto 0);
    multiplier_in   : in std_logic_vector (7 downto 0);
    Output          : out std_logic_vector (15 downto 0));
end Multiplier;

architecture Behavioral of Multiplier is
  signal multiplicand : std_logic_vector (15 downto 0);
  signal multiplier   : std_logic_vector (15 downto 0);

begin
  sign_extend : process(multiplier_in, multiplicand_in)
  begin
    if multiplicand_in(7) = '1' then
      multiplicand <= "11111111" & multiplicand_in(7 downto 0);
    else
      multiplicand <= "00000000" & multiplicand_in(7 downto 0);
    end if;

    if multiplier_in(7) = '1' then
      multiplier <= "11111111" & multiplier_in(7 downto 0);
    else
      multiplier <= "00000000" & multiplier_in(7 downto 0);
    end if;

  end process;

  multiply : process(multiplicand, multiplier)
    variable temp : std_logic_vector (15 downto 0);
    variable i    : integer;
  begin
    temp := (others => '0');
    for i in 0 to 7 loop
      if multiplier(i) = '1' then
        temp := std_logic_vector(unsigned(temp) + (unsigned(multiplicand) sll i));
      end if;
    end loop;
    Output <= temp;
  end process;

end Behavioral;
