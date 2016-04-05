`timescale 1 ns /100 ps 
// timeunit =1ns; precision=1/10ns;
module Two_to_one_MUX_tb; 
reg A, B, sel, out;

/**** DESIGN TO SIMULATE (my_fsm) INSTANTIATION ****/
'2_to_1_MUX' dut1(A, B, sel, out);


/****SPECIFY THE INPUT WAVEFORM x ****/
initial begin
  A = 0;
  B = 0;

  sel = 0;
  #100 B = 1;
  #200 A = 1;
  #200 B = 0;
  #300 B = 1;
  
  #400 sel = 1;
  #400 A = 0;
  #400 B = 0;
  #500 B = 1;
  #600 A = 1;
  #600 B = 0;
  #700 B = 1;

  
   #1000  $finish;  //stop simulation
   //without this, it will not stop
end
endmodule
