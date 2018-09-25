`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 20:57:12
// Design Name: 
// Module Name: OutputFunction
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

module OutputFunction(state, opcode, zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, RD, WR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);
    input [2:0] state;
    input [5:0] opcode;
    input zero, sign;
    output reg PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, RD, WR, IRWre, ExtSel;
    output reg [1:0] PCSrc, RegDst;
    output reg [2:0] ALUOp;
    parameter [2:0] IF = 3'b000, // IF状态
                     ID = 3'b001, // ID状态
                     EXE = 3'b010, // EXE状态
                     WB = 3'b011, // WB状态
                     MEM = 3'b100; // MEM状态
    parameter [5:0] ADD = 6'b000000, SUB = 6'B000001, ADDI = 6'b000010, OR = 6'b010000,
                     AND = 6'b010001, ORI = 6'B010010, SLL = 6'b011000, SLT = 6'b100110,
                     SLTIU = 6'b100111, BEQ = 6'b110100, BLTZ = 6'b110110, SW = 6'b110000,
                     LW = 6'b110001, J = 6'b111000, JR = 6'b111001, JAL = 6'b111010, HALT = 6'b111111,
                     SUBI = 6'b000011, ANDI = 6'b010011, XOR = 6'b010100;
    always @(state) begin
        // 由于状态更改是时钟脉冲上升沿触发，所以实际是取上一个周期的状态
        // 要提前一个周期对状态进行修改
        if (state == ID && (opcode == J || opcode == JAL || opcode == JR) ||
            state == EXE && (opcode == BEQ || opcode == BLTZ) ||
            state == MEM && opcode == SW || state == WB) begin
            PCWre = 1;
        end
        else begin
            PCWre = 0;
        end
        ALUSrcA = (opcode == SLL) ? 1: 0;
        ALUSrcB = (opcode == ADDI || opcode == SUBI || opcode == ANDI || opcode == ORI || opcode == SLTIU || opcode == SW ||opcode == LW) ? 1: 0;
        DBDataSrc = (state == MEM) ? 1: 0;
        RegWre = (state == MEM || state == EXE || opcode == JAL) ? 1: 0;
        WrRegDSrc = (opcode == JAL) ? 0: 1;
        InsMemRW = (state == IF) ? 1: 0;
        RD = (state == EXE && opcode == LW) ? 0: 1;
        WR = (state == EXE && opcode == SW) ? 0: 1;
        IRWre = (state == IF) ? 1: 0;
        ExtSel = (opcode == ORI || opcode == ANDI || opcode == SLTIU) ? 0: 1;
        
        // PCSrc
        case(opcode)  
           J: PCSrc = 2'b11;  
           JAL: PCSrc = 2'b11;  
           JR: PCSrc = 2'b10;  
           BEQ: begin  
               if (zero) PCSrc = 2'b01;  
               else PCSrc = 2'b00;  
           end
           BLTZ: begin
                if (sign == 1 && zero == 0) PCSrc = 2'b01;
                else PCSrc = 2'b00;
           end
           default: PCSrc = 2'b00;  
        endcase
        
        // RegDst
        if (opcode == JAL) RegDst = 2'b00;  
        else if (opcode == ADDI || opcode == SUBI || opcode == ANDI || opcode == ORI || opcode == SLTIU || opcode == LW) RegDst = 2'b01;  
        else RegDst = 2'b10;
        
        // ALUOp
        case (opcode)
            ADD: ALUOp = 3'b000;
            SUB: ALUOp = 3'b001;
            ADDI: ALUOp = 3'b000;
            SUBI: ALUOp = 3'b001;
            OR: ALUOp = 3'b101;
            AND: ALUOp = 3'b110;
            ORI: ALUOp = 3'b101;
            ANDI: ALUOp = 3'b110;
            XOR: ALUOp = 3'b111;
            SLL: ALUOp = 3'b100;
            SLT: ALUOp = 3'b010;
            SLTIU: ALUOp = 3'b011;
            BEQ: ALUOp = 3'b001;
            BLTZ: ALUOp = 3'b001;
            default: ALUOp = 3'b000;
        endcase
        
        // 避免在IF状态发生写操作
        if (state == IF) begin
            RegWre = 0;
            WR = 1;
        end
    end
endmodule
