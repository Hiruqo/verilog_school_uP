`timescale 1ns / 1ps

module Dekoder_instrukcji(INSTRUKCJA, ALU_OPER, MUX_LICZBA_1, MUX_LICZBA_2,
                                ADDR_REG, LICZBA_INSTA, ADDR_RAM, WE_RAM,
                                WE_REG, WE_ACC);

input [36:0] INSTRUKCJA;

output [10:0] ALU_OPER;
output reg MUX_LICZBA_1;
output reg MUX_LICZBA_2;
output reg [15:0] ADDR_REG;
output reg [15:0] LICZBA_INSTA;
output reg [15:0] ADDR_RAM;
output reg WE_RAM;
output reg WE_REG;
output reg WE_ACC;

    always @(INSTRUKCJA)
        case (INSTRUKCJA [36:32])
            5'b00000: begin // MOV z INSTA do AKU
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b0;
                LICZBA_INSTA = INSTRUKCJA[15:0];
                ADDR_RAM <= 16'd0;
                ADDR_REG <= 16'd0;
                WE_RAM <= 1'b0;
                WE_REG <= 1'b0; 
                WE_ACC <= 1'b1;
            end
            5'b00001: begin //MOVz RAMU do AKU
                MUX_LICZBA_1 <= 1'b0; 
                MUX_LICZBA_2 <= 1'b0;
                LICZBA_INSTA = 16'd0;
                ADDR_RAM = INSTRUKCJA[15:0];
                ADDR_REG <= 16'd0;
                WE_RAM <= 1'b0;
                WE_REG <= 1'b0; 
                WE_ACC <= 1'b1;
            end
            5'b00010: begin //z REG'a do AKU
                MUX_LICZBA_2 <= 1'b1;
                ADDR_REG = INSTRUKCJA[4:0];
                WE_RAM <= 1'b0;
                WE_REG <= 1'b0; 
                WE_ACC <= 1'b1;                         
            end
            5'b00011: begin //z AKU do REG'a
               WE_RAM <= 1'b0;
               WE_REG <= 1'b1;
               ADDR_REG = INSTRUKCJA[20:16];
               WE_ACC <= 1'b0;  
            end
            5'b00100: begin // z AKU do RAMU
               MUX_LICZBA_1 <= 1'b0;
               WE_RAM <= 1'b1;
               WE_REG <= 1'b0; 
               ADDR_RAM = INSTRUKCJA[31:16];
               WE_ACC <= 1'b0;              
            end
            5'b00101: begin // ADD INSTA z RAM
               MUX_LICZBA_1 <= 1'b0;
               MUX_LICZBA_2 <= 1'b0;
               WE_RAM <= 1'b0;
               WE_REG <= 1'b0; 
               ADDR_RAM = INSTRUKCJA[31:16];
               LICZBA_INSTA = INSTRUKCJA[15:0];
               WE_ACC <= 1'b1;              
            end
            5'b00110: begin // ADD INSTA z REG
               MUX_LICZBA_1 <= 1'b0;
               MUX_LICZBA_2 <= 1'b1;
               WE_RAM <= 1'b0;
               WE_REG <= 1'b0;
               ADDR_REG = INSTRUKCJA[20:16];
               LICZBA_INSTA = INSTRUKCJA[15:0]; 
               WE_ACC <= 1'b1;             
            end
            5'b00111: begin // ADD ACC z RAM
               MUX_LICZBA_1 <= 1'b1;
               MUX_LICZBA_2 <= 1'b0;
               WE_RAM <= 1'b0;
               WE_REG <= 1'b0; 
               ADDR_RAM = INSTRUKCJA[31:16];
               WE_ACC <= 1'b1;
            end 
            5'b01000: begin // ADD ACC z REG
               MUX_LICZBA_1 <= 1'b1;
               MUX_LICZBA_2 <= 1'b1;
               WE_RAM <= 1'b0;
               WE_REG <= 1'b0;
               ADDR_REG = INSTRUKCJA[20:16];
               WE_ACC <= 1'b1;      
            end
            5'b01001: begin // INC INSTA
               MUX_LICZBA_1 <= 1'b0;
               LICZBA_INSTA = INSTRUKCJA[15:0];
               WE_RAM <= 1'b0;
               WE_REG <= 1'b0;
               WE_ACC <= 1'b1;
            end
            5'b01010: begin //INC AC
                MUX_LICZBA_1 <= 1'b1;
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b01011: begin //INC REG
                MUX_LICZBA_2 <= 1'b1;
                ADDR_REG = INSTRUKCJA[4:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b01100: begin //INC RAM
                MUX_LICZBA_2 <= 1'b0;
                ADDR_RAM = INSTRUKCJA[15:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end     
            5'b01101: begin //SUB INSTA, RAM
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b0;
                ADDR_RAM = INSTRUKCJA[15:0];
                LICZBA_INSTA = INSTRUKCJA[31:16];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b01110: begin //SUB INSTA, REG
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b1;
                ADDR_REG = INSTRUKCJA[4:0];
                LICZBA_INSTA = INSTRUKCJA[31:16];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b01111: begin //SUB ACC, RAM
                MUX_LICZBA_1 <= 1'b1;
                MUX_LICZBA_2 <= 1'b0;
                ADDR_RAM = INSTRUKCJA[15:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b10000: begin //SUB ACC, REG
                MUX_LICZBA_1 <= 1'b1;
                MUX_LICZBA_2 <= 1'b1;
                ADDR_REG = INSTRUKCJA[4:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end 
            5'b10001: begin //DEC INSTA
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b0;
                LICZBA_INSTA = INSTRUKCJA[31:16];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end     
            5'b10010: begin //DEC ACC
                MUX_LICZBA_1 <= 1'b1;
                MUX_LICZBA_2 <= 1'b0;
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end  
            5'b10011: begin //DEC REG
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b1;
                ADDR_REG = INSTRUKCJA[4:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end 
            5'b10100: begin //DEC RAM
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b0;
                ADDR_RAM = INSTRUKCJA[15:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end 
            5'b10101: begin //CMP INSTA, REG
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b1;
                ADDR_REG = INSTRUKCJA[4:0];
                LICZBA_INSTA = INSTRUKCJA[31:16];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b10110: begin //CMP INSTA, RAM
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b0;
                ADDR_RAM = INSTRUKCJA[15:0];
                LICZBA_INSTA = INSTRUKCJA[31:16];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b10111: begin //CMP ACC, REG
                MUX_LICZBA_1 <= 1'b1;
                MUX_LICZBA_2 <= 1'b1;
                ADDR_REG = INSTRUKCJA[4:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b11000: begin //CMP ACC, RAM
                MUX_LICZBA_1 <= 1'b1;
                MUX_LICZBA_2 <= 1'b0;
                ADDR_RAM = INSTRUKCJA[15:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b11001: begin //NOT INSTA
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b0;
                LICZBA_INSTA = INSTRUKCJA[31:16];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b11010: begin //NOT ACC
                MUX_LICZBA_1 <= 1'b1;
                MUX_LICZBA_2 <= 1'b0;
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b11011: begin //NOT RAM
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b0;
                ADDR_RAM = INSTRUKCJA[15:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            5'b11100: begin //NOT REG
                MUX_LICZBA_1 <= 1'b0;
                MUX_LICZBA_2 <= 1'b1;
                ADDR_REG = INSTRUKCJA[4:0];
                WE_REG <= 1'b0;
                WE_RAM <= 1'b0;
                WE_ACC <= 1'b1;
            end
            default: begin
               MUX_LICZBA_1 <= 1'b0;
               MUX_LICZBA_2 <= 1'b0;
               WE_RAM <= 1'b0;
               WE_REG <= 1'b0;
               WE_ACC <= 1'b0; 
            end
        endcase
        
        assign ALU_OPER = INSTRUKCJA[36:32];
        
endmodule
