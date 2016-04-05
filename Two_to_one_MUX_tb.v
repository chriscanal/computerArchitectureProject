module Two_to_one_MUX_tb; 
reg A, B, sel;
wire out;

Two_to_one_MUX myMUX(.sel(sel), .A(A), .B(B), .out(out));


/****SPECIFY THE INPUT WAVEFORM x ****/
initial begin
  A = 0;
  B = 0;
  sel = 0;
  #100 B = 1;
  #100 A = 1; B = 0;
  #100 B = 1;
  
  #100 sel = 1; A = 0; B = 0;
  #100 B = 1;
  #100 A = 1; B = 0;
  #100 B = 1;

  
   #100 $finish;  //stop simulation
   //without this, it will not stop
end

initial
  $monitor(
    "sel=%b A=%b B=%b out=%b",
    sel, A, B, out);

endmodule