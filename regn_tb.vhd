LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE work.CHECK_PKG.all  ; 

ENTITY regn_tb  IS 
  GENERIC (
    t_setup  : TIME   := 10 ns ;  
    t_hold  : TIME   := 5 ns ;  
    N  : NATURAL   := 8 ); 
END ; 
 
ARCHITECTURE regn_tb_arch OF regn_tb IS
  SIGNAL Q   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL Din   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL Reset   :  STD_LOGIC  ; 
  COMPONENT RegN  
    GENERIC ( 
      t_setup  : TIME ; 
      t_hold  : TIME ; 
      N  : NATURAL  );  
    PORT ( 
      Q  : out std_logic_vector (N - 1 downto 0) ; 
      CLK  : in STD_LOGIC ; 
      Din  : in std_logic_vector (N - 1 downto 0) ; 
      Reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : RegN  
    GENERIC MAP ( 
      t_setup  => t_setup  ,
      t_hold  => t_hold  ,
      N  => N   )
    PORT MAP ( 
      Q   => Q  ,
      CLK   => CLK  ,
      Din   => Din  ,
      Reset   => Reset   ) ; 
      
    clk_process : process
      begin
        CLK <= '1';
        wait for 20 ns;
        CLK <= '0';
        wait for 20 ns;
    end process;
    
    stimulus_process : process
      begin
        Reset <= '0';
        wait for 10 ns;
        Din <= "00000001";
        wait for 27 ns;
        Din <= "10000000";
        wait;
    end process;    
END ; 

