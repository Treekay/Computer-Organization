`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 20:14:20
// Design Name: 
// Module Name: DBDR
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


module DBDR(clk, DMOut, DMoutDR);
    input clk; // ʱ���ź�
    input [31:0] DMOut; // �����������ѡ����ѡ������������
    output reg [31:0] DMoutDR; // �ӳٺ����������
    
    always @(posedge clk) begin
        DMoutDR = DMOut;
    end
endmodule
