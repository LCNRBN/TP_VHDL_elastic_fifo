-- mes_composants.vhd
library ieee ;
use ieee.std_logic_1164.all ;

package mes_composants is
component CounDecounNbitsRSTsync is
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
end component;

component RAM is
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
end component;

component GENHL is
  port (
    CLK     : in  std_logic;
    RESET   : in  std_logic;
    ENREAD  : out std_logic;
    ENWRITE : out std_logic
  );
end component;

component genadr is
generic(M : natural := 8);
  port (
    CLK     : in  std_logic;
    Reset   : in  std_logic;
    incread  : in std_logic;
    incwrite : in std_logic;
    selread : in std_logic;
    Adrg : out std_logic_vector(M-1 downto 0)
  );
end component;

component fastslow is
generic(M : natural := 8);
  port (
    CLK     : in  std_logic;
    Reset   : in  std_logic;
    incread  : in std_logic;
    incwrite : in std_logic;
    fast : out std_logic;
    slow : out std_logic
  );
end component;

component complement_a_2 is
generic (N : natural := 8);
port (nombre : in std_logic_vector (N-1 downto 0);
      sortie : out std_logic_vector (N-1 downto 0));
end component;

component RegN is
generic(N : natural := 8; t_setup : time := 10 ns; t_hold : time := 5 ns);
  port (
    CLK     : in  std_logic;
    Reset   : in  std_logic;
    Din : in std_logic_vector(N-1 downto 0);
    Q : out std_logic_vector(N-1 downto 0)
  );
end component;

component seq is
port (
    CLK     : in  std_logic;
    Reset   : in  std_logic;
    Enread  : in  std_logic;
    Enwrite : in  std_logic;
    req     : in  std_logic;
    Ack     : out std_logic := '0';
    RW_n    : out std_logic := '1';
    OE      : out std_logic := '0';
    Incwrite: out std_logic := '0';
    Incread : out std_logic := '0';
    HL      : out std_logic := '0';
    Selread : out std_logic := '0';
    CS_n    : out std_logic := '1'
);
end component;

end mes_composants ;

