`timescale 1ns / 1ps

module MUX(IN1, IN2, SEL, OUTPUT);

input [15:0] IN1;
input [15:0] IN2;
input SEL;
output reg[15:0] OUTPUT;

always @(SEL) begin
    assign OUTPUT = SEL ? IN1 : IN2;
end

endmodule
