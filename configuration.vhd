--configuration.vhd
library ieee ;
use ieee.std_logic_1164.all ;

configuration test_seq of seq_tb is
  for seq_tb_arch
    for DUT : seq use entity
      --work.seq(archi_Mealy);
      work.seq(archi_Moore);
    end for;
  end for;
end test_seq;