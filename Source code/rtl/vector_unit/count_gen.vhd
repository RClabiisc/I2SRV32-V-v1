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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity count_gen is
port(
	clk 			: in  STD_LOGIC;
    reset 			: in  STD_LOGIC;
	start			: in  STD_LOGIC;
	illegal			: in  STD_LOGIC;
	ENABLE          : in  STD_LOGIC;
	vl				: in  STD_LOGIC_VECTOR(8 DOWNTO 0);
	count			: out STD_LOGIC_VECTOR(5 DOWNTO 0);
	DONE			: out STD_LOGIC
);
end count_gen;

architecture Behavioral of count_gen is
--Signals
signal count_internal	:	STD_LOGIC_VECTOR(6 downto 0);
signal done_internal	:	STD_LOGIC;
signal expire			:	STD_LOGIC;
signal terminal_count	:	STD_LOGIC_VECTOR(6 downto 0);


begin
-----------Terminal Count--------------
terminal_count <= std_logic_vector(resize((unsigned(vl) - 1),count_internal'LENGTH));
---------------------------------------
------------Expire---------------------
--expire <= '1' when (count_internal = terminal_count)	else	'0';
---------------------------------------
-- done_gen: process(illegal,terminal_count,start,reset,count_internal)
-- begin
	-- if( (reset = '1') or (not(start) = '1') or (count_internal >= terminal_count) or(illegal = '1')) then
		-- done_internal	<=	'1';
	-- else
		-- done_internal	<=	'0';
	-- end if;
-- end process done_gen;
---------------------------------------
done_gen: process(illegal,terminal_count,start,reset,count_internal)
begin
	if ( (reset = '1') or (illegal = '1') ) then
		done_internal <= '1';
	elsif start = '0' then
		done_internal <= '1';
	elsif count_internal >= terminal_count then
		done_internal <= '1';
	else
		done_internal <= '0';
	end if;
end process done_gen;
---------------------------------------
-- done_internal_gen: process(clk,reset)
-- begin
	-- if reset = '1' then
		-- done_internal <= '1';
	-- elsif rising_edge(clk) then
		-- if start = '0' then
			-- done_internal <= '1';
		-- elsif( (count_internal <= terminal_count-1)) then
			-- done_internal <= '0';
		-- else
			-- done_internal <= '1';
		-- end if;
	-- end if;
-- end process done_internal_gen;
---------------------------------------
-- 1 . 8-bit Synchronous Counter
---------------------------------------
counter: process(clk,reset)
begin
    if(reset = '1') then
        count_internal <= (others=>'0');
	elsif(rising_edge(clk))	then
	    if start = '0' then
	       count_internal <= (others=>'0');
		--elsif(done_internal	= '0') then
		elsif ENABLE = '1' then
			count_internal <= count_internal+1;
		end if;
	end if;
end process counter;
---------------------------------------

---------------------------------------
-----------Outputs      ---------------
done  <= done_internal;
count <= count_internal(5 downto 0);  
end Behavioral;
