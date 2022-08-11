-- ******************************************************************************
--  Copyright (c) 2014 - 2018, 2019 - 2021, Indian Institute of Science, Bangalore.
--  All Rights Reserved. See LICENSE for license details.
-- ------------------------------------------------------------------------------
-- 
--  Contributors
--  Naveen Chander V (naveenv@alum.iisc.ac.in)
--  Akshay Birari (akshay@alum.iisc.ac.in), Piyush Birla (piyush@alum.iisc.ac.in)
--  Suseela Budi (suseela@alum.iisc.ac.in), Pradeep Gupta (gupta@alum.iisc.ac.in)
--  Kavya Sharat (kavyasharat@alum.iisc.ac.in), Sumeet Bandishte (sumeet.bandishte30@gmail.com)
--  Kuruvilla Varghese (kuru@iisc.ac.in)
----------------------------------------------------------------------------------
-- Create Date:  26.04.2021 10:21:16
-- Module Name: Xoutreg - Behavioral 
-- Project Name: risc_v_cpu
-- Target Devices:Xilinx-Vertex7 {vc707 Board} 
-- Tool Versions: Vivado 2020.2
-- Description: Pipelined Vector Execution Unit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
library xil_defaultlib;
use xil_defaultlib.mypack.all;

entity Xoutreg is
    Port  ( 
	    clk 		: in  STD_LOGIC;
        reset 		: in  STD_LOGIC;	-- Asynchronous RESET
        WDATA       : in  alu_y_signed;
        RDATA       : out op_array;
        WE          : in  done_array
		);
end Xoutreg;

-----------------------------------------------------------------
architecture Behavioral of Xoutreg is
------------------------------------------------------------------
---------------------------------------------------------
------------		Xout reg 	--------------------------
-- Contains 8 registers - One register per lane
-- Each Register is meant to store scalar output of its
-- corresponding lane.
-- Read is asynchronous ; Write is Synchronous
-- These registers willl be eventually written to the XRF
-- upon compoeletion of the vector instruction.
-- --------------------------------------------------------
signal Xoutreg          :   op_array;		--Scalar Register in Each Vector Lane
begin
process(clk,reset)
begin
	-- Write Registers
	if reset = '1' then
		for i in 0 to 7 loop
			Xoutreg(i) <= (others=>'0');
		end loop;
	elsif rising_edge(clk) then
		for i in 0 to 7 loop
			if WE(i) = '1' then
				Xoutreg(i) <= std_logic_vector(WDATA(i));
			end if;
		end loop;
	end if;
end process;
XoutReader: process(Xoutreg)
begin
--- Xoutreg READ
	for i in 0 to 7 loop
		RDATA(i) <= Xoutreg(i);
	end loop;
end process XoutReader;		
end Behavioral;