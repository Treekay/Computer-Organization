`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 20:11:37
// Design Name: 
// Module Name: DataOutSelector
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


module DataOutSelector(DBDataSrc, result, DataOut, out);
    input DBDataSrc;
    input [31:0] result, DataOut;
    output wire [31:0] out;
    
    assign out = DBDataSrc ? DataOut : result;
endmodule
