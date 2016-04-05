module Sign_extend(out, in);
  input [15:0] in;
  output reg [31:0] out;
  always @(in)
  begin
    out <= $signed(in);
  end
endmodule
