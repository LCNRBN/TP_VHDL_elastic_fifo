LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE work.mes_composants.all  ; 
ENTITY fastslow_tb  IS 
  GENERIC (
    M  : NATURAL   := 8 ); 
END ; 
 
ARCHITECTURE fastslow_tb_arch OF fastslow_tb IS
  SIGNAL slow   :  STD_LOGIC  ; 
  SIGNAL incwrite   :  STD_LOGIC  ; 
  SIGNAL fast   :  STD_LOGIC  ; 
  SIGNAL incread   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL Reset   :  STD_LOGIC  ; 
  COMPONENT fastslow  
    GENERIC ( 
      M  : NATURAL  );  
    PORT ( 
      slow  : out STD_LOGIC ; 
      incwrite  : in STD_LOGIC ; 
      fast  : out STD_LOGIC ; 
      incread  : in STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      Reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : fastslow  
    GENERIC MAP ( 
      M  => M   )
    PORT MAP ( 
      slow   => slow  ,
      incwrite   => incwrite  ,
      fast   => fast  ,
      incread   => incread  ,
      CLK   => CLK  ,
      Reset   => Reset   ) ;
      
      clk_process : process
      begin
        CLK <= '0';
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
      end process;
      
      reset_process : process
      begin
        incread <= '0';
        incwrite <= '1';
        wait for 260 ns;
        incwrite <= '0';
        incread <= '1';
        wait;
      end process;
      
END ; 

