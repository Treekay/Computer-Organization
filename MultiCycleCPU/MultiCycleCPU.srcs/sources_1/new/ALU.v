`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:57:00
// Design Name: 
// Module Name: ALU
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

module ALU(out1, out2, Extout, sa, ALUSrcA, ALUSrcB, ALUOp, sign, zero, A, B, result);
    input [31:0] out1; // 来自ADR寄存器的输出，作为操作数1的候选
    input [31:0] out2; // 来自BDR寄存器的输出，作为操作数2的候选
    input [31:0] Extout; // 拓展后的立即数，作为操作数2的候选
    input [4:0] sa; // 移位数,作为操作数1的候选
    input ALUSrcA, ALUSrcB; // 操作数1的选择信号, 操作数2的选择信号
    input [2:0] ALUOp; // ALU功能选择信号
    output sign, zero; // 运算结果的符号位, 运算结果是否为0的标志
    output reg [31:0] result; // 运算结果
    
    output wire [31:0] A; // 操作数1
    output wire [31:0] B; // 操作数2

    // 当ALUSrcA为1时，操作数1为sa； 当ALUSrcB为0时，操作数2为out1
    // 当ALUSrcB为1时，操作数2为Extout；当ALUSrcB为0，操作数2为out2
    assign A = ALUSrcA ? sa: out1;
    assign B = ALUSrcB ? Extout: out2;
    
    assign zero = result ? 0 : 1;
    assign sign = result[31] ? 1 : 0;
    always @(out1 or out2 or Extout or ALUSrcA or ALUSrcB or ALUOp or A or B) begin
        case(ALUOp)
            // A + B
            3'b000: result = A + B;
            // A - B
            3'b001: result = A - B;
            // 无符号比较
            3'b010: result = (A < B) ? 1: 0;
            //  带符号比较
            3'b011: result = (((A < B) && (A[31] == B[31])) || (A[31] == 1 && B[31] == 0)) ? 1 : 0;
            // A 左移 B 位
            3'b100: result = B << A;
            // A | B
            3'b101: result = A | B;
            // A & B
            3'b110: result = A & B;
            // A ^ B
            3'b111: result = A ^ B;
        endcase
    end
endmodule
