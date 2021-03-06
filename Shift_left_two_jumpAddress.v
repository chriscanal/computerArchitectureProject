module Shift_left_two_jumpAddress(out, instructionIn, PCIn);
  input [31:0] instructionIn;
  input [31:0] PCIn;
  output reg [31:0] out;

  reg [31:0] instructionHolder;
  reg [31:0] instructionHolder2;
  reg [31:0] PCInHolder;
  reg [31:0] PCInHolder2;

  always @(instructionIn)
  begin
    PCInHolder = PCIn/268435456;
    PCInHolder2 = PCInHolder*268435456;
    instructionHolder = 256*instructionIn;
    instructionHolder2 = instructionHolder/64;
    out = instructionHolder2+PCInHolder2;
  end
endmodule
