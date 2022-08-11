`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////
///                                                               //// 
/// Wishbone multiplexer, burst-compatible                        ////
///                                                               ////
/// Simple mux with an arbitrary number of slaves.                ////
///                                                               ////
/// The parameters MATCH_ADDR and MATCH_MASK are flattened arrays ////
/// aw*NUM_SLAVES sized arrays that are used to calculate the     ////
/// active slave. slave i is selected when                        ////
/// (wb_adr_i & MATCH_MASK[(i+1)*aw-1:i*aw] is equal to           ////
/// MATCH_ADDR[(i+1)*aw-1:i*aw]                                   ////
/// If several regions are overlapping, the slave with the lowest ////
/// index is selected. This can be used to have fallback          ////
/// functionality in the last slave, in case no other slave was   ////
/// selected.                                                     ////
///                                                               ////
/// If no match is found, the wishbone transaction will stall and ////
/// an external watchdog is required to abort the transaction     ////
///                                                               ////
/// Olof Kindgren, olof@opencores.org                             ////
///                                                               ////
/// Todo:                                                         ////
/// Registered master/slave connections                           ////
/// Rewrite with System Verilog 2D arrays when tools support them ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2013 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

`include "verilogutils.vh"


module wb_mux

   (wb_clk_i,wb_rst_i,
    wbm_adr_i,
wbm_dat_i,
wbm_sel_i,
wbm_we_i,
wbm_cyc_i,
wbm_stb_i,
wbm_cti_i,
wbm_bte_i,
wbm_dat_o,
wbm_ack_o,
wbm_err_o,
wbm_rty_o, 

wbs_adr_o,
wbs_dat_o,
wbs_sel_o, 
wbs_we_o,
wbs_cyc_o,
wbs_stb_o,
wbs_cti_o,
wbs_bte_o,
 wbs_dat_i,
 wbs_ack_i,
 wbs_err_i,
 wbs_rty_i);
   
    parameter dw = 32;        // Data width
    parameter aw = 32;        // Address width
    parameter num_slaves = 4; // Number of slaves
    parameter [aw*num_slaves-1:0] MATCH_ADDR = {32'h5f100700, 32'h5f100800, 32'h5f000600, 32'h00000000};
    parameter [aw*num_slaves-1:0] MATCH_MASK = {num_slaves{32'hff000000}};

   input                      wb_clk_i;
    input 		       wb_rst_i;

    // Master Interface
    input [aw-1:0] 	       wbm_adr_i;
    input [dw-1:0] 	       wbm_dat_i;
    input [3:0] 	       wbm_sel_i;
    input 		           wbm_we_i;
    input 		           wbm_cyc_i;
    input 		           wbm_stb_i;
    input [2:0] 	       wbm_cti_i;
    input [1:0] 	       wbm_bte_i;
    output [dw-1:0] 	   wbm_dat_o;
    output 		           wbm_ack_o;
    output 		           wbm_err_o;
    output 		           wbm_rty_o; 
    // Wishbone Slave interface
    output [num_slaves*aw-1:0] wbs_adr_o;
    output [num_slaves*dw-1:0] wbs_dat_o;
    output [num_slaves*4-1:0]  wbs_sel_o; 
    output [num_slaves-1:0]    wbs_we_o;
    output [num_slaves-1:0]    wbs_cyc_o;
    output [num_slaves-1:0]    wbs_stb_o;
    output [num_slaves*3-1:0]  wbs_cti_o;
    output [num_slaves*2-1:0]  wbs_bte_o;
    input  [num_slaves*dw-1:0]  wbs_dat_i;
    input  [num_slaves-1:0]     wbs_ack_i;
    input  [num_slaves-1:0]     wbs_err_i;
    input  [num_slaves-1:0]     wbs_rty_i;


///////////////////////////////////////////////////////////////////////////////
// Master/slave connection
///////////////////////////////////////////////////////////////////////////////

   parameter slave_sel_bits = num_slaves > 1 ? $clog2(num_slaves) : 1;

   reg  			 wbm_err;
   wire [slave_sel_bits-1:0] 	 slave_sel;
   wire [num_slaves-1:0] 	 match;
   wire [6:0] slave_sel_adr_dat;
   wire [6:0] slave_sel_sel;
   genvar 			 idx;

   generate
      for(idx=0; idx<num_slaves ; idx=idx+1) begin : addr_match
	 assign match[idx] = (wbm_adr_i & MATCH_MASK[idx*aw+:aw]) == MATCH_ADDR[idx*aw+:aw];
      end
   endgenerate
   
   integer ff1;
   integer i,j;
    always @(*) begin
        if(wb_rst_i) ff1 = 0;
        else begin 
            ff1 = 0;       
            for(i = num_slaves-1; i >= 0; i=i-1) begin
                if (match[i])
                    ff1 = i;
            end
        end
    end

   assign slave_sel = ff1;

   always @(posedge wb_clk_i)
     wbm_err <= wbm_cyc_i & !(|match);
   
   assign slave_sel_adr_dat = slave_sel << 5;
   assign slave_sel_sel = slave_sel << 2;
   
   assign wbs_adr_o = wb_rst_i ? 0 : (wbm_adr_i << (slave_sel_adr_dat));         //Shift the adr signal 32 positions for the next slave
   assign wbs_dat_o = wb_rst_i ? 0 : (wbm_dat_i << (slave_sel_adr_dat));         //Shift the dat signal 32 positions for the next slave
   assign wbs_sel_o = wb_rst_i ? 0 : (wbm_sel_i << (slave_sel_sel));         //Shift the sel signal 4 positions for the next slave
   assign wbs_we_o  = wb_rst_i ? 0 : (wbm_we_i << slave_sel);          //Shift the we signal 1 position for the next slave

   assign wbs_cyc_o = wb_rst_i ? 0 : (wbm_cyc_i << slave_sel);      //Shift the cyc signal 1 position for the next slave
   assign wbs_stb_o = wb_rst_i ? 0 : (wbm_stb_i << slave_sel);      //Shift the stb signal 1 position for the next slave
   
   assign wbs_cti_o = wb_rst_i ? 0 : {num_slaves{wbm_cti_i}};         //Shift the cti signal 3 positions for the next slave
   
//   for(i=0; i < num_slaves; i=i+1) begin
//        if(wbs_cyc_o[i]) begin
//            for(j=0; j<i;j=j+1) begin
//                wbs_cti_int <= match & (wbm_cti_i << 3);
//            end
//        end
//   end 
   
   assign wbs_bte_o = wb_rst_i ? 0 : (wbm_bte_i << (slave_sel << 1));         //Shift the bte signal 2 positions for the next slave

   assign wbm_dat_o = wb_rst_i ? 0 : wbs_dat_i[slave_sel*dw+:dw];
   assign wbm_ack_o = wb_rst_i ? 0 : wbs_ack_i[slave_sel];
   assign wbm_err_o = wb_rst_i ? 0 : wbs_err_i[slave_sel] | wbm_err;
   assign wbm_rty_o = wb_rst_i ? 0 : wbs_rty_i[slave_sel];

endmodule
