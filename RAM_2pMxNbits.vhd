--RAM_2pMxNbits.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RAM is
  generic (
    M : integer := 4; -- Nombre de bits pour l'adresse (2^M mots)
    N : integer := 8  -- Nombre de bits par mot
  );
  port (
    CLK   : in  std_logic;
    CS_n  : in  std_logic;
    RW_n  : in  std_logic;
    OE    : in  std_logic;
    Din   : in  std_logic_vector(N-1 downto 0);
    Adr   : in  std_logic_vector(M-1 downto 0);
    Dout  : out std_logic_vector(N-1 downto 0)
  );
end RAM;

architecture Behavioral of RAM is
  type ram_type is array (0 to 2**M-1) of std_logic_vector(N-1 downto 0);
  signal RAM : ram_type := (others => (others => '0'));
  signal Dout_reg : std_logic_vector(N-1 downto 0);
begin
  process (CLK)
  begin
    if rising_edge(CLK) then
      if CS_n = '0' then
        if RW_n = '0' then
          -- Ecriture
          RAM(to_integer(unsigned(Adr))) <= Din;
        else
          -- Lecture
          Dout_reg <= RAM(to_integer(unsigned(Adr)));
        end if;
      end if;
    end if;
  end process;

  -- Gestion de la sortie
  Dout <= Dout_reg when (CS_n = '0' and RW_n = '1' and OE = '1') else (others => 'Z');
end Behavioral;

