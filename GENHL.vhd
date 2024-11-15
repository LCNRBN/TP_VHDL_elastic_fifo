--GENHL.vhd

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.mes_composants.all;

entity GENHL is
  port (
    CLK     : in  std_logic;
    RESET   : in  std_logic;
    ENREAD  : out std_logic;
    ENWRITE : out std_logic
  );
end GENHL;

architecture GENHL_arch of GENHL is
  signal count : std_logic_vector(7 downto 0);
  signal local_reset : std_logic;
  
  begin
  U1 : CounDecounNbitsRSTsync 
  port map(
  CLK  => CLK, 
  reset => local_reset, 
  enable => '1', 
  up_down => '1', 
  count => count
 ); 
 --up_down and enable set to 1 by default


process(CLK, RESET)
  begin
    if rising_edge(CLK) then
      if RESET = '1' then
        ENREAD <= '0';
        ENWRITE <= '1';
        local_reset <= '1';
      else
        if count = "11000111" then
          ENREAD <= '1';
          ENWRITE <= '0';
          local_reset <= '1';
        else
          ENREAD <= '0';
          ENWRITE <= '1';
          local_reset <= '0';
        end if;
      end if;
    end if;
  end process;
end GENHL_arch;