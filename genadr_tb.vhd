LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE work.mes_composants.all  ; 
ENTITY genadr_tb  IS 
  GENERIC (
    M  : NATURAL   := 8 ); 
END ; 
 
ARCHITECTURE genadr_tb_arch OF genadr_tb IS
  SIGNAL selread   :  STD_LOGIC  ; 
  SIGNAL incwrite   :  STD_LOGIC  ; 
  SIGNAL Adrg   :  std_logic_vector (M - 1 downto 0)  ; 
  SIGNAL incread   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL Reset   :  STD_LOGIC  ; 
  
  COMPONENT genadr  
    GENERIC ( 
      M  : NATURAL := 8);  
    PORT ( 
      selread  : in STD_LOGIC ; 
      incwrite  : in STD_LOGIC ; 
      Adrg  : out std_logic_vector (M - 1 downto 0) ; 
      incread  : in STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      Reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : genadr  
    GENERIC MAP ( 
      M  => M   )
    PORT MAP ( 
      selread   => selread  ,
      incwrite   => incwrite  ,
      Adrg   => Adrg  ,
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
        reset <= '0';
        incread <= '1';
        selread <= '1';
        wait for 60 ns;
        reset <= '1';
        incread <= '0';
        wait for 30 ns;
        reset <= '0';
        wait for 30 ns;
        selread <= '0';
        wait for 20 ns;
        incwrite <= '1';
        wait;
      end process;
END ; 

-- pb coundecoun ou genadr ou son testbench M 4, 8 generic ?