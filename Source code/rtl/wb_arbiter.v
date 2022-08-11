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



module wb_arbiter(clock, reset, roundORpriority, request, priority,
grant, done);
    integer i,j,k,p,q,r,s,t,u,v; //index for "for" loops
    //-----------------------------------------------------------------
//    -------
    // parameters
    //-----------------------------------------------------------------
//    -------
    parameter NUMUNITS = 8;
    parameter ADDRESSWIDTH = $clog2(NUMUNITS); //number of bits needed to address NUMUNITS
    //-----------------------------------------------------------------
//    -------
    // input and output declarations
    //-----------------------------------------------------------------
//    -------
    input clock;
    input reset;
    input roundORpriority;
    input [NUMUNITS-1 : 0] request;
    input [ADDRESSWIDTH*NUMUNITS-1 : 0] priority;
    input done;    
    output [NUMUNITS-1 : 0] grant;
    //hack for 2-D input
    reg [ADDRESSWIDTH-1 : 0] prio [NUMUNITS-1 : 0];
    reg [ADDRESSWIDTH-1 : 0] tmp_prio;
    always@(priority) begin
        for (i=0; i<NUMUNITS; i=i+1) begin
            for (j=0; j<ADDRESSWIDTH; j=j+1)
                tmp_prio[j] = priority[i*ADDRESSWIDTH + j];
            prio[i] = tmp_prio;
        end
    end
    reg [NUMUNITS-1 : 0] grant; //registered output
    reg [NUMUNITS-1 : 0] grantD; //input to "grant" flip-flop
    reg [ADDRESSWIDTH-1 : 0] next; //index of next unit in round-robin
    reg [ADDRESSWIDTH-1 : 0] nextNext; //input to "next" flip-flop
    reg [ADDRESSWIDTH-1 : 0] scan [NUMUNITS-1 : 0];
    //stores info on the order in which to scan units for round-robin
    reg [NUMUNITS-2 : 0] found;
    //in round-robin search, stores info on where assignment is made
    reg [ADDRESSWIDTH-1 : 0] selectPrio[NUMUNITS-1 : 0];
    //holds the priorities of only those units requesting the bus
    reg [ADDRESSWIDTH-1 : 0] min;
    //holds the minimum priority of all units currently requesting the bus
    reg [NUMUNITS-1 : 0] minPrio;
    //units that have the minimum priority
    wire [NUMUNITS-1 : 0] prioRequest;
    //request signals for only those units with minimum priority
    reg [NUMUNITS-1 : 0] finalRequest;
    //requests actually examined depending on "roundORpriority"
    // flip-flop for "grant" signals
    always@(posedge clock)
    begin
        if(!reset)
#1          grant <= 0;
        else if(done)
#1          grant <= grantD;
    end
    // flip-flop for "next" register
    always@(posedge clock) begin
        if(!reset)
#1            next <= 0;
        else if(done)
#1            next <= nextNext;
    end
    //selects the priorities of units sending requests
    always@(*) begin
        for(k=0; k<NUMUNITS; k=k+1)
            selectPrio[k] = request[k] ? prio[k] : NUMUNITS-1;
    end
    //selects priority or round robin operation
    always@(*) begin
        for(r=0; r<NUMUNITS; r=r+1)
            finalRequest[r] = roundORpriority ? prioRequest[r] :
        request[r];
    end
    //this logic finds the minimum priority out of all units sending a
    //request
    always@(*) begin
        min = selectPrio[0];
        for (p=1; p<NUMUNITS; p=p+1)
            if (selectPrio[p] < min) min = selectPrio[p];
    end
    //this logic decides if the units have minimum priority
    always@(*) begin
        for(q=0; q<NUMUNITS; q=q+1)
            minPrio[q] = (prio[q]==min) ? 1:0;
    end
    //produces request signals for units that have minimum priority
    assign prioRequest = minPrio & request;
    //produces the "scan" array
    always@(*) begin
        for(s=0; s<NUMUNITS; s=s+1)
            scan[s] = (next+s < NUMUNITS) ? next+s : next+s-NUMUNITS;
    end
    //produces the "found" array
    always@(*) begin
        found[0] = finalRequest[scan[0]];
        for(t=1; t<NUMUNITS-1; t=t+1)
            found[t] = found[t-1] || finalRequest[scan[t]];
    end
    //produces inputs to "grant" flip-flops
    always@(*) begin
        grantD[scan[0]] = finalRequest[scan[0]];
        for(u=1; u<NUMUNITS; u=u+1)
        grantD[scan[u]] = finalRequest[scan[u]] && ~found[u-1];
    end
    always@(*) begin
        nextNext = 0;
        for(v=0; v<NUMUNITS-1; v=v+1)
            if(grantD[v]) nextNext = v+1;
    end
endmodule //arbiter
