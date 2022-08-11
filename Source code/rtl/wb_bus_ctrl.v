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

module	wb_bus_ctrl(i_clk, i_rst, roundORpriority,

	i_adr, i_dat, i_we, i_stb, i_sel, i_cyc, i_cti, i_bte, o_ack, o_rty, o_err, m_dat_o,
	o_adr, o_dat, o_we, o_stb, o_cyc, o_cti, o_bte, i_ack, i_rty, i_err, s_dat_i, o_sel);
	parameter			DW=32, AW=32;
	parameter           num_master = 2;
	parameter           num_slaves = 2;
    parameter [num_slaves*AW-1:0] MATCH_ADDR = 0;
    parameter [num_slaves*AW-1:0] MATCH_MASK = 0;

    parameter idle = 1'b0;
    parameter transaction = 1'b1;
    
	// Wishbone doesn't use an i_ce signal.  While it could, they dislike
	// what it would (might) do to the synchronous reset signal, i_rst.
	input				i_clk, i_rst;
    input               roundORpriority;        //Arbitrator mode;0-> Round-robin. 1-> Priority based
	input		[(num_master*AW-1):0]	i_adr;
	input		[(num_master*DW-1):0]	i_dat;
	input		[num_master-1:0]		i_we, i_stb, i_cyc;
	input       [num_master*4-1:0]      i_sel;
	input       [num_master*3-1:0]      i_cti;
	input       [num_master*2-1:0]      i_bte;	
    input       [(DW-1):0]              s_dat_i;
	output reg [num_master-1:0]		o_ack, o_rty, o_err;
    output reg [4-1:0]  o_sel;
    output reg [3-1:0]  o_cti;
    output reg [2-1:0]  o_bte;    
	output reg [(AW-1):0]	o_adr;
	output reg [(DW-1):0]	o_dat;
	output reg [(num_master*DW-1):0]	m_dat_o;
	output reg o_we, o_stb, o_cyc;
	input  	i_ack, i_rty, i_err;
    


    integer i,j;
    reg state,nextState;
    wire roundORpriority;
    reg i_ack_int;
    wire i_ack_pulse;
    reg done;
    reg [num_master-1:0] request;
    wire [num_master-1:0] grant;
    wire [num_master*($clog2(num_master))-1:0] priority;
    
    always @(posedge i_clk ) begin
        if(i_rst) begin
#1          state <= idle;
            i_ack_int <= 1'b0;
        end
        else begin
#1          state <= nextState;
            i_ack_int <= i_ack;
        end
    end
    
    assign i_ack_pulse = i_ack_int & ~i_ack; 
    
    always @(*) begin
        case(state)
            idle: begin
#1                request <= i_stb;
                if(|i_stb) begin
                    nextState <= transaction;
                    done    <= 1'b1;
                end
                else begin
                    nextState <= idle;
                    done    <= 1'b0;
                end
            end
            transaction: begin
#1                request <= i_stb;
                done    <= i_ack_pulse;
                if(|i_stb) begin
                    nextState <= transaction;
                end
                else begin
                    nextState <= idle;
                end            
            end
            default: begin
#1                request <= 0;
                done <= 0;
                nextState <= idle;                
            end
        endcase;
    end
    
    //Arbiter Module//Takes in the all inputs which are high. Returns the one to be serviced/////
    wb_arbiter #(num_master) wa1(.clock(i_clk), .reset(~i_rst), .roundORpriority(roundORpriority), .request(request),
    .priority(priority),.grant(grant),.done(done));

    always @(*) begin    
        if(i_rst) begin
#1          o_we  <= 1'b0;
            o_sel <= 4'b0;
            o_stb <= 1'b0;
            o_cyc <= 1'b0;
            o_adr <= 32'bz;              
            o_dat <= 32'bz;
            m_dat_o <= 32'bz;
            o_cti <= 3'bz;
            o_bte <= 2'bz;
            o_ack <= 2'b0;
            o_err <= 2'b0;
            o_rty <= 2'b0;
        end
        else if(state == transaction) begin
            o_we  <= grant[0] ? i_we[0] : ( grant[1] ? i_we[1] : 1'b0 );
            o_stb <= grant[0] ? i_stb[0] : (grant[1] ?  i_stb[1] : 1'b0) ;
            o_cyc <= grant[0] ? i_cyc[0] : (grant[1] ?  i_cyc[1] : 1'b0) ;
            o_sel <= grant[0] ? i_sel >> (0 << 2) : ( grant[1] ? i_sel >> (1 << 2) : 4'b0) ;
            o_adr <= grant[0] ? (i_adr >> (0 << 5)) : ( grant[1] ? (i_adr >> (1 << 5)) : 32'bz);        
            o_dat <= grant[0] ? (i_dat >> (0 << 5)) : ( grant[1] ? (i_dat >> (1 << 5)) : 32'bz);
            m_dat_o <= grant[0] ? (s_dat_i << (0 << 5)) : ( grant[1] ? (s_dat_i << (1 << 5)) : 32'bz);     
            o_cti <= grant[0] ?  i_cti[2:0] : (grant[1] ? i_cti[5:3] : 3'bz );
            o_bte <= grant[0] ?  i_bte[1:0] : (grant[1] ? i_bte[3:2] : 2'bz );
            o_ack[0] <= grant[0] ?  i_ack : 1'b0;
            o_ack[1] <= grant[1] ?  i_ack : 1'b0;
            o_err[0] <= grant[0] ?  i_err : 1'b0;
            o_err[1] <= grant[1] ?  i_err : 1'b0;
            o_rty[0] <= grant[0] ?  i_rty : 1'b0;
            o_rty[1] <= grant[1] ?  i_rty : 1'b0;
        end
        else begin
            o_we  <= 1'b0;
            o_stb <= 1'b0;
            o_cyc <= 1'b0;
            o_sel <= 4'b0;
            o_adr <= 32'bz;              
            o_dat <= 32'bz;
            m_dat_o <= 32'bz;
            o_cti <= 3'bz;
            o_bte <= 2'bz;
            o_ack <= 2'b0;
            o_err <= 2'b0;
            o_rty <= 2'b0;     
       end 
    end
endmodule
