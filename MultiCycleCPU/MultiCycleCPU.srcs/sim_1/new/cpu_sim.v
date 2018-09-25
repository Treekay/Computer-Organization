`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 22:52:40
// Design Name: 
// Module Name: cpu_sim
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


module cpu_sim;
    // inputs
    reg clk, Reset, stateRST;
    // outputs
    wire [2:0] nowState, nextState;
    wire [31:0] nowPC, nextPC;
    wire [31:0] instruction;
    wire [5:0] opCode;
    wire [2:0] ALUOp;
    wire [31:0] ReadData1, ReadData2, A, B, Result;
    wire zero, sign;
    wire PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, RD, WR, IRWre, ExtSel;
    wire [1:0] PCSrc, RegDst;
    wire [15:0] immediate;
    wire [4:0] rs, rt, rd, sa;
    wire [31:0] PC4, PCJump, PCBranch;
    wire [25:0] addr;
    wire [31:0] Extout, DMOut, DataOut;
    wire [4:0] WriteReg;
    wire [31:0] WriteData;

    // Instantiate the Unit Under Test (UUT)
    MultiCycleCPU cpu(
        .clk(clk),
        .Reset(Reset), 
        .stateRST(stateRST),
        .opCode(opCode),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .nowPC(nowPC),
        .A(A),
        .B(B),
        .Result(Result),
        .PCSrc(PCSrc), 
        .Extout(Extout), 
        .DMOut(DMOut), 
        .DataOut(DataOut), 
        .immediate(immediate),
        .rs(rs), 
        .rt(rt), 
        .rd(rd), 
        .sa(sa), 
        .zero(zero), 
        .sign(sign), 
        .PCWre(PCWre), 
        .ALUSrcA(ALUSrcA), 
        .ALUSrcB(ALUSrcB), 
        .DBDataSrc(DBDataSrc), 
        .RegWre(RegWre), 
        .WrRegDSrc(WrRegDSrc), 
        .InsMemRW(InsMemRW), 
        .RD(RD), 
        .WR(WR), 
        .IRWre(IRWre),
        .ExtSel(ExtSel), 
        .RegDst(RegDst), 
        .ALUOp(ALUOp), 
        .nextPC(nextPC), 
        .PC4(PC4), 
        .PCJump(PCJump),
        .PCBranch(PCBranch), 
        .addr(addr), 
        .instruction(instruction), 
        .WriteReg(WriteReg), 
        .WriteData(WriteData),
        .nowState(nowState),
        .nextState(nextState)
    );

    initial begin
        // Initialize Inputs
      clk = 0;
      Reset = 0;
      stateRST = 0;
      #50;
        clk = 1;
      #50;
        Reset = 1;
      forever #50 begin // ?¨²?¨²?¡À??????
          clk = !clk;
      end
    end
endmodule