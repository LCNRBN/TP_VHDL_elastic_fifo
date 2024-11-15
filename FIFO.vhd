--FIFO.vhd
library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.CHECK_PKG.all;
use work.mes_composants.all;

entity FIFO is
  generic(N : natural := 8);
  port (
    CLK     : in  std_logic;
    Reset   : in  std_logic;
    req     : in  std_logic;
    Din     : in  std_logic_vector(N-1 downto 0);
    Ack     : out std_logic;
    Data_out: out std_logic_vector(N-1 downto 0);
    HL      : out std_logic;
    fast    : out std_logic;
    slow    : out std_logic 
  );
end FIFO;

architecture FIFO_arch of FIFO is
  signal reg_out           : std_logic_vector(N-1 downto 0);
  signal complement_out    : std_logic_vector(N-1 downto 0);
  signal genhl_enread_out  : std_logic;
  signal genhl_enwrite_out : std_logic;
  signal seq_rw_n_out      : std_logic;
  signal seq_oe_out        : std_logic;
  signal seq_incwrite_out  : std_logic;
  signal seq_incread_out   : std_logic;
  signal seq_selread_out   : std_logic;
  signal seq_cs_n_out      : std_logic;
  signal ram_out           : std_logic_vector(N-1 downto 0);
  signal genadr_adr_out    : std_logic_vector(N-1 downto 0);
  
begin
  
  BLOCK1 : RegN
  port map(CLK  => CLK, Reset => Reset, Din => Din, Q => reg_out); -- entr�es de FIFO sur entr�e de RegN
    
  BLOCK2 : complement_a_2
  port map(nombre => reg_out, sortie => complement_out); -- sortie de regN sur entr�es de Complement_a_2
    
  BLOCK3 : RAM
  port map(
    CLK   => CLK,
    CS_n  => seq_cs_n_out,
    RW_n  => seq_rw_n_out,
    OE    => seq_oe_out,
    Din   => complement_out,
    Adr   => genadr_adr_out,
    Dout  => ram_out
  );
  
  BLOCK4 : GENHL 
  port map(CLK => CLK, RESET => Reset, ENREAD => genhl_enread_out, ENWRITE => genhl_enwrite_out); -- entr�es de FIFO sur entr�es de GENHL
    
  BLOCK5 : seq
  port map (
    CLK      => CLK,
    Reset    => Reset,
    Enread   => genhl_enread_out,      -- ENREAD sortie GENHL vers Enread seq 
    Enwrite  => genhl_enwrite_out,     -- ENWRITE sortie GENHL vers Enwrite seq 
    req      => req,                   -- req entr�e FIFO vers req entr�e seq
    Ack      => Ack,
    RW_n     => seq_rw_n_out,
    OE       => seq_oe_out,
    Incwrite => seq_incwrite_out,
    Incread  => seq_incread_out,
    HL       => HL,
    Selread  => seq_selread_out,
    CS_n     => seq_cs_n_out
  );
    
  BLOCK6 : genadr
  port map(
    CLK      => CLK,
    Reset    => Reset,
    incread  => seq_incread_out,
    incwrite => seq_incwrite_out,
    selread  => seq_selread_out,
    Adrg     => genadr_adr_out
  );
    
  BLOCK7 : fastslow
  port map(
    CLK      => CLK,
    Reset    => Reset,
    incread  => seq_incread_out,
    incwrite => seq_incwrite_out,
    fast     => fast,
    slow     => slow
  );
     
end FIFO_arch;