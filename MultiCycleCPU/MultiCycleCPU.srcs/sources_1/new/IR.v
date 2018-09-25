`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 19:42:51
// Design Name: 
// Module Name: IR
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


module IR(clk, IRWre, instruction, ins_out, op, rs, rt, rd, immediate, sa, addr);
    input clk; // ʱ���ź�
    input IRWre; // IRдָ���ź�
    input [31:0] instruction; // ��ǰָ��
    output reg [31:0] ins_out; // �ӳ������ָ��
    output wire [5:0] op; // ָ�������
    output wire [4:0] rs, rt, rd; // ���������Ĵ���
    output wire [15:0] immediate; // ������
    output wire [10:6] sa; // λ����
    output wire [25:0] addr; // ��ַ����ת�ֽڵ�ַ)
    
    // ʱ�������½��ش������ӳ٣�Ŀ����ʹָ����뱣���ȶ�
    always @(negedge clk) begin
        if (IRWre) begin
            ins_out = instruction;        
        end
    end
    
   assign op = instruction[31:26];  
   assign rs = instruction[25:21];  
   assign rt = instruction[20:16];  
   assign rd = instruction[15:11];  
   assign immediate = instruction[15:0];
   assign sa = instruction[10:6];
   assign addr = instruction[25:0];
endmodule
