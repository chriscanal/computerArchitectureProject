module Shift_left_two_tb;
  wire [31:0] out;
  reg [31:0] in;
  
  Shift_left_two myShifter(.out(out), .in(in));

  initial 
  begin
    in = 32'b00000000000000000000000000000001;
    #100 in = 32'b00000000000000000000000000001111;
    #100 in = 32'b11100000000000000000000000000001;
    #100 $finish;  //stop simulation
  end 
endmodule
