module Two_to_one_MUX_5bit(out, A, B, sel);
input [4:0] A, B;
input sel;
output reg [4:0] out;
always @(A or B or sel)
begin
  if(sel == 0)
    out = B;
  else if(sel == 1)
    out = A;
end
endmodule
