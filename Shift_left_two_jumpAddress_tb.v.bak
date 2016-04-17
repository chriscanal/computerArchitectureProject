module Shift_left_two_jumpAddress_tb;
  wire [31:0] outTest;
  reg [31:0] instructionInTest;
  reg [31:0] PCInTest;
  
  Shift_left_two_jumpAddress myShifter( .out(outTest), .instructionIn(instructionInTest), .PCIn(PCInTest) );

  initial 
  begin
    #100 instructionInTest = 32'b11111111111111111111111111111111;
    #100 PCInTest = 32'b11111111111111111111111111111111;
    #100 instructionInTest = 32'b10000000000000000000000000000001;
    #100 PCInTest = 32'b11111111111111111111111111111111;
    #100 instructionInTest = 32'b11111111111111111111111111111111;
    #100 PCInTest = 32'b00000000000000000000000000000000;
    #100 instructionInTest = 32'b10000000000000000000000000000001;
    #100 PCInTest = 32'b00000000000000000000000000000000;
    #100 $finish;  //stop simulation
  end 
endmodule