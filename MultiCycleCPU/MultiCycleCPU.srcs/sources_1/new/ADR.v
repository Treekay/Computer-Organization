`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 20:09:12
// Design Name: 
// Module Name: ADR
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


module ADR(clk, ReadData1, out1);
    input clk; // ʱ���źţ����ڴ�����ģ��Ĺ���
    input [31:0] ReadData1; // ���������
    output reg [31:0] out1; // ���������
    
    always @(posedge clk) begin
        out1 = ReadData1;
    end
endmodule
