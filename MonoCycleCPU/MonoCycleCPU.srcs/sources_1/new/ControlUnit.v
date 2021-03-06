`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/12 21:58:46
// Design Name: 
// Module Name: ControlUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ControlUnit(
    input [5:0] opCode,
    input zero,
    output PCWre,
    output ALUSrcA,
    output ALUSrcB,
    output DBDataSrc,
    output RegWre,
    output InsMemRW,
    output RD,
    output WR,
    output ExtSel,
    output RegDst,
    output [1:0] PCSrc,
    output [2:0] ALUOp
    );
    assign PCWre = (opCode == 6'b111111) ? 0 : 1;
    assign ALUSrcA = (opCode == 6'b011000) ? 1 : 0;
    assign ALUSrcB = (opCode == 6'b000001 || opCode == 6'b010000 || opCode == 6'b011011 || opCode == 6'b100110 || opCode == 6'b100111 || opCode == 6'b000011 || opCode == 6'b010011) ? 1 : 0;
    assign DBDataSrc = (opCode == 6'b100111 || opCode ==6'b100110) ? 1 : 0;
    assign RegWre = (opCode == 6'b100110 || opCode == 6'b110000 || opCode == 6'b110001 || opCode == 6'b111000 || opCode == 6'b111111) ? 0 : 1;
    assign InsMemRW = 0;
    assign RD = (opCode == 6'b100111) ? 0 : 1;
    assign WR = (opCode == 6'b100110) ? 0 : 1;
    assign RegDst = (opCode == 6'b000001 || opCode == 6'b010000 || opCode == 6'b011011 || opCode == 6'b100111 || opCode == 6'b000011 || opCode == 6'b010011) ? 0 : 1;
    assign ExtSel = (opCode == 6'b010000 || opCode == 6'b010011) ? 0 : 1;
    assign PCSrc[1] = (opCode == 6'b111000) ? 1: 0;
    assign PCSrc[0] = (opCode == 6'b110000 && zero == 1|| opCode == 6'b110001 && zero == 0) ? 1 : 0;
    assign ALUOp[2] = (opCode == 6'b010001 || opCode == 6'b011011 || opCode == 6'b010011 || opCode == 6'b010100) ? 1 : 0;
    assign ALUOp[1] = (opCode == 6'b010000 || opCode == 6'b010010 || opCode == 6'b011000 || opCode == 6'b010100) ? 1 : 0;
    assign ALUOp[0] = (opCode == 6'b000010 || opCode == 6'b010000 || opCode == 6'b010010 || opCode == 6'b011011 || opCode == 6'b110000 || opCode == 6'b110001 || opCode == 6'b000011 || opCode == 6'b010100) ? 1 : 0;
endmodule
