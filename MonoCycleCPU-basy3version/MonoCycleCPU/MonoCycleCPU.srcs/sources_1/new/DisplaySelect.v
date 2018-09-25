`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/18 18:52:47
// Design Name: 
// Module Name: DisplaySelect
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

module DisplaySelect(
    input clk,
    input btr,
    input reset,
    input [1:0] switch,
    output reg [3:0] display_out,
    output reg [7:0] dispcode
);
    wire [31:0] nowPC, curPC, Out1, Out2;
    wire[4:0] rs, rt;
    wire [31:0] Result, DBData;
    reg [15:0] show;
    reg [19:0] count1 = 0;
    reg [1:0] count2 = 0;
    parameter t1 = 50000;
    always @(posedge clk) begin 
        count1 <= count1 + 1;
        if (count1 == t1) begin
            count1 <= 0;
            count2 <= count2 + 1;
            if (count2 == 4) begin
                count2 <= 0;
            end
        end
    end
    reg [3:0] display_data;
    always @(count2) begin
        case (count2)
            2'b00: begin
                display_data = show[15:12];
                display_out = 4'b0111;
            end
            2'b01: begin
                display_data = show[11:8];
                display_out = 4'b1011;
            end
            2'b10: begin
                display_data = show[7:4];
                display_out = 4'b1101;
            end
            2'b11: begin
                display_data = show[3:0];
                display_out = 4'b1110;
            end
        endcase
        case (display_data)
            4'b0000 : dispcode = 8'b1100_0000;  //0£»'0'-ÁÁµÆ£¬'1'-Ï¨µÆ
            4'b0001 : dispcode = 8'b1111_1001;  //1
            4'b0010 : dispcode = 8'b1010_0100;  //2
            4'b0011 : dispcode = 8'b1011_0000;  //3
            4'b0100 : dispcode = 8'b1001_1001;  //4
            4'b0101 : dispcode = 8'b1001_0010;  //5
            4'b0110 : dispcode = 8'b1000_0010;  //6 
            4'b0111 : dispcode = 8'b1101_1000;  //7
            4'b1000 : dispcode = 8'b1000_0000;  //8
            4'b1001 : dispcode = 8'b1001_0000;  //9
            4'b1010 : dispcode = 8'b1000_1000;  //A
            4'b1011 : dispcode = 8'b1000_0011;  //b
            4'b1100 : dispcode = 8'b1100_0110;  //C
            4'b1101 : dispcode = 8'b1010_0001;  //d
            4'b1110 : dispcode = 8'b1000_0110;  //E
            4'b1111 : dispcode = 8'b1000_1110;  //F
            default : dispcode = 8'b0000_0000;  //²»ÁÁ
        endcase
    end
    parameter TIME_20MS = 1_000;
    
    reg point;
    reg [20:0] cnt;
    reg key_cnt;
    always @(posedge clk) begin
        if (cnt == TIME_20MS - 1) begin
            point <= btr;
        end
    end
    always @(posedge clk) begin
        if (key_cnt) begin
            cnt <= cnt + 1'b1;
        end
        else begin
            cnt <= 0;
        end
    end
    always @(posedge clk) begin
        if (key_cnt == 0 && btr != point) begin
            key_cnt <= 1;
        end
        else if (cnt == TIME_20MS - 1) begin
            key_cnt <= 0;
        end
    end
    
    MonoCycleCPU uut (
        .clk(point), 
        .Reset(reset),
        .nowPC(nowPC),
        .curPC(curPC),
        .Out1(Out1),
        .Out2(Out2),
        .rs(rs),
        .rt(rt),
        .Result(Result),
        .writeData(DBData)
    );
            
    always @(posedge clk) begin
        case (switch) 
            2'b00: begin
                show[15:8] = nowPC;
                show[7:0] = curPC;
            end
            2'b01: begin
                show[15:8] = rs;
                show[7:0] = Out1;
            end
            2'b10: begin
                show[15:8] = rt;
                show[7:0] = Out2;
            end
            2'b11: begin
                show[15:8] = Result;
                show[7:0] = DBData;
            end
        endcase
    end
endmodule
