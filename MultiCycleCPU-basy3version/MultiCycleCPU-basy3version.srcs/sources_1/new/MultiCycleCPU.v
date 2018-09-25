`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:58:16
// Design Name: 
// Module Name: MultiCycleCPU
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

module MultiCycleCPU(clk, Reset, stateRST, opCode, ReadData1, ReadData2, nowPC, A, B, Result, PCSrc, Extout, DMOut, DataOut,
                    immediate, rs, rt, rd, sa, zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, RD, WR, IRWre,
                    ExtSel, RegDst, ALUOp, nextPC, PC4, PCJump, PCBranch, addr, instruction, WriteReg, WriteData, nowState, nextState);
    input clk, Reset, stateRST;
    output wire [5:0] opCode;
    output wire [31:0] ReadData1, ReadData2, nowPC, Result;
    output wire [31:0] A, B;
    wire [31:0] ALUout;
    wire [31:0] out1, out2;
    output wire [1:0] PCSrc;
    output wire [31:0] Extout, DMOut, DataOut;
    wire [31:0] DMoutDR;
    output wire [15:0] immediate;
    output wire [4:0] rs, rt, rd, sa;
    output wire zero, sign;
    output wire PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, RD, WR, IRWre, ExtSel;
    output wire [1:0] RegDst;
    output wire [2:0] ALUOp;
    output wire [31:0] nextPC, PC4, PCJump, PCBranch;
    output wire [25:0] addr;
    output wire [31:0] instruction;
    wire [31:0] ins_out;
    output wire [4:0] WriteReg;
    output wire [31:0] WriteData;
    output wire [2:0] nowState, nextState;
    
    PC pc(clk, Reset, PCWre, nextPC, nowPC);
    PCAddFour pcaddfour(nowPC, PC4);
    PCJump pcjump(addr, PC4, PCJump);
    PCBranch pcbranch(PC4, Extout, PCBranch);
    PCSelector pcselector(PCSrc, PC4, PCBranch, ReadData1, PCJump, nextPC);
    InstructionMemory im(nowPC, InsMemRW, instruction);
    IR ir(clk, IRWre, instruction, ins_out, opCode, rs, rt, rd, immediate, sa, addr);
    WriteRegSelector writeregselector(RegDst, rt, rd, WriteReg);
    WriteDataSelector writedataselector(WrRegDSrc, PC4, DMoutDR, WriteData);
    RegisterFile rf(clk, RegWre, rs, rt, WriteReg, WriteData, ReadData1, ReadData2);
    ADR adr(clk, ReadData1, out1);
    BDR bdr(clk, ReadData2, out2);
    SignZeroExtend sze(immediate, ExtSel, Extout);
    ALU alu(out1, out2, Extout, sa, ALUSrcA, ALUSrcB, ALUOp, sign, zero, A, B, Result);
    ALUoutDR aludr(clk, Result, ALUout);
    DataMemory dm(ALUout, out2, RD, WR, DataOut);
    DataOutSelector dataoutselector(DBDataSrc, Result, DataOut, DMOut); 
    DBDR dbdr(clk, DMOut, DMoutDR);
    ControlUnit cu(opCode, zero, sign, clk, stateRST, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, RD, WR, IRWre, ExtSel, PCSrc, RegDst, ALUOp, nowState, nextState);
endmodule
