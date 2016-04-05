module And_gate(out, in1, in2);
  input in1, in2;
  output out;
  reg out;
  reg temp1, temp2;
  always @(in1 or in2)
  begin
    if(in1 == 1 && in2 == 1)
      out = 1;
    else
      out = 0;
  end
endmodule
