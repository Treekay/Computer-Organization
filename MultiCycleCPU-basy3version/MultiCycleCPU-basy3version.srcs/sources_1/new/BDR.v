`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 20:09:23
// Design Name: 
// Module Name: BDR
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


module BDR(clk, ReadData2, out2);
    input clk; // 时钟信号，用于触发该模块的工作
    input [31:0] ReadData2;  // 读入的数据
    output reg [31:0] out2; // 输出的数据
    
    always @(posedge clk) begin
        out2 = ReadData2;
    end
endmodule
