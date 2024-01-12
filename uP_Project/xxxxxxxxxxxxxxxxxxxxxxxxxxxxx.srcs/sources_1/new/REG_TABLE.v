`timescale 1ns / 1ps

module REG(ADDR, WE, OUTPUT, INPUT, CLK);
    input CLK;
    input[4:0] ADDR;
    input WE;
    input[15:0] INPUT;
    reg [15:0] REG_TAB [0:31];
    output[15:0] OUTPUT;
    
    reg [15:0] data_out_tmp;
    
    always @(posedge CLK)
    if(WE)
        REG_TAB[ADDR] = INPUT;
    else
        data_out_tmp = REG_TAB[ADDR];
            
        assign OUTPUT = data_out_tmp;
endmodule
