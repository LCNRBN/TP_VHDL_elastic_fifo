LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 

ENTITY coundecounnbitsrstsync_tb  IS 
  GENERIC (
    N  : INTEGER   := 8 ); 
END ; 
 
ARCHITECTURE coundecounnbitsrstsync_tb_arch OF coundecounnbitsrstsync_tb IS
  SIGNAL up_down   :  STD_LOGIC  ; 
  SIGNAL count   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL enable   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  
  COMPONENT CounDecounNbitsRSTsync  
    GENERIC ( 
      N  : INTEGER  );  
    PORT ( 
      up_down  : in STD_LOGIC ; 
      count  : out std_logic_vector (N - 1 downto 0) ; 
      CLK  : in STD_LOGIC ; 
      enable  : in STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 

BEGIN
  DUT  : CounDecounNbitsRSTsync  
    GENERIC MAP ( 
      N  => N   )
    PORT MAP ( 
      up_down   => up_down  ,
      count   => count  ,
      CLK   => CLK  ,
      enable   => enable  ,
      reset   => reset   ) ; 

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
    wait for 20 ns;

    -- Incrémentation
    enable <= '1';
    up_down <= '1';
    wait for 100 ns;

    -- Décrémentation
    up_down <= '0';
    wait for 100 ns;

    -- Désactivation
    enable <= '0';
    wait for 50 ns;

    -- Reset
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 20 ns;

    -- Fin du test
    wait;
  end process;
  
END coundecounnbitsrstsync_tb_arch; 