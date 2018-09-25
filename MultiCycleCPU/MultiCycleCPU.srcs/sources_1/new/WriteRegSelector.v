`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:15:34
// Design Name: 
// Module Name: WriteRegSelector
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


module WriteRegSelector(RegDst, rt, rd, WriteReg);
    input [1:0] RegDst; // ���ھ���д�Ĵ�����Ĵ����ĵ�ַ
    input [4:0] rt, rd; // �����rt��rd�Ĵ�����ַ
    output reg [4:0] WriteReg; // д�Ĵ�����Ĵ����ĵ�ַ
    
    always @(RegDst or rt or rd) begin
        case (RegDst)
            2'b00: WriteReg <= 5'b11111; // 31�żĴ��������ڴ洢jrָ��Ҫ���صĵ�ַ
            2'b01: WriteReg <= rt;
            2'b10: WriteReg <= rd;
            default: WriteReg <= 0;
        endcase
    end
    
endmodule
