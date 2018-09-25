`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:57:40
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

module ControlUnit(opcode, zero, sign, clk, reset, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, RD, WR, IRWre, ExtSel, PCSrc, RegDst, ALUOp, nowState, nextState);
    input [5:0]opcode;
    input zero, sign, clk, reset;
    output wire PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, RD, WR, IRWre, ExtSel;
    output wire [1:0] PCSrc, RegDst;
    output wire [2:0] ALUOp;
    output wire [2:0] nowState, nextState;

    DFlipFlop DFlipFlop(nextState, clk, reset, nowState);
    NextState NextState(nowState, opcode, nextState);
    OutputFunction OutputFunction(nowState, opcode, zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, RD, WR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);

endmodule
