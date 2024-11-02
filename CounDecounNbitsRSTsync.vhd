library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CounDecounNbitsRSTsync is
  generic (
    N : integer := 8  -- nombre de bits du compteur
  );
  port (
    CLK     : in  std_logic;
    reset   : in  std_logic;
    enable  : in  std_logic;
    up_down : in  std_logic; -- '1' pour incrémenter, '0' pour décrémenter
    count   : out std_logic_vector(N-1 downto 0)
  );
end CounDecounNbitsRSTsync;

architecture Behavioral of CounDecounNbitsRSTsync is
  signal count_reg : unsigned(N-1 downto 0) := (others => '0');
begin
  process (CLK, reset)
  begin
    if rising_edge(CLK) then
      if reset = '1' then
        count_reg <= (others => '0');
      elsif enable = '1' then
        if up_down = '1' then
          count_reg <= count_reg + 1;
        else
          count_reg <= count_reg - 1;
        end if;
      end if;
    end if;
  end process;

  count <= std_logic_vector(count_reg);
end Behavioral;

