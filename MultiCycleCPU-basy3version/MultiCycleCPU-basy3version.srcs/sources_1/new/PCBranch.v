`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:50:57
// Design Name: 
// Module Name: PCBranch
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


module PCBranch(PC4, Extout, PCBranch);
    input [31:0] PC4; //��ǰPC+4��ĵ�ַ
    input [31:0] Extout; //����λ��չ�����תƫ����(����ָ���еĵ�ַ���ֽڵ�ַ����Ҫ��4
    output wire [31:0] PCBranch; //��ָ֧��Ҫ��ת����PC��ַ
    
    assign PCBranch = PC4 + Extout * 4;
endmodule
