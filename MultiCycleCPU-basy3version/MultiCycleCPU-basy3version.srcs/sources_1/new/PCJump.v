`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:44:39
// Design Name: 
// Module Name: PCJump
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


module PCJump(addr, PC4, PCJump);
    input [25:0] addr; //��ǰָ����������0-25λ����j��jalָ������Ҫ��ת�ĵ�ַ�ĵ�26λ�ֽڵ�ַ
    input [31:0] PC4; //��ǰPC+4�����ںϳ���ת��ַ�ĸ���λ
    output reg [31:0] PCJump; //�õ�����ת��ַ
    
    wire [27:0] temp; // ���ڱ���������λ��ĵ�ַ
    assign temp = addr << 2;  // ָ���е���ת��ַ���ֽڵ�ַ������ʵ�ʵ�PC��ַҪ������λ
    always @(addr) begin  
        PCJump <= {PC4[31:28], temp[27:0]};  
    end  
endmodule
