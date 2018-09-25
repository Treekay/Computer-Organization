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
    input [31:0] out1; // ����ADR�Ĵ������������Ϊ������1�ĺ�ѡ
    input [31:0] out2; // ����BDR�Ĵ������������Ϊ������2�ĺ�ѡ
    input [31:0] Extout; // ��չ�������������Ϊ������2�ĺ�ѡ
    input [4:0] sa; // ��λ��,��Ϊ������1�ĺ�ѡ
    input ALUSrcA, ALUSrcB; // ������1��ѡ���ź�, ������2��ѡ���ź�
    input [2:0] ALUOp; // ALU����ѡ���ź�
    output sign, zero; // �������ķ���λ, �������Ƿ�Ϊ0�ı�־
    output reg [31:0] result; // ������
    
    output wire [31:0] A; // ������1
    output wire [31:0] B; // ������2

    // ��ALUSrcAΪ1ʱ��������1Ϊsa�� ��ALUSrcBΪ0ʱ��������2Ϊout1
    // ��ALUSrcBΪ1ʱ��������2ΪExtout����ALUSrcBΪ0��������2Ϊout2
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
            // �޷��űȽ�
            3'b010: result = (A < B) ? 1: 0;
            //  �����űȽ�
            3'b011: result = (((A < B) && (A[31] == B[31])) || (A[31] == 1 && B[31] == 0)) ? 1 : 0;
            // A ���� B λ
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
