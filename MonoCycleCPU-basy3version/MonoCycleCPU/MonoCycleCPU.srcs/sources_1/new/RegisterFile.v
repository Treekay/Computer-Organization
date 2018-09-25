`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/12 22:02:09
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


module RegisterFile(clk, RegWre, RegDst, opCode, rs, rt, rd, immediate, DBDataSrc, dataFromALU, dataFromRW, Data1, Data2, writeData); 
     input clk, RegDst, RegWre, DBDataSrc;
     input [5:0] opCode;
     input [4:0] rs, rt, rd;
     input [10:0] immediate;
     input [31:0] dataFromALU, dataFromRW;  
     output [31:0] Data1, Data2;

     wire [4:0] writeReg;  // Ҫд�ļĴ����˿�
     output wire [31:0] writeData;  // Ҫд������
     // RegDstΪ��ʱ������R��ָ�rdΪĿ��������Ĵ�����Ϊ��ʱ����I��ָ��,��������ź����ñ�
     assign writeReg = RegDst? rd : rt;
     // ALUM2RegΪ0ʱ��ʹ������ALU�������Ϊ1ʱ��ʹ���������ݴ洢��(DM)�����,��������ź����ñ�
     assign writeData = DBDataSrc? dataFromRW : dataFromALU;  // ʵ������ѡ����

     // ��ʼ���Ĵ���
     reg [31:0] register[0:31];  
     integer i;  
     initial begin
        for (i = 0; i < 32; i = i+1) register[i] <= 0;  
     end  

     // output����register�仯���仯
     // Data1 ΪALU����ʱ��A����ָ��Ϊsllʱ��A��ֵ����������16λ�л��
     // Data2 λALU�����е�B����ֵʼ����Ϊrt
     assign Data1 = (opCode == 6'b011000) ? immediate[10:6] : register[rs];
     assign Data2 = register[rt];

     always @(posedge clk) begin  
         if (RegWre && writeReg) register[writeReg] = writeData;  // ��ֹ����д��0�żĴ���(writeReg=0)
     end
endmodule
