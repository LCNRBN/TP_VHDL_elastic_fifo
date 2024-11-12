LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE work.CHECK_PKG.all  ; 

ENTITY seq_tb  IS 
END ; 
 
ARCHITECTURE seq_tb_arch OF seq_tb IS
  -- Initialisés de sorte à ce que IDLE soit l'état de départ voir tableau
  SIGNAL req   :  STD_LOGIC  ; 
  SIGNAL Selread   :  STD_LOGIC := '0'  ; 
  SIGNAL CS_n   :  STD_LOGIC := '1'  ; 
  SIGNAL Reset   :  STD_LOGIC  ; 
  SIGNAL HL   :  STD_LOGIC := '0'  ; 
  SIGNAL Incwrite   :  STD_LOGIC := '0'  ; 
  SIGNAL Ack   :  STD_LOGIC := '0'  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL OE   :  STD_LOGIC := '0'  ; 
  SIGNAL Enwrite   :  STD_LOGIC  ; 
  SIGNAL RW_n   :  STD_LOGIC := '1'  ; 
  SIGNAL Incread   :  STD_LOGIC := '0'  ; 
  SIGNAL Enread   :  STD_LOGIC  ; 
  COMPONENT seq  
    PORT ( 
      req  : in STD_LOGIC ; 
      Selread  : out STD_LOGIC ; 
      CS_n  : out STD_LOGIC ; 
      Reset  : in STD_LOGIC ; 
      HL  : out STD_LOGIC ; 
      Incwrite  : out STD_LOGIC ; 
      Ack  : out STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      OE  : out STD_LOGIC ; 
      Enwrite  : in STD_LOGIC ; 
      RW_n  : out STD_LOGIC ; 
      Incread  : out STD_LOGIC ; 
      Enread  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : seq  
    PORT MAP ( 
      req   => req  ,
      Selread   => Selread  ,
      CS_n   => CS_n  ,
      Reset   => Reset  ,
      HL   => HL  ,
      Incwrite   => Incwrite  ,
      Ack   => Ack  ,
      CLK   => CLK  ,
      OE   => OE  ,
      Enwrite   => Enwrite  ,
      RW_n   => RW_n  ,
      Incread   => Incread  ,
      Enread   => Enread   ) ; 
      
  clk_process : process
  begin
    CLK <= '1';
    wait for 20 ns;
    CLK <= '0';
    wait for 20 ns;
  end process;

  stim_proc : process
  begin

    Reset <= '1';
    wait for 40 ns;
    Reset <= '0';
    wait for 40 ns;

    -- Tester état READ1
    Enread <= '1';
    Enwrite <= '0';
    req <= '0';
    wait for 80 ns;

    -- Tester état WRITE (transition vers WAITING instantanée)
    Enread <= '0';
    Enwrite <= '1';
    wait for 80 ns;

    -- Tester état READ2
    Enread <= '1';
    Enwrite <= '0';
    wait for 80 ns;
    
    Enread <= '0';
    wait for 120 ns;

    -- Tester transition retour vers IDLE
    Enread <= '0';
    Enwrite <= '0';
    req <= '1';
    wait for 80 ns;

    Reset <= '1';
    wait for 40 ns;
    Reset <= '0';
    wait for 80 ns;

    -- Tester état READ1 encore
    Enread <= '1';
    Enwrite <= '0';
    req <= '1';
    wait for 80 ns;

    wait;
  end process;

END ARCHITECTURE seq_tb_arch; 

