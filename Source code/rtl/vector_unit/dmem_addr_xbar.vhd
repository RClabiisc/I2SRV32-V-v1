--******************************************************************************
-- Copyright (c) 2014 - 2018, 2019 - 2021, Indian Institute of Science, Bangalore.
-- All Rights Reserved. See LICENSE for license details.
--------------------------------------------------------------------------------

-- Contributors
-- Naveen Chander V (naveenv@alum.iisc.ac.in)
-- Akshay Birari (akshay@alum.iisc.ac.in), Piyush Birla (piyush@alum.iisc.ac.in)
-- Suseela Budi (suseela@alum.iisc.ac.in), Pradeep Gupta (gupta@alum.iisc.ac.in)
-- Kavya Sharat (kavyasharat@alum.iisc.ac.in), Sumeet Bandishte (sumeet.bandishte30@gmail.com)
-- Kuruvilla Varghese (kuru@iisc.ac.in)


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library xil_defaultlib;
use xil_defaultlib.mypack.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dmem_xbar is
generic(DMEM_ADDR_WIDTH : integer :=10);
	port(
		WR_ADDR 	: in  op_array;
		RD_ADDR 	: in  op_array;
		DIN			: in  op_array;
		DATA_RD_IN	: in  op_array;
		WE          : in  done_array;
		RE          : in  done_array;
		PortA_ADDR  : out DMEM_addr_array;
		PortA_WE    : out done_array;
		PortA_DIN   : out op_array;
		DATA_RD_OUT : out op_array     
		);
end dmem_xbar;

architecture Behavioral of dmem_xbar is
type dmem_bank_select is array(0 to 7) of std_logic_vector(2 downto 0);

signal wr_banksel : dmem_bank_select;   -- Array of eight 3bit numbers 
signal rd_banksel : dmem_bank_select;   -- Array of eight 3bit numbers 
signal mem_access : done_array;	-- Either read or write

begin
--------------------------------------------------
mem_access_gen: process(RE,WE)
begin
	for i in 0 to 7 loop
		if WE(i) = '1' or RE(i) = '1' then
			mem_access(i) <= '1';
		else
			mem_access(i) <= '0';
		end if;
	end loop;
	
end process mem_access_gen;
--------------------------------------------------
--------------------------------------------------
banksel_gen: process(WR_ADDR,RD_ADDR,mem_access)
begin
	for i in 0 to 7 loop
		if mem_access(i) = '1' then
			wr_banksel(i) <= WR_ADDR(i)(4 downto 2);  -- Address modulo to 32
			rd_banksel(i) <= RD_ADDR(i)(4 downto 2);  -- Address modulo to 32
		else
			wr_banksel(i) <= (others=>'1');
			rd_banksel(i) <= (others=>'1');
		end if;
	end loop;
end process banksel_gen;
                      
                                          
 --------------------------------------------------                     
                       --------------------------------------------------						
 ----------------DMEM0_ADDR   ---------------------                     
 --------------------------------------------------                     
 dmem0_portA: process(WR_ADDR,wr_banksel,DIN,WE)                        
 begin	                                                                
 	-- PortA_ADDR("000") Assignment                                         
 	if wr_banksel(0) ="000" then                                     
   		PortA_ADDR(0) <= WR_ADDR(0)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(0)  <= DIN(0);                                        
 		PortA_WE(0)   <= WE(0);                                         
 	elsif wr_banksel(1) = "000" then                                  
   		PortA_ADDR(0) <= WR_ADDR(1)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(0)  <= DIN(1);                                        
 		PortA_WE(0)   <= WE(1);                                         
 	elsif wr_banksel(2) = "000" then                                  
   		PortA_ADDR(0) <= WR_ADDR(2)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(0)  <= DIN(2);                                        
 		PortA_WE(0)   <= WE(2);		                                    
 	elsif wr_banksel(3) = "000" then                                  
   		PortA_ADDR(0) <= WR_ADDR(3)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(0)  <= DIN(3);                                        
 		PortA_WE(0)   <= WE(3);		                                    
 	elsif wr_banksel(4) = "000" then                                  
   		PortA_ADDR(0) <= WR_ADDR(4)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(0)  <= DIN(4);                                        
 		PortA_WE(0)   <= WE(4);				                            
 	elsif wr_banksel(5) = "000" then                                  
   		PortA_ADDR(0) <= WR_ADDR(5)(DMEM_ADDR_WIDTH+4 downto 5);		
 		PortA_DIN(0)  <= DIN(5);                                        
 		PortA_WE(0)   <= WE(5);		                                    
 	elsif wr_banksel(6) = "000" then                                  
   		PortA_ADDR(0) <= WR_ADDR(6)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(0)  <= DIN(6);                                        
 		PortA_WE(0)   <= WE(6);	                                        
 	else                                                                
 		PortA_ADDR(0) <= WR_ADDR(7)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(0)  <= DIN(7);                                        
 		PortA_WE(0)   <= WE(7);			                                
 	end if;	                                                            
 end process dmem0_portA;	                                            
 --------------------------------------------------                     
 --------------------------------------------------						
 ----------------DMEM1_ADDR   ---------------------                     
 --------------------------------------------------                     
 dmem1_portA: process(WR_ADDR,wr_banksel,DIN,WE)                        
 begin	                                                                
 	-- PortA_ADDR("001") Assignment                                         
 	if wr_banksel(0) ="001" then                                     
   		PortA_ADDR(1) <= WR_ADDR(0)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(1)  <= DIN(0);                                        
 		PortA_WE(1)   <= WE(0);                                         
 	elsif wr_banksel(1) = "001" then                                  
   		PortA_ADDR(1) <= WR_ADDR(1)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(1)  <= DIN(1);                                        
 		PortA_WE(1)   <= WE(1);                                         
 	elsif wr_banksel(2) = "001" then                                  
   		PortA_ADDR(1) <= WR_ADDR(2)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(1)  <= DIN(2);                                        
 		PortA_WE(1)   <= WE(2);		                                    
 	elsif wr_banksel(3) = "001" then                                  
   		PortA_ADDR(1) <= WR_ADDR(3)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(1)  <= DIN(3);                                        
 		PortA_WE(1)   <= WE(3);		                                    
 	elsif wr_banksel(4) = "001" then                                  
   		PortA_ADDR(1) <= WR_ADDR(4)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(1)  <= DIN(4);                                        
 		PortA_WE(1)   <= WE(4);				                            
 	elsif wr_banksel(5) = "001" then                                  
   		PortA_ADDR(1) <= WR_ADDR(5)(DMEM_ADDR_WIDTH+4 downto 5);		
 		PortA_DIN(1)  <= DIN(5);                                        
 		PortA_WE(1)   <= WE(5);		                                    
 	elsif wr_banksel(6) = "001" then                                  
   		PortA_ADDR(1) <= WR_ADDR(6)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(1)  <= DIN(6);                                        
 		PortA_WE(1)   <= WE(6);	                                        
 	else                                                                
 		PortA_ADDR(1) <= WR_ADDR(7)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(1)  <= DIN(7);                                        
 		PortA_WE(1)   <= WE(7);			                                
 	end if;	                                                            
 end process dmem1_portA;	                                            
 --------------------------------------------------                     
 --------------------------------------------------						
 ----------------DMEM2_ADDR   ---------------------                     
 --------------------------------------------------                     
 dmem2_portA: process(WR_ADDR,wr_banksel,DIN,WE)                        
 begin	                                                                
 	-- PortA_ADDR("010") Assignment                                         
 	if wr_banksel(0) ="010" then                                     
   		PortA_ADDR(2) <= WR_ADDR(0)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(2)  <= DIN(0);                                        
 		PortA_WE(2)   <= WE(0);                                         
 	elsif wr_banksel(1) = "010" then                                  
   		PortA_ADDR(2) <= WR_ADDR(1)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(2)  <= DIN(1);                                        
 		PortA_WE(2)   <= WE(1);                                         
 	elsif wr_banksel(2) = "010" then                                  
   		PortA_ADDR(2) <= WR_ADDR(2)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(2)  <= DIN(2);                                        
 		PortA_WE(2)   <= WE(2);		                                    
 	elsif wr_banksel(3) = "010" then                                  
   		PortA_ADDR(2) <= WR_ADDR(3)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(2)  <= DIN(3);                                        
 		PortA_WE(2)   <= WE(3);		                                    
 	elsif wr_banksel(4) = "010" then                                  
   		PortA_ADDR(2) <= WR_ADDR(4)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(2)  <= DIN(4);                                        
 		PortA_WE(2)   <= WE(4);				                            
 	elsif wr_banksel(5) = "010" then                                  
   		PortA_ADDR(2) <= WR_ADDR(5)(DMEM_ADDR_WIDTH+4 downto 5);		
 		PortA_DIN(2)  <= DIN(5);                                        
 		PortA_WE(2)   <= WE(5);		                                    
 	elsif wr_banksel(6) = "010" then                                  
   		PortA_ADDR(2) <= WR_ADDR(6)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(2)  <= DIN(6);                                        
 		PortA_WE(2)   <= WE(6);	                                        
 	else                                                                
 		PortA_ADDR(2) <= WR_ADDR(7)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(2)  <= DIN(7);                                        
 		PortA_WE(2)   <= WE(7);			                                
 	end if;	                                                            
 end process dmem2_portA;	                                            
 --------------------------------------------------                     
 --------------------------------------------------						
 ----------------DMEM3_ADDR   ---------------------                     
 --------------------------------------------------                     
 dmem3_portA: process(WR_ADDR,wr_banksel,DIN,WE)                        
 begin	                                                                
 	-- PortA_ADDR("011") Assignment                                         
 	if wr_banksel(0) ="011" then                                     
   		PortA_ADDR(3) <= WR_ADDR(0)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(3)  <= DIN(0);                                        
 		PortA_WE(3)   <= WE(0);                                         
 	elsif wr_banksel(1) = "011" then                                  
   		PortA_ADDR(3) <= WR_ADDR(1)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(3)  <= DIN(1);                                        
 		PortA_WE(3)   <= WE(1);                                         
 	elsif wr_banksel(2) = "011" then                                  
   		PortA_ADDR(3) <= WR_ADDR(2)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(3)  <= DIN(2);                                        
 		PortA_WE(3)   <= WE(2);		                                    
 	elsif wr_banksel(3) = "011" then                                  
   		PortA_ADDR(3) <= WR_ADDR(3)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(3)  <= DIN(3);                                        
 		PortA_WE(3)   <= WE(3);		                                    
 	elsif wr_banksel(4) = "011" then                                  
   		PortA_ADDR(3) <= WR_ADDR(4)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(3)  <= DIN(4);                                        
 		PortA_WE(3)   <= WE(4);				                            
 	elsif wr_banksel(5) = "011" then                                  
   		PortA_ADDR(3) <= WR_ADDR(5)(DMEM_ADDR_WIDTH+4 downto 5);		
 		PortA_DIN(3)  <= DIN(5);                                        
 		PortA_WE(3)   <= WE(5);		                                    
 	elsif wr_banksel(6) = "011" then                                  
   		PortA_ADDR(3) <= WR_ADDR(6)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(3)  <= DIN(6);                                        
 		PortA_WE(3)   <= WE(6);	                                        
 	else                                                                
 		PortA_ADDR(3) <= WR_ADDR(7)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(3)  <= DIN(7);                                        
 		PortA_WE(3)   <= WE(7);			                                
 	end if;	                                                            
 end process dmem3_portA;	                                            
 --------------------------------------------------                     
 --------------------------------------------------						
 ----------------DMEM4_ADDR   ---------------------                     
 --------------------------------------------------                     
 dmem4_portA: process(WR_ADDR,wr_banksel,DIN,WE)                        
 begin	                                                                
 	-- PortA_ADDR("100") Assignment                                         
 	if wr_banksel(0) ="100" then                                     
   		PortA_ADDR(4) <= WR_ADDR(0)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(4)  <= DIN(0);                                        
 		PortA_WE(4)   <= WE(0);                                         
 	elsif wr_banksel(1) = "100" then                                  
   		PortA_ADDR(4) <= WR_ADDR(1)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(4)  <= DIN(1);                                        
 		PortA_WE(4)   <= WE(1);                                         
 	elsif wr_banksel(2) = "100" then                                  
   		PortA_ADDR(4) <= WR_ADDR(2)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(4)  <= DIN(2);                                        
 		PortA_WE(4)   <= WE(2);		                                    
 	elsif wr_banksel(3) = "100" then                                  
   		PortA_ADDR(4) <= WR_ADDR(3)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(4)  <= DIN(3);                                        
 		PortA_WE(4)   <= WE(3);		                                    
 	elsif wr_banksel(4) = "100" then                                  
   		PortA_ADDR(4) <= WR_ADDR(4)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(4)  <= DIN(4);                                        
 		PortA_WE(4)   <= WE(4);				                            
 	elsif wr_banksel(5) = "100" then                                  
   		PortA_ADDR(4) <= WR_ADDR(5)(DMEM_ADDR_WIDTH+4 downto 5);		
 		PortA_DIN(4)  <= DIN(5);                                        
 		PortA_WE(4)   <= WE(5);		                                    
 	elsif wr_banksel(6) = "100" then                                  
   		PortA_ADDR(4) <= WR_ADDR(6)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(4)  <= DIN(6);                                        
 		PortA_WE(4)   <= WE(6);	                                        
 	else                                                                
 		PortA_ADDR(4) <= WR_ADDR(7)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(4)  <= DIN(7);                                        
 		PortA_WE(4)   <= WE(7);			                                
 	end if;	                                                            
 end process dmem4_portA;	                                            
 --------------------------------------------------                     
 --------------------------------------------------						
 ----------------DMEM5_ADDR   ---------------------                     
 --------------------------------------------------                     
 dmem5_portA: process(WR_ADDR,wr_banksel,DIN,WE)                        
 begin	                                                                
 	-- PortA_ADDR("101") Assignment                                         
 	if wr_banksel(0) ="101" then                                     
   		PortA_ADDR(5) <= WR_ADDR(0)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(5)  <= DIN(0);                                        
 		PortA_WE(5)   <= WE(0);                                         
 	elsif wr_banksel(1) = "101" then                                  
   		PortA_ADDR(5) <= WR_ADDR(1)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(5)  <= DIN(1);                                        
 		PortA_WE(5)   <= WE(1);                                         
 	elsif wr_banksel(2) = "101" then                                  
   		PortA_ADDR(5) <= WR_ADDR(2)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(5)  <= DIN(2);                                        
 		PortA_WE(5)   <= WE(2);		                                    
 	elsif wr_banksel(3) = "101" then                                  
   		PortA_ADDR(5) <= WR_ADDR(3)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(5)  <= DIN(3);                                        
 		PortA_WE(5)   <= WE(3);		                                    
 	elsif wr_banksel(4) = "101" then                                  
   		PortA_ADDR(5) <= WR_ADDR(4)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(5)  <= DIN(4);                                        
 		PortA_WE(5)   <= WE(4);				                            
 	elsif wr_banksel(5) = "101" then                                  
   		PortA_ADDR(5) <= WR_ADDR(5)(DMEM_ADDR_WIDTH+4 downto 5);		
 		PortA_DIN(5)  <= DIN(5);                                        
 		PortA_WE(5)   <= WE(5);		                                    
 	elsif wr_banksel(6) = "101" then                                  
   		PortA_ADDR(5) <= WR_ADDR(6)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(5)  <= DIN(6);                                        
 		PortA_WE(5)   <= WE(6);	                                        
 	else                                                                
 		PortA_ADDR(5) <= WR_ADDR(7)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(5)  <= DIN(7);                                        
 		PortA_WE(5)   <= WE(7);			                                
 	end if;	                                                            
 end process dmem5_portA;	                                            
 --------------------------------------------------                     
 --------------------------------------------------						
 ----------------DMEM6_ADDR   ---------------------                     
 --------------------------------------------------                     
 dmem6_portA: process(WR_ADDR,wr_banksel,DIN,WE)                        
 begin	                                                                
 	-- PortA_ADDR("110") Assignment                                         
 	if wr_banksel(0) ="110" then                                     
   		PortA_ADDR(6) <= WR_ADDR(0)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(6)  <= DIN(0);                                        
 		PortA_WE(6)   <= WE(0);                                         
 	elsif wr_banksel(1) = "110" then                                  
   		PortA_ADDR(6) <= WR_ADDR(1)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(6)  <= DIN(1);                                        
 		PortA_WE(6)   <= WE(1);                                         
 	elsif wr_banksel(2) = "110" then                                  
   		PortA_ADDR(6) <= WR_ADDR(2)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(6)  <= DIN(2);                                        
 		PortA_WE(6)   <= WE(2);		                                    
 	elsif wr_banksel(3) = "110" then                                  
   		PortA_ADDR(6) <= WR_ADDR(3)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(6)  <= DIN(3);                                        
 		PortA_WE(6)   <= WE(3);		                                    
 	elsif wr_banksel(4) = "110" then                                  
   		PortA_ADDR(6) <= WR_ADDR(4)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(6)  <= DIN(4);                                        
 		PortA_WE(6)   <= WE(4);				                            
 	elsif wr_banksel(5) = "110" then                                  
   		PortA_ADDR(6) <= WR_ADDR(5)(DMEM_ADDR_WIDTH+4 downto 5);		
 		PortA_DIN(6)  <= DIN(5);                                        
 		PortA_WE(6)   <= WE(5);		                                    
 	elsif wr_banksel(6) = "110" then                                  
   		PortA_ADDR(6) <= WR_ADDR(6)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(6)  <= DIN(6);                                        
 		PortA_WE(6)   <= WE(6);	                                        
 	else                                                                
 		PortA_ADDR(6) <= WR_ADDR(7)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(6)  <= DIN(7);                                        
 		PortA_WE(6)   <= WE(7);			                                
 	end if;	                                                            
 end process dmem6_portA;	                                            
 --------------------------------------------------                     
 --------------------------------------------------						
 ----------------DMEM7_ADDR   ---------------------                     
 --------------------------------------------------                     
 dmem7_portA: process(WR_ADDR,wr_banksel,DIN,WE,mem_access)                        
 begin	                                                                
 	-- PortA_ADDR("111") Assignment                                         
 	if wr_banksel(0) ="111" and mem_access(0) = '1' then                                     
   		PortA_ADDR(7) <= WR_ADDR(0)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(7)  <= DIN(0);                                        
 		PortA_WE(7)   <= WE(0);                                         
 	elsif wr_banksel(1) = "111" and mem_access(1) = '1' then                                  
   		PortA_ADDR(7) <= WR_ADDR(1)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(7)  <= DIN(1);                                        
 		PortA_WE(7)   <= WE(1);                                         
 	elsif wr_banksel(2) = "111" and mem_access(2) = '1' then                                  
   		PortA_ADDR(7) <= WR_ADDR(2)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(7)  <= DIN(2);                                        
 		PortA_WE(7)   <= WE(2);		                                    
 	elsif wr_banksel(3) = "111" and mem_access(3) = '1' then                                  
   		PortA_ADDR(7) <= WR_ADDR(3)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(7)  <= DIN(3);                                        
 		PortA_WE(7)   <= WE(3);		                                    
 	elsif wr_banksel(4) = "111" and mem_access(4) = '1' then                                  
   		PortA_ADDR(7) <= WR_ADDR(4)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(7)  <= DIN(4);                                        
 		PortA_WE(7)   <= WE(4);				                            
 	elsif wr_banksel(5) = "111" and mem_access(5) = '1' then                                  
   		PortA_ADDR(7) <= WR_ADDR(5)(DMEM_ADDR_WIDTH+4 downto 5);		
 		PortA_DIN(7)  <= DIN(5);                                        
 		PortA_WE(7)   <= WE(5);		                                    
 	elsif wr_banksel(6) = "111" and mem_access(6) = '1' then                                  
   		PortA_ADDR(7) <= WR_ADDR(6)(DMEM_ADDR_WIDTH+4 downto 5);        
 		PortA_DIN(7)  <= DIN(6);                                        
 		PortA_WE(7)   <= WE(6);	                                        
 	else                                                                
 		PortA_ADDR(7) <= WR_ADDR(7)(DMEM_ADDR_WIDTH+4 downto 5);	    
 		PortA_DIN(7)  <= DIN(7);                                        
 		PortA_WE(7)   <= WE(7);			                                
 	end if;	                                                            
 end process dmem7_portA;	                                            
 --------------------------------------------------                     
                    
 --------------------------------------------------                     
                                         
 ----------------READ------------------------------
 DMEM_RD: process(rd_banksel, DATA_RD_IN)
 begin
	for i in 0 to 7 loop	
		case rd_banksel(i) is
			when "000" => DATA_RD_OUT(i) <= DATA_RD_IN(0);
			when "001" => DATA_RD_OUT(i) <= DATA_RD_IN(1);
			when "010" => DATA_RD_OUT(i) <= DATA_RD_IN(2);
			when "011" => DATA_RD_OUT(i) <= DATA_RD_IN(3);
			when "100" => DATA_RD_OUT(i) <= DATA_RD_IN(4);
			when "101" => DATA_RD_OUT(i) <= DATA_RD_IN(5);
			when "110" => DATA_RD_OUT(i) <= DATA_RD_IN(6);
			when "111" => DATA_RD_OUT(i) <= DATA_RD_IN(7);
			when others=> DATA_RD_OUT(i) <= DATA_RD_IN(i);
		end case;
	end loop;
 end process;	
end Behavioral;
