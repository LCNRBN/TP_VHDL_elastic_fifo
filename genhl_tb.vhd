LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE work.mes_composants.all  ; 
ENTITY genhl_tb  IS 
END ; 
 
ARCHITECTURE genhl_tb_arch OF genhl_tb IS
  SIGNAL ENWRITE   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL ENREAD   :  STD_LOGIC  ; 
  SIGNAL RESET   :  STD_LOGIC  ; 
  COMPONENT GENHL  
    PORT ( 
      ENWRITE  : out STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      ENREAD  : out STD_LOGIC ; 
      RESET  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : GENHL  
    PORT MAP ( 
      ENWRITE   => ENWRITE  ,
      CLK   => CLK  ,
      ENREAD   => ENREAD  ,
      RESET   => RESET   ) ; 
      
    clk_process : process
      begin
        CLK <= '0';
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
      end process;
    
    reset_process : process
      begin
        RESET <= '0';
        wait for 5000 ns;
        RESET <= '1';
        wait for 100 ns;
        RESET <= '0';
        wait;
    end process;
END ; 

