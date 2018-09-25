`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:15:34
// Design Name: 
// Module Name: WriteRegSelector
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


module WriteRegSelector(RegDst, rt, rd, WriteReg);
    input [1:0] RegDst; // 用于决定写寄存器组寄存器的地址
    input [4:0] rt, rd; // 输入的rt、rd寄存器地址
    output reg [4:0] WriteReg; // 写寄存器组寄存器的地址
    
    always @(RegDst or rt or rd) begin
        case (RegDst)
            2'b00: WriteReg <= 5'b11111; // 31号寄存器，用于存储jr指令要跳回的地址
            2'b01: WriteReg <= rt;
            2'b10: WriteReg <= rd;
            default: WriteReg <= 0;
        endcase
    end
    
endmodule
