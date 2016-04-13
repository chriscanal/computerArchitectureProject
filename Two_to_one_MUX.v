module Two_to_one_MUX(out, A, B, sel);
input [31:0] A, B;
input sel;
output reg [31:0] out;
always @(A or B or sel)
begin
  if(sel == 0)
    out = B;
  else if(sel == 1)
    out = A;
end
endmodule
