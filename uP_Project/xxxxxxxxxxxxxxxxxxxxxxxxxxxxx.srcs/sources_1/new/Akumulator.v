`timescale 1ns / 1ps

module Akumulator(INPUT, WE, OUTPUT, CLK);

input [15:0] INPUT;
input WE;
input CLK;
output [15:0] OUTPUT;

reg [15:0] tmp_data;

always @(posedge CLK)
    if(WE)
        tmp_data <= INPUT;
//    else
//        tmp_data <= tmp_data;

 assign OUTPUT = tmp_data;

endmodule
