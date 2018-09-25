`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/12 22:01:29
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


module InstructionMemory(
    input [31:0] pc,   
    output [5:0] op,   
    output [4:0] rs, rt, rd,  
    output [15:0] immediate,
    output [4:0] sa
    );
    // ָ��洢���洢��Ԫ���ʹ��8λ
    reg [7:0] mem[0:127];
    reg [31:0] address;
    reg [31:0] instruction;
    initial begin
        // ���ļ��ж�ȡָ��
       $readmemb("C:/Users/admin/Desktop/CPU/MonoCycleCPU/instructions.txt", mem);
       instruction = 0; // ָ���ʼ��
    end
    
    always @(pc) begin
        // pc�������λ��Ϊ0���ӵ���λ��ʼȡ
        address = pc[31:2] << 2;
        // ÿ�δ��ļ���ȡһ��32λ��ָ��
        // �浽4��8λ�Ĵ洢����Ԫ
        // �ٺϲ�Ϊ32λ��ָ��
        instruction = (mem[address]<<24) + (mem[address+1]<<16) + (mem[address+2]<<8) + mem[address+3];
    end
    // output  
    assign op = instruction[31:26];  
    assign rs = instruction[25:21];  
    assign rt = instruction[20:16];  
    assign rd = instruction[15:11];  
    assign immediate = instruction[15:0];
    assign sa = instruction[10:6];
endmodule 
