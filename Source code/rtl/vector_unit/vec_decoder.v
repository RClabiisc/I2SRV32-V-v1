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

`define OP_VEC_LOAD 			7'b0000111
`define OP_VEC_STORE			7'b0100111
`define OP_VEC_ARITH			7'b1010111

`define funct6__vadd 			6'b000000
`define funct6__vsub 			6'b000010
`define funct6__vslidedown 		6'b001111
`define funct6__vdiv 			6'b100001
`define funct6__vmulhu 			6'b100100
`define funct6__vmul 			6'b100101
`define funct6__vmulhsu 		6'b100110
`define funct6__vmulh	 		6'b100111
`define funct6__vmadd	 		6'b101001
`define funct6__vnmsub	 		6'b101011
`define funct6__vmacc	 		6'b101101
`define funct6__vnmsac	 		6'b101111

`define funct6__vdivu			6'b100000
`define funct6__vdiv			6'b100001
`define funct6__vremu			6'b100010
`define funct6__vrem			6'b100011

`define funct6__vredsum	 		6'b000000	// Same as vadd!
`define funct6__vdot	 		6'b111001	// Dot Product
`define funct6__vmax	 		6'b001001	// vand ReLu
`define funct6__vmaxval     	6'b000001	// vredand --> IMplements vmaxval
`define funct6__vmaxuval    	6'b000010	// vredor 
`define funct6__vminval     	6'b000011   //vredxor
`define funct6__vminuval    	6'b001000   //vaaddu
`define funct6__vmaxidx 		6'b000111    
`define funct6__vmaxuidx    	6'b000110
`define funct6__vminidx     	6'b000101
`define funct6__vminuidx    	6'b000100

`define funct3__OPIVV	 		3'b000		// Integer Vector-Vector
`define funct3__OPMVV	 		3'b010		// Integer Mask -Vector ?
`define funct3__OPIVI	 		3'b011		// Integer Vector-Immediate {simm5}
`define funct3__OPIVX	 		3'b100		// Integer Vector-Scalar {rs1}
`define funct3__OPMVX	 		3'b110		// Integer Vector-Scalar {rs1}
`define funct3__VCSR	 		3'b111		// To R/W Vector CSRs
`define funct3__VRELU	 		3'b000		// To R/W Vector CSRs

// 26.04.2021: The source code for Spike (and riscv-v toolchain) appears to have a mismatch 
// with RVV_1.0 Spec document for decoding arithmetic  instructions.
// The funct_3 values for vector arithmetic operations of the form :
// vop_vv assumes OP_MVV and OP_MVX instead of OP_IVV and OP_IVX 
// Decoding table  used as reference is shown below {Sticking to toolchain opcodes}:-
//		+----------------+--------------+-----------+
//		|Instruction	 |	funct6	    |	funct3	|
//		+----------------+--------------+-----------+
//		|vadd_vv   	 	 |	00_0000     |	000		|
//		|vadd_vx		 |	00_0000     |	100		|
//		|vmul_vv		 |	10_0101     |	010		|
//		|vmul_vx		 |	10_0101     |	110		|
//		|vmacc_vv		 |	10_1101     |	010		|
//		|vmacc_vx		 |	10_1101     |	110		|
//		|vdot_vv		 |	11_1001     |	010		|
//		|vdot_vx		 |	11_1001     |	110		|
//		|vredsum_vx	 	 |	00_0000     |	010		|
//		|vReLu_vx	 	 |	00_1001     |	000		| // Implements ReLu Instruction {However, vand_vx INST is mapped}
//		+----------------+--------------+-----------+


// Vector Load Store Format
//--------------------------------------------------------------------------------------------
/*
Format for Vector Load Instructions under LOAD-FP major opcode

////
31 29  28  27 26  25  24      20 19       15 14   12 11      7 6     0
 nf  | mew| mop | vm |  lumop   |    rs1    | width |    vd   |0000111| VL*  unit-stride
 nf  | mew| mop | vm |   rs2    |    rs1    | width |    vd   |0000111| VLS* strided
 nf  | mew| mop | vm |   vs2    |    rs1    | width |    vd   |0000111| VLX* indexed
  3     1    2     1      5           5         3         5       7
  
*/ 


// Vector Store Store Format {As per RVV_1.0}
//--------------------------------------------------------------------------------------------
/*Format for Vector Store Instructions under STORE-FP major opcode
////
31 29  28  27 26  25  24      20 19       15 14   12 11      7 6     0
 nf  | mew| mop | vm |  sumop   |    rs1    | width |   vs3   |0100111| VS*  unit-stride
 nf  | mew| mop | vm |   rs2    |    rs1    | width |   vs3   |0100111| VSS* strided
 nf  | mew| mop | vm |   vs2    |    rs1    | width |   vs3   |0100111| VSX* indexed
  3     1    2     1      5           5         3         5        7
*/
// Vector ARITHMETIC INSTRUCTION fORMAT
//--------------------------------------------------------------------------------------------

/*
31       26  25   24      20 19      15 14   12 11      7 6     0
  funct6   | vm  |   vs2    |    vs1   | 0 0 0 |    vd   |1010111| OP-V (OPIVV)
  funct6   | vm  |   vs2    |    vs1   | 0 0 1 |  vd/rd  |1010111| OP-V (OPFVV)
  funct6   | vm  |   vs2    |    vs1   | 0 1 0 |  vd/rd  |1010111| OP-V (OPMVV)
  funct6   | vm  |   vs2    |   simm5  | 0 1 1 |    vd   |1010111| OP-V (OPIVI)
  funct6   | vm  |   vs2    |    rs1   | 1 0 0 |    vd   |1010111| OP-V (OPIVX)
  funct6   | vm  |   vs2    |    rs1   | 1 0 1 |    vd   |1010111| OP-V (OPFVF)
  funct6   | vm  |   vs2    |    rs1   | 1 1 0 |  vd/rd  |1010111| OP-V (OPMVX)
     6        1        5          5        3        5        7
*/


module vec_decoder(	
    input [31:0] 		Instruction     ,
	input 				reset			,
	input				Inst_Cache__Stall,	//Mapped to freeze_vector{delayed /no_delayed}
	input				Data_Cache__Stall,	//Data_Cache__Stall
	output reg 			S_VECn			,
	output reg [4:0]	decode__vs1     ,	
	output reg [4:0]	decode__vs2     ,
	output reg [4:0]	decode__vd      ,
	output reg [4:0]	decode__RS1     ,
	output reg [4:0]	decode__RS2     ,
	output reg [4:0]	decode__uimm5   ,
	output reg [7:0]	decode__funct   ,
	output reg [1:0]	decode__permute ,
	output reg 			decode__mask_en ,
	output reg [1:0]	decode__ALUSrc  ,
	output reg 			decode__dmr     ,
	output reg 			decode__dmw     ,
	output reg 			decode__reg_we  ,
	output reg 			decode__mem_reg ,
	output reg 			decode__Xout    ,
	output reg [1:0]	decode__mode_lsu
    );
wire [7:0] opcode;
wire [5:0] funct6;
wire [2:0] funct3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] vs1;
wire [4:0] vs2;
wire [4:0] vd;
wire [4:0] rd;
wire [4:0] uimm5;

wire 	   vector_mask;
wire       decoder_disable;
wire 	   vector_reduction;
//////////////Decode logic		////////////////////

assign opcode 		= Instruction[6:0];
assign funct6 		= Instruction[31:26];
assign funct3 		= Instruction[14:12];
assign vector_mask 	= ~Instruction[25];
assign rs1 	  		= Instruction[19:15];
assign vs1 	  		= Instruction[19:15];
assign vs2 	  		= Instruction[24:20];
assign rs2 	  		= Instruction[24:20];
assign lsuop 	  	= Instruction[24:20];
assign vd  	  		= Instruction[11:7];
assign rd  	  		= Instruction[11:7];
assign uimm5  		= Instruction[19:15];
//////////////////////////////////////
assign decoder_disable =  Data_Cache__Stall;
//////////////////////////////////////
always @(*) begin
	if (reset|decoder_disable) 	
		S_VECn				<= 1;	//Scalar Instruction by default
	else
		S_VECn <=  ( (((opcode == `OP_VEC_LOAD) || (opcode == `OP_VEC_STORE)) &&(funct3 != 3'b0)) || ((opcode == `OP_VEC_ARITH) && funct3 !=`funct3__VCSR) )? 1'b0 : 1'b1;
end
// Note that Opcodes for Vector load/Store is same as Scalar Floatoing Point. However, for Scalar FP, funct3 is "000".
always @(*) begin
	if (reset|S_VECn) begin	
		decode__vs1         <= 0;
		decode__vs2         <= 0;
		decode__vd          <= 0;
		decode__RS1         <= 0;
		decode__RS2         <= 0;
		decode__uimm5       <= 0;
		decode__funct       <= 0;
		decode__permute     <= 0;
		decode__mask_en     <= 0;
		decode__ALUSrc      <= 0;
		decode__dmr         <= 0;
		decode__dmw         <= 0;
		decode__reg_we      <= 0;
		decode__mem_reg     <= 0;
		decode__Xout        <= 0;
		decode__mode_lsu    <= 0;

	end
	else begin

		decode__vs1 <= ((opcode == `OP_VEC_LOAD) || (opcode == `OP_VEC_STORE))? 0 : 
					   (	(opcode==`OP_VEC_ARITH)  && 
					   		((funct3 == `funct3__OPIVX) || (funct3 == `funct3__OPMVX) || (funct3 == `funct3__OPIVI)) 
					   ) ? 0 : vs1;
		decode__vs2 <= ((opcode == `OP_VEC_LOAD)  | 
						(opcode == `OP_VEC_STORE) | 
						(funct6 == `funct6__vredsum && funct3 == `funct3__OPMVV)	// vredsum instruction
					   ) ? 0 : vs2;
		decode__vd  <= vd;
		decode__RS1 <= ((opcode == `OP_VEC_LOAD) || (opcode == `OP_VEC_STORE))? rs1 : 
						((opcode==`OP_VEC_ARITH) && (funct3 == `funct3__OPIVX) | (funct3 == `funct3__OPMVX) )? rs1: 0;
		decode__RS2 <= ((opcode == `OP_VEC_LOAD) || (opcode == `OP_VEC_STORE))? 0 : lsuop;
		decode__uimm5  <= ((opcode == `OP_VEC_ARITH) &&(funct3 == `funct3__OPIVI)) ? uimm5 : 0;	
		
		if 	(opcode == `OP_VEC_ARITH) begin
		case(funct6)
			`funct6__vadd 			: decode__funct <= 8'b00000000;
			`funct6__vsub 			: decode__funct <= 8'b00000000;	//Yet to be implemented	
			`funct6__vslidedown 	: decode__funct <= 8'b00000000;	
			`funct6__vdiv 		    : decode__funct <= 8'b00001000;
			`funct6__vmulhu 		: decode__funct <= 8'b00000100;
			`funct6__vmul 		    : decode__funct <= 8'b00000001;
			`funct6__vmulhsu 	    : decode__funct <= 8'b00000010;
			`funct6__vmulh	 	    : decode__funct <= 8'b00000010;
			`funct6__vmadd	 	    : decode__funct <= 8'b00000000;	// Yet to be implemented
			`funct6__vnmsub	 	    : decode__funct <= 8'b00000000; //Yet to be implemented
			`funct6__vmacc	 	    : decode__funct <= 8'b00000011;
			`funct6__vnmsac	 	    : decode__funct <= 8'b00000100;
			`funct6__vdivu			: decode__funct <= 8'b00001000;
			`funct6__vdiv			: decode__funct <= 8'b00001001;
			`funct6__vremu			: decode__funct <= 8'b00001010;
			`funct6__vrem			: decode__funct <= 8'b00001011;
			`funct6__vdot			: decode__funct <= 8'b00000011;	// Same as MACC
			`funct6__vmax			: decode__funct <= 8'b00000101;	// for vmax and ReLu Instruction
			`funct6__vmaxval        : decode__funct <= 8'b10000000; //
			`funct6__vmaxuval       : decode__funct <= 8'b10010000; //
			`funct6__vminval        : decode__funct <= 8'b10100000; //
			`funct6__vminuval       : decode__funct <= 8'b10110000; //
			`funct6__vmaxidx        : decode__funct <= 8'b11000000; //
			`funct6__vmaxuidx       : decode__funct <= 8'b11010000; //
			`funct6__vminidx        : decode__funct <= 8'b11100000; //
			`funct6__vminuidx       : decode__funct <= 8'b11110000; //
			default 				: decode__funct <= 8'b00000000;  //vadd
		endcase
		end
		else begin
			decode__funct <=8'b0;
		end

		decode__permute <= ( (opcode == `OP_VEC_ARITH) && (funct6 ==`funct6__vslidedown) ) ? 2'b01 : 0;	//Fix to slide1down
		decode__mask_en <= vector_mask;
		//-------------decode__ALUSrc-----------------------
		if (opcode == `OP_VEC_ARITH) begin
		  if (funct3 == `funct3__OPIVX | funct3 == `funct3__OPMVX)
		      decode__ALUSrc <= 2'b01;
		  else if (funct3 == `funct3__OPIVI)
		      decode__ALUSrc <= 2'b11;
		  else
		      decode__ALUSrc <= 2'b00;
		  end
		else begin
			decode__ALUSrc <= 2'b00;
		end
		  
        //-----------------------------------------------------
		decode__dmr		<= (opcode == `OP_VEC_LOAD)   ? 1'b1 :1'b0;
		decode__dmw		<= (opcode == `OP_VEC_STORE)  ? 1'b1 :1'b0;
		decode__reg_we	<= ((opcode == `OP_VEC_LOAD)  || (opcode == `OP_VEC_ARITH))  ? (~decode__Xout ? 1'b1 :1'b0) : 1'b0;
		decode__mem_reg	<= ((opcode == `OP_VEC_LOAD))  ? 1'b1 :1'b0;
		decode__mode_lsu<= ((opcode == `OP_VEC_LOAD))  ? Instruction[27:26] :1'b0;
		//--- Vector Instructions with Scalar outputs
		if (opcode == `OP_VEC_ARITH) begin
			if ( ((funct6 == `funct6__vdot) && ((funct3 == `funct3__OPIVV)||(funct3 == `funct3__OPMVX))) ||
				 //((funct6 == `funct6__vredsum )  &&   (funct3 == `funct3__OPIVV) ) |
				 ((funct6 == `funct6__vmaxidx )  &&   (funct3 == `funct3__OPIVV) ) ||
				 ((funct6 == `funct6__vmaxuidx)   &&  (funct3 == `funct3__OPIVV) ) ||
				 ((funct6 == `funct6__vminidx )  &&   (funct3 == `funct3__OPIVV) ) ||
				 ((funct6 == `funct6__vminuidx)   &&  (funct3 == `funct3__OPIVV) ) 
				)		//Only for vredsum,vdot,vmax_min
				decode__Xout <= 1'b1;
			
			else
				decode__Xout <= 1'b0;
		end
		else
			decode__Xout <= 1'b0;
		///------------------------------------------------------
	end 
end
endmodule