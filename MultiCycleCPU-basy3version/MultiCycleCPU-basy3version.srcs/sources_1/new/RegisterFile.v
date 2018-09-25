`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:58:39
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(clk, RegWre, ReadReg1, ReadReg2, WriteReg, WriteData, ReadData1, ReadData2);
    input clk; // 时钟信号
    input RegWre; // 寄存器组寄存器写使能信号
    input [4:0] ReadReg1, ReadReg2, WriteReg; // rs寄存器、rt寄存器，以及要写入的寄存器
    input [31:0] WriteData; // 要写入寄存器的数据
    output wire [31:0] ReadData1, ReadData2; // rs寄存器的数据、 rt寄存器的数据
    
    reg [31:0] register [0:31]; // 32个32位寄存器组成的寄存器组
    initial begin // 初始化0号寄存器即可
        register[0] = 0; 
    end
    
    always @(posedge clk) begin 
    // 由时钟信号触发，并且仅当寄存器组寄存器写使能信号为1时才能写入
        // 还要防止 0号寄存器被修改
        if (RegWre && WriteReg != 0) register[WriteReg] <= WriteData;
    end
    assign ReadData1 = register[ReadReg1];
    assign ReadData2 = register[ReadReg2];
endmodule