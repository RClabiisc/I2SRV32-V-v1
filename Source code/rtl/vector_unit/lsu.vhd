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
use IEEE.STD_LOGIC_UNSIGNED.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
library xil_defaultlib;
use xil_defaultlib.mypack.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity lsu is
port(
	RS1				: in  STD_LOGIC_VECTOR(31 DOWNTO 0);		-- Scalar Reg Store Data
	RS2				: in  STD_LOGIC_VECTOR(31 DOWNTO 0);		-- ScalarReg Store Addr/Dataend lsu;
	MODE    		: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
	count   		: in  STD_LOGIC_VECTOR(5 downto 0);
	V_OFFSET		: in  STD_LOGIC_VECTOR(31 DOWNTO 0);
	y_prev  		: in  STD_LOGIC_VECTOR(31 downto 0);
	y       		: out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end lsu;


architecture Behavioral of lsu is
type dmem_bank_select is array(0 to 7) of std_logic_vector(2 downto 0);

signal count32 : unsigned(31 downto 0);
signal product : unsigned(63 downto 0);
begin
count32<=resize(unsigned(count),32);
product <= unsigned(RS2)*count32;
--------------------------------------------------
addr_gen: process(RS1,RS2,MODE,V_OFFSET,count,count32,y_prev,product)
begin
	case MODE is
		when "00" => --Unit Stride
			y <= std_logic_vector(shift_left(count32,2) + unsigned(RS1));
		when "10" => -- STrided
			y <= std_logic_vector(unsigned(RS1) + shift_left(product(31 downto 0),2));
		when others =>	--Indexed
			y <= RS1 + V_OFFSET;
	end case;
end process addr_gen;
--------------------------------------------------

end Behavioral;