`timescale 1ns / 1ps

module tb;

reg CLR;
reg CLK;
wire CARRY;

TOP top(
.CLK(CLK),
.CLR(CLR),
.CARRY(CARRY)
);


// ---------------------
// ----- Testbench -----

initial CLK = 1'b0;
always #5 CLK = ~CLK;

initial begin


CLR = 1'b1;
#5 CLR = 1'b0;

#1000 $stop;
end

//initial
//$monitor($time, " COMMAND = %d",  COMMAND);

endmodule
