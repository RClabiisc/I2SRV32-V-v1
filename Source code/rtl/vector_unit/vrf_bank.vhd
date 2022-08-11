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
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity vrf_bank is
generic(width : integer :=32);
    Port (  clk 		: in  STD_LOGIC;
            reset 		: in  STD_LOGIC;
			bankID      : in  integer range 0 to 7;	-- To specify initialization pattern	
			wr_count	: in  STD_LOGIC_VECTOR(5  downto 0);	-- To calculate vreg_offset for write
			rd_count	: in  STD_LOGIC_VECTOR(5  downto 0);	-- To calculate vreg_offset for read
			shift_count : in  STD_LOGIC_VECTOR(5  downto 0);    -- To calculate vreg_offset for read
			DONE		: in  STD_LOGIC;
			vl			: in  STD_LOGIC_VECTOR(8 downto 0);
			vd			: in  STD_LOGIC_VECTOR(4  downto 0);
			vs1			: in  STD_LOGIC_VECTOR(4  downto 0);
			vs2			: in  STD_LOGIC_VECTOR(4  downto 0);
			vs3			: in  STD_LOGIC_VECTOR(4  downto 0);	-- vd from Instruction without delay
			vs4			: in  STD_LOGIC_VECTOR(4  downto 0);	-- vs2 from Instruction for Vector Permutations
			DATA_WR		: in  STD_LOGIC_VECTOR(31 downto 0);
			WE			: in  STD_LOGIC;
			v0_DATA		: out STD_LOGIC_VECTOR(width -1 downto 0);
			DATA_RD1	: out STD_LOGIC_VECTOR(31 downto 0);	--vs1 Data
			DATA_RD2	: out STD_LOGIC_VECTOR(31 downto 0);	-- vs2 Data
			DATA_RD3	: out STD_LOGIC_VECTOR(31 downto 0);		--vd Data
			DATA_RD4	: out STD_LOGIC_VECTOR(31 downto 0)		--vd Data
		   );
end vrf_bank;

architecture Behavioral of vrf_bank is
-- Create a REG_ARRAY of 32 x 32
type reg_array is array (31 downto 0) of std_logic_vector(width-1 downto 0);
signal vec_reg 			:	reg_array;
signal v_index_offset : unsigned(2 downto 0);
signal wr_v_index_offset : integer range 0 to 7;
signal v_index_offset_vs4 : unsigned(2 downto 0);
signal vs1_index : unsigned(4 downto 0);
signal vs2_index : unsigned(4 downto 0);
signal vs3_index : unsigned(4 downto 0);
signal vs4_index : unsigned(4 downto 0);
signal vd_index  : integer range 0 to 31;


begin
--- Doubting Variable : v_index_offet. Converting it into a signal ...
wr_v_index_offset  <=   to_integer(shift_right(unsigned(wr_count),3));  -- count / 8 
vd_index           <=    to_integer(unsigned((vd)))+wr_v_index_offset;
writer: process(clk,reset)
-- Process Variable Definitions
	variable i 			: integer range 0 to width-1;
	variable offset 	    : integer := 0;
	variable hi_bit			: integer := 31;
	variable lo_bit		    : integer := 0;
	variable v_index_offset : integer range 0 to 7;
	variable nElements      : integer := 8;
	variable ele_size       : integer := 32;
	variable v_index        : integer range 0 to 31;

begin
	if(reset = '1') then
		for i in 0 to 31 loop
			--vec_reg(i)	<= std_logic_vector(to_signed((i*8+bankID),32));
			vec_reg(i)	<= (others=>'0');
		end loop;
	
 	elsif(rising_edge(clk))   then
		if (WE = '1') then
			--v_index_offset  :=    to_integer(shift_right(unsigned(wr_count),3));  -- count / 8 
			--v_index         :=    to_integer(unsigned((vd)))+v_index_offset;
			--vec_reg(v_index) <= DATA_WR;	 
			if ('0'&wr_count) <= vl(6 downto 0) then				
			     vec_reg((vd_index)) <= DATA_WR;	 
			end if;				
			---------------------------------------------------------------------------------
		end if;
	end if;
end process writer;
		v_index_offset      <=    resize(shift_right(unsigned(rd_count),3),3);
		v_index_offset_vs4  <=    resize(shift_right(unsigned(shift_count),3),3);
-- rd_offset_gen: process(rd_count,shift_count,DONE)
-- begin
	-- if DONE='0' then
		-- v_index_offset      <=    resize(shift_right(unsigned(rd_count),3),3);
		-- v_index_offset_vs4  <=    resize(shift_right(unsigned(shift_count),3),3);
	-- else
		-- v_index_offset      <=    (others=>'0');
		-- v_index_offset_vs4  <=    (others=>'0');
	-- end if;
-- end process rd_offset_gen;	
---------------------------------------------------------------------------	
vs1_index           <=    (unsigned((vs1)))+v_index_offset;
vs2_index           <=    (unsigned((vs2)))+v_index_offset;	
vs3_index           <=    (unsigned((vs3)))+v_index_offset;	
vs4_index           <=    unsigned((vs4))+v_index_offset_vs4;
		
DATA_RD1            <= vec_reg(to_integer(vs1_index));  -- vs1 Data
DATA_RD2            <= vec_reg(to_integer(vs2_index));  -- vs2 Data
DATA_RD3            <= vec_reg(to_integer(vs3_index));  -- For MAC Operation Only
DATA_RD4            <= vec_reg(to_integer(vs4_index));  -- For vector Permute Operations Only
------------------------------------------------------------------------------------------------
v0_DATA <= vec_reg(0);	--MASK

end Behavioral;
