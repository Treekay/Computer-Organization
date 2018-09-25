`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:57:57
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(nowPC, InsMemRW, instruction);
    input [31:0] nowPC; // ��ǰPC��ַ
    input InsMemRW; // ָ���д�ź�
    output reg [31:0] instruction; // ��ǰָ��
    
    // ָ��Ĵ���
    reg [7:0] InsMEM[0:127];
    initial begin
        // ���ļ��е�ָ��д��ָ��Ĵ�����
       $readmemb("C:/Users/admin/Desktop/MultiCycleCPU-basy3version/instructions.txt", InsMEM);
       instruction = 0; // ��ʼ�������ָ��
    end
    
    always @(nowPC or InsMemRW) begin
        if (InsMemRW) begin // ��˴洢����λ��ַ���λ���ݣ���λ��ַ���λ���ݣ����ֶ�дʱһ�¼���
            instruction[31:24] = InsMEM[nowPC];
            instruction[23:16] = InsMEM[nowPC+1];
            instruction[15:8] = InsMEM[nowPC+2];
            instruction[7:0] = InsMEM[nowPC+3];
        end
    end
endmodule 
