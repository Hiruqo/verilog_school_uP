`timescale 1ns / 1ps

module ALU(IN1, IN2, OPERACJA, FLAG, OUTPUT, CARRY);

input [15:0] IN1;
input [15:0] IN2;
input [4:0] OPERACJA;
output reg [2:0] FLAG;
output [15:0] OUTPUT;
reg [15:0] temp_out;  
output CARRY;
reg [16:0] CARRY_TMP;

 always @*
      case (OPERACJA)
         5'b00000: begin 
            temp_out = IN1;
         end
         5'b00001: begin 
            temp_out = IN2;
         end
         5'b00010: begin 
            temp_out = IN2;
         end
         5'b00100: begin
            temp_out = IN1;
         end
         5'b00011: begin
            temp_out = IN1;
         end
         5'b00101: begin
            temp_out = IN1 + IN2;
            CARRY_TMP = {1'b0, IN1} + {1'b0, IN2};
         end
         5'b00110: begin
            temp_out = IN1 + IN2;
            CARRY_TMP = {1'b0, IN1} + {1'b0, IN2};
         end
         5'b00111: begin
            temp_out = IN1 + IN2;
            CARRY_TMP = {1'b0, IN1} + {1'b0, IN2};
         end
         5'b01000: begin
            temp_out = IN1 + IN2;
            CARRY_TMP = {1'b0, IN1} + {1'b0, IN2};
         end
         5'b01001: begin //INC INSTA
            temp_out = IN1 + 1;
            CARRY_TMP = {1'b0, IN1} + 1;
         end
         5'b01010: begin //INC AC
            temp_out = IN1 + 1;
            CARRY_TMP = {1'b0, IN1} + 1;
         end
         5'b01011: begin //INC REG
            temp_out = IN2 + 1;
            CARRY_TMP = {1'b0, IN2} + 1;
         end
         5'b01100: begin //INC RAM
            temp_out = IN2 + 1;
            CARRY_TMP = {1'b0, IN2} + 1;
         end
         5'b01101: begin //SUB RAM, INSTA
            temp_out = IN1 - IN2;
            CARRY_TMP = {1'b0, IN1} - {1'b0, IN2};
         end
         5'b01110: begin //SUB REG, INSTA
            temp_out = IN1 - IN2;
            CARRY_TMP = {1'b0, IN1} - {1'b0, IN2};
         end
         5'b01111: begin //SUB RAM, ACC
            temp_out = IN1 - IN2;
            CARRY_TMP = {1'b0, IN1} - {1'b0, IN2};
         end
         5'b10000: begin //SUB REG, ACC
            temp_out = IN1 - IN2;
            CARRY_TMP = {1'b0, IN1} - {1'b0, IN2};
         end
         5'b10001: begin //DEC INSTA
            temp_out = IN1 - 1;
            CARRY_TMP = {1'b0, IN1} - 1;
         end
         5'b10010: begin //DEC ACC
            temp_out = IN1 - 1;
            CARRY_TMP = {1'b0, IN1} - 1;
         end
         5'b10011: begin //DEC REG
            temp_out = IN2 - 1;
            CARRY_TMP = {1'b0, IN2} - 1;
         end 
         5'b10100: begin //DEC RAM
            temp_out = IN2 - 1;
            CARRY_TMP = {1'b0, IN2} - 1;
         end
         5'b10101: begin //CMP INSTA, REG
            temp_out = IN1 < IN2 ? 1 : 0;
            CARRY_TMP = 16'd0;
         end
         5'b10110: begin //CMP INSTA, RAM
            temp_out = IN1 < IN2 ? 1 : 0;
            CARRY_TMP = 16'd0;
         end  
         5'b10111: begin //CMP ACC, REG
            temp_out = IN1 < IN2 ? 1 : 0;
            CARRY_TMP = 16'd0;
         end
         5'b11000: begin //CMP ACC, RAM
            temp_out = IN1 < IN2 ? 1 : 0;
            CARRY_TMP = 16'd0;
         end
         5'b11001: begin //NOT INSTA
            temp_out = ~IN1 + 1;
            CARRY_TMP = 16'd0;
         end
         5'b11010: begin //NOT ACC
            temp_out = ~IN1 + 1;
            CARRY_TMP = 16'd0;
         end
         5'b11011: begin //NOT RAM
            temp_out = ~IN2 + 1;
            CARRY_TMP = 16'd0;
         end
         5'b11100: begin //NOT REG
            temp_out = ~IN2 + 1;
            CARRY_TMP = 16'd0;
         end
         default: begin
            temp_out = 16'd0;
            CARRY_TMP = 16'd0;
         end
     endcase
     
     assign OUTPUT = temp_out;
     assign CARRY = CARRY_TMP[16];
     

endmodule
