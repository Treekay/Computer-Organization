`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 20:05:57
// Design Name: 
// Module Name: ALUoutDR
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


module ALUoutDR(clk, Result, ALUout);
    input clk; // ʱ���ź�
    input [31:0] Result; // �����ź�
    output reg [31:0] ALUout; // ALU������
    
    always @(posedge clk) begin
        ALUout = Result;
    end
endmodule
