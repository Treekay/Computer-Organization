`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/12 14:53:38
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


`timescale 1ns / 1ps  
  
module ALU(
    input [31:0] ReadData1, 
    input [31:0] ReadData2,
    input [31:0] inExt,
    input [4:0] insa,
    input ALUSrcA, ALUSrcB,
    input [2:0] ALUOp,
    output zero,
    output reg [31:0] result
    ); 
    // 定义两个输入端口
    wire [31:0] A;
    wire [31:0] B;

    // ALU输入端口的数据选择器
    assign A = ALUSrcA ? insa: ReadData1;
    assign B = ALUSrcB ? inExt: ReadData2;
    assign zero = result ? 0 : 1;
    always @(ReadData1 or ReadData2 or inExt or ALUSrcA or ALUSrcB or ALUOp or A or B) begin
        case(ALUOp)
            3'b000: result = A + B;
            3'b001: result = A - B;
            3'b010: result = B << A;
            3'b011: result = A | B;
            3'b100: result = A & B;
            3'b101: result = (A < B) ? 1: 0;
            3'b110: result = (((A < B) && (A[31] == B[31])) || (A[31] == 1 && B[31] == 0)) ? 1 : 0;
            3'b111: result = A ^ B;
        endcase
    end
endmodule