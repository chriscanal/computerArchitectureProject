module controlUnit (Opcode, RegDst, ALUSrc, MemtoReg, RegWrite,  MemRead, MemWrite, Branch, ALUOp, Jump);
  input [5:0] Opcode;
  output reg RegDst, ALUSrc, MemtoReg, RegWrite,  MemRead, MemWrite, Branch, Jump;
  output reg [1:0] ALUOp;
  
  always @ (Opcode)
    begin
      case (Opcode)
	6'b000000: // R-format: Instructions add, addi, 
	  begin
	    RegDst = 1; ALUSrc = 0; MemtoReg = 0; RegWrite = 1; MemRead = 0; MemWrite = 0; Branch = 0; Jump = 0;
	    ALUOp = 2'b10;
	  end
	6'b100011: // lw
	  begin	
	    RegDst = 0; ALUSrc = 1; MemtoReg = 1; RegWrite = 1; MemRead = 1; MemWrite = 0; Branch = 0; Jump = 0;
	    ALUOp = 2'b00;
	  end
	6'b101011: // sw
	  begin	
	    RegDst = 0; ALUSrc = 1; MemtoReg = 0; RegWrite = 0; MemRead = 0; MemWrite = 1; Branch = 0; Jump = 0;
	    ALUOp = 2'b00;
	  end
	6'b000100: // beq
	  begin
	    RegDst = 0; ALUSrc = 0; MemtoReg = 0; RegWrite = 0; MemRead = 0; MemWrite = 0; Branch = 1; Jump = 0;
	    ALUOp = 2'b01;
	  end
	6'b010000: // jump
	  begin
	    RegDst = 0; ALUSrc = 0; MemtoReg = 0; RegWrite = 0; MemRead = 0; MemWrite = 0; Branch = 0; Jump = 1;
	    ALUOp = 2'b00;
	  end
	6'b001000: // addi
	  begin
	    RegDst = 0; ALUSrc = 0; MemtoReg = 0; RegWrite = 1; MemRead = 0; MemWrite = 0; Branch = 0; Jump = 0;
	    ALUOp = 2'b00;
	  end
	6'b001001: // addiu
	  begin
	    RegDst = 0; ALUSrc = 0; MemtoReg = 0; RegWrite = 1; MemRead = 0; MemWrite = 0; Branch = 0; Jump = 0;
	    ALUOp = 2'b00;
	  end

      endcase
    end

endmodule

