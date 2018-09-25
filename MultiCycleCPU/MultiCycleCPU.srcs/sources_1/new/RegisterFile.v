`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:58:39
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(clk, RegWre, ReadReg1, ReadReg2, WriteReg, WriteData, ReadData1, ReadData2);
    input clk; // ʱ���ź�
    input RegWre; // �Ĵ�����Ĵ���дʹ���ź�
    input [4:0] ReadReg1, ReadReg2, WriteReg; // rs�Ĵ�����rt�Ĵ������Լ�Ҫд��ļĴ���
    input [31:0] WriteData; // Ҫд��Ĵ���������
    output wire [31:0] ReadData1, ReadData2; // rs�Ĵ��������ݡ� rt�Ĵ���������
    
    reg [31:0] register [0:31]; // 32��32λ�Ĵ�����ɵļĴ�����
    initial begin // ��ʼ��0�żĴ�������
        register[0] = 0; 
    end
    
    always @(posedge clk) begin 
    // ��ʱ���źŴ��������ҽ����Ĵ�����Ĵ���дʹ���ź�Ϊ1ʱ����д��
        // ��Ҫ��ֹ 0�żĴ������޸�
        if (RegWre && WriteReg != 0) register[WriteReg] <= WriteData;
    end
    assign ReadData1 = register[ReadReg1];
    assign ReadData2 = register[ReadReg2];
endmodule