`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:27:45
// Design Name: 
// Module Name: WriteDataSelector
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


module WriteDataSelector(WrRegDSrc, PC4, DMoutDR, WriteData);
    input WrRegDSrc; // �ɸ��źž���ѡ���ĸ������������ΪҪд��Ĵ���������
    input [31:0] PC4, DMoutDR; // PC+4��ĵ�ַ �� �������ݴ洢���ӳ�ģ�������
    output wire [31:0] WriteData; // �����Ҫд��Ĵ���������

    // ѡ��Ҫд��Ĵ���������
    assign WriteData = WrRegDSrc ? DMoutDR : PC4;
endmodule
