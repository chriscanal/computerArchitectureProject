module Shift_left_two(out, in);
  input [31:0] in;
  output reg [31:0] out;
  //reg [29:0] temp;
  always @(in)
  begin
    out = 4*in;
    //out = temp + 2'b00;
    //out = in;
  end
endmodule