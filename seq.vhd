library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.CHECK_PKG.all;

entity seq is
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
end seq;

architecture archi_Mealy of seq is
  type state_type is (IDLE, READ1, READ2, WRITE, WAITING);
  signal etat_present, etat_futur : state_type;
  
begin
  process(etat_present, enread, enwrite, req) --logique de transition d'�tat et de sortie
    begin -- les sorties d�pendent des entr�es et de l'�tat pr�sent
      case etat_present is 
        when IDLE =>
          if enread = '1' then 
            etat_futur <= READ1;
            RW_n <= '1'; OE <= '1'; Incread <= '1'; HL <= '1'; Selread <= '1';
          elsif enwrite = '1' and req = '0' then
            etat_futur <= WRITE;
            Ack <= '1'; Incwrite <= '1';
          else
            etat_futur <= IDLE;
            Ack <= '1'; RW_n <= '1'; CS_n <= '1';
          end if;
        when READ1 =>
          etat_futur <= IDLE;
          Ack <= '1'; RW_n <= '1'; CS_n <= '1';
        when WRITE =>
          etat_futur <= WAITING;
          Ack <= '1'; RW_n <= '1'; CS_n <= '1';
        when WAITING =>
          if enread = '0' then
            if req = '1' then
              etat_futur <= IDLE;
              Ack <= '1'; RW_n <= '1'; CS_n <= '1';
            elsif req = '0' then
              etat_futur <= WAITING;
              Ack <= '1'; RW_n <= '1'; CS_n <= '1';
            end if;
          elsif enread = '1' then 
            etat_futur <= READ2;
            Ack <= '1'; OE <= '1'; Incread <= '1'; HL <= '1'; Selread <= '1';
          end if;
        when READ2 =>
          etat_futur <= WAITING; 
          RW_n <= '1'; CS_n <= '1';
      end case;
  end process;
  
  process(CLK, Reset) --process de transition d'�tat
    begin
      if Reset = '1' then
        etat_present <= IDLE;
      elsif rising_edge(CLK) then
        etat_present <= etat_futur;
      end if;
  end process;
  
end archi_Mealy;






architecture archi_Moore of seq is
  type state_type is (IDLE, READ1, READ2, WRITE, WAITING);
  signal etat_present, etat_futur : state_type;
  
begin
  process(etat_present, enread, enwrite, req) -- m�me logique de transition d'�tats
    begin
      case etat_present is 
        when IDLE =>
          if enread = '1' then 
            etat_futur <= READ1;
          elsif enwrite = '1' and req = '0' then
            etat_futur <= WRITE;
          else
            etat_futur <= IDLE;
          end if;
        when READ1 =>
          etat_futur <= IDLE;
        when WRITE =>
          etat_futur <= WAITING;
        when WAITING =>
          if enread = '0' then
            if req = '1' then
              etat_futur <= IDLE;
            elsif req = '0' then
              etat_futur <= WAITING;
            end if;
          elsif enread = '1' then 
              etat_futur <= READ2;
          end if;
        when READ2 =>
          etat_futur <= WAITING;
      end case;
      
  end process;
      -- sorties affect�es en dehors du process et d�pendent que de l'�tat pr�sent
      Ack <= '1' when
        etat_present = IDLE or etat_present = WRITE or etat_present = WAITING else '0';
      RW_n <= '1' when
        etat_present = IDLE or etat_present = WAITING or etat_present = READ1 or etat_present = READ2 else '0';
      OE <= '1' when
        etat_present = READ1 or etat_present = READ2 else '0';
      Incwrite <= '1' when
        etat_present = WRITE else '0';
      Incread <= '1' when
        etat_present = READ1 or etat_present = READ2 else '0';
      HL <= '1' when
        etat_present = READ1 or etat_present = READ2 else '0';
      Selread <= '1' when
        etat_present = READ1 or etat_present = READ2 else '0';
      CS_n <= '1' when
        etat_present = IDLE or etat_present = WAITING else '0';
            
  process(CLK, Reset)
    begin
      if Reset = '1' then
        etat_present <= IDLE;
      elsif rising_edge(CLK) then
        etat_present <= etat_futur;
      end if;
  end process;
  
end archi_Moore;
