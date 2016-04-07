module Shift_left_two(out, in);
  input [31:0] in;
  output reg [31:0] out;

  always @(in)
  begin
    out = 4*in;
  end
endmodule
