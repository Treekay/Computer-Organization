`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:39:37
// Design Name: 
// Module Name: PCAddFour
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


module PCAddFour(nowPC, PC4);
    input [31:0] nowPC; //当前PC地址
    output wire [31:0] PC4; // 当前PC+4后的地址
    
    assign PC4 = nowPC + 4;
endmodule
