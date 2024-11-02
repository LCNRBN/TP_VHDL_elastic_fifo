library ieee;
use ieee.std_logic_1164.all;

entity div2N_tb is
end div2N_tb;

architecture Behavioral of div2N_tb is
  constant N : integer := 4; -- Nombre de diviseurs par 2 en cascade

  signal CLK     : std_logic := '0';
  signal reset   : std_logic := '0';
  signal CLK_OUT : std_logic;

  -- Instanciation du diviseur de fréquence par 2^N
  component div2N
    generic (
      N : integer := 4
    );
    port (
      CLK     : in  std_logic;
      reset   : in  std_logic;
      CLK_OUT : out std_logic
    );
  end component;

begin
  uut: div2N
    generic map (
      N => N
    )
    port map (
      CLK     => CLK,
      reset   => reset,
      CLK_OUT => CLK_OUT
    );

  -- Génération de l'horloge
  CLK_process : process
  begin
    while true loop
      CLK <= '0';
      wait for 10 ns;
      CLK <= '1';
      wait for 10 ns;
    end loop;
  end process;

  -- Stimuli de test
  stimulus: process
  begin
    -- Initialisation
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 200 ns;

    -- Fin du test
    wait;
  end process;
end Behavioral;
