--div2.vhd
library ieee;
use ieee.std_logic_1164.all;

entity div2 is
  port(
    CLK, reset : in std_logic;
    CLK_OUT : out std_logic
  );
end div2;

architecture div2 of div2 is
  signal temp : std_logic := '0';
begin
  process(CLK, reset)
  begin
    if reset = '1' then
      temp <= '0';
      CLK_OUT <= '0';
    elsif rising_edge(CLK) then
      temp <= not temp;
      CLK_OUT <= temp;
    end if;
  end process;
end div2;


      
      

