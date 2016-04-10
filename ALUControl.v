module ALUControl (ALUOp, Funct, Operation);
  input [1:0] ALUOp;
  input [5:0] Funct;
  output reg [3:0] Operation;

  always @ (ALUOp or Funct)
  begin
    case (ALUOp)
      2'b00:
	//lw,sw, addi, and addiu - add for load word, store word add immediate and add immediate unsigned
	Operation = 4'b0010;
      2'b01:
	//beq - subtract for branch if equal
	Operation = 4'b0110;
      2'b10:
	begin
	  case (Funct[0 +: 4])
	    4'b0000:
	      //add
	      Operation = 4'b0010;
	    4'b0010:
	      //sub - subtract
	      Operation = 4'b0110;
	    4'b0100:
	      //AND
	      Operation = 4'b0000;
	    4'b0101:
	      //OR
	      Operation = 4'b0001;
	    4'b1010:
	      //slt - Set on less than
	      Operation = 4'b0111;
	  endcase
	end
    endcase
  end

endmodule
