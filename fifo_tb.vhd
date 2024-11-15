LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE work.CHECK_PKG.all  ; 
USE work.mes_composants.all  ; 
ENTITY fifo_tb  IS 
  GENERIC (
    N  : NATURAL   := 8 ); 
END ; 
 
ARCHITECTURE fifo_tb_arch OF fifo_tb IS
  SIGNAL HL   :  STD_LOGIC  ; 
  SIGNAL req   :  STD_LOGIC  ; 
  SIGNAL slow   :  STD_LOGIC  ; 
  SIGNAL Data_out   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL fast   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL Ack   :  STD_LOGIC  ; 
  SIGNAL Din   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL Reset   :  STD_LOGIC  ; 
  COMPONENT FIFO  
    GENERIC ( 
      N  : NATURAL  );  
    PORT ( 
      HL  : out STD_LOGIC ; 
      req  : in STD_LOGIC ; 
      slow  : out STD_LOGIC ; 
      Data_out  : out std_logic_vector (N - 1 downto 0) ; 
      fast  : out STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      Ack  : out STD_LOGIC ; 
      Din  : in std_logic_vector (N - 1 downto 0) ; 
      Reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : FIFO  
    GENERIC MAP ( 
      N  => N   )
    PORT MAP ( 
      HL   => HL  ,
      req   => req  ,
      slow   => slow  ,
      Data_out   => Data_out  ,
      fast   => fast  ,
      CLK   => CLK  ,
      Ack   => Ack  ,
      Din   => Din  ,
      Reset   => Reset   ) ; 
      
  clk_process : process
  begin
    CLK <= '1';
    wait for 20 ns;
    CLK <= '0';
    wait for 20 ns;
  end process;      
  
  stim_proc : process
  begin
    Reset <= '0';
    wait for 10 ns;
    Din <= "00000001";
    wait for 27 ns;
    Din <= "10000000";
    wait;
  end process;    
      
END ; 

