/*  Every time an instruction is executed, update the register file variable by using the 
    "writtenReg" and "writtenRegData" outputs of the processor.  Have the register file be in 
    the monitor system call somehow (will probably have to make 32 different variables for each 
    register. Syntax of monitor: $monitor ("format_string", par_1, par_2, ... );
*/

module Processor_tb;

/*============DECLERATIONS============*/

  reg [31:0] instruction
  reg clk;

  wire [4:0] writtenRegAddress;
  wire [31:0] writtenRegData;

/*============END DECLERATIONS============*/

/*-----------Memory-----------*/
/*-----------End Memory-----------*/

/*============MODULE INSTANCES============*/

Processor myProcessor(
	.clk(clk), 
	.instruction(instruction), 
	memoryDataOutOutput_processorInput, 
		writtenRegAddressOutput, 
		writtenRegDataOutput, 
		memoryInstAddrInput_processorOutput, 
		memoryDataAddrInput_processorOutput, 
		memoryDataInInput_processorOutput, 
		memoryMemReadInput_processorOutput, 
		memoryMemWriteInput_processorOutput
);

Memory myMemory(
    inst_addr,
    instr,
	data_addr,
	data_in,
	mem_read,
	mem_write,
	data_out
);

/*============END MODULE INSTANCES============*/

  initial begin
  clk = 0;
  end
  always #50clk=~clk; /* 10MHz clock (50*1ns*2) with 50% duty-cycle */

  initial begin
  instruction = 32'b100011 00000 00001

  #100 $finish;  //stop simulation
  
end
endmodule