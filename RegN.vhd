--RegN.vhd

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.CHECK_PKG.all;

entity RegN is
generic(N : natural := 8; t_setup : time := 10 ns; t_hold : time := 5 ns);
  port (
    CLK     : in  std_logic;
    Reset   : in  std_logic;
    Din : in std_logic_vector(N-1 downto 0);
    Q : out std_logic_vector(N-1 downto 0)
  );
end RegN;

architecture RegN_arch of RegN is
    
  begin
    process(CLK, reset)
      begin
        if reset = '1' then Q <= (others => '0');
        else 
          if rising_edge(CLK) then
            Q <= din;
          end if;
        end if;
    end process;
    check_setup(CLK, din, t_setup, warning);
    check_hold(CLK, din, t_hold, warning);
end RegN_arch;