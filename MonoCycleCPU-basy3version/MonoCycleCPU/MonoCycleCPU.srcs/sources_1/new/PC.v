`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/12 15:48:33
// Design Name: 
// Module Name: PC
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

module PC(clk, Reset, PCWre, PCSrc, immediate, nowPC, Address);
    input clk, Reset, PCWre;
    input [1:0] PCSrc;
    input [31:0] immediate;  // ��ָ����ȡ�����з�����չ�������
    output reg [31:0] nowPC, Address;
    initial begin
        nowPC = 0;
        Address = 4;
    end
     // clock�����ص�����Reset�½��ص���ʱ��ִ�����к���
    always @(posedge clk or negedge Reset) begin
        if (Reset == 0) begin
            nowPC = 0;
            Address = 4;
        end
        else if (PCWre) begin  // PCWreΪ1ʱPC���ģ�PCWreΪ0ʱPC������
            if (PCSrc == 2) begin
                nowPC = immediate * 4;  // j ��תָ��
                Address = nowPC + 4;
            end
            else if (PCSrc == 1) begin
                nowPC = nowPC + 4 + immediate * 4; // beq, bne
                Address = nowPC + 4;
            end
            else begin
                nowPC = nowPC + 4;
                Address = nowPC + 4;  // ����һָ��
            end
        end
    end
endmodule  
