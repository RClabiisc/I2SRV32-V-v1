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
use IEEE.NUMERIC_STD.ALL;
library xil_defaultlib;
use xil_defaultlib.mypack.all;


entity wrapper is
port(
	clk 			: in  STD_LOGIC;
	reset 			: in  STD_LOGIC;
	vl				: in  STD_LOGIC_VECTOR(8 DOWNTO 0);			-- Vector LENGTH Register
	vcsr_quant		: in  STD_LOGIC_VECTOR(1 DOWNTO 0);			-- Vector LENGTH Register
	I_clear			: in  std_logic; 						-- Clear all instructions
	I_id			: in  std_logic_vector(2 downto 0);		-- Instruction 0 --> 7
	ALU_mon         : out std_logic;
	stall			: out std_logic;
	-----------------------------------------------------
	I_start   		: in std_logic;
	I_vs1     		: in std_logic_vector(4 downto 0);
	I_vs2     		: in std_logic_vector(4 downto 0);
	I_vd      		: in std_logic_vector(4 downto 0);
	I_RS1    		: in std_logic_vector(31 downto 0);
	I_RS2    		: in std_logic_vector(31 downto 0);
	I_uimm5    		: in std_logic_vector(4 downto 0);
	I_funct   		: in std_logic_vector(7 downto 0);
	I_permute   	: in std_logic_vector(1 downto 0);
	I_mask_en 		: in std_logic;
	I_ALUSrc  		: in std_logic_vector(1 downto 0);
	I_dmr     		: in std_logic;
	I_dmw     		: in std_logic;
	I_reg_we  		: in std_logic;
	I_mem_reg 		: in std_logic;
	I_Xout	 		: in std_logic;
	I_mode_lsu		: in std_logic_vector(1 downto 0);	
	-----------------------------------------------------
    DONE            : out std_logic;
	PROC_ADDR		: in  std_logic_vector(31 downto 0);
	PROC_DIN		: in  std_logic_vector(31 downto 0);
	PROC_WE			: in  std_logic;
	PROC_DOUT		: out std_logic_vector(31 downto 0);
	-----------------------------------------------------
	XRF_ADDR    : out STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Address for Writing Scalar OUtputs into XRF
	XRF_DATAWR  : out STD_LOGIC_VECTOR(31 DOWNTO 0);    -- Scalar Data
	XRF_WE      : out std_logic
	
);

end wrapper;

architecture Behavioral of wrapper is
component exe_unit is
	generic(VMEM_ADDR_WIDTH : integer :=14);
    Port  ( 
	    clk 		: in  STD_LOGIC;
        reset 		: in  STD_LOGIC;	-- Asynchronous RESET
		vl			: in  STD_LOGIC_VECTOR(8 DOWNTO 0);			-- Vector LENGTH Register
		vcsr_quant  : in  STD_LOGIC_VECTOR(1 downto 0);			-- From vector CSR
		Instruction : in  i_rec;		-- Instruction Specification
		I_id		: in  std_logic_vector(2 downto 0);	-- Id of Instructions in I-Bank
		I_clear		: in  std_logic;	-- Sync Clear for Instruction Bank
		ALU_mon     : out std_logic;	-- Output brought out to prevent logic optimization
		stall		: out std_logic;	-- High during Stall cycles
		DONE		: out std_logic;	-- High if Convoy is not executing an instruction
		----------------------Processor interface----------------------------------------
		PROC_ADDR   : in  STD_LOGIC_VECTOR(31 downto 0);	-- Adress from CPU to RW VREG/VMEM
		PROC_DIN    : in  STD_LOGIC_VECTOR(31 downto 0);	-- Write Data
		PROC_WE		: in  STD_LOGIC;						-- WE
		PROC_DOUT   : out STD_LOGIC_VECTOR(31 downto 0);		-- Read Data from VREG/VMEM
		-----------------------XRF Write INterface---------------------------------------
		XRF_ADDR    : out STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Address for Writing Scalar OUtputs into XRF
		XRF_DATAWR  : out STD_LOGIC_VECTOR(31 DOWNTO 0);    -- Scalar Data
		XRF_WE      : out std_logic
		   );
end component;

begin

VECTOR_EXE_UNIT_PIPE: exe_unit generic map(VMEM_ADDR_WIDTH=>14)
	port map(
	clk 					=> clk 				,		
	reset 		    		=> reset 			,	
	vl			    		=> vl				,	
	vcsr_quant				=> vcsr_quant		,
	I_id		    		=> I_id				,	
	I_clear		    		=> I_clear			,	
	ALU_mon         		=> ALU_mon  		,    
	stall		    		=> stall			,	
	--------------------------------------------------
	Instruction.start   	=> I_start   		,			
    Instruction.vs1     	=> I_vs1     		,	
    Instruction.vs2     	=> I_vs2     		,	
    Instruction.vd      	=> I_vd      		,	
    Instruction.RS1    		=> I_RS1    		,
    Instruction.RS2    		=> I_RS2    		,
    Instruction.uimm5    	=> I_uimm5    		,
    Instruction.funct   	=> I_funct   		,	
    Instruction.permute   	=> I_permute   		,	
    Instruction.mask_en 	=> I_mask_en 		,	
    Instruction.ALUSrc  	=> I_ALUSrc  		,	
    Instruction.dmr     	=> I_dmr     		,	
    Instruction.dmw     	=> I_dmw     		,	
    Instruction.reg_we  	=> I_reg_we  		,	
    Instruction.mem_reg 	=> I_mem_reg 		,	
    Instruction.Xout	 	=> I_Xout	 		,	
    Instruction.mode_lsu	=> I_mode_lsu		,	
	-------------------------------------------------
    DONE                    => DONE				,
	PROC_ADDR				=> PROC_ADDR		,
	PROC_DIN				=> PROC_DIN			,
	PROC_WE					=> PROC_WE			,
	PROC_DOUT				=> PROC_DOUT		,
	--------------------------------------------------
	XRF_ADDR    			=> XRF_ADDR   		,
	XRF_DATAWR  			=> XRF_DATAWR 		,
	XRF_WE      			=> XRF_WE     		
	);
	
end Behavioral;