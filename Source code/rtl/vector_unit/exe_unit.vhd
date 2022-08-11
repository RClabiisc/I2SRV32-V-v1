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
use ieee.numeric_std.all;
library xil_defaultlib;
use xil_defaultlib.mypack.all;

  
entity exe_unit is
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
end exe_unit;
-----------------------------------------------------------------

architecture Behavioral of exe_unit is
-----------------------------------------------------------------


-----------------------------------------------------------------
--Signals

type chain_select is array(0 to 7) of std_logic_vector(2 downto 0);
type reg_select is array(0 to 7) of std_logic_vector(4 downto 0);



signal ALU_y            :   ALU_y_signed;
signal vs1				:   reg_select;
signal vs2				:   reg_select;
signal vs3				:   reg_select;
signal vs4				:   reg_select;
signal vd				:   reg_select;
signal VREG_WE          :   done_array;
signal Xoutreg_WE       :   done_array;
signal DONEs_internal   :   done_array;
signal multi_cyc_done_level   : done_array;
signal DIV_BUSY		    :   done_array;
signal RD_EXE_DONEs     :   done_array;
signal EXE_MEM_DONEs    :   done_array;
signal MEM_WB_DONEs     :   done_array;
signal WB_FIN_DONEs     :   done_array;
signal REG_DATA_WR      :   op_array;
signal counts           :   count_array;
signal RD_EXE_counts    :   count_array;
signal EXE_MEM_counts   :   count_array;
signal MEM_WB_counts    :   count_array;
signal WB_FIN_counts    :   count_array;
signal shift_count      :   count_array;
signal STALLs           :   done_array;
signal STALLs_FF        :   done_array;
signal STALLs_internal  :   done_array;
signal DMEM_WE          :   done_array;
signal DMEM_RE          :   done_array;
signal DMEM_WE_Xbar     :   done_array;
signal op1_XbarOut      :   op_array;
signal op2_XbarOut      :   op_array;
signal op3_XbarOut      :   op_array;
signal op4_XbarOut      :   op_array;
signal op2              :   op_array;
signal op1              :   op_array;
signal op3              :   op_array;
signal DATA_RD1         :   op_array;
signal DATA_RD2         :   op_array;
signal DATA_RD3         :   op_array;
signal DATA_RD4         :   op_array;
signal v0_DATA          :   op_array;
signal LSU_y            :   op_array;
signal div_op           :   op_array;
signal y_minmax         :   op_array;

signal ALU_cout         :   done_array;
signal ALU_overflow     :   done_array;
signal ALU_underflow    :   done_array;
signal divbyzero	    :   done_array;
signal illegal_internal :   STD_LOGIC;
signal multi_cyc_inst   :   STD_LOGIC;
signal MASK_VECTOR_VREGWR :   STD_LOGIC_VECTOR(255 downto 0);
signal MASK_VECTOR_DMEMWR :   STD_LOGIC_VECTOR(255 downto 0);
signal E_FA             :   chain_select;
signal E_FB             :   chain_select;
signal E_FC             :   chain_select;
signal M_FA             :   chain_select;
signal M_FB             :   chain_select;
signal count_enable     :   STD_LOGIC;
------------------------------------------------------
--RD_EXE SIgnals
signal RD_EXE_DATA_RD1  :   op_array;
signal RD_EXE_DATA_RD2  :   op_array;
signal RD_EXE_DATA_RD3  :   op_array;
signal RD_EXE_DATA_RD4  :   op_array;
signal RD_EXE_v0_DATA   :   op_array;
signal RD_EXE_Instructions : array_i_rec;
------------------------------------------------------
--EXE_MEM Signals		
signal EXE_MEM_ALU_y	:	op_array;
signal EXE_MEM_DATA_RD2 :	op_array;
signal EXE_MEM_DATA_RD3 :	op_array;
signal EXE_MEM_DATA_RD4 :	op_array;
signal EXE_MEM_v0_DATA	:	op_array;
signal EXE_MEM_LSU_y	:	op_array;
signal EXE_MEM_Instructions : array_i_rec;
-------------------------------------------------------
signal DMEM_ADDR        : dmem_addr_array;
signal DMEM_ADDR_Xbar   : dmem_addr_array;
signal DMEM_DATA        : op_array;
signal DMEM_DATA_Xbar   : op_array;
signal dmem_din         : op_array;
signal dmem_din_Xbar    : op_array;
signal DMEM_DIN_CPU     : op_array;


signal Xoutreg_data     : op_array;

signal MEM_WB_Instructions : array_i_rec;
signal MEM_WB_ALU_y        : op_array;
signal MEM_WB_v0_DATA      : op_array;
signal MEM_WB_DATA         : op_array;
signal MEM_WB_LSU_y	       : op_array;

signal WB_FIN_Instructions : array_i_rec;
signal WB_FIN_DATA         : op_array;			
		
signal stalls_internal_ored: std_logic;		
signal div_stalls_ored	   : std_logic;		
signal stall_q			   : std_logic;
signal RD_EXE_count_en	   : std_logic;
signal slide_val		   : std_logic_vector(1 downto 0);
signal ALU_mon_int         : std_logic_vector(34 downto 0);		
------------------------------------------------------------
signal Instructions		   : array_i_rec;
------------------------------------------------------------
-- CPU Interface Related
signal vs1_VEC_CPU			: reg_select;		-- Signal oing into VREG
signal vd_VEC_CPU			: reg_select;
signal vs1_CPU				: STD_LOGIC_VECTOR(4 DOWNTO 0);	-- CPU's vs1 Select
signal vd_CPU				: STD_LOGIC_VECTOR(4 DOWNTO 0);
signal VREG_WE_CPU		    : done_array;	
signal DONE_int             : STD_LOGIC;					-- Selector for CPU/VECTOR MUX
signal DMEM_ADDR_VEC_CPU	: dmem_addr_array;
signal DMEM_DIN_VEC_CPU 	: op_array;
signal DMEM_WE_VEC_CPU  	: done_array;
signal DMEM_WE_CPU  		: done_array;
signal REG_DATA_WR_VEC_CPU 	: op_array;
signal VREG_WE_VEC_CPU		: done_array;
signal DMEM_ADDR_CPU    	: std_logic_vector(VMEM_ADDR_WIDTH-1 downto 0);
-- XRF Interface Related
signal end_cycle_XRF_Addr : std_logic_vector(8 downto 0);
signal end_cycle_XRF_DataWR : std_logic_vector(8 downto 0);
------------------------------------------------------------
-- Vector Permutation Related
--signal scalar_uimm5        : std_logic;
signal v_slide             : done_array; -- 0:= Up; 1:= Down
signal v_permute_en        : done_array;
begin
------------------------------------------------------						
stalls_internal_ored <= stalls_internal(0) or stalls_internal(1) OR
						stalls_internal(2) or stalls_internal(3) OR
						stalls_internal(4) or stalls_internal(5) OR
						stalls_internal(6) or stalls_internal(7) ;
------------------------------------------------------														  
div_stalls_ored		 <= DIV_BUSY(0) or DIV_BUSY(1) OR
						DIV_BUSY(2) or DIV_BUSY(3) OR
						DIV_BUSY(4) or DIV_BUSY(5) OR
						DIV_BUSY(6) or DIV_BUSY(7) ;				  
------------------------------------------------------
MASK_VECTOR_VREGWR	 <= MEM_WB_v0_DATA(7) & MEM_WB_v0_DATA(6) &
						MEM_WB_v0_DATA(5) & MEM_WB_v0_DATA(4) &
						MEM_WB_v0_DATA(3) & MEM_WB_v0_DATA(2) &
						MEM_WB_v0_DATA(1) & MEM_WB_v0_DATA(0) ;
------------------------------------------------------
MASK_VECTOR_DMEMWR	 <= EXE_MEM_v0_DATA(7) & EXE_MEM_v0_DATA(6) &
						EXE_MEM_v0_DATA(5) & EXE_MEM_v0_DATA(4) &
						EXE_MEM_v0_DATA(3) & EXE_MEM_v0_DATA(2) &
						EXE_MEM_v0_DATA(1) & EXE_MEM_v0_DATA(0) ;
illegal_internal <= '0';
----------------------------------------------------
-- Stall for Counter Control 
count_enable <= not (stall_q OR DIV_BUSY(0) OR
								DIV_BUSY(1) OR		
	                            DIV_BUSY(2) OR
	                            DIV_BUSY(3) OR
	                            DIV_BUSY(4) OR
	                            DIV_BUSY(5) OR
	                            DIV_BUSY(6) OR
	                            DIV_BUSY(7) );
--------------------------------------------------
-- STALL Output Signal for Instruction COntrol
stall <= stall_q OR DIV_BUSY(0) OR
								DIV_BUSY(1) OR		
	                            DIV_BUSY(2) OR
	                            DIV_BUSY(3) OR
	                            DIV_BUSY(4) OR
	                            DIV_BUSY(5) OR
	                            DIV_BUSY(6) OR
	                            DIV_BUSY(7);
								
RD_EXE_count_en <= not (stall_q);
								
DONE_int <= DONEs_internal(0) and DONEs_internal(1) and WB_FIN_DONEs(0) and WB_FIN_DONEs(1) and
			DONEs_internal(2) and DONEs_internal(3) and WB_FIN_DONEs(2) and WB_FIN_DONEs(3) and
			DONEs_internal(4) and DONEs_internal(5) and WB_FIN_DONEs(4) and WB_FIN_DONEs(5) and
			DONEs_internal(6) and DONEs_internal(7) and WB_FIN_DONEs(6) and WB_FIN_DONEs(7);
		
------------------------------------------------------
DONE	 <= DONEs_internal(0) and DONEs_internal(1) and MEM_WB_DONEs(0) and MEM_WB_DONEs(1) and
			DONEs_internal(2) and DONEs_internal(3) and MEM_WB_DONEs(2) and MEM_WB_DONEs(3) and
			DONEs_internal(4) and DONEs_internal(5) and MEM_WB_DONEs(4) and MEM_WB_DONEs(5) and
			DONEs_internal(6) and DONEs_internal(7) and MEM_WB_DONEs(6) and MEM_WB_DONEs(7);
------------------------------------------------------
Instruction_bank: process(clk,reset)
begin
	if reset = '1' then
		Instructions <= (others=>i_rec_init);
	elsif rising_edge(clk) then
		if I_clear = '1' then
			Instructions <= (others=>i_rec_init);
		else
		  case I_id is
		      when "001" =>Instructions(1) <= Instruction;
		      when "010" =>Instructions(2) <= Instruction;
		      when "011" =>Instructions(3) <= Instruction;
		      when "100" =>Instructions(4) <= Instruction;
		      when "101" =>Instructions(5) <= Instruction;
		      when "110" =>Instructions(6) <= Instruction;
		      when "111" =>Instructions(7) <= Instruction;
		      when others=>Instructions(0) <= Instruction;
		  end case;
		end if;
	end if;
end process Instruction_bank;
------------------------------------------------------
-- Vector Permute operations
permute_logic_inp: process(Instructions)
begin
    for i in 0 to 7 loop
        v_slide(i)       <= Instructions(i).permute(0);
        v_permute_en(i)  <= Instructions(i).permute(1) OR Instructions(i).permute(0);
    end loop;
end process permute_logic_inp;
------------------------------------------------------
-- Permute INput Signal gen
compute_permute_inp: process(Instructions, counts,slide_val)
begin
    for i in 0 to 7 loop
        shift_count(i) <= counts(i)+slide_val; 
    end loop;
end process compute_permute_inp;
------------------------------------------------------
	
------------------------------------------------------
GEN_COUNTERS:
	for i in 0 to 7 generate
		counts_gen: count_gen port map
			(
				clk 	=> clk 					 ,	
				reset 	=> reset 				 ,		
				start	=> Instructions(i).start ,		
				illegal	=> illegal_internal		 ,	
				ENABLE  => count_enable			 ,
				vl		=> vl					 ,		
				count	=> counts(i)			 ,		
				DONE	=> DONEs_internal(i)	
			);
	end generate GEN_COUNTERS;
------------------------------------------------------
GEN_ALUs:
	for i in 0 to 7 generate
		alu_gen: alu generic map(32)  
		port map
		(
			op1 	    =>	signed(op1(i)) 	 		, 
			op2 	    =>	signed(op2(i))  	 	, 
			op3 	    =>	signed(op3(i)) 			, 
			funct	    =>	RD_EXE_Instructions(i).funct(2 downto 0), 
			cin  	    =>	'0'  					 ,  -- To be added later for supporting adc inst
			vcsr_quant  =>  vcsr_quant			     ,  -- From vector CSR Register
			y    	    =>	ALU_y(i)    	 		 , 
			cout 	    =>	ALU_cout(i) 	 		 , 
			overflow    =>	ALU_overflow(i) 		 , 
			underflow   =>	ALU_underflow(i)		 	
		);
	end generate GEN_ALUs;
------------------------------------------------------


GEN_DIVIDERs:
	for i in 0 to 7 generate
	multicycle_ops_gen:  multicycle_ops generic map(32)
	port map
	(
		clk 		=>	clk					,
        reset		=>	reset				,
		funct		=>  Instructions(i).funct(1 downto 0),
		op1 		=>	op1(i)				,
        op2 		=>	op2(i)				,
        div_op   	=>  div_op(i)			,
		BUSY		=>	DIV_BUSY(i)			,
		divbyzero 	=>	divbyzero(i)		,
        start 		=>	Instructions(i).funct(3)		
	);
	end generate GEN_DIVIDERs;
------------------------------------------------------
GEN_VRFS:
	for i in 0 to 7 generate
	vrf_gen: vrf_bank generic map(32) 
	port map 
	( 
		clk 	 	=> clk 				    , 
		reset 	 	=> reset 			    , 
		bankID      => i            	    , 
		wr_count	=> MEM_WB_counts(i)	    ,  	
		rd_count	=> counts(i)	        ,  	
		shift_count => shift_count(i)       , 
		DONE		=> DONEs_internal(i) 	, 
		vl			=> vl					, 
		vd		 	=> vd_VEC_CPU(i)		, 	-- From VEC/CPU
		vs1		 	=> vs1_VEC_CPU(i)		, 	-- From VEC/CPU	
		vs2		 	=> vs2(i)				, 			
		vs3		 	=> vs3(i)				, 			
		vs4		 	=> vs4(i)				, 			
		DATA_WR	 	=> REG_DATA_WR_VEC_CPU(i) ,	-- From VEC/CPU	
		WE		 	=> VREG_WE_VEC_CPU(i)	, -- For VEC and CPU
		v0_DATA		=> v0_DATA(i)			,	
		DATA_RD1 	=> DATA_RD1(i)			,	
		DATA_RD2 	=> DATA_RD2(i)			,
		DATA_RD3 	=> DATA_RD3(i)			,
		DATA_RD4 	=> DATA_RD4(i)			
	);
	end generate GEN_VRFS;
------------------------------------------------------

GEN_LSUs:
	for i in 0 to 7 generate
	lsu_gen: lsu port map(
		RS1			=> RD_EXE_Instructions(i).RS1,
		RS2			=> RD_EXE_Instructions(i).RS2,
		MODE    	=> RD_EXE_Instructions(i).mode_lsu,
		count       => RD_EXE_counts(i),
		V_OFFSET	=> RD_EXE_DATA_RD2(i),
		y_prev  	=> EXE_MEM_LSU_y(i),
		y       	=> LSU_y(i)
		);
		end generate GEN_LSUs;
------------------------------------------------------

		gen_stall: stall_gen port map(
			clk			=> clk					,
			reset		=> reset				,
			stall_in	=> stalls_internal_ored ,
			stall_out   => stall_q				
		);

------------------------------------------------------	
	-- DMEM Interface XBAR
	DMEM_INF: dmem_xbar generic map(DMEM_ADDR_WIDTH=>VMEM_ADDR_WIDTH) 
	port map(
		WR_ADDR 		=> EXE_MEM_LSU_y,
		RD_ADDR 		=> MEM_WB_LSU_y ,
		DIN				=> dmem_din,
		DATA_RD_IN		=> DMEM_DATA,
		WE          	=> DMEM_WE,
		RE          	=> DMEM_RE,
		PortA_ADDR  	=> DMEM_ADDR_Xbar,
		PortA_WE    	=> DMEM_WE_Xbar ,   
		PortA_DIN   	=> dmem_din_Xbar ,  
		DATA_RD_OUT 	=> DMEM_DATA_Xbar
	);
------------------------------------------------------	
	
-- DMEMs
DMEM0: DMEM_0 port map(
    clka 	=> clk,
    wea(0) 	=> DMEM_WE_VEC_CPU(0),
    addra 	=> DMEM_ADDR_VEC_CPU(0),
    dina 	=> DMEM_DIN_VEC_CPU(0),
    douta 	=> DMEM_DATA(0)
);
 
DMEM1: DMEM_1 port map(
    clka 	=> clk,
    wea(0) 	=> DMEM_WE_VEC_CPU(1),
    addra 	=> DMEM_ADDR_VEC_CPU(1),
    dina 	=> DMEM_DIN_VEC_CPU(1),
    douta 	=> DMEM_DATA(1)

);
 
DMEM2: DMEM_2 port map(
    clka 	=> clk,
    wea(0) 	=> DMEM_WE_VEC_CPU(2),
    addra 	=> DMEM_ADDR_VEC_CPU(2),
    dina 	=> DMEM_DIN_VEC_CPU(2),
    douta 	=> DMEM_DATA(2)
);

DMEM3: DMEM_3 port map(
    clka 	=> clk,
    wea(0) 	=> DMEM_WE_VEC_CPU(3),
    addra 	=> DMEM_ADDR_VEC_CPU(3),
    dina 	=> DMEM_DIN_VEC_CPU(3),
    douta 	=> DMEM_DATA(3)
);

DMEM4: DMEM_4 port map(
    clka 	=> clk,
    wea(0) 	=> DMEM_WE_VEC_CPU(4),
    addra 	=> DMEM_ADDR_VEC_CPU(4),
    dina 	=> DMEM_DIN_VEC_CPU(4),
    douta 	=> DMEM_DATA(4)
);

DMEM5: DMEM_5 port map(
    clka 	=> clk,
    wea(0) 	=> DMEM_WE_VEC_CPU(5),
    addra 	=> DMEM_ADDR_VEC_CPU(5),
    dina 	=> DMEM_DIN_VEC_CPU(5),
    douta 	=> DMEM_DATA(5)
);

DMEM6: DMEM_6 port map(
    clka 	=> clk,
    wea(0) 	=> DMEM_WE_VEC_CPU(6),
    addra 	=> DMEM_ADDR_VEC_CPU(6),
    dina 	=> DMEM_DIN_VEC_CPU(6),
    douta 	=> DMEM_DATA(6)
);

DMEM7: DMEM_7 port map(
    clka 	=> clk,
    wea(0) 	=> DMEM_WE_VEC_CPU(7),
    addra 	=> DMEM_ADDR_VEC_CPU(7),
    dina 	=> DMEM_DIN_VEC_CPU(7),
    douta 	=> DMEM_DATA(7)
);

------------------------------------------------------
-- Xout registers to store Vector Units's Scalar outputs
X_REGS: Xoutreg port map
(
	    clk 		=>  clk		,
        reset 		=>  reset	,
        WDATA       =>  ALU_y   ,
        RDATA       =>  Xoutreg_data,
        WE          =>  Xoutreg_WE
); 
------------------------------------------------------	
--VMINMAX_FINDERS  
------------------------------------------------------
GEN_VMINMAX:
	for i in 0 to 7 generate
		vminmax_gen: vminmax generic map(32) 
		port map
			(
				clk       =>   clk       ,
				reset     =>   reset     ,
				clear     =>   I_clear   ,
				vl 		  =>   vl         ,
				op2       =>   signed(op2(i)) ,
				f_minmax  =>   RD_EXE_Instructions(i).funct(7 downto 4)  ,
				count     =>   RD_EXE_counts(i)     ,	
				y_minmax  =>   y_minmax(i)  	-- Available in EXE_MEM Stage
			);
	end generate GEN_VMINMAX;
------------------------------------------------------	
--INterface to Write Scalar Outputs from Vector Unit into Xregs(x0-x31)
-- Required Signals : XRF_ADDR(4 downto 0), XRF_DATA(31 downto 0), XRF_WE
end_cycle_XRF_DataWR <= ("000"&RD_EXE_Counts(0) - vl) when (("000"&EXE_MEM_Counts(0)) > vl) else (others=>'0');
end_cycle_XRF_Addr   <= ("000"&EXE_MEM_Counts(0) -  vl) when (("000"&MEM_WB_Counts(0)) > vl ) else (others=>'0');

XRF_Write_gen: process(clk,reset)
begin
	if reset = '1' then
		XRF_WE <= '0';
	elsif rising_edge(clk) then
		if i_clear = '1' then
			XRF_WE <= '0';
		else
			case end_cycle_XRF_DataWR(4 downto 0) is
				when "00000"	=> XRF_WE <= Instructions(0).Xout;
				when "00001"	=> XRF_WE <= Instructions(1).Xout;
				when "00010"	=> XRF_WE <= Instructions(2).Xout;
				when "00011"	=> XRF_WE <= Instructions(3).Xout;
				when "00100"	=> XRF_WE <= Instructions(4).Xout;
				when "00101"	=> XRF_WE <= Instructions(5).Xout;
				when "00110"	=> XRF_WE <= Instructions(6).Xout;
				when "00111"	=> XRF_WE <= Instructions(7).Xout;
				when others => XRF_WE <= '0';
			end case;
		end if;
	end if;
end process XRF_Write_gen;
------------------------------------------------------	
XRF_ADDR_DATA_gen: process(y_minmax, Instructions,end_cycle_XRF_Addr)
begin
	case end_cycle_XRF_Addr(4 downto 0) is
		-----------------------------------------
		when "00000"		=> 
			if Instructions(0).Xout = '1' then 
				XRF_DataWR 	<= y_minmax(0); 	
				XRF_Addr 	<= Instructions(0).vd; 
			else
				XRF_DataWR  <= (others=>'0');
				XRF_Addr    <= (others=>'0');
			end if;
		-----------------------------------------
		when "00001"	=> 
			if Instructions(1).Xout = '1' then 
				XRF_DataWR <= y_minmax(1); 	
				XRF_Addr   <= Instructions(1).vd;
			else
				XRF_DataWR  <= (others=>'0');
				XRF_Addr    <= (others=>'0');
			end if;
		-----------------------------------------
		when "00010"	=> 
		if Instructions(2).Xout = '1' then 
			XRF_DataWR <= y_minmax(2); 	
			XRF_Addr   <= Instructions(2).vd;
			else
			XRF_DataWR  <= (others=>'0');
			XRF_Addr    <= (others=>'0');
		end if;
	-----------------------------------------
		when "00011"	=> 
		if Instructions(3).Xout = '1' then 
			XRF_DataWR <= y_minmax(3); 	
			XRF_Addr   <= Instructions(3).vd;
		else
			XRF_DataWR  <= (others=>'0');
			XRF_Addr    <= (others=>'0');
		end if;
	-----------------------------------------
		when "00100"	=> 
		if Instructions(4).Xout = '1' then 
			XRF_DataWR <= y_minmax(4); 	
			XRF_Addr   <= Instructions(4).vd;
		else
			XRF_DataWR  <= (others=>'0');
			XRF_Addr    <= (others=>'0');
		end if;
	-----------------------------------------	
		when "00101"	=> 
			if Instructions(5).Xout = '1' then 
				XRF_DataWR <= y_minmax(5); 	
				XRF_Addr   <= Instructions(5).vd;
			else
				XRF_DataWR  <= (others=>'0');
				XRF_Addr    <= (others=>'0');
			end if;
		-----------------------------------------	
		when "00110"	=> 
			if Instructions(6).Xout = '1' then 
				XRF_DataWR <= y_minmax(6); 	
				XRF_Addr   <= Instructions(6).vd;
			else
				XRF_DataWR  <= (others=>'0');
				XRF_Addr    <= (others=>'0');
		end if;
	-----------------------------------------
		when "00111"	=> 
			if Instructions(7).Xout = '1' then 
				XRF_DataWR <= y_minmax(7); 	
				XRF_Addr   <= Instructions(7).vd;
			else
				XRF_DataWR  <= (others=>'0');
				XRF_Addr    <= (others=>'0');
			end if;
		-----------------------------------------
		when others => 
			XRF_DataWR <= (others=>'0');
			XRF_Addr    <= (others=>'0');
	end case;
end process XRF_ADDR_DATA_gen;

-----------------------------------------------------	
-- CPU INterface
VECTOR_CPU_INF: cpu_inf generic map(DMEM_ADDR_WIDTH=>VMEM_ADDR_WIDTH) 
		   port map(
		   clk			 => clk			 ,
		   reset		 => reset		 ,
		   ADDR_IN       => PROC_ADDR	 ,
		   DMEM_DATA_RD  => DMEM_DATA	 ,
		   VREG_DATA_RD  => DATA_RD1	 ,
		   WE_IN         => PROC_WE		 ,
		   vs1           => vs1_cpu		 ,
		   vd            => vd_cpu		 ,
		   mem_addr      => DMEM_ADDR_CPU,
		   DMEM_WE       => DMEM_WE_CPU  ,
		   VREG_WE       => VREG_WE_CPU	 ,
		   dout          => PROC_DOUT	 
		  );
------------------------------------------------------	
-- CPU INterface
VECTOR_CPU_MUX: process(vs1, vd, vs1_CPU, vd_CPU, DMEM_WE_Xbar, DMEM_ADDR_Xbar, dmem_din_xbar,
						DMEM_ADDR_CPU, PROC_DIN, DONE_int, DMEM_WE_CPU, VREG_WE_CPU,REG_DATA_WR, VREG_WE)

begin
	if DONE_int = '1' then -- CPU Access Case
		for i in 0 to 7 loop
			-- DMEM Signals
			DMEM_ADDR_VEC_CPU(i)  <= DMEM_ADDR_CPU;
			DMEM_DIN_VEC_CPU(i)   <= PROC_DIN ;
			DMEM_WE_VEC_CPU(i)    <= DMEM_WE_CPU(i);
			--VREG Signals
			vs1_VEC_CPU(i)		  <= vs1_cpu;
			vd_VEC_CPU(i)		  <= vd_cpu;
			REG_DATA_WR_VEC_CPU(i)<= PROC_DIN;
			VREG_WE_VEC_CPU(i)    <= VREG_WE_CPU(i);
		end loop;
	else
	for i in 0 to 7 loop
		-- DMEM Signals
		DMEM_ADDR_VEC_CPU(i)  <= DMEM_ADDR_Xbar(i);
		DMEM_DIN_VEC_CPU(i)   <= dmem_din_Xbar(i) ;
		DMEM_WE_VEC_CPU(i)    <= DMEM_WE_Xbar(i);
		--VREG Signals
		vs1_VEC_CPU(i)		  <= vs1(i);
		vd_VEC_CPU(i)		  <= vd(i);
		REG_DATA_WR_VEC_CPU(i)<= REG_DATA_WR(i);
		VREG_WE_VEC_CPU(i)    <= VREG_WE(i);
	end loop;	
	end if;
end process VECTOR_CPU_MUX;	
------------------------------------------------------	

DMEM_WE_GEN: process(MEM_WB_DONEs, DONEs_internal, EXE_MEM_Instructions,MASK_VECTOR_DMEMWR)
begin
	for i in 0 to 7 loop
		if EXE_MEM_Instructions(i).MASK_EN ='1' then
			DMEM_WE(i) <= EXE_MEM_Instructions(i).dmw and 
						((not(DONEs_internal(i))) OR (not (MEM_WB_DONEs(((i) mod 8))))) and
						MASK_VECTOR_DMEMWR(to_integer(unsigned(EXE_MEM_counts(i))));
		else
		DMEM_WE(i) <= EXE_MEM_Instructions(i).dmw and 
					 ((not(DONEs_internal(i))) OR (not (MEM_WB_DONEs(((i) mod 8)))));
		end if;

		DMEM_RE(i) <= EXE_MEM_Instructions(i).dmr ;
	end loop;
end process DMEM_WE_GEN;
------------------------------------------------------	
slide_val <= Instructions(0).permute OR Instructions(1).permute OR
			 Instructions(2).permute OR Instructions(3).permute OR
			 Instructions(4).permute OR Instructions(5).permute OR
			 Instructions(6).permute OR Instructions(7).permute ;
------------------------------------------------------		
-- Crossbar to route Reg-banks and ALUs
---------------------------------------------------------
read_xbar: process(counts,DATA_RD1,DATA_RD2,DATA_RD3,DATA_RD4, Instructions,slide_val)
variable count_id  : integer range 0 to 7;
variable offset_vs4: integer range 0 to 4;
variable sum       : integer range -7 to 7;
begin
	count_id := to_integer(unsigned(counts(0))) mod 8;
	
	-------------------------------------------------------------
	for i in 0 to 7 loop
	   offset_vs4 := to_integer(unsigned(slide_val));
	-- Configure INputs to VRF bank inputs to lanes
		vs1(i) 	 <= Instructions(((8-i+count_id) mod 8)).vs1;
		vs2(i) 	 <= Instructions(((8-i+count_id) mod 8)).vs2;
		vs3(i) 	 <= Instructions(((8-i+count_id) mod 8)).vd;	--Instructions.vd
		vs4(i) 	 <= Instructions(((8-i+count_id+offset_vs4) mod 8)).vs2;	--Vector Slide Down 

		-------------------------------------------------------------
		-- Configure Inputs to ALU
		-- OPerand 1
		op1_XbarOut(i) 	<= DATA_RD1(((8-i+count_id) mod 8));		
		-------------------------------------------------------
		---Operand 2
		op2_XbarOut(i)  <= DATA_RD2(((8-i+count_id) mod 8));						
		-------------------------------------------------------
		---Operand 3
		op3_XbarOut(i)  <= DATA_RD3(((8-i+count_id) mod 8));				
		-------------------------------------------------------
        ---Operand for Permutation
		op4_XbarOut((i) mod 8)  <= 	DATA_RD4(((8-i+count_id+offset_vs4) mod 8));				
	end loop;
		-------------------------------------------------------------
end process read_xbar;

---------------------------------------------------------
-- MEM REG MUX in WB Stages
MEM_WB_MUX: process(MEM_WB_Instructions,MEM_WB_ALU_y,DMEM_DATA_Xbar)
begin
	for i in 0 to 7 loop
		if MEM_WB_Instructions(i).mem_reg = '0' then
			MEM_WB_DATA(i) <= std_logic_vector(MEM_WB_ALU_y(i));
		else
			MEM_WB_DATA(i) <= std_logic_vector(DMEM_DATA_Xbar(i));
		end if;
	end loop;
end process MEM_WB_MUX;
---------------------------------------------------------
--VREG_WRITE_DATA XBAR
-- Write Logic to Vector Destination Registers
-- 
vreg_write_xbar: process(MEM_WB_counts,MEM_WB_DATA,MEM_WB_Instructions,MASK_VECTOR_VREGWR,DONEs_internal,WB_FIN_DONEs)
variable count_mem : integer range 0 to 7;
begin
	count_mem := to_integer(unsigned(MEM_WB_counts(0))) mod 8;
	for i in 0 to 7 loop
		-- Register Bank Write Data Router
		REG_DATA_WR(i) <= MEM_WB_DATA(((8-i+count_mem) mod 8));
		-- Register Bank vd Router
		vd(i)      	   <= MEM_WB_Instructions(((8-i+count_mem) mod 8)).vd;
		-- Register Bank Masked Write Enable Router
		if MEM_WB_Instructions(i).MASK_EN = '1' then
			-------------------------------------------------------------------------------------------------
				VREG_WE(i)  <= MEM_WB_Instructions(((8-i+count_mem) mod 8)).REG_WE and
							  MASK_VECTOR_VREGWR(to_integer(unsigned(MEM_WB_counts(i)))) and 
							  ((not (DONEs_internal(((8-i+count_mem) mod 8)))) or (not (WB_FIN_DONEs(((8-i+count_mem) mod 8)))));
			-------------------------------------------------------------------------------------------------
		else								-- IF Vector Mask is Disabled
				VREG_WE(i)  <= MEM_WB_Instructions(((8-i+count_mem) mod 8)).REG_WE and ((not (DONEs_internal(((8-i+count_mem) mod 8)))) or (not (WB_FIN_DONEs(((8-i+count_mem) mod 8)))));	
			-------------------------------------------------------------------------------------------------
		end if;
	end loop;
end process vreg_write_xbar;

---------------------------------------------------------
Xoutreg_WE_gen: process(RD_EXE_Instructions,MASK_VECTOR_VREGWR, DONEs_internal, EXE_MEM_DONEs,RD_EXE_Counts)
begin 
	for i in 0 to 7 loop
		if RD_EXE_Instructions(i).MASK_EN = '1' then
			--------------------------------------------------------------------------------------
				Xoutreg_WE(i)	<= 	RD_EXE_Instructions(i).Xout 						and 
									MASK_VECTOR_VREGWR(to_integer(unsigned(MEM_WB_counts(i)))) 	and 
									(	(not (DONEs_internal(((i))))) or (not (EXE_MEM_DONEs(i))));
		else		-- IF Vector Mask is NOT enabled
			--------------------------------------------------------------------------------------
				Xoutreg_WE(i)	<= 	RD_EXE_Instructions(i).Xout 						and 
									(	(not (DONEs_internal(((i))))) or (not (EXE_MEM_DONEs(i))));				
		end if;
	end loop;
end process	Xoutreg_WE_gen;

---------------------------------------------------------
--PIPELINE
-- Stages
	-- RD
	-- EXE
	-- MEM
	-- WB
---------------------------------------------------------
Read_Stage: process(clk,reset)
begin
	if reset = '1' then
		RD_EXE_Instructions <= (others=>i_rec_init);
		for i in 0 to 7 loop
		    RD_EXE_DONEs(i)    <= '1';
			RD_EXE_DATA_RD1(i) <= (others=>'0');
			RD_EXE_DATA_RD2(i) <= (others=>'0');
			RD_EXE_DATA_RD3(i) <= (others=>'0');
			RD_EXE_DATA_RD4(i) <= (others=>'0');
			RD_EXE_v0_DATA(i)  <= (others=>'0');
			RD_EXE_counts(i)   <= (others=>'0');
		end loop;
	elsif rising_edge(clk) then
		for i in 0 to 7 loop
			if RD_EXE_count_en = '1' then
				RD_EXE_Instructions(i) <= Instructions(i);
				RD_EXE_DATA_RD1(i) <= op1_XbarOut(i);
				RD_EXE_DATA_RD2(i) <= op2_XbarOut(i);
				RD_EXE_DATA_RD3(i) <= op3_XbarOut(i);
				RD_EXE_DATA_RD4(i) <= op4_XbarOut(i); --Forwarding Not Planned
				RD_EXE_v0_DATA(i)  <= v0_DATA(i);
				RD_EXE_counts(i)   <= counts(i);
				RD_EXE_DONEs(i)    <= DONEs_internal(i);
			end if;
		end loop;
	end if;
end process Read_Stage;
---------------------------------------------------------
Exe_Stage: process(clk,reset)
begin
	if reset = '1' then
		EXE_MEM_Instructions <= (others=>i_rec_init);
		for i in 0 to 7 loop
		    EXE_MEM_DONEs(i)    <= '1';
			EXE_MEM_ALU_y(i) 	<= (others=>'0');
			EXE_MEM_DATA_RD2(i) <= (others=>'0');
			EXE_MEM_DATA_RD3(i) <= (others=>'0');
			EXE_MEM_v0_DATA(i) 	<= (others=>'0');
			EXE_MEM_LSU_y(i)    <= (others=>'0');
			EXE_MEM_counts(i)   <= (others=>'0');
		end loop;
	elsif rising_edge(clk) then
		for i in 0 to 7 loop
			EXE_MEM_Instructions(i) <= RD_EXE_Instructions(i);
			EXE_MEM_DATA_RD2(i)     <= op2(i);	-- Has forwarded Contents .. May not be required "{}Make sure ALUSrc is 0 for Stores! " ??
			EXE_MEM_DATA_RD3(i)     <= op3(i);	-- EXE Chained --> MEM Chained --> Vector Store
			EXE_MEM_v0_DATA(i)      <= RD_EXE_v0_DATA(i);
			if RD_EXE_Instructions(i).funct(3) = '1' then	--Multicycle Instruction case
				EXE_MEM_ALU_y(i)	<= div_op(i);
			elsif v_permute_en(i) = '1' then    -- Permutation operation
			    EXE_MEM_ALU_y(i)    <=  RD_EXE_DATA_RD4(i);
            else
                EXE_MEM_ALU_y(i)    <=  std_logic_vector(ALU_y(i));
            end if;			
			EXE_MEM_counts(i)       <= RD_EXE_counts(i);
			EXE_MEM_LSU_y(i)    	<= LSU_y(i);
			EXE_MEM_DONEs(i)        <= RD_EXE_DONEs(i);
		end loop;
	end if;
end process Exe_Stage;

---------------------------------------------------------
Mem_Stage: process(clk,reset)
begin
	if reset = '1' then
		MEM_WB_Instructions <= (others=>i_rec_init);
		for i in 0 to 7 loop
		    MEM_WB_DONEs(i)     <= '1';
			MEM_WB_ALU_y(i) 	<= (others=>'0');
			MEM_WB_v0_DATA(i)   <= (others=>'0');
			MEM_WB_counts(i)   <= (others=>'0');
			MEM_WB_LSU_y(i)    <=  (others=>'0');
		end loop;
	elsif rising_edge(clk) then
		for i in 0 to 7 loop
			MEM_WB_Instructions(i) <= EXE_MEM_Instructions(i);
            MEM_WB_ALU_y(i)    	   <= EXE_MEM_ALU_y(i);
			MEM_WB_v0_DATA(i)      <= EXE_MEM_v0_DATA(i);
			MEM_WB_counts(i)       <= EXE_MEM_counts(i);
			MEM_WB_DONEs(i)        <= EXE_MEM_DONEs(i);
			MEM_WB_LSU_y(i)        <= EXE_MEM_LSU_y(i);
			
		end loop;
	end if;
end process Mem_Stage;

---------------------------------------------------------
Fin_Stage: process(clk,reset)
begin
	if reset = '1' then
		WB_FIN_Instructions <= (others=>i_rec_init);
		for i in 0 to 7 loop
			WB_FIN_DONEs(i) <= '1';
			WB_FIN_DATA(i) <= (others=>'0');
			WB_FIN_counts(i) <= (others=>'0');
		end loop;
	elsif rising_edge(clk) then
		for i in 0 to 7 loop
			WB_FIN_Instructions(i)  <= MEM_WB_Instructions(i);
			WB_FIN_counts(i)        <=  MEM_WB_counts(i);
			--if count_enable = '1' then
				WB_FIN_DONEs(i) <= MEM_WB_DONEs(i);
		   -- end if;
			if MEM_WB_Instructions(i).mem_reg = '1' then
				WB_FIN_DATA(i) 			<= DMEM_DATA_Xbar(i);
			else
				WB_FIN_DATA(i) 			<= MEM_WB_ALU_y(i);
		    end if;
		end loop;
	end if;
end process Fin_Stage;

-------------------------------------------------------------------------------------------------------
-- Vector Chaining Logic -- 
-------------------------------------------------------------------------------------------------------
-- POssible Cases Identified for Chaining
-- (1)From (i-1)th instruction
		--> EX Stage Chaining
			-->a. EXE_MEM of (i-1)th instruction
		--> MEM Stage Chaining
			-->b. MEM_WB(i-1)-- IN Load-Use Case {With Stall}
		---*-_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
-- (2) From (i-2)th instruction
		-- EXE Stage Chaining
			--> MEM_WB(i-2)	
		-- MEM Stage Chaining
			--> WB_FIN(i-2)	-- IN case of  (a) MAC(i-2) --> Something(i-1) --> MAC(i) when the vd's match
							--             (b) Something(i-2) --> Something(i-1) --> Store(i) when their vs2's match  
		--> During Stalls, no Chaining would be required from (i-2)th instruction 
		---*-_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
-- (3) From (i-3)th instruction
		-->	EX Stage Chaining
			--> WB_FIN(i-3)
		--> During Stalls, no Chaining would be required from (i-3)th instruction
		---*-_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
--		|---------------------------------+
--		|-- Chaining table              --|
--		|-- E_FA   |  Data To be Chained  |
--		|---------------------------------|
--		|-- others |  No Chaining         |
--		|-- 001    |  EX_MEM(i-1)         |
--		|-- 010    |  MEM_WB(i-1)         |
--		|-- 011    |  MEM_WB(i-2)         |
--		|-- 100    |  WB_FIN(i-3)         |
--		|---------------------------------+
--	NOTE: Forwarding shall not be done if a previous instruction has scalar outputs. {Xout=1]
------------------------------------------------------------------------------------------
-- /()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()
--             EX STAGE FORWARDING
-- /()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()
op1_chain: process(stalls_internal_ored,div_stalls_ored,EXE_MEM_Instructions,RD_EXE_Instructions,MEM_WB_Instructions,WB_FIN_Instructions,RD_EXE_counts)
begin
	if stalls_internal_ored = '1' then 
		------------------------------------
		-- IN this case, only MEM Harazd is possible
		for i in 0 to 7 loop
			-----------------------------1st Instruction Forwarding-----------------------------------
			if i = 0 then
				E_FA(0) <= "000";  -- No Chaining for 1st Instruction in the convoy
			-----------------------------All other instructions-----------------------------------
			else
				if	((MEM_WB_Instructions(i-1).REG_WE = '1') and 
					 (MEM_WB_Instructions(i-1).vd /="00000") and
					 (MEM_WB_Instructions(i-1).Xout = '0'  ) and  	
					 (MEM_WB_Instructions(i-1).vd = RD_EXE_Instructions(i).vs1)
					) then
						E_FA(i) <= "010";	-- MEM_WB(i-1)	
				else
						E_FA(i) <= "000";  -- No Forwarding
		
				end if;
			end if;
		end loop;
		--------------------------------------------------------
	elsif div_stalls_ored = '1' then
		------------------------------------
		-- IN this case, chaining is only required for the first element in the vector
		-- The other elements should read from their respective registers
		for i in 0 to 7 loop
			-----------------------------1st Instruction Forwarding-----------------------------------
			if i = 0 then
				E_FA(0) <= "000";  -- No Chaining for 1st Instruction in the convoy
			-----------------------------2nd Instructoins Forwarding-----------------------------------
			elsif i = 1 then
				if	RD_EXE_counts(i) = "000000" then	-- Only for 0th element
					if( (EXE_MEM_Instructions(0).REG_WE = '1') and 
						(EXE_MEM_Instructions(0).vd /="00000") and
						(EXE_MEM_Instructions(0).Xout = '0'  ) and  
						(EXE_MEM_Instructions(0).vd = RD_EXE_Instructions(1).vs1)
					  ) then
							E_FA(1) <= "001";	-- EX_MEM(i-1)
					 else
					       E_FA(1) <= "000";
					 end if;
			     else
			         E_FA(1) <= "000";
			     end if;
			 --------------------------------------------------------------
			 -- Instruction 3
			 elsif i = 2 then
			     if	RD_EXE_counts(i) = "000000" then	-- Only for 0th element
					if( (EXE_MEM_Instructions(1).REG_WE = '1') and 
						(EXE_MEM_Instructions(1).vd /="00000") and
						(EXE_MEM_Instructions(1).Xout = '0'  ) and  
					    (EXE_MEM_Instructions(1).vd = RD_EXE_Instructions(2).vs1)
				       ) then
					       E_FA(i) <= "001";	-- EX_MEM(i-1)
					
				    elsif(  (MEM_WB_Instructions(0).REG_WE = '1') and 
							(MEM_WB_Instructions(0).vd /="00000") and
							(MEM_WB_Instructions(0).Xout = '0'  ) and  
						    (MEM_WB_Instructions(0).vd = RD_EXE_Instructions(2).vs1)
				          ) then
					       E_FA(i) <= "011";	-- MEM_WB(i-2) Stage Data		
				    else
					       E_FA(i) <= "000";	-- Register  Data
				    end if;	
				  else
				    		E_FA(i) <= "000";	-- Register  Data
				  end if;     
			 --------------------------------------------------------------
               -- For Instructions 4,5,6,7
			 else
			     if	RD_EXE_counts(i) = "000000" then	-- Only for 0th element
				        if( (EXE_MEM_Instructions(i-1).REG_WE = '1') and 
							(EXE_MEM_Instructions(i-1).vd /="00000") and
							(EXE_MEM_Instructions(i-1).Xout = '0'  ) and  
					        (EXE_MEM_Instructions(i-1).vd = RD_EXE_Instructions(i).vs1)
				           ) then
					           E_FA(i) <= "001";	-- EX_MEM(i-1)			 
					     elsif(	(MEM_WB_Instructions(i-2).REG_WE = '1') and 
						 		(MEM_WB_Instructions(i-2).vd /="00000") and
						 		(MEM_WB_Instructions(i-2).Xout = '0'  ) and  
							    (MEM_WB_Instructions(i-2).vd = RD_EXE_Instructions(i).vs1)
						      ) then
							     E_FA(i) <= "011";	-- MEM_WB(i-2)	
					     elsif(  (WB_FIN_Instructions(i-3).REG_WE = '1') and 
						 		 (WB_FIN_Instructions(i-3).vd /="00000") and
						 		 (WB_FIN_Instructions(i-3).Xout = '0'  ) and  
							     (WB_FIN_Instructions(i-3).vd = RD_EXE_Instructions(i).vs1)
						          ) then
							     E_FA(i) <= "100";	-- WB_FIN Stage Data					  					
					     else
						         E_FA(i) <= "000";  -- No Forwarding
						 end if;
					else
					   E_FA(i) <= "000"; -- No Forwarding
					end if;
				end if;
		end loop;	
	else
		--------------------------------------------------------
		--         No Stall Case
		--         Hazards List
		--         EX_MEM(i-1)
		--         MEM_WB(i-2)
		--         WB_FIN(i-3)
		--------------------------------------------------------
		for i in 0 to 7 loop
			-----------------------------1st Instruction Forwarding-----------------------------------
			if i = 0 then
				E_FA(0) <= "000";  -- No Chaining for 1st Instruction in the convoy
			-----------------------------2nd Instruction Forwarding-----------------------------------
			elsif i = 1 then
				if( (EXE_MEM_Instructions(0).REG_WE = '1') and    -- Previ Instruction writes to Reg
					(EXE_MEM_Instructions(0).vd /="00000") and
					(EXE_MEM_Instructions(0).Xout = '0'  ) and  
					(EXE_MEM_Instructions(0).vd = RD_EXE_Instructions(1).vs1)
				) then
					E_FA(1) <= "001";	-- EX_MEM(i-1)
				
				else
					E_FA(1) <= "000";	-- Register Data
					
				end if;
			-----------------------------3rd Instruction Forwarding-----------------------------------
			elsif i = 2 then
				if( (EXE_MEM_Instructions(1).REG_WE = '1') and 
					(EXE_MEM_Instructions(1).vd /="00000") and
					(EXE_MEM_Instructions(1).Xout = '0'  ) and  
					(EXE_MEM_Instructions(1).vd = RD_EXE_Instructions(2).vs1)
				) then
					E_FA(2) <= "001";	-- EX_MEM(i-1)
					
				elsif(  (MEM_WB_Instructions(0).REG_WE = '1') and 
						(MEM_WB_Instructions(0).vd /="00000") and
						(MEM_WB_Instructions(0).Xout = '0'  ) and  
						(MEM_WB_Instructions(0).vd = RD_EXE_Instructions(2).vs1)
				) then
					E_FA(2) <= "011";	-- MEM_WB(i-2) Stage Data		
				else
					E_FA(2) <= "000";	-- Register  Data
				end if;	
			------------------------------4,5,6,7 Instruction Forwarding-----------------------------------
			else
				if( (EXE_MEM_Instructions(i-1).REG_WE = '1') and 
					(EXE_MEM_Instructions(i-1).vd /="00000") and
					(EXE_MEM_Instructions(i-1).Xout = '0'  ) and  
					(EXE_MEM_Instructions(i-1).vd = RD_EXE_Instructions(i).vs1)
				) then
					E_FA(i) <= "001";	-- EX_MEM(i-1)
					
				elsif(  (MEM_WB_Instructions(i-2).REG_WE = '1') and 
						(MEM_WB_Instructions(i-2).vd /="00000") and
						(MEM_WB_Instructions(i-2).Xout = '0'  ) and  
						(MEM_WB_Instructions(i-2).vd = RD_EXE_Instructions(i).vs1)
				) then
					E_FA(i) <= "011";	-- MEM_WB(i-2) Stage Data	
					
				elsif( (WB_FIN_Instructions(i-3).REG_WE = '1') and 
					   (WB_FIN_Instructions(i-3).vd /="00000") and
					   (WB_FIN_Instructions(i-3).Xout = '0'  ) and  
					   (WB_FIN_Instructions(i-3).vd = RD_EXE_Instructions(i).vs1)
				) then
					E_FA(i) <= "100";	-- WB_FIN Stage Data	
					
				else
					E_FA(i) <= "000";	-- Register  Data
					
				end if;
			end if;				
		end loop;
	end if;
end process op1_chain;	
		
---------------------------------------------------------
-------OPerand 2 Chaining Logic                  --------
---------------------------------------------------------
op2_chain: process(stalls_internal_ored,div_stalls_ored,EXE_MEM_Instructions,RD_EXE_Instructions,MEM_WB_Instructions,WB_FIN_Instructions,RD_EXE_counts)
begin
	if stalls_internal_ored = '1' then 
		------------------------------------
		-- IN this case, only MEM Harazd is possible
		for i in 0 to 7 loop
			-----------------------------1st Instruction Forwarding-----------------------------------
			if i = 0 then
				E_FB(0) <= "000";  -- No Chaining for 1st Instruction in the convoy
			-----------------------------All other instructions-----------------------------------
			else
				if	((MEM_WB_Instructions(i-1).REG_WE = '1') and 
					 (MEM_WB_Instructions(i-1).vd /="00000") and
					 (MEM_WB_Instructions(i-1).Xout = '0'  ) and  	
					 (MEM_WB_Instructions(i-1).vd = RD_EXE_Instructions(i).vs2)
					) then
						E_FB(i) <= "010";	-- MEM_WB(i-1)	
				else
						E_FB(i) <= "000";  -- No Forwarding
		
				end if;
			end if;
		end loop;
		--------------------------------------------------------
	elsif div_stalls_ored = '1' then
		------------------------------------
		-- IN this case, chaining is only required for the first element in the vector
		-- The other elements should read from their respective registers
		for i in 0 to 7 loop
			-----------------------------1st Instruction Forwarding-----------------------------------
			if i = 0 then
				E_FB(0) <= "000";  -- No Chaining for 1st Instruction in the convoy
			-----------------------------2nd Instructoins Forwarding-----------------------------------
			elsif i = 1 then
				if	RD_EXE_counts(i) = "000000" then	-- Only for 0th element
					if( (EXE_MEM_Instructions(0).REG_WE = '1') and 
						(EXE_MEM_Instructions(0).vd /="00000") and
						(EXE_MEM_Instructions(0).Xout = '0'  ) and  
						(EXE_MEM_Instructions(0).vd = RD_EXE_Instructions(1).vs2)
					  ) then
							E_FB(1) <= "001";	-- EX_MEM(i-1)
					 else
					       E_FB(1) <= "000";
					 end if;
			     else
			         E_FB(1) <= "000";
			     end if;
			 --------------------------------------------------------------
			 -- Instruction 3
			 elsif i = 2 then
			     if	RD_EXE_counts(i) = "000000" then	-- Only for 0th element
					if( (EXE_MEM_Instructions(1).REG_WE = '1') and 
						(EXE_MEM_Instructions(1).vd /="00000") and
						(EXE_MEM_Instructions(1).Xout = '0'  ) and  
					    (EXE_MEM_Instructions(1).vd = RD_EXE_Instructions(2).vs2)
				       ) then
					       E_FB(i) <= "001";	-- EX_MEM(i-1)
					
				    elsif(  (MEM_WB_Instructions(0).REG_WE = '1') and 
							(MEM_WB_Instructions(0).vd /="00000") and
							(MEM_WB_Instructions(0).Xout = '0'  ) and  
						    (MEM_WB_Instructions(0).vd = RD_EXE_Instructions(2).vs2)
				          ) then
					       E_FB(i) <= "011";	-- MEM_WB(i-2) Stage Data		
				    else
					       E_FB(i) <= "000";	-- Register  Data
				    end if;	
				  else
				    		E_FB(i) <= "000";	-- Register  Data
				  end if;     
			 --------------------------------------------------------------
               -- For Instructions 4,5,6,7
			 else
			     if	RD_EXE_counts(i) = "000000" then	-- Only for 0th element
				        if( (EXE_MEM_Instructions(i-1).REG_WE = '1') and 
							(EXE_MEM_Instructions(i-1).vd /="00000") and
							(EXE_MEM_Instructions(i-1).Xout = '0'  ) and  
					        (EXE_MEM_Instructions(i-1).vd = RD_EXE_Instructions(i).vs2)
				           ) then
					           E_FB(i) <= "001";	-- EX_MEM(i-1)			 
					     elsif(	(MEM_WB_Instructions(i-2).REG_WE = '1') and 
						 		(MEM_WB_Instructions(i-2).vd /="00000") and
						 		(MEM_WB_Instructions(i-2).Xout = '0'  ) and  
							    (MEM_WB_Instructions(i-2).vd = RD_EXE_Instructions(i).vs2)
						      ) then
							     E_FB(i) <= "011";	-- MEM_WB(i-2)	
					     elsif(  (WB_FIN_Instructions(i-3).REG_WE = '1') and 
						 		 (WB_FIN_Instructions(i-3).vd /="00000") and
						 		 (WB_FIN_Instructions(i-3).Xout = '0'  ) and  
							     (WB_FIN_Instructions(i-3).vd = RD_EXE_Instructions(i).vs2)
						          ) then
							     E_FB(i) <= "100";	-- WB_FIN Stage Data					  					
					     else
						         E_FB(i) <= "000";  -- No Forwarding
						 end if;
					else
					   E_FB(i) <= "000"; -- No Forwarding
					end if;
				end if;
		end loop;	
	else
		--------------------------------------------------------
		--         No Stall Case
		--         Hazards List
		--         EX_MEM(i-1)
		--         MEM_WB(i-2)
		--         WB_FIN(i-3)
		--------------------------------------------------------
		for i in 0 to 7 loop
			-----------------------------1st Instruction Forwarding-----------------------------------
			if i = 0 then
				E_FB(0) <= "000";  -- No Chaining for 1st Instruction in the convoy
			-----------------------------2nd Instruction Forwarding-----------------------------------
			elsif i = 1 then
				if( (EXE_MEM_Instructions(0).REG_WE = '1') and    -- Previ Instruction writes to Reg
					(EXE_MEM_Instructions(0).vd /="00000") and
					(EXE_MEM_Instructions(0).Xout = '0'  ) and  
					(EXE_MEM_Instructions(0).vd = RD_EXE_Instructions(1).vs2)
				) then
					E_FB(1) <= "001";	-- EX_MEM(i-1)
				
				else
					E_FB(1) <= "000";	-- Register Data
					
				end if;
			-----------------------------3rd Instruction Forwarding-----------------------------------
			elsif i = 2 then
				if( (EXE_MEM_Instructions(1).REG_WE = '1') and 
					(EXE_MEM_Instructions(1).vd /="00000") and
					(EXE_MEM_Instructions(1).Xout = '0'  ) and  
					(EXE_MEM_Instructions(1).vd = RD_EXE_Instructions(2).vs2)
				) then
					E_FB(2) <= "001";	-- EX_MEM(i-1)
					
				elsif(  (MEM_WB_Instructions(0).REG_WE = '1') and 
						(MEM_WB_Instructions(0).vd /="00000") and
						(MEM_WB_Instructions(0).Xout = '0'  ) and  
						(MEM_WB_Instructions(0).vd = RD_EXE_Instructions(2).vs2)
				) then
					E_FB(2) <= "011";	-- MEM_WB(i-2) Stage Data		
				else
					E_FB(2) <= "000";	-- Register  Data
				end if;	
			------------------------------4,5,6,7 Instruction Forwarding-----------------------------------
			else
				if( (EXE_MEM_Instructions(i-1).REG_WE = '1') and 
					(EXE_MEM_Instructions(i-1).vd /="00000") and
					(EXE_MEM_Instructions(i-1).Xout = '0'  ) and  
					(EXE_MEM_Instructions(i-1).vd = RD_EXE_Instructions(i).vs2)
				) then
					E_FB(i) <= "001";	-- EX_MEM(i-1)
					
				elsif(  (MEM_WB_Instructions(i-2).REG_WE = '1') and 
						(MEM_WB_Instructions(i-2).vd /="00000") and
						(MEM_WB_Instructions(i-2).Xout = '0'  ) and  
						(MEM_WB_Instructions(i-2).vd = RD_EXE_Instructions(i).vs2)
				) then
					E_FB(i) <= "011";	-- MEM_WB(i-2) Stage Data	
					
				elsif( (WB_FIN_Instructions(i-3).REG_WE = '1') and 
					   (WB_FIN_Instructions(i-3).vd /="00000") and
					   (WB_FIN_Instructions(i-3).Xout = '0'  ) and  
					   (WB_FIN_Instructions(i-3).vd = RD_EXE_Instructions(i).vs2)
				) then
					E_FB(i) <= "100";	-- WB_FIN Stage Data	
					
				else
					E_FB(i) <= "000";	-- Register  Data
					
				end if;
			end if;				
		end loop;
	end if;
end process op2_chain;	
---------------------------------------------------------
op3_chain: process(stalls_internal_ored,EXE_MEM_Instructions,RD_EXE_Instructions,MEM_WB_Instructions,WB_FIN_Instructions)
begin
	if stalls_internal_ored = '1' then 
		------------------------------------
		-- IN this case, only MEM Harazd is possible
		for i in 0 to 7 loop
			-----------------------------1st Instruction Forwarding-----------------------------------
			if i = 0 then
				E_FC(0) <= "000";  -- No Chaining for 1st Instruction in the convoy
			-----------------------------All other instructions-----------------------------------
			else
				if	((MEM_WB_Instructions(i-1).REG_WE = '1') and 
					 (MEM_WB_Instructions(i-1).vd /="00000") and
					 (MEM_WB_Instructions(i-1).Xout = '0'  ) and  
					 (MEM_WB_Instructions(i-1).vd = RD_EXE_Instructions(i).vd)
					) then
						E_FC(i) <= "010";	-- MEM_WB(i-1)	
				else
						E_FC(i) <= "000";  -- No Forwarding
		
				end if;
			end if;
		end loop;
		--------------------------------------------------------
	else
		--------------------------------------------------------
		--         No Stall Case
		--         Hazards List
		--         EX_MEM(i-1)
		--         MEM_WB(i-2)
		--         WB_FIN(i-3)
		--------------------------------------------------------
		for i in 0 to 7 loop
			-----------------------------1st Instruction Forwarding-----------------------------------
			if i = 0 then
				E_FC(0) <= "000";  -- No Chaining for 1st Instruction in the convoy
			-----------------------------2nd Instruction Forwarding-----------------------------------
			elsif i = 1 then
				if( (EXE_MEM_Instructions(0).REG_WE = '1') and    -- Previ Instruction writes to Reg
					(EXE_MEM_Instructions(0).vd /="00000") and
					(EXE_MEM_Instructions(0).Xout = '0'  ) and  
					(EXE_MEM_Instructions(0).vd = RD_EXE_Instructions(1).vd)
				) then
					E_FC(1) <= "001";	-- EX_MEM(i-1)
				
				else
					E_FC(1) <= "000";	-- Register Data
					
				end if;
			-----------------------------3rd Instruction Forwarding-----------------------------------
			elsif i = 2 then
				if( (EXE_MEM_Instructions(1).REG_WE = '1') and 
					(EXE_MEM_Instructions(1).vd /="00000") and
					(EXE_MEM_Instructions(1).Xout = '0'  ) and  
					(EXE_MEM_Instructions(1).vd = RD_EXE_Instructions(2).vd)
				) then
					E_FC(i) <= "001";	-- EX_MEM(i-1)
					
				elsif(  (MEM_WB_Instructions(0).REG_WE = '1') and 
						(MEM_WB_Instructions(0).vd /="00000") and
						(MEM_WB_Instructions(0).Xout = '0'  ) and  
						(MEM_WB_Instructions(0).vd = RD_EXE_Instructions(2).vd)
				) then
					E_FC(i) <= "011";	-- MEM_WB(i-2) Stage Data		
				else
					E_FC(i) <= "000";	-- Register  Data
				end if;	
			------------------------------4,5,6,7 Instruction Forwarding-----------------------------------
			else
				if( (EXE_MEM_Instructions(i-1).REG_WE = '1') and 
					(EXE_MEM_Instructions(i-1).vd /="00000") and
					(EXE_MEM_Instructions(i-1).Xout = '0'  ) and  
					(EXE_MEM_Instructions(i-1).vd = RD_EXE_Instructions(i).vd)
				) then
					E_FC(i) <= "001";	-- EX_MEM(i-1)
					
				elsif(  (MEM_WB_Instructions(i-2).REG_WE = '1') and 
						(MEM_WB_Instructions(i-2).vd /="00000") and
						(MEM_WB_Instructions(i-2).Xout = '0'  ) and  
						(MEM_WB_Instructions(i-2).vd = RD_EXE_Instructions(i).vd)
				) then
					E_FC(i) <= "011";	-- MEM_WB(i-2) Stage Data	
					
				elsif( (WB_FIN_Instructions(i-3).REG_WE = '1') and 
					   (WB_FIN_Instructions(i-3).vd /="00000") and
					   (WB_FIN_Instructions(i-3).Xout = '0'  ) and  
					   (WB_FIN_Instructions(i-3).vd = RD_EXE_Instructions(i).vd)
				) then
					E_FC(i) <= "100";	-- WB_FIN Stage Data	
					
				else
					E_FC(i) <= "000";	-- Register  Data
					
				end if;
			end if;				
		end loop;
	end if;
end process op3_chain;	
---------------------------------------------------------------------------------------------------+
-- /()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/
--             MEM STAGE CHAINING																   /
-- /()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/()/
---------------------------------------------------------------------------------------------------+
---------------------------------------------------------
---------------------------------------------------------
-------MEM DIN Chaining Logic                  --------
---------------------------------------------------------
mem_din_chain: process(stalls_internal_ored,EXE_MEM_Instructions,RD_EXE_Instructions,MEM_WB_Instructions,WB_FIN_Instructions)
begin 
	if stalls_internal_ored = '1' then 
		for i in 0 to 7 loop
			M_FB(i) <= "000";  -- No Forwarding
		end loop;
		--------------------------------------------------------
	else
		--------------------------------------------------------
		--         No Stall Case
		--         Hazards List
		--         MEM_WB(i-1)

		--------------------------------------------------------
		for i in 0 to 7 loop
			-----------------------------1st Instruction Forwarding-----------------------------------
			if i = 0 then
				M_FB(0) <= "000";  -- No Chaining for 1st Instruction in the convoy
			-----------------------------2nd Instruction Forwarding-----------------------------------
			elsif i = 1 then
				if( (MEM_WB_Instructions(0).REG_WE = '1') and    -- Previ Instruction writes to Reg
					(MEM_WB_Instructions(0).vd /="00000") and 	-- Prev inst is not a vector mask instruction
					(MEM_WB_Instructions(0).Xout = '0'  ) and	-- Prev Instruction should not output a scalar  
					(EXE_MEM_Instructions(1).dmw = '1') and  -- Only for Store Instructions
					(MEM_WB_Instructions(0).vd = EXE_MEM_Instructions(1).vd)
				) then
					M_FB(1) <= "010";	-- MEM_WB(i-1)
				
				else
					M_FB(1) <= "000";	-- EXE_MEM_DATA_RD2
				end if;
			------------------------------2,3,4,5,6,7 Instruction Forwarding-----------------------------------
			else
				if( (MEM_WB_Instructions(i-1).REG_WE = '1') and 
					(MEM_WB_Instructions(i-1).vd /="00000") and 
					(MEM_WB_Instructions(i-1).Xout = '0'  ) and	-- Prev Instruction should not output a scalar 
					(EXE_MEM_Instructions(i).dmw = '1') and  -- Only for Store Instructions
					(MEM_WB_Instructions(i-1).vd = EXE_MEM_Instructions(i).vd)
				) then
					M_FB(i) <= "010";	-- MEM_WB(i-1)
					
				elsif(  (WB_FIN_Instructions(i-2).REG_WE = '1') and 
						(WB_FIN_Instructions(i-2).vd /="00000") and 
						(WB_FIN_Instructions(i-2).Xout = '0'  ) and	-- Prev Instruction should not output a scalar 
						(EXE_MEM_Instructions(i).dmw = '1'     ) and  -- Only for Store Instructions
						(WB_FIN_Instructions(i-2).vd = EXE_MEM_Instructions(i).vd)
				) then
					M_FB(i) <= "100";	-- WB_FIN(i-2) Stage Data	
					
				else
					M_FB(i) <= "000";	-- EXE_MEM_DATA_RD2
					
				end if;
			end if;				
		end loop;
	end if;
end process mem_din_chain;	
---------------------------------------------------------
-- CHaining MUX
-- Notes :-
-- There are total 4 operands to be chained
--   //////////////////////////////////////////////////////////////////////////
--   Operand Name   |  Chaining Control 	|	Pipeline Stage where Chained //
--   ---------------|---------------------- |--------------------------------//
--	    op1			| 	   E_FA				| 		EXE Stage				//
--	    op2			| 	   E_FB				| 		EXE Stage				//
--	    op3			| 	   E_FC				| 		EXE Stage				//
--	    mem_din		| 	   M_FB				| 		MEM Stage				//
--   ---------------|---------------------- |--------------------------------//
CHAINING: process(EXE_MEM_DATA_RD3,RD_EXE_DATA_RD3,Xoutreg_data,RD_EXE_Instructions,EXE_MEM_Instructions,RD_EXE_DATA_RD1,RD_EXE_DATA_RD2,EXE_MEM_ALU_y,
					MEM_WB_DATA,WB_FIN_DATA,E_FA,E_FB,E_FC,M_FB)
begin
	for i in 0 to 7 loop
		if i = 0 then
		--------------------i=0 Case---------------------------No Forwarding is required

			---op1
			case RD_EXE_Instructions(0).ALUSrc is
				when "11" =>  op1(0) <=  x"000000"&"000"&(RD_EXE_Instructions(0).uimm5);
				when "01" =>  op1(0) <=  RD_EXE_Instructions(0).RS1;
				when others =>op1(0) <=  RD_EXE_DATA_RD1(0);   -- Vector Register
			end case;
			--op2
			op2(0) <=  RD_EXE_DATA_RD2(0);
			-- op3
			if RD_EXE_Instructions(0).Xout = '1' then
				op3(0) 	<=   Xoutreg_data(0);
			else
				op3(0) 	<=   RD_EXE_DATA_RD3(0);
			end if;
			-- DMEM_DIN
			dmem_din(0) <= EXE_MEM_DATA_RD3(0);		-- vs3: For Vector Stores {MEM Stage  Chained}
		--------------------i=1 Case--------------------------EXE_MEM(i-1) and MEM_WB(i-1)
		elsif i = 1 then
			-- op1
			case RD_EXE_Instructions(1).ALUSrc is
				when "11" =>  op1(1) <=  x"000000"&"000"&(RD_EXE_Instructions(1).uimm5);
				when "01" =>  op1(1) <=  RD_EXE_Instructions(1).RS1;
				when others =>	-- Chaining Required
					case E_FA(1) is
						when "001"   => op1(1) <=  EXE_MEM_ALU_y(0);  -- EX-chaining
						when "010"   => op1(1) <=  MEM_WB_DATA(0);  --MEMchaining
						when others  => op1(1) <=  RD_EXE_DATA_RD1(1);	--no chaining
					end case;
			end case;
			-- op2
			case E_FB(1) is
				when "001"   => op2(1) <=  EXE_MEM_ALU_y(0);		---EX chain
				when "010"   => op2(1) <=  MEM_WB_DATA(0);  -- MEM chaining
				when others  => op2(1) <=  RD_EXE_DATA_RD2(1);    -- No chaining
			end case;
			--op3		 
			if RD_EXE_Instructions(1).Xout = '1' then
				op3(1) 	<=   Xoutreg_data(1);
			else
				case E_FC(1) is
					when "001"   => op3(1) <=  EXE_MEM_ALU_y(0);  -- EX-chaining
					when "010"   => op3(1) <=  MEM_WB_DATA(0);  --MEMchaining
					when others  => op3(1) <=  RD_EXE_DATA_RD3(1);	--no chaining
				end case;
			end if;
			-- DMEM_DIN
			if M_FB(1) = "010" then
				dmem_din(1) <= MEM_WB_DATA(0);
			else
				dmem_din(1) <= EXE_MEM_DATA_RD3(1);		-- MEM Stage Chained > Vector Store
			end if;
		----------------------i=2------------------EXE_MEM(i-1) + MEM_WB(i-1) + MEM_WB(i-2)
		elsif i = 2 then
			--op1
			case RD_EXE_Instructions(2).ALUSrc is
				when "11" =>  op1(2) <=  x"000000"&"000"&(RD_EXE_Instructions(2).uimm5);
				when "01" =>  op1(2) <=  RD_EXE_Instructions(2).RS1;
				when others=>	--Chaining Required
					case E_FA(2) is
						when "001"   => op1(2) <=  EXE_MEM_ALU_y(1);
						when "010"   => op1(2) <=  MEM_WB_DATA(1);
						when "011"   => op1(2) <=  MEM_WB_DATA(0);
						when others  => op1(2) <=  RD_EXE_DATA_RD1(2);
					end case;
			end case;
			--op2
			case E_FB(2) is
				when "001"   => op2(2) <=  EXE_MEM_ALU_y(1);
				when "010"   => op2(2) <=  MEM_WB_DATA(1);
				when "011"   => op2(2) <=  MEM_WB_DATA(0);
				when others  => op2(2) <=  RD_EXE_DATA_RD2(2);
			end case;
			--op3
			if RD_EXE_Instructions(2).Xout = '1' then
				op3(2) 	<=   Xoutreg_data(2);
			else
				case E_FC(2) is
					when "001"   => op3(2) <=  EXE_MEM_ALU_y(1);
					when "010"   => op3(2) <=  MEM_WB_DATA(1);
					when "011"   => op3(2) <=  MEM_WB_DATA(0);
					when others  => op3(2) <=  RD_EXE_DATA_RD3(2);
				end case;		
			end if;	
			-- DMEM_DIN
			case M_FB(2) is
				when "010" => dmem_din(2) <= MEM_WB_DATA(1);
				when "100" => dmem_din(2) <= WB_FIN_DATA(0);
				when others=> dmem_din(2) <= EXE_MEM_DATA_RD3(2);
			end case;			
		----------------------i>=3-------------------------------------All Chaining
		else
			--op1
			case RD_EXE_Instructions(i).ALUSrc is  --Vec Reg
				when "11" =>  op1(i) <=  x"000000"&"000"&(RD_EXE_Instructions(i).uimm5);
				when "01" =>  op1(i) <=  RD_EXE_Instructions(i).RS1;	
				when others=>
					case E_FA(i) is
						when "001"   => op1(i) <=  EXE_MEM_ALU_y(i-1);
						when "010"   => op1(i) <=  MEM_WB_DATA(i-1);
						when "011"   => op1(i) <=  MEM_WB_DATA(i-2);
						when "100"   => op1(i) <=  WB_FIN_DATA(i-3);
						when others  => op1(i) <=  RD_EXE_DATA_RD1(i);
					end case;
				end case;
			--op2
			case E_FB(i) is
				when "001"   => op2(i) <=  EXE_MEM_ALU_y(i-1);
				when "010"   => op2(i) <=  MEM_WB_DATA(i-1);
				when "011"   => op2(i) <=  MEM_WB_DATA(i-2);
				when "100"   => op2(i) <=  WB_FIN_DATA(i-3);
				when others  => op2(i) <=  RD_EXE_DATA_RD2(i);
			end case;
			-- op3
			if RD_EXE_Instructions(i).Xout = '1' then
				op3(i) 	<=   Xoutreg_data(i);
			else
				case E_FC(i) is
					when "001"   => op3(i) <=  EXE_MEM_ALU_y(i-1);
					when "010"   => op3(i) <=  MEM_WB_DATA(i-1);
					when "011"   => op3(i) <=  MEM_WB_DATA(i-2);
					when "100"   => op3(i) <=  WB_FIN_DATA(i-3);
					when others  => op3(i) <=  RD_EXE_DATA_RD3(i);
				end case;
			end if;
			-- DMEM_DIN
			case M_FB(i) is
				when "010" => dmem_din(i) <= MEM_WB_DATA(i-1);
				when "100" => dmem_din(i) <= WB_FIN_DATA(i-2);
				when others=> dmem_din(i) <= EXE_MEM_DATA_RD3(i);
			end case;				
		--------------------------------------------------------------	
	   end if;
	end loop;
end process;

---------------------------------------------------------
-- OUtput
---------------------------------------------------------
-- STall Generation
-- (1) Load Store Case

---------------------------------------------------------
STALLER: process(Instructions,RD_EXE_Instructions)
begin
	for i in 0 to 7 loop
		if i = 0 then
			stalls_internal(0) <='0';
		else
		   if(  (RD_EXE_Instructions(i-1).REG_WE = '1') 	and 
				  (RD_EXE_Instructions(i-1).dmr ='1') 		and 
				  (	(RD_EXE_Instructions(i-1).vd = Instructions(i).vs1) or
					(RD_EXE_Instructions(i-1).vd = Instructions(i).vs2)	)
			    ) then
				stalls_internal(i) <= '1';
			else
				stalls_internal(i) <= '0';
			end if;
		end if;
	end loop;
end process STALLER;
---------------------------------------------------------

---------------------------------------------------------
--ALU_mon <= (others=>'0');
ALU_mon_int <= ("000" & MEM_WB_ALU_y(0)) + 
           ("000" & MEM_WB_ALU_y(1)) + 
           ("000" & MEM_WB_ALU_y(2)) + 
           ("000" & MEM_WB_ALU_y(3)) + 
           ("000" & MEM_WB_ALU_y(4)) + 
           ("000" & MEM_WB_ALU_y(5)) + 
           ("000" & MEM_WB_ALU_y(6)) + 
           ("000" & MEM_WB_ALU_y(7)) ;
           
ALU_mon <= '1' when (ALU_mon_int = "01"&x"55555555") else '0';
end behavioral;			  
