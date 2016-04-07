module controlUnit_tb;
wire RegDst, ALUSrc, MemtoReg, RegWrite,  MemRead, MemWrite, Branch, Jump;
wire [1:0] ALUOp;
reg [5:0] Opcode;

controlUnit myControlUnit(.Opcode(Opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite),  .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp), .Jump(Jump));

initial begin
  Opcode = 6'b000000; // R-format
  #100 Opcode = 6'b100011; // load word
  #100 Opcode = 6'b101011; // store word
  #100 Opcode = 6'b000100; // branch equal
  #100 Opcode = 6'b010000; // jump
  
   #100 $finish;  //stop simulation
end
endmodule
