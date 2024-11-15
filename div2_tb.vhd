LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
ENTITY div2_tb  IS 
END ; 
 
ARCHITECTURE div2_tb_arch OF div2_tb IS
  SIGNAL CLK_OUT   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  COMPONENT div2  
    PORT ( 
      CLK_OUT  : out STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : div2  
    PORT MAP ( 
      CLK_OUT   => CLK_OUT  ,
      CLK   => CLK  ,
      reset   => reset   ) ; 
      
      process
        begin
          CLK<='0'; wait for 20 ns;
          CLK<='1'; wait for 20 ns;
      End process;
      
      process
        begin
          reset<='0'; wait for 200 ns;
          --reset<='1'; wait for 20 ns;
          Wait;
      End process;
      
END div2_tb_arch; 

