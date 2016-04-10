module Sign_extend(out, in);
  input signed [15:0] in;
  output reg signed [31:0] out;
  always @(in)
  begin
    out <= $signed(in);
  end
endmodule
