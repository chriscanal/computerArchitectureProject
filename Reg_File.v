module regFile (readAddress0, readAddress1, writeAddress, writeData, writeEnable, clk, readData0, readData1);
  input [4:0] readAddress0, readAddress1, writeAddress;
  input [31:0] writeData;
  input writeEnable, clk;
  output reg [31:0] readData0, readData1;

  reg [31:0] rF [31:0];

  initial 
  begin
    rF[5'b01000] = 32'b00000000000000000000000000000001;
    rF[5'b01001] = 32'b00000000000000000000000000000001;
    rF[5'b01010] = 32'b00000000000000000000000000000000;
    rF[5'b01011] = 32'b00000000000000000000000000000000;
  end
  
  always @ (readAddress0 or readAddress1)
    begin
      readData0 = rF[readAddress0];
      readData1 = rF[readAddress1];
    end

  always @ (posedge clk)
    begin
      if (writeEnable)
	rF[writeAddress] = writeData;
    end

endmodule


