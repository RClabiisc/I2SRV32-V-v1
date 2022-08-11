//******************************************************************************
// Copyright (c) 2014 - 2018, 2019 - 2021, Indian Institute of Science, Bangalore.
// All Rights Reserved. See LICENSE for license details.
//------------------------------------------------------------------------------

// Contributors
// Naveen Chander V (naveenv@alum.iisc.ac.in)
// Akshay Birari (akshay@alum.iisc.ac.in), Piyush Birla (piyush@alum.iisc.ac.in)
// Suseela Budi (suseela@alum.iisc.ac.in), Pradeep Gupta (gupta@alum.iisc.ac.in)
// Kavya Sharat (kavyasharat@alum.iisc.ac.in), Sumeet Bandishte (sumeet.bandishte30@gmail.com)
// Kuruvilla Varghese (kuru@iisc.ac.in)
`timescale 1ns / 1ps

`define nLANES 8
`define VECTOR_OPCODE 7'b1010111
`define vec_counter_thd 10
`define max_release_count 4
`define release_thd 3
//`define i_buf_fill_count `nLANES-1

`define OP_VEC_LOAD 			7'b0000111
`define OP_VEC_STORE			7'b0100111
`define OP_VEC_ARITH			7'b1010111

module vector_top(
    input 				clk,
    input 				reset,
	input				Branch_Taken__EX_MEM,
	input				Branch_Taken__MEM_WB,
    input [31:0] 		Instruction__IF_ID,
    input [31:0] 		Instruction__ID_EX,
    input [31:0] 		rs1_data,
    input [31:0] 		rs2_data,
    input [8:0] 		vl,
    input [8:0] 		vcsr_quant,
    input 	            freeze_vector_ops,
    input 	            Data_Cache__Stall,
	// Processor interface Related//
	input [31:0]		proc_addr,				// Scalar Core Accessing VREG/VMEM Address
	input [31:0]		proc_din,				// Data to be Written into VREG/VMEM
	output [31:0]		proc_dout,				// Data Read from VREG/VMEM
	input 				proc_we,				// Write Enable
	//
	output reg 		    sv_vv,
	output reg			v_stall,
	output reg			freeze_x,
	output   			freeze,
	output reg [1:0]	release_counter,
    output reg [4:0]  	rs2_sel,
    output reg [4:0]  	rs1_sel,
	output wire			ALU_monitor,
	output reg         vect_cxt_changed,
	//XRF INterface
	output  wire    vec_wr_XRF,
	output [4:0]	XRF_ADDR		,
	output [31:0]	XRF_DATAWR		,
	output  wire    XRF_WE			
    );
///////////////////////////////////////////////	
// Define REGs and WIREs
//Processor interface Related
reg [31:0]	vec_addr;
reg [31:0] 	vec_din;
reg [31:0] 	vec_dout;
reg 		vec_we;
wire [3:0]   i_buf_fill_count;		// Limit for issuing I_Start
// ----------------Vector Unit Related
reg 			I_clear		;		// Clears all 8 vector instructions in the Vector Execution Unit
reg [2:0]		I_id		;		// Instruction ID : 0-->7 of ith instruction
reg 			I_start   	;		// Start Signal to begin execution of ith instruction
reg [4:0]		I_vs1     	;		// Vector Source Register vs1 of ith instruction
reg [4:0]		I_vs2     	;		// Vector Source Register vs2 of ith instruction
reg [4:0]		I_vd      	;		// Vector Destination Register vd of ith instruction
reg [31:0]		I_RS1    	;		// Scalar Source Register RS1 of ith instruction
reg [31:0]		I_RS2    	;		// Scalar Source Register RS2 of ith instruction
reg [4:0]		I_uimm5    	;		// Unsigned 5-bit Immediate Value of ith instruction
reg [7:0]		I_funct   	;		// Vector Operation
reg [1:0]		I_permute   ;		// Vector Slide down coefficient (0--3) for ith instruction
reg 			I_mask_en 	;		// Control Signal to enable Vector Mask for ith instruction
reg [1:0]		I_ALUSrc  	;		// ALU Source > vs(=00) / rs(=01) / uimm5(=11)
reg 			I_dmr     	;		// Vector data memory read control signal for ith instruction 
reg 			I_dmw     	;		// Vector data memory write control signal for ith instruction
reg 			I_reg_we  	;		// Vector Register Write control signal for ith instruction
reg 			I_mem_reg 	;		// Vector Register Write Data Source Select <DMEM(1) or vector-ALU(0)>
reg 			I_Xout  	;		// 1 : IF the Vector operation produces a scalar Output
reg [1:0]		I_mode_lsu	;		// Load Store Unit Operation mode : 00=>Unit Stride; "01"=>Stided "11"=>Indexed
wire 			ALU_mon     ;   	// ALU Mon : Dummy Output {Can be ignored safely}
wire 			stall		;		// 
wire  			DONE        ;  		// 1: if Convoy Execution is complete : 0: If Convoy Execution is in progress
									// Note: There is a need for providing a gap of at least 6 clock cycle between the end of
									// first convoy and the start of a subsequent convoy
									
//////////////////////////////////////
reg [2:0] 		vec_inst_counter	;		// Counts the number of contiguous Vector Instructions (0-7)
wire [6:0] 		opcode;
reg 			vector_gate;
reg 			v_busy;
reg [7:0] 		vec_cycle_counter;
wire 			S_VECn_prev;
wire 			ored_freeze;
reg 			freeze_vector_ops_delayed;
wire			vec_decoder_disable;
///////////////////////////////////////////////
// Instruction Array Declaration
reg [2:0]	id			[`nLANES-1:0];
reg 		start   	[`nLANES-1:0];
reg [4:0]	vs1     	[`nLANES-1:0];
reg [4:0]	vs2     	[`nLANES-1:0];
reg [4:0]	vd      	[`nLANES-1:0];
reg [4:0]	RS1    		[`nLANES-1:0];
reg [4:0]	RS2    		[`nLANES-1:0];
reg [4:0]	uimm5    	[`nLANES-1:0];
reg [7:0]	funct   	[`nLANES-1:0];
reg [1:0]	permute   	[`nLANES-1:0];
reg 		mask_en 	[`nLANES-1:0];
reg [1:0]	ALUSrc  	[`nLANES-1:0];
reg 		dmr     	[`nLANES-1:0];
reg 		dmw     	[`nLANES-1:0];
reg 		reg_we  	[`nLANES-1:0];
reg 		mem_reg 	[`nLANES-1:0];
reg 		Xout    	[`nLANES-1:0];
reg [1:0]	mode_lsu	[`nLANES-1:0];
integer i;
wire S_VECn;
////////////////////////Vector Decoder Wires 
wire [4:0]	decode_prev__vs1     ;	
wire [4:0]	decode_prev__vs2     ;
wire [4:0]	decode_prev__vd      ;
wire [4:0]	decode_prev__RS1     ;
wire [4:0]	decode_prev__RS2     ;
wire [4:0]	decode_prev__uimm5   ;
wire [7:0]	decode_prev__funct   ;
wire [1:0]	decode_prev__permute ;
wire 		decode_prev__mask_en ;
wire [1:0]	decode_prev__ALUSrc  ;
wire 		decode_prev__dmr     ;
wire 		decode_prev__dmw     ;
wire 		decode_prev__reg_we  ;
wire 		decode_prev__mem_reg ;
wire 		decode_prev__Xout    ;
wire [1:0]	decode_prev__mode_lsu;

wire [4:0]	decode_pres__vs1     ;	
wire [4:0]	decode_pres__vs2     ;
wire [4:0]	decode_pres__vd      ;
wire [4:0]	decode_pres__RS1     ;
wire [4:0]	decode_pres__RS2     ;
wire [4:0]	decode_pres__uimm5   ;
wire [7:0]	decode_pres__funct   ;
wire [1:0]	decode_pres__permute ;
wire 		decode_pres__mask_en ;
wire [1:0]	decode_pres__ALUSrc  ;
wire 		decode_pres__dmr     ;
wire 		decode_pres__dmw     ;
wire 		decode_pres__reg_we  ;
wire 		decode_pres__mem_reg ;
wire 		decode_pres__Xout    ;
wire [1:0]	decode_pres__mode_lsu;

reg  [4:0]	decode__vs1     ;	
reg  [4:0]	decode__vs2     ;
reg  [4:0]	decode__vd      ;
reg  [4:0]	decode__RS1     ;
reg  [4:0]	decode__RS2     ;
reg  [4:0]	decode__uimm5   ;
reg  [7:0]	decode__funct   ;
reg  [1:0]	decode__permute ;
reg  		decode__mask_en ;
reg  [1:0]	decode__ALUSrc  ;
reg  		decode__dmr     ;
reg  		decode__dmw     ;
reg  		decode__reg_we  ;
reg  		decode__mem_reg ;
reg  		decode__Xout    ;
reg  [1:0]	decode__mode_lsu;


reg [2:0]  	dispatch_counter;
reg [3:0]  	freeze_thd;
reg 		x_int;						//Interrupting Scalar Instruction Detector
reg 		freeze_v;					//Interrupting Scalar Instruction Detector
wire 		freeze_vector;				//Signal that freezes - 
										// (a) Vector_instruction Counter
										// (b) Vector_cycle Counter
										// (c) Freeze
										// (d) Writing INstructions into Instruction Buffer
// --------------------------------------------------------------------------//
//          		RTL Logic Begins	 								     //
// --------------------------------------------------------------------------//
assign opcode = Instruction__IF_ID[6:0];
assign freeze = freeze_v | freeze_x;
assign vec_decoder_disable = (release_counter == 0) ? (freeze_vector ? 1'b1 : 1'b0) : 1'b0;  
assign ALU_monitor = ALU_mon;
assign vec_wr_XRF = ~DONE;
///////////////////////////////////////////////
///// Instantiate Vector Decoder Module     ///
///////////////////////////////////////////////
vec_decoder VECTOR_DECODER_PRES(
	.Instruction     (Instruction__IF_ID	 ),
	.reset			 (reset			         ),
	.Inst_Cache__Stall(1'b0			         ),
	.Data_Cache__Stall(freeze_vector_ops	     ),	//was freeze_vector b4
	.S_VECn			 (S_VECn				 ),
	.decode__vs1     (decode_pres__vs1       ),
	.decode__vs2     (decode_pres__vs2       ),
	.decode__vd      (decode_pres__vd        ),
	.decode__RS1     (decode_pres__RS1       ),
	.decode__RS2     (decode_pres__RS2       ),
	.decode__uimm5   (decode_pres__uimm5     ),
	.decode__funct   (decode_pres__funct     ),
	.decode__permute (decode_pres__permute   ),
	.decode__mask_en (decode_pres__mask_en   ),
	.decode__ALUSrc  (decode_pres__ALUSrc    ),
	.decode__dmr     (decode_pres__dmr       ),
	.decode__dmw     (decode_pres__dmw       ),
	.decode__reg_we  (decode_pres__reg_we    ),
	.decode__mem_reg (decode_pres__mem_reg   ),
	.decode__Xout    (decode_pres__Xout      ),
	.decode__mode_lsu(decode_pres__mode_lsu  )
	);

	vec_decoder VECTOR_DECODER_PREV(
	.Instruction     (Instruction__ID_EX     ),
	.reset			 (reset			         ),
	.Inst_Cache__Stall(1'b0         ),
	.Data_Cache__Stall(freeze_vector_ops_delayed ),
	.S_VECn			 (S_VECn_prev		     ),
	.decode__vs1     (decode_prev__vs1       ),
	.decode__vs2     (decode_prev__vs2       ),
	.decode__vd      (decode_prev__vd        ),
	.decode__RS1     (decode_prev__RS1       ),
	.decode__RS2     (decode_prev__RS2       ),
	.decode__uimm5   (decode_prev__uimm5     ),
	.decode__funct   (decode_prev__funct     ),
	.decode__permute (decode_prev__permute   ),
	.decode__mask_en (decode_prev__mask_en   ),
	.decode__ALUSrc  (decode_prev__ALUSrc    ),
	.decode__dmr     (decode_prev__dmr       ),
	.decode__dmw     (decode_prev__dmw       ),
	.decode__reg_we  (decode_prev__reg_we    ),
	.decode__mem_reg (decode_prev__mem_reg   ),
	.decode__Xout    (decode_prev__Xout      ),
	.decode__mode_lsu(decode_prev__mode_lsu  )
	);
	
///////////////////////////////////////////////
///// Instantiate Vector Wrapper Module     ///
///////////////////////////////////////////////
v_wrapper  VEC_EXE_UNIT( 
	.clk 			(clk 		),
	.reset 			(reset 		),
	.vl				(vl			),
	.vcsr_quant		(vcsr_quant ),
	.I_clear		(I_clear	),
	.I_id			(I_id		),
	.ALU_mon     	(ALU_mon    ),
	.stall			(stall		),
	.DONE        	(DONE       ),
	.proc_addr      (proc_addr  ),
	.proc_din		(proc_din	),
	.proc_dout		(proc_dout	),
	.proc_we		(proc_we	),
	.XRF_ADDR		(XRF_ADDR	),
	.XRF_DATAWR		(XRF_DATAWR ),
	.XRF_WE	        (XRF_WE 	),
	.I_start   		(I_start   	),
	.I_vs1     		(I_vs1     	),
	.I_vs2     		(I_vs2     	),
	.I_vd      		(I_vd      	),
	.I_RS1    		(I_RS1    	),
	.I_RS2    		(I_RS2    	),
	.I_uimm5    	(I_uimm5   	),
	.I_funct   		(I_funct   	),
	.I_permute   	(I_permute  ),
	.I_mask_en 		(I_mask_en 	),
	.I_ALUSrc  		(I_ALUSrc  	),
	.I_dmr     		(I_dmr     	),
	.I_dmw     		(I_dmw     	),
	.I_reg_we  		(I_reg_we  	),
	.I_mem_reg 		(I_mem_reg 	),
	.I_Xout 		(I_Xout 	),
	.I_mode_lsu		(I_mode_lsu	)
	);
///////////////////////////////////////////////////////////////////////////
// 	Vector Instruction Count Register [2:0]
//  Increments with every incoming vector instruction
//  provided there are no Stalls from Vector Execution Unit

always @(posedge reset or posedge clk) 
begin
	if (reset)
		vec_inst_counter <= 0;
	else if (v_busy|I_start) 
		vec_inst_counter <= 0;
	else if (~(freeze_vector|freeze))	
		vec_inst_counter <= vec_inst_counter + 1;
end

///////////////////////////////////////////////////////////////////////////
always @(posedge reset or posedge clk) 
begin
	if (reset)
		release_counter <= 0;
	else if (v_busy || release_counter == `max_release_count) 
		release_counter <= 0;
	else if (DONE && (vec_cycle_counter > `vec_counter_thd) && (~freeze_vector_ops) )
		release_counter <= release_counter + 1;
	
end

///////////////////////////////////////////////////////////////////////////
//	Vector Cycle Counter : Count the number of cycles since rise of vec_gate
///////////////////////////////////////////////////////////////////////////
always @(posedge reset or posedge clk) 
begin
	if(reset)
		vec_cycle_counter <= 0;
	else if(v_busy)
		vec_cycle_counter <= 0;
	else if(~freeze_vector)
		vec_cycle_counter <= vec_cycle_counter+1;
end
///////////////////////////////////////////////////////////////////////////
//	Vector Unit Busy : 
///////////////////////////////////////////////////////////////////////////
always @(posedge reset or posedge clk) 
begin
	if(reset) 
		v_busy 	<= 1'b1;
	else if(Branch_Taken__EX_MEM | Branch_Taken__MEM_WB)
		v_busy <= 1'b1;		//Come out  of Vector if there was a preceding scalar branch instruction
	else if(release_counter ==`release_thd) 
		v_busy <= 1'b1;
	else if(~S_VECn) 
		v_busy  <= 1'b0;
		
end
///////////////////////////////////////////////////////////////////////////
//	Stall Signal Generation : To stall IF_ID and PC from fetching instructions 
///////////////////////////////////////////////////////////////////////////
always @(posedge reset or posedge clk) 
begin
	if(reset) 
		v_stall 	<= 1'b0;
	else if(Branch_Taken__EX_MEM| Branch_Taken__MEM_WB)
		v_stall <= 1'b0;		//Come out  of Vector if there was a preceding scalar branch instruction
	else if(release_counter ==`release_thd) 
		v_stall <= 1'b0;
	else if(~S_VECn) 
		v_stall  <= 1'b1;
		
end
//////////////////////////////////////////////	
//  Freeze Threshold                        //
//////////////////////////////////////////////	
always @(posedge reset or posedge clk) begin
	if(reset) begin
		freeze_thd <= `nLANES-2; // Scalar followed by Vector
		sv_vv <= 1'b1;	// ID_EX Stage Input
		end
	else if (v_busy && ~S_VECn)
		if (S_VECn_prev) begin
			freeze_thd = `nLANES-1; 	// Scalar -- Vector Case
			sv_vv = 1'b1;
			end
		else begin
			freeze_thd <= `nLANES-1;	//Vector-Vector Case
			sv_vv <= 1'b1;
			end
end	

//////////////////////////////////////////////	
//  Freeze Logic  -- Stall ScalarPipeline    //
//////////////////////////////////////////////	
//    a. Due to Scalar Interruption
//////////////////////////////////////////////	
always @(posedge reset or posedge clk) begin
	if(reset) 
		freeze_x <= 1'b0;
	else if(release_counter == `release_thd-2)
			freeze_x <=1'b0;
	else if((~v_busy) && (vec_cycle_counter < freeze_thd) && S_VECn && ~(freeze_vector_ops|freeze_vector))
			freeze_x <= 1'b1;
end	
//////////////////////////////////////////////	
//    b. Due to Vector Overflow
//////////////////////////////////////////////	
always @(posedge reset or posedge clk) begin
	if(reset) 
		freeze_v <= 1'b0;
	else if(release_counter == `release_thd-2) 
			freeze_v <=1'b0;
	else if((~v_busy) && (vec_cycle_counter == freeze_thd) && (~freeze_x))
			freeze_v <= 1'b1;
end	
//////////////////////////////////////////////	
//  Interrupting Scalar Inst Detection      //
//////////////////////////////////////////////
always @(posedge reset or posedge clk) begin
	if(reset)
		x_int <= 1'b0;
	else if(v_busy)
		x_int <= 1'b0;
	else if((S_VECn) && (vec_cycle_counter <= `nLANES-1) && ~(freeze_vector_ops|freeze_vector))
		x_int <= 1'b1;
end
////////////////////////////////////////////////
// Vector STallers
//////////////////////////////////////////////	
//  Select the right vector freeze          //
//////////////////////////////////////////////	
assign freeze_vector = sv_vv ? freeze_vector_ops_delayed : freeze_vector_ops ;
//////////////////////////////////////////////
//  Delayed signals --
//	1. freeze_vector_ops for sv_sequence 		//
////////////////////////////////////////////////
always @(posedge reset or posedge clk) begin
	if(reset) begin
		freeze_vector_ops_delayed <= 1'b0;
	end
	else begin
		freeze_vector_ops_delayed <= freeze_vector_ops ;
	end
end

// Define i-buf_fill_count based on sv_vv
assign i_buf_fill_count = sv_vv ? `nLANES : `nLANES -1 ;
//////////////////////////////////////////////	
//  Send Instructions from the Inst Record   //
//////////////////////////////////////////////	
always @(posedge reset or posedge clk) 
begin
	if (reset) 
	begin
		I_id			 <= 0;
		I_clear			 <= 1;
		I_start   		 <= 0;
		I_vs1     		 <= 0;
		I_vs2     		 <= 0;
		I_vd      		 <= 0;
		I_RS1    		 <= 0;
		I_RS2    		 <= 0;
		I_uimm5    		 <= 0;
		I_funct   		 <= 0;
		I_permute   	 <= 0;
		I_mask_en 		 <= 0;
		I_ALUSrc  		 <= 0;
		I_dmr     		 <= 0;
		I_dmw     		 <= 0;
		I_reg_we  		 <= 0;
		I_mem_reg 		 <= 0;
		I_mode_lsu		 <= 0;
		I_Xout			 <= 0;
		dispatch_counter <= 0;
		//rs1_sel			 <= 0;
		//rs2_sel			 <= 0;
	end

	else if ( (~v_busy) && (~stall) && (vec_cycle_counter >= i_buf_fill_count))				// If Convoy Execution has already started
														// Vector Unit should not be stalling 
														
		begin
		I_id			 <= dispatch_counter;
		I_clear			 <= 1'b0;
		I_start   		 <= 1'b1;                
		I_vs1     		 <= vs1     [dispatch_counter];
		I_vs2     		 <= vs2     [dispatch_counter];
		I_vd      		 <= vd      [dispatch_counter];
		I_RS1    		 <= rs1_data				  ;	// Data coming from the x-reg file
		I_RS2    		 <= rs2_data				  ;
		I_uimm5    		 <= uimm5   [dispatch_counter];
		I_funct   		 <= funct   [dispatch_counter];
		I_permute   	 <= permute [dispatch_counter];
		I_mask_en 		 <= mask_en [dispatch_counter];
		I_ALUSrc  		 <= ALUSrc  [dispatch_counter];
		I_dmr     		 <= dmr     [dispatch_counter];
		I_dmw     		 <= dmw     [dispatch_counter];
		I_reg_we  		 <= reg_we  [dispatch_counter];
		I_mem_reg 		 <= mem_reg [dispatch_counter];
		I_Xout			 <= Xout    [dispatch_counter];
		I_mode_lsu		 <= mode_lsu[dispatch_counter];			
		//	Also Increment the dispatch counter		
		dispatch_counter <= dispatch_counter + 1;

		end
	else if (DONE == 1'b1 && vec_cycle_counter >= `vec_counter_thd)
		begin
		I_id			 <= 0;
		I_clear			 <= 1;
		I_start   		 <= 0;
		I_vs1     		 <= 0;
		I_vs2     		 <= 0;
		I_vd      		 <= 0;
		I_RS1    		 <= 0;
		I_RS2    		 <= 0;
		I_uimm5    		 <= 0;
		I_funct   		 <= 0;
		I_permute   	 <= 0;
		I_mask_en 		 <= 0;
		I_ALUSrc  		 <= 0;
		I_dmr     		 <= 0;
		I_dmw     		 <= 0;
		I_reg_we  		 <= 0;
		I_mem_reg 		 <= 0;
		I_Xout           <= 0;
		I_mode_lsu		 <= 0;
		dispatch_counter <= 0;
		//rs1_sel			 <= 0;
		//rs2_sel			 <= 0;
		end
		
end	
always @(*) begin 
// Select the Appropriate Scalar Register
rs1_sel			 <= RS1[dispatch_counter];
rs2_sel			 <= RS2[dispatch_counter];
end
//////////////////////////////////////////////	
//       Fill-in the instruction Record     //
//////////////////////////////////////////////	
always @(posedge reset or posedge clk) 
begin
	if (reset | v_busy)
    for (i=0;i<8;i=i+1)
	begin
		id		[i]	<=	0;	
	    start   [i]	<=	0;	
	    vs1     [i]	<=	0;	
	    vs2     [i]	<=	0;	
	    vd      [i]	<=	0;	
	    RS1    	[i]	<=	0;	
	    RS2    	[i]	<=	0;	
	    uimm5   [i]	<=	0; 	
	    funct   [i]	<=	0;	
	    permute [i]	<=	0;  	
	    mask_en [i]	<=	0;	
	    ALUSrc  [i]	<=	0;	
	    dmr     [i]	<=	0;	
	    dmw     [i]	<=	0;	
	    reg_we  [i]	<=	0;	
	    mem_reg [i]	<=	0;	
		Xout	[i] <=  0;
	    mode_lsu[i]	<=	0;	
	end 
	else 
		if(sv_vv) begin	 //Scalar to vector 
			if (~S_VECn_prev && (vec_cycle_counter <= `nLANES-1) &&(~x_int) && ~freeze_vector)  // If the incoming instruction is a Vector Instruction 
				begin
				id		[vec_inst_counter]		<=		vec_inst_counter	 ;	
				start   [vec_inst_counter]		<=		1'b1				 ;	
				vs1     [vec_inst_counter]		<=		decode_prev__vs1     ;	
				vs2     [vec_inst_counter]		<=		decode_prev__vs2     ; 	
				vd      [vec_inst_counter]		<=		decode_prev__vd      ; 	
				RS1    	[vec_inst_counter]		<=		decode_prev__RS1     ; 	
				RS2    	[vec_inst_counter]		<=		decode_prev__RS2     ; 	
				uimm5   [vec_inst_counter]		<=		decode_prev__uimm5   ;  	
				funct   [vec_inst_counter]		<=		decode_prev__funct   ; 	
				permute [vec_inst_counter]		<=		decode_prev__permute ;   	
				mask_en [vec_inst_counter]		<=		decode_prev__mask_en ; 	
				ALUSrc  [vec_inst_counter]		<=		decode_prev__ALUSrc  ; 	
				dmr     [vec_inst_counter]		<=		decode_prev__dmr     ; 	
				dmw     [vec_inst_counter]		<=		decode_prev__dmw     ; 	
				reg_we  [vec_inst_counter]		<=		decode_prev__reg_we  ; 	
				mem_reg [vec_inst_counter]		<=		decode_prev__mem_reg ; 	
				Xout    [vec_inst_counter]		<=		decode_prev__Xout	 ;
				mode_lsu[vec_inst_counter]		<=		decode_prev__mode_lsu; 			
				end	
			end
		else	 begin		// Back to Back Vector Convoys
			if (~S_VECn && (vec_cycle_counter <= `nLANES-1) && (~x_int)  && ~freeze_vector)  // If the incoming instruction is a Vector Instruction 
				begin
				id		[vec_inst_counter]		<=		vec_inst_counter	 ;	
				start   [vec_inst_counter]		<=		1'b1				 ;	
				vs1     [vec_inst_counter]		<=		decode_pres__vs1     ;	
				vs2     [vec_inst_counter]		<=		decode_pres__vs2     ; 	
				vd      [vec_inst_counter]		<=		decode_pres__vd      ; 	
				RS1    	[vec_inst_counter]		<=		decode_pres__RS1     ; 	
				RS2    	[vec_inst_counter]		<=		decode_pres__RS2     ; 	
				uimm5   [vec_inst_counter]		<=		decode_pres__uimm5   ;  	
				funct   [vec_inst_counter]		<=		decode_pres__funct   ; 	
				permute [vec_inst_counter]		<=		decode_pres__permute ;   	
				mask_en [vec_inst_counter]		<=		decode_pres__mask_en ; 	
				ALUSrc  [vec_inst_counter]		<=		decode_pres__ALUSrc  ; 	
				dmr     [vec_inst_counter]		<=		decode_pres__dmr     ; 	
				dmw     [vec_inst_counter]		<=		decode_pres__dmw     ; 	
				reg_we  [vec_inst_counter]		<=		decode_pres__reg_we  ; 	
				mem_reg [vec_inst_counter]		<=		decode_pres__mem_reg ; 	
				Xout    [vec_inst_counter]		<=		decode_pres__Xout    ; 	
				mode_lsu[vec_inst_counter]		<=		decode_pres__mode_lsu; 			
				end	
		end
end

///////////////////////////////////Logic to Save Vector Context Switches///////////////////////////
// This logic generates a signal that changes the XS[1:0] bits in mstatus register to dirty {2'b11}
// Vector Context Change bit {vect_cxt_changed} get set when any vector instruction modifies 
// Vector Registers v0-v31 . 
// For this to happen successfully, 
//	1. reg_we of any instruction in the cony shoule be 1'b1.
//	2. Start should be 1'b1

always @(*) begin
	vect_cxt_changed <= (start[0] && reg_we[0]) || 
	                    (start[1] && reg_we[1]) || 
	                    (start[2] && reg_we[2]) || 
	                    (start[3] && reg_we[3]) || 
	                    (start[4] && reg_we[4]) || 
	                    (start[5] && reg_we[5]) || 
	                    (start[6] && reg_we[6]) || 
	                    (start[7] && reg_we[7]) ;
	end

endmodule

