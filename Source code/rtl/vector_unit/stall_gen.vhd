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
entity stall_gen is
    Port ( 
    clk         	: in STD_LOGIC;
    reset       	: in STD_LOGIC;
    stall_in    	: in STD_LOGIC;
    stall_out   	: out STD_LOGIC);
end stall_gen;

architecture Behavioral of stall_gen is
signal stall_q : std_logic;
begin
STALL_GEN: process(clk,reset)
begin
    if reset = '1' then
        stall_q <= '0';
    elsif rising_edge(clk) then
		if stall_in = '1' then
			stall_q <= not stall_q;
		else
			stall_q <= '0';
		end if;
     end if;
end process STALL_GEN;


stall_out <= not stall_q and stall_in;

-----------------------------------------
end Behavioral;
