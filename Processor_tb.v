/* 
   NAMES OF GROUP MEMBERS:
     Nicolas Knaian
     Chris Canal

   DESCRIPTION OF TESTBENCH FUNCTION:
     Testbench for Processor.v, creates an instance of processor, an instance of 
     memory and generates a clock.  Then it connects appropriate ports of processor
     and memory to each other. The clock starting causes the processor to start 
     reading instructions from memory to execute.

     At every clock cycle the register contents are displayed in the transcript window
     (via displayRegisterFile)
*/
`timescale 1ns/100ps

module Processor_tb;

/*============DECLERATIONS============*/
  
  /*-----------Processor-----------*/
  //INPUTS
  reg clk;
  reg [31:0] instruction;
  reg [31:0] memoryDataOutOutput_processorInput;
  
  //Outputs
  wire [4:0] writtenRegAddressOutput;
  wire [31:0] writtenRegDataOutput;
  wire [31:0] memoryInstAddrInput_processorOutput;
  wire [31:0] memoryDataAddrInput_processorOutput;
  wire [31:0] memoryDataInInput_processorOutput;
  wire memoryMemReadInput_processorOutput;
  wire memoryMemWriteInput_processorOutput;
  /*-----------End Processor-----------*/


  /*-----------Memory-----------*/
  //INPUTS
  reg [31:0] memoryInstAddrInput;
  reg [31:0] memoryDataAddrInput;
  reg [31:0] memoryDataInInput;
  reg memoryMemReadInput;
  reg memoryMemWriteInput;

  //OUTPUTS
  wire [31:0] memoryInstOutOutput;
  wire [31:0] memoryDataOutOutput;
  /*-----------End Memory-----------*/


  /*-----------Output Monitor-------------*/

  reg signed [31:0] displayRegisterFile [31:0];
  reg [8:0] clockCycleNumber;

  /*-----------End Output Monitor-----------*/

/*============END DECLERATIONS============*/





/*============MODULE INSTANCES============*/

Processor myProcessor(
	clk, 
	instruction, 
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
    .inst_addr(memoryInstAddrInput),
    .instr(memoryInstOutOutput),
	.data_addr(memoryDataAddrInput),
	.data_in(memoryDataInInput),
	.mem_read(memoryMemReadInput),
	.mem_write(memoryMemWriteInput),
	.data_out(memoryDataOutOutput)
);

/*============END MODULE INSTANCES============*/


/*============PROCESSOR TO MEMORY CONNECTIONS============*/
  /*-----------Set memory inputs equal to processor outputs-----------*/
  always@(memoryInstAddrInput_processorOutput or memoryDataAddrInput_processorOutput or memoryDataInInput_processorOutput or memoryMemReadInput_processorOutput or memoryMemWriteInput_processorOutput)
  begin
    memoryInstAddrInput = memoryInstAddrInput_processorOutput;
    memoryDataAddrInput = memoryDataAddrInput_processorOutput;
    memoryDataInInput = memoryDataInInput_processorOutput;
    memoryMemReadInput = memoryMemReadInput_processorOutput;
    memoryMemWriteInput = memoryMemWriteInput_processorOutput;
  end 
  /*-----------End set memory inputs equal to processor outputs-----------*/
 

  /*-----------Set processor inputs equal to memory outputs-----------*/
  always@(memoryInstOutOutput or memoryDataOutOutput)
  begin
    instruction = memoryInstOutOutput;
    memoryDataOutOutput_processorInput = memoryDataOutOutput;
  end
  /*-----------End set processor inputs equal to memory outputs-----------*/
/*============END PROCESSOR TO MEMORY CONNECTIONS============*/




/*============INITIALIZE CLOCK============*/
  initial begin
  clk = 0;
  clockCycleNumber = 0;
  end
  always #500clk=~clk; /* 1MHz clock (500*1ns*2) with 500% duty-cycle */
/*============END INITIALIZE CLOCK============*/




/*============MONITOR CHANGED REGISTERS============*/
  /*-----------Update contents of displayRegisterFile -----------*/
  always@(posedge clk)
  begin
    if( clockCycleNumber >= 1 )
    begin
      displayRegisterFile[writtenRegAddressOutput] = writtenRegDataOutput;
      $display("Register file contents after clock cycle %d: %p", clockCycleNumber, displayRegisterFile);
    end
    clockCycleNumber = clockCycleNumber + 1;
  end
  /*-----------End Update contents of displayRegisterFile -----------*/

  /*-----------Initialize displayRegisterFile -----------*/
  initial 
  begin
    //Set contents of displayRegisterFile to be all 0s
    displayRegisterFile[5'b00000] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b00001] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b00010] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b00011] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b00100] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b00101] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b00110] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b00111] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b01000] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b01001] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b01010] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b01011] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b01100] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b01101] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b01110] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b01111] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b10000] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b10001] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b10010] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b10011] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b10100] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b10101] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b10110] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b10111] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b11000] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b11001] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b11010] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b11011] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b11100] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b11101] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b11110] = 32'b00000000000000000000000000000000;
    displayRegisterFile[5'b11111] = 32'b00000000000000000000000000000000;


  end
  /*-----------End Initialize displayRegisterFile -----------*/
 
/*============END MONITOR CHANGED REGISTERS============*/
  
endmodule