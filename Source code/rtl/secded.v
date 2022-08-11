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
`include "defines.v"

module secded(
    

// this module takes output of pmem memory (pmem_dout) and then checks for error and gives the correct data bits to core
// it uses the chip enable signal to check if memory is enabled
// it raises an error signal when parity doesnt match

///		 				---------------------------------
/// 					|								|
///		pmem_din -->	|								| --> mem_err_double
///		pmem_cen -->	|								| --> mem_err_single
///		mem_dout --> 	|								| --> mem_din
///		pmem_wen --> 	|			SECDED				| --> pmem_dout
///		mclk	 -->	|								|
///		puc_rst	 --> 	|								|
///						|								|
///						|								|
///		 				---------------------------------



	mclk,
	puc_rst,	
    mem_we,

	pmem_dout,
	pmem_din,
//	pmem_addr,
	addr_in,
	mem_din,
	
    ////////////////////////////////////
    clk_i,         // clock
    rst_i,         // reset (asynchronous active low)
    cyc_i,         // cycle
    stb_i,         // strobe  (cycle and strobe are the same signal)
    adr_i,         // address
    we_i,          // write enable
    dat_i,         // data output
    sel_i,         // byte select inputs
    dat_o,         // data input
    ack_o,         // normal bus termination
	//////////////////////////////
	mem_dout,
	mem_err_double,
	mem_err_single
	
);

input [31:0]  pmem_din;                                         
input 		[31:0]  addr_in;                          
input      mclk,puc_rst;   
//input 		[11:0] 	pmem_addr;	                        

input   [38:0] mem_dout;                                 
input mem_we;
/////////////////////////////////////

input  clk_i;                    // clock
input  rst_i;                    // reset (asynchronous active low)
input cyc_i;                     // cycle
input stb_i;                     // strobe  (cycle and strobe are the same signal)
input [31:0] adr_i;              // address
input  we_i;                     // write enable
input [31:0] dat_i;              // data output
input [3:0] sel_i;                // byte select inputs

output  reg [31:0]  pmem_dout;                                                        
output  [38:0] mem_din;                                       		 
output   mem_err_double,mem_err_single;            // memory error signal 

output reg [31:0] dat_o;         // data input
output    reg   ack_o;         // normal bus termination
 
///////////////////////////////////////////
//reg [31:0] pmem_dout;
reg[31:0] secded_addr_reg;  //register to record address where data has an error
reg[31:0] secded_data_reg; //register to record correct data
reg[31:0] secded_enable_reg;
reg [38:0] mem_din;
reg state,nextstate;

wire [38:0] gen_din;
wire [31:0] correctdataout;
wire[31:0] DD;
wire D[31:0];
wire P1,P2,P3,P4,P5,P6,P0; //parity

reg P0C,P1C,P2C,P3C,P4C,P5C,P6C; //check bits
parameter state0=1'b0;
parameter state1=1'b1;

wire secded_enable_reg_we;
wire wb_acc = cyc_i & stb_i;                   // WISHBONE access
wire wb_wr  = wb_acc & we_i;                   // WISHBONE write access

assign wb_err_o = cyc_i & stb_i & (sel_i != 4'b1111);
/////////////////////////////////////////////////////////

assign secded_enable_reg_we = (adr_i==`SECDED_ENABLE_REG) && cyc_i && stb_i && we_i; // signal to write to secded_enable_reg

always@(posedge  clk_i or posedge rst_i)
begin
 if (rst_i)
 #2 secded_enable_reg <= 32'hFFFFFFFF;
 else
 if (secded_enable_reg_we)
 #2 secded_enable_reg <= dat_i;  // write 0 to disable secded
end

always@(posedge  clk_i or posedge rst_i)
begin
if(rst_i)
#2  state<=state0;
else  
#2  state<=nextstate;  
end    
 /*
 Below code is to give out data and acknowlegde signals whenever wishbone transaction to secded registers is made
 
 */
always @(*)
begin
if (rst_i)
begin
       dat_o<=32'h0;

end

else

case(state)
state0:
begin
 if(cyc_i | stb_i)
 begin
     if((adr_i[31:8]==24'b000000000000000000000110) && (~we_i) )
             begin
                        dat_o<=32'h0;
                        nextstate<=state1;
                end   
  end                             
     
 else
     begin
         nextstate<=state0;
         dat_o<=32'h0;
     end
end
 
state1:
begin

nextstate<=state0;
        case (adr_i) 
            `SECDED_ADDRESS_REG : dat_o <= secded_addr_reg;
            `SECDED_DATA_REG :    dat_o <= secded_data_reg;          
            default:              dat_o <=32'h0;
          endcase;

end

default:
begin
 nextstate<=state0;
 dat_o<=32'h0;
end

endcase;     
end


always@(*)
begin
 if(state==state1)
 ack_o<=1'b1;
 else
 ack_o<=1'b0;
end
/////////////////////////////////////////////////

/////////////////////////////
// checking for pmem wen and assigning data
always @( puc_rst or correctdataout or gen_din or mem_err_double)
	if (puc_rst)
		begin
			pmem_dout = 32'b0;
			mem_din = 39'b0000000000000000000000;
		end
	else 
		if (mem_err_double)
			begin
				pmem_dout = 32'b0;
				mem_din = gen_din;
            end
		else
			begin
				pmem_dout = correctdataout;
				mem_din = gen_din;
            end



////////////////////////////////////////////////////////////////////////////////////////////////////////////
//When there is write to main memory

assign DD = pmem_din;  //input ; 32 bit data without ecc to be written to main memory 
// parity computed from data bits to write to main memory
wire PP0C = (DD[0] ^ DD[1]) ^ (DD[3] ^ DD[4]) ^ (DD[6] ^ DD[8]) ^ (DD[10] ^ DD[11]) ^ (DD[13] ^ DD[15]) ^ (DD[17] ^ DD[19]) ^ (DD[21] ^ DD[23]) ^ (DD[25] ^ DD[26]) ^ (DD[28] ^ DD[30]);//(DD15 ^ DD13) ^ (DD11 ^ DD10) ^ (DD8 ^ DD6) ^ (DD4 ^ DD3) ^ (DD1 ^ DD0);
wire PP1C = (DD[0] ^ DD[2]) ^ (DD[3] ^ DD[5]) ^ (DD[6] ^ DD[9]) ^ (DD[10] ^ DD[12]) ^ (DD[13] ^ DD[16]) ^ (DD[17] ^ DD[20]) ^ (DD[21] ^ DD[24]) ^ (DD[25] ^ DD[27]) ^ (DD[28] ^ DD[31]);//(DD13 ^ DD12) ^ (DD10 ^ DD9) ^ (DD6 ^ DD5) ^ (DD3 ^ DD2) ^ DD0;
wire PP2C = (DD[1] ^ DD[2]) ^ (DD[3] ^ DD[7]) ^ (DD[8] ^ DD[9]) ^ (DD[10] ^ DD[14]) ^  (DD[15] ^ DD[16]) ^ (DD[17] ^ DD[22]) ^ (DD[23] ^ DD[24]) ^ (DD[25] ^ DD[29]) ^ (DD[30] ^ DD[31]);//DD15 ^ (DD14 ^ DD10) ^ (DD9 ^ DD8) ^ (DD7 ^ DD3) ^ (DD2 ^ DD1);
wire PP3C = (DD[4] ^ DD[5]) ^ (DD[6] ^ DD[7]) ^ (DD[8] ^ DD[9]) ^ (DD[10] ^ DD[18]) ^ (DD[19] ^ DD[20]) ^ (DD[21] ^ DD[22] ^ DD[23]) ^ (DD[24] ^ DD[25]);//(DD10 ^ DD9) ^ (DD8 ^ DD7) ^ (DD6 ^ DD5) ^ DD4;
wire PP4C = (DD[11] ^ DD[12]) ^ (DD[13] ^ DD[14]) ^ (DD[15] ^ DD[16]) ^ (DD[17] ^ DD[18])^ (DD[19] ^ DD[20]) ^ (DD[21] ^ DD[22]) ^ (DD[23] ^ DD[24] ^ DD[25]);//(DD15 ^ DD14) ^ (DD13 ^ DD12) ^ DD11;
wire PP5C = (DD[26] ^ DD[27]) ^ (DD[28] ^ DD[29]) ^ (DD[30] ^ DD[31]);
wire PP6C = (DD[31] ^ DD[30] ^ DD[29]^ DD[28]) ^ (DD[27] ^ DD[26] ^ DD[25] ^ DD[24]) ^ (DD[23] ^ DD[22]) ^ (DD[21] ^ DD[20]) ^ (DD[19] ^ DD[18] ^ DD[17] ^ DD[16] ^ DD[15] ^ DD[14]) ^ (DD[13] ^ DD[12] ^ DD[11] ^ DD[10]) ^ (DD[9] ^ DD[8] ^ DD[7] ^ DD[6]) ^ (DD[5] ^ DD[4] ^ DD[3] ^ DD[2] ^ DD[1] ^ DD[0]) ^ (PP0C ^ PP1C) ^ (PP2C ^ PP3C) ^ (PP4C ^ PP5C);	//(DD0 ^ DD1) ^ (DD2 ^ DD3) ^ (DD4 ^ DD5) ^ (DD6 ^ DD7) ^ (DD8 ^ DD9) ^ (DD10 ^ DD11) ^ (DD12 ^ DD13) ^ (DD14 ^ DD15) ^ (PP0C ^ PP1C) ^ (PP2C ^ PP3C) ^ PP4C;		
//compute parity bits and assign data+parity to gen_din
assign gen_din = {PP6C,DD[31],DD[30],DD[29],DD[28],DD[27],DD[26],PP5C,DD[25],DD[24],DD[23],DD[22],DD[21],DD[20],DD[19],DD[18],DD[17],DD[16],DD[15],DD[14],DD[13],DD[12],DD[11],PP4C,DD[10],DD[9],DD[8],DD[7],DD[6],DD[5],DD[4],PP3C,DD[3],DD[2],DD[1],PP2C,DD[0],PP1C,PP0C};   //{PP5C,DD15,DD14,DD13,DD12,DD11,PP4C,DD10,DD9,DD8,DD7,DD6,DD5,DD4,PP3C,DD3,DD2,DD1,PP2C,DD0,PP1C,PP0C};


/////////////////////////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////
///When main memory read operation

assign {P6,D[31],D[30],D[29],D[28],D[27],D[26],P5,D[25],D[24],D[23],D[22],D[21],D[20],D[19],D[18],D[17],D[16],D[15],D[14],D[13],D[12],D[11],P4,D[10],D[9],D[8],D[7],D[6],D[5],D[4],P3,D[3],D[2],D[1],P2,D[0],P1,P0}=mem_dout[38:0];



// P0C-P6C are check bits calculated from stored parity bits

always@(D)
begin
 P0C <= (D[0] ^ D[1]) ^ (D[3] ^ D[4]) ^ (D[6] ^ D[8]) ^ (D[10] ^ D[11]) ^ (D[13] ^ D[15]) ^ (D[17] ^ D[19]) ^ (D[21] ^ D[23]) ^ (D[25] ^ D[26]) ^ (D[28] ^ D[30]);
 P1C <= (D[0]^D[2])^(D[3]^D[5])^(D[6]^D[9])^ (D[10] ^ D[12]) ^ (D[13] ^ D[16]) ^ (D[17] ^ D[20])^ (D[21] ^ D[24]) ^ (D[25] ^ D[27])^ (D[28] ^ D[31]);
 P2C <= (D[1] ^ D[2]) ^ (D[3] ^ D[7]) ^ (D[8] ^ D[9])^ (D[10] ^ D[14]) ^  (D[15] ^ D[16]) ^ (D[17] ^ D[22]) ^ (D[23] ^ D[24]) ^ (D[25] ^ D[29]) ^ (D[30] ^ D[31]);
 P3C <= (D[4] ^ D[5]) ^ (D[6] ^ D[7]) ^ (D[8] ^ D[9]) ^ (D[10] ^ D[18]) ^ (D[19] ^ D[20]) ^ (D[21] ^ D[22] ^ D[23]) ^ (D[24] ^ D[25]);
 P4C <= (D[11] ^ D[12]) ^ (D[13] ^ D[14]) ^ (D[15] ^ D[16]) ^ (D[17] ^ D[18])^ (D[19] ^ D[20]) ^ (D[21] ^ D[22]) ^ (D[23] ^ D[24] ^ D[25]);
 P5C <= (D[26] ^ D[27]) ^ (D[28] ^ D[29]) ^ (D[30] ^ D[31]);
 P6C <= (D[31] ^ D[30] ^ D[29]^ D[28]) ^ (D[27] ^ D[26] ^ D[25] ^ D[24]) ^ (D[23] ^ D[22]) ^ (D[21] ^ D[20]) ^ (D[19] ^ D[18] ^ D[17] ^ D[16] ^ D[15] ^ D[14]) ^ (D[13] ^ D[12] ^ D[11] ^ D[10]) ^ (D[9] ^ D[8] ^ D[7] ^ D[6]) ^ (D[5] ^ D[4] ^ D[3] ^ D[2] ^ D[1] ^ D[0]) ^ (P0 ^ P1) ^ (P2 ^ P3) ^ (P4 ^ P5) ;	//(D[3]^D[6]^D[8]^D[9]^D[13]^D[15]^D[16]^D[19]^D[20]^D[22]^D[25]^D[28]^D[30]^D[31]);
end

// checking if computed parity bits match with  parity bits stored in memory or not
wire errP0 = P0C ^ P0;
wire errP1 = P1C ^ P1;
wire errP2 = P2C ^ P2;
wire errP3 = P3C ^ P3;
wire errP4 = P4C ^ P4;
wire errP5 = P5C ^ P5;
wire errP6 = P6C ^ P6;

wire singleerr = (errP6==1); //single-bit error

wire doubleerr = (errP6==0) && ((errP5|errP4|errP3|errP2|errP1|errP0)!=0); //double -bit errors

reg mem_err_double,mem_err_single;
reg [1:0] count_double,count_single;
reg [15:0] latched_address;
always @(posedge mclk)
begin
	if (puc_rst)
		count_double <= 2'b00;
	else if (mem_err_double)
		count_double <= count_double + 2'b01;

end


always @(posedge mclk)
begin	
	 if (puc_rst)
	begin
	count_single <= 2'b00;
#2  secded_addr_reg <= 0;//latched_address;
#2  secded_data_reg <= 0;		
	 end
	 
	 else
	 if (mem_err_single)
	 begin
#2		count_single <= count_single + 2'b01;
#2	    secded_addr_reg <= addr_in;//latched_address;
#2	    secded_data_reg <= pmem_dout;
	 end
end	
	
always @(posedge puc_rst or posedge mclk)
begin
	if (puc_rst)
		begin	
			mem_err_double <= 1'b0;
			mem_err_single <= 1'b0;
		end
	else 
	if(mem_we==0)
		begin
			mem_err_double <= doubleerr;
			mem_err_single <= singleerr;
		end
end			
// need to correct for single errors. in case of single errors, P5 will change and xor of P4-P0 gives the location
wire [5:0] oldparity = {P5,P4,P3,P2,P1,P0};
wire [5:0] newparity = {P5C,P4C,P3C,P2C,P1C,P0C};
wire [5:0] error_location = oldparity ^ newparity;
reg [38:0] correction;

//Flip the error bit in case of single bit errors based on the syndrome
always @(mclk or error_location)
begin
case (error_location)
	6'd1:  correction = 39'b000000000000000000000000000000000000001;
	6'd2:  correction = 39'b000000000000000000000000000000000000010;
	6'd3:  correction = 39'b000000000000000000000000000000000000100; 
	6'd4:  correction = 39'b000000000000000000000000000000000001000; 
	6'd5:  correction = 39'b000000000000000000000000000000000010000; 
	6'd6:  correction = 39'b000000000000000000000000000000000100000; 
	6'd7:  correction = 39'b000000000000000000000000000000001000000; 
	6'd8:  correction = 39'b000000000000000000000000000000010000000; 
	6'd9:  correction = 39'b000000000000000000000000000000100000000; 
	6'd10: correction = 39'b000000000000000000000000000001000000000; 
	6'd11: correction = 39'b000000000000000000000000000010000000000; 
	6'd12: correction = 39'b000000000000000000000000000100000000000; 
	6'd13: correction = 39'b000000000000000000000000001000000000000; 
	6'd14: correction = 39'b000000000000000000000000010000000000000; 
	6'd15: correction = 39'b000000000000000000000000100000000000000; 
	6'd16: correction = 39'b000000000000000000000001000000000000000; 
	6'd17: correction = 39'b000000000000000000000010000000000000000; 
	6'd18: correction = 39'b000000000000000000000100000000000000000; 
	6'd19: correction = 39'b000000000000000000001000000000000000000; 
	6'd20: correction = 39'b000000000000000000010000000000000000000; 
	6'd21: correction = 39'b000000000000000000100000000000000000000;
	6'd22: correction = 39'b000000000000000001000000000000000000000;
	6'd23: correction = 39'b000000000000000010000000000000000000000;
	6'd24: correction = 39'b000000000000000100000000000000000000000;
	6'd25: correction = 39'b000000000000001000000000000000000000000;
	6'd26: correction = 39'b000000000000010000000000000000000000000;
	6'd27: correction = 39'b000000000000100000000000000000000000000;
	6'd28: correction = 39'b000000000001000000000000000000000000000;
	6'd29: correction = 39'b000000000010000000000000000000000000000;
	6'd30: correction = 39'b000000000100000000000000000000000000000;
	6'd31: correction = 39'b000000001000000000000000000000000000000;
	6'd32: correction = 39'b000000010000000000000000000000000000000;
	6'd33: correction = 39'b000000100000000000000000000000000000000;
	6'd34: correction = 39'b000001000000000000000000000000000000000;
	6'd35: correction = 39'b000010000000000000000000000000000000000;
	6'd36: correction = 39'b000100000000000000000000000000000000000;
	6'd37: correction = 39'b001000000000000000000000000000000000000;
	6'd38: correction = 39'b010000000000000000000000000000000000000;
	6'd39: correction = 39'b100000000000000000000000000000000000000;
	default: correction = 39'b0; 
	
	

endcase
end

wire [38:0] correctdata = ( |secded_enable_reg ) ? (mem_dout ^ correction):mem_dout; //Do error correction only if SECDED enable register is non-zero
assign correctdataout = {correctdata[37:32],correctdata[30:16],correctdata[14:8],correctdata[6:4],correctdata[2]}; //correct 32-bit data


endmodule

