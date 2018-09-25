`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 12:20:38
// Design Name: 
// Module Name: Display
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


module Display(
    input clk,
    input btr,
    input reset,
    input stateRST,
    input [1:0] switch,
    output reg [3:0] display_out,
    output reg [7:0] dispcode,
    output reg [2:0] state
    );
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
    
    reg [15:0] show;
    reg [19:0] count1 = 0;
    reg [1:0] count2 = 0;
    parameter t1 = 50000;
    always @(posedge clk) begin 
        count1 <= count1 + 1;
        if (count1 == t1) begin
            count1 <= 0;
            count2 <= count2 + 1;
            if (count2 == 4) begin
                count2 <= 0;
            end
        end
    end
    reg [3:0] display_data;
    always @(count2) begin
        case (count2)
            2'b00: begin
                display_data = show[15:12];
                display_out = 4'b0111;
            end
            2'b01: begin
                display_data = show[11:8];
                display_out = 4'b1011;
            end
            2'b10: begin
                display_data = show[7:4];
                display_out = 4'b1101;
            end
            2'b11: begin
                display_data = show[3:0];
                display_out = 4'b1110;
            end
        endcase
        case (display_data)
            4'b0000 : dispcode = 8'b1100_0000;  //0??'0'-??????'1'-?¡§??
            4'b0001 : dispcode = 8'b1111_1001;  //1
            4'b0010 : dispcode = 8'b1010_0100;  //2
            4'b0011 : dispcode = 8'b1011_0000;  //3
            4'b0100 : dispcode = 8'b1001_1001;  //4
            4'b0101 : dispcode = 8'b1001_0010;  //5
            4'b0110 : dispcode = 8'b1000_0010;  //6 
            4'b0111 : dispcode = 8'b1101_1000;  //7
            4'b1000 : dispcode = 8'b1000_0000;  //8
            4'b1001 : dispcode = 8'b1001_0000;  //9
            4'b1010 : dispcode = 8'b1000_1000;  //A
            4'b1011 : dispcode = 8'b1000_0011;  //b
            4'b1100 : dispcode = 8'b1100_0110;  //C
            4'b1101 : dispcode = 8'b1010_0001;  //d
            4'b1110 : dispcode = 8'b1000_0110;  //E
            4'b1111 : dispcode = 8'b1000_1110;  //F
            default : dispcode = 8'b0000_0000;  //????
        endcase
    end
    parameter TIME_20MS = 1_000;
    
    reg point;
    reg [20:0] cnt;
    reg key_cnt;
    always @(posedge clk) begin
        if (cnt == TIME_20MS - 1) begin
            point <= btr;
        end
    end
    always @(posedge clk) begin
        if (key_cnt) begin
            cnt <= cnt + 1'b1;
        end
        else begin
            cnt <= 0;
        end
    end
    always @(posedge clk) begin
        if (key_cnt == 0 && btr != point) begin
            key_cnt <= 1;
        end
        else if (cnt == TIME_20MS - 1) begin
            key_cnt <= 0;
        end
    end
    
    MultiCycleCPU uut (
        .clk(point), 
        .Reset(reset),
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
            
    always @(posedge clk) begin
        case (switch) 
            2'b00: begin
                show[15:8] = nowPC;
                show[7:0] = nextPC;
            end
            2'b01: begin
                show[15:8] = rs;
                show[7:0] = ReadData1;
            end
            2'b10: begin
                show[15:8] = rt;
                show[7:0] = ReadData2;
            end
            2'b11: begin
                show[15:8] = Result;
                show[7:0] = DMOut;
            end
        endcase
        state = nowState;
    end
endmodule
