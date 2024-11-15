--fastslow.vhd

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.mes_composants.all;

entity fastslow is
generic(M : natural := 8);
  port (
    CLK     : in  std_logic;
    Reset   : in  std_logic;
    incread  : in std_logic;
    incwrite : in std_logic;
    fast : out std_logic;
    slow : out std_logic
  );
end fastslow;

architecture fastslow_arch of fastslow is
  signal count : std_logic_vector(M-1 downto 0);
  signal EN : std_logic;

  begin
  U1 : CounDecounNbitsRSTsync 
  port map(
  CLK  => CLK, 
  reset => reset, 
  enable => EN, 
  up_down => incwrite, 
  count => count
); 
 
 EN <= incread xor incwrite;
 fast <= not(count(3) or count(2)); --fast = 1 if count is between 0000 and 0011 (0  and  3)
 slow <= count(3) and count(2); --slow = 1 if count is between 1100 and 1111 (12 and 16)
end fastslow_arch;