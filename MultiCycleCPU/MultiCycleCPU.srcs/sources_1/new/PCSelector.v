`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:56:17
// Design Name: 
// Module Name: PCSelector
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


module PCSelector(PCSrc, PC4, PCBranch, PCBack, PCJump, nextPC);
    input [1:0] PCSrc; // ���ھ������ĸ�����ĵ�ַ��Ϊ��һ��PC��ַ
    input [31:0] PC4, PCBranch, PCBack, PCJump;
    output reg [31:0] nextPC;
    
    // �����ָ���л�õ���ת��ַ��PC+4��ַ����֧��ַ��PC���ص�ַ
    // ����PCSrcѡ��һ����ַ��Ϊ��һ��PC��ַ����������Ϊ��������ĵ�ַ��PCSrc
    always @(PCSrc or PC4 or PCBranch or PCBack or PCJump) begin
        case (PCSrc)
            0: nextPC <= PC4;
            1: nextPC <= PCBranch;
            2: nextPC <= PCBack;
            3: nextPC <= PCJump;
            default: nextPC <= 0;
        endcase
    end
endmodule
