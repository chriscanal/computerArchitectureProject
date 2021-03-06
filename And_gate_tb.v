module And_gate_tb;
  wire out;
  reg in1, in2;
  
  And_gate myAndGate(.out(out), .in1(in1), .in2(in2));

  initial 
  begin
    in1 = 0;
    in2 = 0;
    #100 in1 = 1;
    #100 in2 = 1;
    #100 in1 = 0;
    #100 $finish;  //stop simulation
  end 
endmodule
