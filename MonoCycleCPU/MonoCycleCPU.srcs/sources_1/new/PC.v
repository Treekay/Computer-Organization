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

module PC(clk, Reset, PCWre, PCSrc, immediate, Address);
    input clk, Reset, PCWre;
    input [1:0] PCSrc;
    input [31:0] immediate;
    output reg [31:0] Address;
    initial begin
        Address = 0;
    end
     // clock上升沿到来或Reset下降沿到来时执行
    always @(posedge clk) begin
        // Reset 为0时重置PC为0
        if (Reset == 0) begin
            Address = 0;  
        end
        // PCWre为1时,PC更改指向下一条指令
        // PCWre为0时停机，PC不更改
        else if (PCWre) begin
            if (PCSrc == 2) begin
                Address = immediate * 4;  // j 跳转指令
            end
            else if (PCSrc == 1) begin 
               Address = Address + 4 + immediate * 4;  // beq, bne 跳转指令
            end
            else begin
                Address = Address + 4;  // 跳转到下一指令
            end
        end
    end
endmodule  
