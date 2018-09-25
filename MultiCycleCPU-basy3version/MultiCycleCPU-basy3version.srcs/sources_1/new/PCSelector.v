`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:56:17
// Design Name: 
// Module Name: PCSelector
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


module PCSelector(PCSrc, PC4, PCBranch, PCBack, PCJump, nextPC);
    input [1:0] PCSrc; // 用于决定将哪个输入的地址作为下一个PC地址
    input [31:0] PC4, PCBranch, PCBack, PCJump;
    output reg [31:0] nextPC;
    
    // 输入从指令中获得的跳转地址、PC+4地址、分支地址、PC返回地址
    // 根据PCSrc选出一个地址作为下一条PC地址，触发条件为所有输入的地址和PCSrc
    always @(PCSrc or PC4 or PCBranch or PCBack or PCJump) begin
        case (PCSrc)
            0: nextPC <= PC4;
            1: nextPC <= PCBranch;
            2: nextPC <= PCBack;
            3: nextPC <= PCJump;
            default: nextPC <= 0;
        endcase
    end
endmodule
