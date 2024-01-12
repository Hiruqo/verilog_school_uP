`timescale 1ns / 1ps

module PC(CLK, CLR, Q);
input CLK, CLR;
output reg [4:0] Q;

always @(posedge CLK or posedge CLR)
 if(CLR)
    Q <= 5'd0;
  else
    Q <= Q + 1;
    
endmodule
