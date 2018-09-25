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
    input clk; // 时钟信号
    input [31:0] DMOut; // 来自输出数据选择器选择后输出的数据
    output reg [31:0] DMoutDR; // 延迟后输出的数据
    
    always @(posedge clk) begin
        DMoutDR = DMOut;
    end
endmodule
