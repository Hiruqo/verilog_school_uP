`timescale 1ns / 1ps

module TOP(CLK, CLR, CARRY);
    input CLK;
    input CLR;
    output CARRY;
    
    // ----- Variables -----
// ---- PC ----
wire [4:0] Q;
// ------------

// ---- ROM ----
parameter ROM_WIDTH = 37;
wire [ROM_WIDTH-1:0] COMMAND;

// ---- Dekoder_instrukcji ----
wire [10:0] ALU_OPER;
wire MUX_LICZBA_1;
wire MUX_LICZBA_2;
wire [4:0] ADDR_REG;
wire [15:0] LICZBA_INSTA;
wire [15:0] ADDR_RAM;
wire WE_RAM;
wire WE_REG;
wire WE_ACC;

// ---- ALU ----
wire [2:0] FLAG;
wire [15:0] OUTPUT_ALU;
wire CARRY;

// ---- Akumulator ----
reg WE;
wire [15:0] OUTPUT_AKU;

// ---- MUX_ALU_LEWO ----
wire [15:0] OUTPUT_MUX_LEWO;

// ---- RAM ----
wire [15:0] OUTPUT_RAM;

// ---- MUX_ALU_PRAWO ----
wire [15:0] OUTPUT_MUX_PRAWO;

// ---- REG_BLOCK ----
wire [15:0] OUTPUT_REG;

// -------------------
// ----- Modules -----
PC program_counter(
    .CLK(CLK),
    .CLR(CLR),
    .Q(Q)
);

ROM rom(
    .ADDR(Q),
    .COMMAND(COMMAND)
);

Dekoder_instrukcji dekod(
    .INSTRUKCJA(COMMAND), 
    .ALU_OPER(ALU_OPER), 
    .MUX_LICZBA_1(MUX_LICZBA_1), 
    .MUX_LICZBA_2(MUX_LICZBA_2),
    .ADDR_REG(ADDR_REG),
    .LICZBA_INSTA(LICZBA_INSTA), 
    .ADDR_RAM(ADDR_RAM), 
    .WE_RAM(WE_RAM),
    .WE_REG(WE_REG),
    .WE_ACC(WE_ACC)
);

ALU alu(
    .IN1(OUTPUT_MUX_LEWO),
    .IN2(OUTPUT_MUX_PRAWO),
    .OPERACJA(ALU_OPER),
    .OUTPUT(OUTPUT_ALU),
    .CARRY(CARRY)
);

Akumulator aku(
    .INPUT(OUTPUT_ALU),
    .WE(WE_ACC),
    .CLK(CLK),
    .OUTPUT(OUTPUT_AKU)
);

MUX mux_ALU_lewo(
    .IN1(OUTPUT_AKU),
    .IN2(LICZBA_INSTA),
    .SEL(MUX_LICZBA_1),
    .OUTPUT(OUTPUT_MUX_LEWO)
);
RAM ram_ram(
    .INPUT(OUTPUT_AKU),
    .ADDR(ADDR_RAM),
    .CLK(CLK),
    .WE(WE_RAM),
    .OUTPUT(OUTPUT_RAM)  
);

MUX mux_ALU_prawo(
    .IN1(OUTPUT_REG),
    .IN2(OUTPUT_RAM),
    .SEL(MUX_LICZBA_2),
    .OUTPUT(OUTPUT_MUX_PRAWO)
);

REG register_block(
    .ADDR(ADDR_REG),
    .WE(WE_REG),
    .OUTPUT(OUTPUT_REG), 
    .INPUT(OUTPUT_AKU), 
    .CLK(CLK)
);
endmodule
