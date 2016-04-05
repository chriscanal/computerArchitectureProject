module ALUControl_tb;
  reg [1:0] ALUOp;
  reg [5:0] Funct;
  wire [3:0] Operation;

  ALUControl myALUControlUnit(.ALUOp(ALUOp), .Funct(Funct), .Operation(Operation));

initial begin
  ALUOp = 2'b00;
  Funct = 6'b000000;
end

initial begin
  ALUOp = 2'b00; // add (for load and store)
  #100 ALUOp = 2'b01; // subtract (for beq)
  #100 ALUOp = 2'b10;  // add (adding register values)
  #100 Funct = 6'b000010; // subtract (subtracting register values)
  #100 Funct = 6'b000100; // AND
  #100 Funct = 6'b000101; // OR
  #100 Funct = 6'b001010; // set on less than
  
   #100 $finish;  //stop simulation
   //without this, it will not stop
end
endmodule
