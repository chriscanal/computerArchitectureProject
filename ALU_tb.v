module ALU_tb;
  reg [3:0] ALUControl;
  reg [31:0] DataIn0, DataIn1;
  wire [31:0] DataOut;
  wire ZeroOut;

  ALU myALU(ALUControl, DataIn0, DataIn1, DataOut, ZeroOut);

initial begin
  DataIn0 = 32'b00000000000000000000000000000000;
  DataIn1 = 32'b00000000000000000000000000000000;
end

initial begin
  /*Add 0 and 0 together*/
  ALUControl = 4'b0010; 

  /*Add 1 and 2 together*/
  #100 DataIn0 = 32'b00000000000000000000000000000001;
  DataIn1 = 32'b00000000000000000000000000000010; 

  /*Add -Big number and 1 together*/
  #100 DataIn0 = 32'b10000000000000000000000000000001;
  DataIn1 = 32'b00000000000000000000000000000001; 

  /*Add -1 and 3 together*/
  #100 DataIn0 = 32'b11111111111111111111111111111111;
  DataIn1 = 32'b00000000000000000000000000000011; 

  /*set on less than, DataOut should be set to 1*/
  #100 ALUControl = 4'b0111;

  /*set on less than, DataOut should be set to 0*/
  #100 DataIn0 = 32'b00000000000000000000000000000100;

  /*beq, ZeroOut should be set to 0*/
  #100 ALUControl = 4'b0110;

  /*beq, ZeroOut should be set to 1*/
  #100 DataIn1 = 32'b00000000000000000000000000000100;
  
   #100 $finish;  //stop simulation
   //without this, it will not stop
end
endmodule
