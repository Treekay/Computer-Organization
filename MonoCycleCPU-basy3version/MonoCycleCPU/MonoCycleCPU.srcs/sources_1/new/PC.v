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
    input [31:0] immediate;  // 从指令中取出进行符号扩展后得来的
    output reg [31:0] nowPC, Address;
    initial begin
        nowPC = 0;
        Address = 4;
    end
     // clock上升沿到来或Reset下降沿到来时，执行下列函数
    always @(posedge clk or negedge Reset) begin
        if (Reset == 0) begin
            nowPC = 0;
            Address = 4;
        end
        else if (PCWre) begin  // PCWre为1时PC更改，PCWre为0时PC不更改
            if (PCSrc == 2) begin
                nowPC = immediate * 4;  // j 跳转指令
                Address = nowPC + 4;
            end
            else if (PCSrc == 1) begin
                nowPC = nowPC + 4 + immediate * 4; // beq, bne
                Address = nowPC + 4;
            end
            else begin
                nowPC = nowPC + 4;
                Address = nowPC + 4;  // 到下一指令
            end
        end
    end
endmodule  
