LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM_tb is
end RAM_tb;

architecture Behavioral of RAM_tb is
  constant M : integer := 4; -- Nombre de bits pour l'adresse
  constant N : integer := 8; -- Nombre de bits par mot

  signal CLK   : std_logic := '0';
  signal CS_n  : std_logic := '1';
  signal RW_n  : std_logic := '1';
  signal OE    : std_logic := '0';
  signal Din   : std_logic_vector(N-1 downto 0) := (others => '0');
  signal Adr   : std_logic_vector(M-1 downto 0) := (others => '0');
  signal Dout  : std_logic_vector(N-1 downto 0);

  -- Instanciation de la RAM
  component RAM
    generic (
      M : integer := 4;
      N : integer := 8
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
  end component;

begin
  uut: RAM
    generic map (
      M => M,
      N => N
    )
    port map (
      CLK   => CLK,
      CS_n  => CS_n,
      RW_n  => RW_n,
      OE    => OE,
      Din   => Din,
      Adr   => Adr,
      Dout  => Dout
    );

  -- Génération de l'horloge
  CLK_process : process
  begin
      CLK <= '0';
      wait for 10 ns;
      CLK <= '1';
      wait for 10 ns;
  end process;

  -- Stimuli de test
  stimulus: process
  begin
    -- Initialisation
    CS_n <= '1';
    RW_n <= '1';
    OE <= '0';
    Din <= (others => '0');
    Adr <= (others => '0');
    wait for 20 ns;

    -- Ecriture dans la RAM
    CS_n <= '0';
    RW_n <= '0';
    Adr <= "0001";
    Din <= "10101010";
    wait for 20 ns;

    -- Lecture de la RAM
    RW_n <= '1';
    OE <= '1';
    wait for 20 ns;

    -- Désactivation de la RAM
    CS_n <= '1';
    wait for 20 ns;

    -- Fin du test
    wait;
  end process;
end Behavioral;
