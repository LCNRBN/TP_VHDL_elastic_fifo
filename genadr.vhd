--genadr.vhd

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.mes_composants.all;

entity genadr is
generic(M : natural := 8);
  port (
    CLK     : in  std_logic;
    Reset   : in  std_logic;
    incread  : in std_logic;
    incwrite : in std_logic;
    selread : in std_logic;
    Adrg : out std_logic_vector(M-1 downto 0)
  );
end genadr;

architecture genadr_arch of genadr is
  signal count1 : std_logic_vector(M-1 downto 0);
  signal count2 : std_logic_vector(M-1 downto 0);
  
  begin
  U1 : CounDecounNbitsRSTsync 
  port map(
  CLK  => CLK, 
  reset => reset, 
  enable => incread, 
  up_down => '1', 
  count => count1
 
  ); 
 
  U2 : CounDecounNbitsRSTsync 
  port map(
  CLK  => CLK, 
  reset => reset, 
  enable => incwrite, 
  up_down => '1', 
  count => count2
 
  );
 
  Adrg <= count1 when selread = '1' else count2; --mux 
end genadr_arch;