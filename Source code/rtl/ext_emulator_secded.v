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



module ext_emulator_secded(clk,rst,wb_dat_i,wb_cyc_o,wb_adr_o,wb_stb_o,wb_we_o,wb_sel_o,wb_dat_o,wb_cti_o,wb_bte_o,clmode,
wb_ack_i,wb_err_i,wb_rty_i,);


input rst;
input clk;
input wb_cyc_o;
input [31:0] wb_adr_o;
input wb_stb_o;
input wb_we_o;
input [3:0] wb_sel_o;
input [31:0] wb_dat_o;
input [2:0] wb_cti_o;
input [1:0] wb_bte_o;

output reg [31:0] wb_dat_i;
output reg wb_ack_i;
output reg wb_err_i;
output reg wb_rty_i;
output reg [1:0] clmode;
wire mem_err_double;
wire mem_err_single;
wire [31:0] dat_o;
wire ack_o;

reg [2:0] state,nxstate;
reg [3:0] count;
integer k;
integer j;

localparam START = 3'b000;
localparam A = 3'b001;
localparam READ_B = 3'b010;
localparam READ_C = 3'b011;
localparam READ_D = 3'b100;
localparam WRITE_B = 3'b101;
localparam WRITE_C = 3'b110;
localparam WRITE_D = 3'b111;

reg [31:0] addra;
reg [31:0] dina;
reg [3:0] wea;
reg ena;
wire [38:0] douta;
wire [31:0] data_to_core;
wire mem_we =0;
wire [38:0] mem_wr;

always @(posedge clk ) begin
    if(rst) begin
#1        k <= 0;
    end
    else begin
        if(wb_stb_o & wb_cyc_o & (count == 4'b1111)) begin                               //Latch the first address if the burst//Use this for subsequent increments
#1            k <= wb_adr_o[31] ? (~(wb_adr_o) + 32'd1) : wb_adr_o;
        end
    end
end

reg dat;

always @(posedge clk ) begin
    if(rst) begin
        dat <= 1'b0;
    end
    else if ( (wb_adr_o == 32'h21234) )begin
        dat <= 1'b1;
    end
    else
        dat <= 1'b0;
end

mainMem_secded Main_secded(
  .clka(clk), // input clka
  .ena(~ena), // input ena
  .wea(wea), // input [3 : 0] wea
  .addra(addra>>2), // input [31 : 0] addra
  .dina(mem_wr), // input [31 : 0] dina
  .douta(douta) // output [31 : 0] douta
);

secded s1(
.mclk(clk),
.puc_rst(rst),
.pmem_dout(data_to_core),//output; main instruction memory data of 32 bits to be given to core when main memory read
.mem_we(mem_we),   //memory write
.pmem_din(dina),     //input ; 32 bit data without ecc to be written to main memory //not used here as instruction memory is read only
.mem_din(mem_wr),     //output ; 39 bit data with ecc to be written to main memory //not used here as instruction memory is read only
////////////////////////////////////
 .clk_i(clk),         // clock
 .rst_i(rst),         // reset (asynchronous active low)
 .cyc_i(wb_cyc_o),         // cycle
 .stb_i(wb_stb_o),         // strobe  (cycle and strobe are the same signal)
 .adr_i(wb_adr_o),         // address
 .we_i(wb_we_o),          // write enable
 .dat_i(wb_dat_o),         // data output
     
 .sel_i(wb_sel_o),         // byte select inputs
     
 .dat_o(dat_o),         // data input
 .ack_o(ack_o),         // normal bus termination
	//////////////////////////////
.mem_dout(douta),          // input ; main instruction memory data of 39 bits
.mem_err_double(mem_err_double), // connected to interrupt line for double bit errors
.mem_err_single(mem_err_single), // connected to interrupt line for singl bit errors
.addr_in((addr))
); 
 
always @(posedge clk ) begin
    if(rst) begin
#1        clmode <= 2'b00;
        wb_rty_i <= 1'b0;
        wb_err_i <= 1'b0;
    end
    else begin
#1        clmode <= 2'b00;
        wb_rty_i <= 1'b0;
        wb_err_i <= 1'b0;
    end
end

always @(posedge clk) begin
    if(rst) begin
#1        count <= 4'b1111;
    end
    else begin
        if(wb_stb_o & wb_cyc_o) begin
#1            case(wb_bte_o)
                2'b00:  count <= count + 1;
                2'b01:  count <= count + 1;                 //TODO: change the count sequence for different burst-type extensions
                2'b10:  count <= count + 1;
                2'b11:  count <= count + 1;
                default:  count <= count + 1;
            endcase;
        end
        else if (wb_stb_o & wb_cyc_o & (wb_cti_o == 3'b111) & (count == 4'b1111)) begin
#1            count <= 4'b1100;
        end
        else begin
            count <= 4'b1111;
        end
    end
end

always @(*) begin
    case(count)
        4'b0000: begin
            addra <= k;
            dina <= wb_dat_o;
            wea <= {4{wb_we_o}};
            ena <= 1'b0;
        end
        4'b0001: begin
            addra <= k+4;
            dina <= wb_dat_o;
            wea <= {4{wb_we_o}};
            ena <= 1'b0;
        end
        4'b0010: begin
            addra <= k+8;
            dina <= wb_dat_o;
            wea <= {4{wb_we_o}};
            ena <= 1'b0;
        end
        4'b0011: begin
            addra <= k+12;
            dina <= wb_dat_o;
            wea <= {4{wb_we_o}};
            ena <= 1'b0;
        end
        4'b0100: begin
            addra <= k+16;
            dina <= wb_dat_o;
            wea <= {4{wb_we_o}};
            ena <= 1'b0;
        end
        4'b0101: begin
            addra <= k+20;
            dina <= wb_dat_o;
            wea <= {4{wb_we_o}};
            ena <= 1'b0;
        end
        4'b0110: begin
            addra <= k+24;
            dina <= wb_dat_o;
            wea <= {4{wb_we_o}};
            ena <= 1'b0;
        end
        4'b0111: begin
            addra <= k+28;
            dina <= wb_dat_o;
            wea <= {4{wb_we_o}};
            ena <= 1'b0;
        end
//////  Classic Cycle Transfer /////
        4'b1100: begin
            addra <= wb_adr_o;
            dina <= wb_dat_o;
            wea <= {4{wb_we_o}};
            ena <= 1'b0;
        end        
        default: begin
            addra <= 0;
            dina <= 0;
            wea <= 0;
            ena <= 1'b1;
        end
    endcase;
end


always @(*) begin
    case(count) 
    // **       This case added to give wb_ack at count oooo only in write operation   -- P  ** // 
        4'b0000 : begin
            wb_ack_i <= wb_we_o;
            wb_dat_i <= 32'b0;
        end 
    // **
        4'b0001 : begin
            wb_ack_i <= 1'b1;
            wb_dat_i <= data_to_core;
        end 
        4'b0010 : begin
            wb_ack_i <= 1'b1;
            wb_dat_i <= data_to_core;
        end    
        4'b0011 : begin
            wb_ack_i <= 1'b1;
            wb_dat_i <= data_to_core;
        end
        4'b0100 : begin
            wb_ack_i <= 1'b1;
            wb_dat_i <= data_to_core;
        end   
        4'b0101 : begin
            wb_ack_i <= 1'b1;
            wb_dat_i <= data_to_core;
        end
        4'b0110 : begin
            wb_ack_i <= 1'b1;
            wb_dat_i <= data_to_core;
        end
        4'b0111 : begin
            wb_ack_i <= 1'b1;                
            wb_dat_i <= data_to_core;
        end
        4'b1000 : begin
            wb_ack_i <= 1'b1;                
            wb_dat_i <= data_to_core;
        end
        4'b1001 : begin
            wb_ack_i <= 1'b0;                                        
            wb_dat_i <= data_to_core;
        end
        4'b1001 : begin
            wb_ack_i <= 1'b0;                                        
            wb_dat_i <= data_to_core;
        end        
        default : begin
            wb_ack_i <= 1'b0;
            wb_dat_i <= 0;
        end                                                                                       
    endcase;
end

endmodule
