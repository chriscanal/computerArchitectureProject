module Two_to_one_MUX(A, B, sel, out);
input A, B, sel;
output out;
reg out;
always @(A or B or sel)
begin
  if(sel == 0)
    out = B;
  else if(sel == 1)
    out = A;
end
endmodule
