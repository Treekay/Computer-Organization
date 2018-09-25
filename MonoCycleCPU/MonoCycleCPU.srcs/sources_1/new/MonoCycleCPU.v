`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/13 11:02:11
// Design Name: 
// Module Name: MonoCycleCPU
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


module MonoCycleCPU(
    input clk, Reset,
    output wire[5:0] opCode,
    output wire[31:0] Out1, Out2, curPC, Result
    );
    wire[2:0] ALUOp;
    wire[1:0] PCSrc;
    wire[31:0] Extout, DMOut;
    wire[15:0] immediate;
    wire[4:0] rs, rt, rd;
    wire[4:0] sa;
    wire zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, RD, WR, ExtSel, RegDst;

    PC pc(clk, Reset, PCWre, PCSrc, Extout, curPC);
    ALU alu(Out1, Out2, Extout, sa, ALUSrcA, ALUSrcB, ALUOp, zero, Result);
    ControlUnit cu(opCode, zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, RD, WR, ExtSel, RegDst, PCSrc, ALUOp);
    DataMemory dm(Result, Out2, RD, WR, DMOut);
    InstructionMemory im(curPC, opCode, rs, rt, rd, immediate, sa);
    RegisterFile rf(clk, RegWre, RegDst, opCode, rs, rt, rd, immediate, DBDataSrc, Result, DMOut, Out1, Out2);
    SignZeroExtend sze(immediate, ExtSel, Extout);
endmodule
