module Processor_tb;
  reg [4:0] destReg, srcReg1, srcReg2;
  reg clk;

  wire [31:0] ALU_result;
  wire ALU_zero_result;
  wire [1:0] test;

  Processor myProcessor(destReg, srcReg1, srcReg2, clk, ALU_result, ALU_zero_result, test);

  initial begin
  clk = 0;
  end
  always #50clk=~clk; /* 10MHz clock (50*1ns*2) with 50% duty-cycle */

  initial begin
  // Add contents of reg8(1) and reg 9(1) and store in reg10(0)
  destReg = 5'b01010; srcReg1 = 5'b01000; srcReg2 = 5'b01001;

  // wait 100 ns then add contents of reg8(1) and reg10(2) and store in reg 11(0) 
  #400 destReg = 5'b01011; srcReg1 = 5'b01000; srcReg2 = 5'b01010;

  // wait 100 ns then add contents of reg8(1) and reg9(0) and store in reg 11(3) 
  #200 destReg = 5'b01011; srcReg1 = 5'b01000; srcReg2 = 5'b01001;

  #100 $finish;  //stop simulation
  
end
endmodule