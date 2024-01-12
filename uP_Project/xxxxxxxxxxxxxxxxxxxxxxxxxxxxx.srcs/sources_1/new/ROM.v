`timescale 1ns / 1ps

module ROM(ADDR, COMMAND);

parameter ROM_WIDTH = 37;

output reg [ROM_WIDTH-1:0] COMMAND;
input [4:0] ADDR;

    always @(ADDR)
        case (ADDR)
            5'd1: COMMAND <= {5'b00000, 16'd0, 16'd4}; //MOV A, #4
            5'd2: COMMAND <= {5'b00100, 16'd2, 16'd0}; //MOV 2, A
            5'd3: COMMAND <= {5'b00000, 16'd0, 16'd5}; //MOV A, #5
            5'd4: COMMAND <= {5'b00100, 16'd3, 16'd0}; //MOV 3, A
            5'd5: COMMAND <= {5'b00001, 16'd0, 16'd2}; //MOV A, 2
            5'd6: COMMAND <= {5'b00000, 16'd0, 16'd11}; //MOV A, #11
            5'd7: COMMAND <= {5'b00011, 16'd5, 16'd0}; //MOV R5, A
            5'd8: COMMAND <= {5'b11001, 16'd13, 16'd0}; //NOT INSTA
            5'd9: COMMAND <= {5'b11010, 16'd0, 16'd0}; //NOT ACC
            5'd10: COMMAND <= {5'b11011, 16'd0, 16'd2}; //NOT RAM
            5'd11: COMMAND <= {5'b11100, 16'd0, 16'd5}; //NOT REG
            5'd12: COMMAND <= {5'b00101, 16'd2, 16'd5}; //ADD RAM, INSTA
            5'd13: COMMAND <= {5'b00110, 16'd5, 16'd5}; //ADD REG, INSTA
            5'd14: COMMAND <= {5'b00111, 16'd2, 16'd0}; //ADD RAM, ACC
            5'd15: COMMAND <= {5'b01000, 16'd5, 16'd0}; //ADD REG, ACC
            5'd16: COMMAND <= {5'b01001, 16'd8, 16'd0}; //INC INSTA
            5'd17: COMMAND <= {5'b01010, 16'd0, 16'd0}; //INC ACC
            5'd18: COMMAND <= {5'b01011, 16'd0, 16'd5}; //INC REG
            5'd19: COMMAND <= {5'b01100, 16'd0, 16'd2}; //INC RAM
            5'd20: COMMAND <= {5'b01101, 16'd10, 16'd2}; //SUB INSTA, RAM
            5'd21: COMMAND <= {5'b01110, 16'd10, 16'd5}; //SUB INSTA, REG
            5'd22: COMMAND <= {5'b01111, 16'd0, 16'd2}; //SUB ACC, RAM
            5'd23: COMMAND <= {5'b10000, 16'd0, 16'd5}; //SUB ACC, REG
            5'd24: COMMAND <= {5'b10001, 16'd2138, 16'd0}; //DEC INSTA
            5'd25: COMMAND <= {5'b10010, 16'd0, 16'd0}; //DEC ACC
            5'd26: COMMAND <= {5'b10011, 16'd0, 16'd5}; //DEC REG
            5'd27: COMMAND <= {5'b10100, 16'd0, 16'd2}; //DEC RAM
            5'd28: COMMAND <= {5'b10101, 16'd10, 16'd5}; //CMP INSTA, REG
            5'd29: COMMAND <= {5'b10110, 16'd5, 16'd2}; //CMP INSTA, RAM
            5'd30: COMMAND <= {5'b10111, 16'd0, 16'd5}; //CMP ACC, REG
            5'd31: COMMAND <= {5'b11000, 16'd0, 16'd2}; //CMP ACC, RAM

            default: COMMAND <= {5'b00000, 16'd0, 16'd0}; //MOV A, #0
        endcase
endmodule
            
// SPIS TRESCI:
//  00000 - MOV A, INSTA - z insta do akumulatora
//  00001 - MOV A, RAM - z RAMU do akumulatora
//  00010 - MOV A, REG - z REJESTRU do akumulatora
//  00011 - MOV REG, A - z akumulatora do REJESTRU
//  00100 - MOV RAM, A - z akumulatora do RAMU
//  00101 - ADD RAM, INSTA
//  00110 - ADD REG, INSTA
//  00111 - ADD RAM, ACC
//  01000 - ADD REG, ACC
//  01001 - INC INSTA
//  01010 - INC ACC
//  01011 - INC REG
//  01100 - INC RAM
//  01101 - SUB INSTA, RAM
//  01110 - SUB INSTA, REG
//  01111 - SUB ACC, RAM
//  10000 - SUB ACC, REG
//  10001 - DEC INSTA
//  10010 - DEC ACC
//  10011 - DEC REG
//  10100 - DEC RAM
//  10101 - CMP INSTA, REG
//  10110 - CMP INSTA, RAM
//  10111 - CMP ACC, REG
//  11000 - CMP ACC, RAM
//  11001 - NOT INSTA
//  11010 - NOT ACC
//  11011 - NOT RAM
//  11100 - NOT REG

