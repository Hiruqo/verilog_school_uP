`timescale 1ns / 1ps

module RAM(INPUT, ADDR, CLK, WE, OUTPUT);

input [15:0] INPUT;
input [15:0] ADDR;
input CLK, WE;
output [15:0] OUTPUT;
reg [15:0] RAM_TAB [0:65535];

always @(posedge CLK)
    if(WE == 1)
        RAM_TAB[ADDR] <= INPUT;

assign OUTPUT = RAM_TAB[ADDR];

endmodule
