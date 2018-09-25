`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:57:11
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


module PC(clk, RST, PCWre, nextPC, nowPC);
    input clk;
    input RST;
    input PCWre;
    input [31:0] nextPC;
    output reg [31:0] nowPC;
    
    always @(posedge clk) begin
        if (RST == 0) begin     //  当RST为0时将当前PC地址重置为0
            nowPC <= 0;
        end
        else begin      //  只有当PCWre为1时才进行PC写操作，其他时候不对当前PC进行修改
            nowPC <= PCWre ? nextPC : nowPC;
        end
    end
endmodule
