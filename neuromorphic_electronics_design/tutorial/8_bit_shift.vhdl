-- we're studying this just to compare
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_bit_shift is
end entity;

architecture sum of eight_bit_shift is
  signal data: STD_LOGIC_VECTOR(7 downto 0) := "10011001";

  signal bits : std_logic_vector(7 downto 0) := "10011001"; -- how we declare bits? 
  signal unright_data : signed(7 downto 0) := "10011001";

  signal shift_right_data: signed(7 downto 0);

begin process is
  begin
  report "oi oi";
  wait;
  end process;
end architecture;
