// Processor that can add the contents of two registers and store result in another register
module Processor(destReg, srcReg1, srcReg2, clk, ALUToWriteReg, ALU_zero_result, test);
  input [4:0] destReg, srcReg1, srcReg2;
  input clk;

  output reg [31:0] ALUToWriteReg; 
  output reg [1:0] test;
  output wire ALU_zero_result;

  wire [31:0] reg1Data, reg2Data;
  wire [31:0] rF [31:0];
  wire [31:0] ALU_result;

  
  regFile myRegFile(.readAddress0(srcReg1), .readAddress1(srcReg2), .writeAddress(destReg), .writeData(ALUToWriteReg), .writeEnable(1'b1), .clk(clk), .readData0(reg1Data), .readData1(reg2Data));
  ALU myALU(.ALUControl(4'b0010), .DataIn0(reg1Data), .DataIn1(reg2Data), .DataOut(ALU_result), .ZeroOut(ALU_zero_result));
  
  initial
  begin
    test = 2'b00;
  end
  always@(posedge clk)
  begin
    ALUToWriteReg = ALU_result;
  end
endmodule

/*Structure of processor:
Input: Instr
Output: register file? (would need to make rF an output of regFle)

Control:
  - always@(instr[31:26]): update control lines to correct values for instruction
  - 
*/