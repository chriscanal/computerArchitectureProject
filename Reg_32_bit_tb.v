module reg32_tb; 
reg [31:0] inputData;
reg clk, rst, loadEnable;
wire [31:0] storedData;

reg32 myReg32(.clk(clk), .rst(rst), .inputData(inpuData), .loadEnable(loadEnable), .storedData(storedData));

initial 
begin
clk=0; 
rst=0;
loadEnable=1;
inputData = 32'b00000000000000000000000000000000;
end

always #50clk=~clk; /* 10MHz clock (50*1ns*2) with 50% duty-cycle */

initial begin

  #100 /*Allow '0' to be initially loaded into the register
  /*Set input data, but it should not be loaded becuase loadEnable = 0*/
  #1 loadEnable=0;
  #1 inputData= 32'b00000000000000000000000000000001;
  #100 inputData= 32'b00000000000000000000000000000010;
  #100 inputData= 32'b00000000000000000000000000000100;

  /*Reset inputData to 0*/
  #100 inputData = 32'b00000000000000000000000000000000;
  
  /*Set loadEnable to 1, then try inputting some values, they should be loaded on the next clock cycle*/
  #100 loadEnable = 1;
  #100 inputData= 32'b00000000000000000000000000000001;
  #100 inputData= 32'b00000000000000000000000000000010;
  #100 inputData= 32'b00000000000000000000000000000100;

  /*Set reset to 1, all bits should go to 0 at the next posedge of the clock*/
  #70 rst = 1;

  /*Disable reset bit, on the next posedge output should read '4' again*/
  #100 rst = 0;

  /*Disable the loadEnable and change the input...the output should not change*/
  #100 loadEnable=0;
  #100 inputData= 32'b00000000000000000000000000000001;

  #200 $finish;  //stop simulation
   //without this, it will not stop
end
endmodule
