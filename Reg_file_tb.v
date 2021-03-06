module regFile_tb;
  reg [4:0] readAddress0, readAddress1, writeAddress;
  reg [31:0] writeData;
  reg writeEnable, clk;

  wire [31:0] readData0, readData1;

regFile myRegFile(readAddress0, readAddress1, writeAddress, writeData, writeEnable, clk, readData0, readData1);

initial 
begin
clk=0; 
writeEnable=1;
readAddress0 = 5'b00000;
readAddress1 = 5'b00001;
writeAddress = 5'b00000;
writeData = 32'b00000000000000000000000000000000;
end

always #50clk=~clk; /* 10MHz clock (50*1ns*2) with 50% duty-cycle */


initial begin

  #70 // delay so that register0 can be written to
  /*Write a '1' to register 16*/
  #100 writeAddress = 5'b10000; writeData = 32'b00000000000000000000000000000001;
  /*Write a '3' to register 17*/
  #100 writeAddress = 5'b10001; writeData = 32'b00000000000000000000000000000011;

  /*Check that readData0 and readData1 show '1' and '3'*/
  #260 readAddress0 = 5'b10000; readAddress1 = 5'b10001;
  
  /*Disable writing*/
  #100 writeEnable = 0;

  /*Try writing a '4' to register 16*/
  #100 writeAddress = 5'b10000; writeData = 32'b00000000000000000000000000000100;
  /*Try writing a '5' to register 17*/
  #100 writeAddress = 5'b10001; writeData = 32'b00000000000000000000000000000101;

  /*Check that readData0 and readData1 show '1' and '3'*/
  #100 readAddress0 = 5'b10000; readAddress1 = 5'b10001;

  #100 $finish;  //stop simulation
  
end
endmodule
