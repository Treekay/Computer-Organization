`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 20:56:29
// Design Name: 
// Module Name: DFlipFlop
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


module DFlipFlop(inState, clk, reset, outState);
    input [2:0] inState; // ��һ��״̬
    input clk;// ʱ������
    input reset; // ����״̬�ź�
    output reg[2:0] outState; // ��ǰ״̬
    always @(posedge clk or posedge reset) begin
        if (reset) outState = 3'b000;
        else outState = inState;
    end
endmodule
