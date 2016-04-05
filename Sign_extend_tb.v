module Sign_extend_tb;
  wire [31:0] out;
  reg [15:0] in;
  
  Sign_extend mySignExtender(.out(out), .in(in));

  initial 
  begin
    in = 16'b0000000000000001;
    #100 in = 16'b0100000011110000;
    #100 in = 16'b1100000011110000;
    #100 $finish;  //stop simulation
  end 
endmodule
