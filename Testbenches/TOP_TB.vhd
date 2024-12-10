----------------------------------------------------------------------------------
-- Company: Germanna CC EGR 271
-- Engineer: 
-- 
-- Create Date: 11/19/2024
-- Design Name: Multiplier-Testbench
-- Module Name: 
-- Project Name: Semester Project
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP_tb is
end;

architecture bench of TOP_tb is
  -- Clock period
  constant clk_period : time := 10 ns; -- 100 MHz
  -- Generics
  -- Ports
  signal clk           : std_logic := '0';
  signal reset         : std_logic;
  signal input         : std_logic_vector(7 downto 0);
  signal led           : std_logic_vector(7 downto 0);
  signal a             : std_logic;
  signal b             : std_logic;
  signal c             : std_logic;
  signal d             : std_logic;
  signal e             : std_logic;
  signal f             : std_logic;
  signal g             : std_logic;
  signal display_anode : std_logic_vector(5 downto 0);
begin

  TOP_inst : entity work.TOP
    port map
    (
      clk           => clk,
      reset         => reset,
      input         => input,
      led           => led,
      a             => a,
      b             => b,
      c             => c,
      d             => d,
      e             => e,
      f             => f,
      g             => g,
      display_anode => display_anode
    );
  clk <= not clk after clk_period/2;

  dut_proc : process
  begin
    reset <= '1';
    input <= "00000000";
    wait for 20ns;
    reset <= '0';

    input <= "00000011";
    wait for 500ns;
    input <= "00000001";
    wait for 500ns;

    wait for 1000ns;
  end process;

end;