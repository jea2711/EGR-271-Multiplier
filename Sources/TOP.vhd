----------------------------------------------------------------------------------
-- Company: Germanna CC EGR 271
-- Engineer: 
-- 
-- Create Date: 11/19/2024
-- Design Name: Multiplier
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

entity TOP is
  port (
    clk                 : in std_logic;
    reset               : in std_logic;
    input               : in std_logic_vector(7 downto 0);
    led                 : out std_logic_vector(7 downto 0);
    a, b, c, d, e, f, g, dp : out std_logic;
    display_anode       : out std_logic_vector(7 downto 0) --8 bits to drive 6 CA displays 5 magnitudes and 1 sign bit.
  );
end TOP;

architecture Behavioral of TOP is
  signal multiplicand                                    : std_logic_vector (7 downto 0);
  signal multiplier                                      : std_logic_vector (7 downto 0);
  signal multiplier_out                                  : std_logic_vector (15 downto 0);
  signal bcd8                                            : unsigned(12 downto 0) := (others => '0');
  signal bcd16                                           : unsigned(20 downto 0) := (others => '0');
  signal current_display8                                : std_logic_vector(7 downto 0);
  signal current_display16                               : std_logic_vector(15 downto 0);
  signal digit                                           : unsigned (3 downto 0);
  signal state                                           : integer range 0 to 2         := 0;
  signal counter                                         : integer range 0 to 499999999 := 0;
  signal display_select                                  : integer range 0 to 5         := 0;
  signal display_counter                                 : integer range 0 to 499       := 0;
  signal seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g : std_logic;

begin

  -- Instantiate the 7-segment display driver
  display_driver : entity work.display
    port map
    (
      i => digit,
      a => seg_a,
      b => seg_b,
      c => seg_c,
      d => seg_d,
      e => seg_e,
      f => seg_f,
      g => seg_g
    );
  -- Instantiate the multiplier component
  multiplier_inst : entity work.Multiplier
    port map
    (
      multiplicand_in => multiplicand,
      multiplier_in   => multiplier,
      Output          => multiplier_out
    );
  -- Instantiate the 8-bit BCD converter
  comp_bcd_8bit : entity work.ToBCD_8bit(behavioral)
    port map
    (
      i   => unsigned(current_display8),
      o1  => bcd8(3 downto 0),
      o2  => bcd8(7 downto 4),
      o3  => bcd8(11 downto 8),
      isn => bcd8(12)
    );
  -- Instantiate the 16-bit BCD converter
  comp_bcd_16bit : entity work.ToBCD_16bit(behavioral)
    port map
    (
      i   => unsigned(current_display16),
      o1  => bcd16(3 downto 0),
      o2  => bcd16(7 downto 4),
      o3  => bcd16(11 downto 8),
      o4  => bcd16(15 downto 12),
      o5  => bcd16(19 downto 16),
      isn => bcd16(20)
    );

  --Finite State Machine for Time Division Multiplexing
  FSM : process (clk, reset)
  begin
    if reset = '1' then
      state        <= 0;
      counter      <= 0;
      multiplicand <= (others => '0');
      multiplier   <= (others => '0');
      led          <= (others => '0');
      current_display8  <= (others => '0');
      current_display16 <= (others => '0');
    elsif rising_edge(clk) then
      if counter = 499999999 then -- counts to 500,000,000 which is 100E6 * 5; 49 for simulation
        counter <= 0;
        case state is
          when 0 => --state 0 input multiplicand
            multiplicand <= input;
            led          <= input; -- pass input to LEDs
            current_display8 <= multiplicand;
            state        <= 1;
          when 1 => --state 1 input multiplier
            multiplier <= input;
            led        <= input; -- pass input to LEDs
            current_display8 <= multiplier;
            state      <= 2;
          when 2 => --state 2 display output
            current_display16 <= multiplier_out;
            state <= 0;
        end case;
      else
        counter <= counter + 1; --increment counter; wait 5s
      end if;
    end if;
  end process;

  -- scanning display controller

  display_controller : process (display_select, bcd8, bcd16)
  begin
    if reset = '1' then
    display_counter <= 0;
    digit <= (others => '0');
    display_anode <= "11111110";
    display_select    <= 0;
    elsif rising_edge(clk)then
      if display_counter = 499 then
        display_counter <= 0;
        if (state = 0) or (state = 1) then
              case display_select is
                when 0 =>
                  if bcd8(12) = '1' then -- sign bit
                    digit <= "1010";
                  else
                    digit <= "1111";
                  end if;
                  display_anode <= "11011111";
                  display_select <= 1;
                when 1 =>
                  digit         <= bcd8(3 downto 0); -- ones
                  display_anode <= "11111110";
                  display_select <= 2;
                when 2 =>
                  digit         <= bcd8(7 downto 4); --tens
                  display_anode <= "11111101";
                  display_select <= 3;
                when 3 =>
                  digit         <= bcd8(11 downto 8); --hundreds
                  display_anode <= "11111011";
                  display_select <= 4;
                when 4 =>
                  digit         <= "0000"; --thousands
                  display_anode <= "11110111";
                  display_select <= 5;
                when 5 =>
                  digit         <= "0000"; --ten thousands
                  display_anode <= "11101111";
                  display_select <= 0;
                when others =>
                  digit         <= "1111"; -- turn off display
                  display_anode <= "11111111";
              end case;
            elsif state = 2 then
              case display_select is
                when 0 =>
                  if bcd16(20) = '1' then -- sign bit
                    digit <= "1010";
                  else
                    digit <= "1111";
                  end if;
                  display_anode <= "11011111";
                  display_select <= 1;
                when 1 =>
                  digit         <= bcd16(3 downto 0); -- ones
                  display_anode <= "11111110";
                  display_select <= 2;
                when 2 =>
                  digit         <= bcd16(7 downto 4); --tens
                  display_anode <= "11111101";
                  display_select <= 3;
                when 3 =>
                  digit         <= bcd16(11 downto 8); --hundreds
                  display_anode <= "11111011";
                  display_select <=4;
                when 4 =>
                  digit         <= bcd16(15 downto 12); --thousands
                  display_anode <= "11110111";
                  display_select <= 5; 
                when 5 =>
                  digit         <= bcd16(19 downto 16); --ten thousands
                  display_anode <= "11101111";
                  display_select <= 0;
                when others =>
                  digit         <= "1111"; -- turn off display
                  display_anode <= "11111111";
              end case;
            else
              digit         <= "1111"; -- turn off display
              display_anode <= "11111111";
            end if;
      else 
        display_counter <= display_counter + 1;
      end if;
    end if;
  end process;

  --outputs 
  a <= not seg_a;
  b <= not seg_b;
  c <= not seg_c;
  d <= not seg_d;
  e <= not seg_e;
  f <= not seg_f;
  g <= not seg_g;
  dp <= '1';

end Behavioral;
