module ALU(ALUControl, DataIn0, DataIn1, DataOut, ZeroOut);
  input [3:0] ALUControl;
  input [31:0] DataIn0, DataIn1;
  output reg [31:0] DataOut;
  output reg ZeroOut;

  reg [31:0] temp;

  always @ (ALUControl or DataIn0 or DataIn1)
  begin
    case (ALUControl)
      4'b0010: // add, addi, sw, lw
	DataOut = DataIn0 + DataIn1;
      4'b0111: // set on less than
	begin
	  temp = $signed(DataIn0) - $signed(DataIn1);
	  if (temp[31 +: 1] == 1)
	    DataOut = 32'b00000000000000000000000000000001;
	  else
	    DataOut = 32'b00000000000000000000000000000000;
	end
      4'b0110: // beq
	begin
	  DataOut = DataIn0 - DataIn1;
	  if (DataOut == 32'b00000000000000000000000000000000)
	    ZeroOut = 1;
	  else
	    ZeroOut = 0;
	end
    endcase
  end
endmodule
