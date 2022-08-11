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
`timescale 1ns / 1 ps


module XADC_INST_des
        (
          dclk_in,             // Clock input for the dynamic reconfiguration port
          reset_in,            // Reset signal for the System Monitor control logic  
          adc_reg,             // Digital value corresponding to Input analog value 
          vp_in,               // Dedicated Analog Input Pair
          vn_in     );
                       
//          daddr_in,            // Address bus for the dynamic reconfiguration port          
//          den_in,              // Enable Signal for the dynamic reconfiguration port
//          di_in,               // Input data bus for the dynamic reconfiguration port
 //         dwe_in,              // Write Enable for the dynamic reconfiguration port
//          busy_out,            // ADC Busy signal
//          channel_out,         // Channel Selection Outputs
//          do_out,              // Output data bus for dynamic reconfiguration port
//          drdy_out,            // Data ready signal for the dynamic reconfiguration port
//          eoc_out,             // End of Conversion Signal
//          eos_out,             // End of Sequence Signal
                    
     
   input vp_in;
   input vn_in;
   input dclk_in;
   input reset_in;
   output reg [15:0] adc_reg;

   wire busy_out;
   wire [4:0] channel_out;
   wire [15:0] do_out;
   wire drdy_out;
   wire eoc_out;
   wire eos_out;

   wire GND_BIT;
   wire [2:0] GND_BUS3;
    
   wire FLOAT_VCCAUX;
     
   wire FLOAT_VCCINT;
     
   wire FLOAT_USER_TEMP_ALARM;

   wire alarm_out;

   reg den;
   reg rst_sync;
   reg rst_sync_int;
   reg rst_sync_int1;
   reg rst_sync_int2;

   always @(posedge reset_in or posedge dclk_in) begin
          if (reset_in) begin
              adc_reg <= 16'b0;
              end
          else if(drdy_out)
          begin
              adc_reg <= do_out;
          end
   end  


   assign GND_BIT = 0;
   assign GND_BUS3 = 3'b000;

     always @(posedge reset_in or posedge dclk_in) begin
       if (reset_in) begin
            rst_sync <= 1'b1;
            rst_sync_int <= 1'b1;
            rst_sync_int1 <= 1'b1;
            rst_sync_int2 <= 1'b1;
       end
       else begin
            rst_sync <= 1'b0;
            rst_sync_int <= rst_sync;     
            rst_sync_int1 <= rst_sync_int; 
            rst_sync_int2 <= rst_sync_int1;
       end
    end

  always @(posedge dclk_in or posedge reset_in)
  begin
  if (reset_in) begin    
    den = 1'b0;
  end
  else begin
   den = eoc_out;
  end
end

XADC_INST
xadc_wiz_inst (
      .daddr_in(7'd3),
      .dclk_in(dclk_in),
      .den_in(den),
      .di_in(16'b0),
      .dwe_in(1'b0),
      .reset_in(rst_sync_int2),
      .busy_out(busy_out),
      .channel_out(channel_out[4:0]),
      .do_out(do_out[15:0]),
      .drdy_out(drdy_out),
      .eoc_out(eoc_out),
      .eos_out(eos_out),
      .alarm_out(alarm_out),
      .vp_in(vp_in),
      .vn_in(vn_in)
      );
endmodule
