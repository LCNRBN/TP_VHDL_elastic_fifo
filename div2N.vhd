library ieee;
use ieee.std_logic_1164.all;

entity div2N is
  generic (
    N : integer := 4  -- Nombre de diviseurs par 2 en cascade
  );
  port(
    CLK, reset : in std_logic;
    CLK_OUT : out std_logic
  );
end div2N;

architecture Behavioral of div2N is
  component div2
    port(
      CLK, reset : in std_logic;
      CLK_OUT : out std_logic
    );
  end component;

  signal clk_signals : std_logic_vector(N downto 0);
begin
  clk_signals(0) <= CLK;

  gen_dividers: for i in 0 to N-1 generate
    div2_inst: div2
      port map (
        CLK => clk_signals(i),
        reset => reset,
        CLK_OUT => clk_signals(i+1)
      );
  end generate;

  CLK_OUT <= clk_signals(N);
end Behavioral;

