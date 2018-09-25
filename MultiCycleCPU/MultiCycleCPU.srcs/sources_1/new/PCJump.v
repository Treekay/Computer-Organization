`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:44:39
// Design Name: 
// Module Name: PCJump
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


module PCJump(addr, PC4, PCJump);
    input [25:0] addr; //当前指令二进制码的0-25位，在j、jal指令中是要跳转的地址的低26位字节地址
    input [31:0] PC4; //当前PC+4，用于合成跳转地址的高四位
    output reg [31:0] PCJump; //得到的跳转地址
    
    wire [27:0] temp; // 用于保存左移两位后的地址
    assign temp = addr << 2;  // 指令中的跳转地址是字节地址，所以实际的PC地址要左移两位
    always @(addr) begin  
        PCJump <= {PC4[31:28], temp[27:0]};  
    end  
endmodule
