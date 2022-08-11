`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DESE, IISc
// Engineer: V Naveen Chander
// 
// Create Date: 02.04.2021 11:28:03
// Design Name: 
// Module Name: v_wrapper
// Project Name: riscv_v_cpu 
// Target Devices: 
// Tool Versions: 
// Description: Verilog Wrapper for Vector Execution unit
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Added I_Xout for Vector Reduction Operations (26th April 2021)
// 
//////////////////////////////////////////////////////////////////////////////////


module v_wrapper(
input 			clk 			,
input 			reset 			,
input [8:0]		vl				,	// Vector LENGTH Register
input [1:0]		vcsr_quant		,	// Vector Quantization Register
input 			I_clear			,	// Clear all instructions
input [2:0]		I_id			,	// Instruction 0 --> 7
output 			ALU_mon         ,
output 			stall			,
output  		DONE            ,
//Processor interface Related   ,
input [31:0]	proc_addr		,
input [31:0]	proc_din		,
output[31:0]	proc_dout		,
input			proc_we			,
//XRF INterface
output [4:0]	XRF_ADDR		,
output [31:0]	XRF_DATAWR		,
output          XRF_WE			,
//
input 			I_start   		,
input [4:0]		I_vs1     		,
input [4:0]		I_vs2     		,
input [4:0]		I_vd      		,
input [31:0]	I_RS1    		,
input [31:0]	I_RS2    		,
input [4:0]		I_uimm5    		,
input [7:0]		I_funct   		,
input [1:0]		I_permute   	,
input 			I_mask_en 		,
input [1:0]		I_ALUSrc  		,
input 			I_dmr     		,
input 			I_dmw     		,
input 			I_reg_we  		,
input 			I_mem_reg 		,
input 			I_Xout  		,
input [1:0]		I_mode_lsu		
);


wrapper wrapper_vhd(
	.clk 			(clk 		),
	.reset 			(reset 		),
	.vl				(vl			),
	.vcsr_quant     (vcsr_quant ),
	.I_clear		(I_clear	),
	.I_id			(I_id		),
	.ALU_mon     	(ALU_mon    ),
	.stall			(stall		),
	.DONE        	(DONE       ),
	.PROC_ADDR		(proc_addr	),
	.PROC_DIN		(proc_din   ),
	.PROC_DOUT      (proc_dout  ),
	.PROC_WE        (proc_we    ),
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
	.I_Xout 		(I_Xout  	),
	.I_mode_lsu		(I_mode_lsu	)
	);
endmodule