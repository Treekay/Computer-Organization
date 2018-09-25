`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:50:57
// Design Name: 
// Module Name: PCBranch
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


module PCBranch(PC4, Extout, PCBranch);
    input [31:0] PC4; //当前PC+4后的地址
    input [31:0] Extout; //符号位拓展后的跳转偏移量(由于指令中的地址是字节地址所以要乘4
    output wire [31:0] PCBranch; //分支指令要跳转到的PC地址
    
    assign PCBranch = PC4 + Extout * 4;
endmodule
