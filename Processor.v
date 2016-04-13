// Processor that can perform lw

module Processor(instruction, clk, processorOut);


/*============DECLERATIONS============*/


/*-----------PROCESSOR-----------*/
  //INPUTS  
  input clk;
  input [31:0] instruction;
  
  //OUTPUTS
  output reg processorOut;
/*---------END PROCESSOR---------*/
  
  


/*-----------ControlUnit-----------*/
  //INPUTS
  reg [0:4] OpcodeInput = instruction[26 +: 6];
 
  //OUTPUTS
  wire controlOutRegDst, controlOutALUSrc, controlOutMemtoReg, controlOutRegWrite,  controlOutMemRead, controlOutMemWrite, controlOutBranch, controlOutJump;
  wire [1:0] controlOutALUOp;
/*---------END ControlUnit---------*/
  
  
  
  
/*-----------MUXRegDst-----------*/
  //INPUTS
  reg [4:0] MUXRegDstInputA = instruction[16 +: 5];
  reg [4:0] MUXRegDstInputB = instruction[11 +: 5];
  reg MUXRegDstControl = RegDst;
  
  //OUTPUTS
  wire [4:0] MUXRegDstOut;
/*---------END MUXRegDst---------*/
  


*-----------MUXALUSrc-----------*/
  //INPUTS
  reg [31:0] MUXALUSrcInputA;
  reg [31:0] MUXALUSrcInputB;
  reg MUXALUSrcControl = ALUSrc;
  
  //OUTPUTS
  wire [31:0] MUXALUSrcOutput;
/*---------END MUXALUSrc---------*/




/*-----------MUXMemtoReg-----------*/
  //INPUTS
  reg [31:0] MUXMemtoRegInputA;
  reg [31:0] MUXMemtoRegInputB;
  reg MUXMemtoRegControl = MemtoReg;
  
  //OUTPUTS
  wire [31:0] MUXMemtoRegOutput;
/*---------END MUXMemtoReg---------*/




/*-----------MUXJump-----------*/
  //INPUTS
  reg [31:0] MUXJumpInputA;
  reg [31:0] MUXJumpInputB;
  reg MUXJumpControl = Jump;
  
  //OUTPUTS
  wire [31:0] MUXJumpOutput;
/*---------END MUXjump---------*/



  
/*-----------regFile-----------*/
  //INPUTS
  reg[4:0] writeRegInput, readReg1Input, readReg2Input;
  reg[31:0] writeRegDataInput;
  
  //OUTPUTS
  wire [31:0] regData1, regData2;
/*---------END regFile---------*/
  
  


/*-----------ALU-----------*/
  //INPUTS
  reg [31:0] ALUPort1, ALUPort2;
  
  //OUTPUTS
  wire [31:0] ALUResult;
  wire ALUZeroResult; //Set to 1 if the result of the result of the ALU operation is '0'
/*---------END ALU---------*/



  
/*-----------Memory-----------*/
  //INPUTS
  reg [32:1] instr_addr;
  reg [32:1] data_addr;
  reg [31:0] data_in;
  reg mem_read;
  reg mem_write;
  
  //OUTPUTS
  wire [31:0] instr;
  wire [31:0] data_out;
/*---------END Memory---------*/


/*==========END DECLERATIONS==========*/




/*============MODULE INSTANCES============*/


/*-----------RegFile-----------*/
  regFile myRegFile(.readAddress0(readReg1), .readAddress1(readReg2), .writeAddress(writeReg), .writeData(writeRegData), .writeEnable(1'b1), .clk(clk), .readData0(regData1), .readData1(regData2));
/*---------END RegFile---------*/




/*-----------ALU-----------*/
  ALU myALU(.ALUControl(4'b0010), .DataIn0(regData1), .DataIn1(regData2), .DataOut(ALUResult), .ZeroOut(ALUZeroResult));
/*---------END ALU---------*/




/*-----------ALUControl-----------*/
  //ALUControl myALUControl(.ALUControl(
/*---------END ALUControl---------*/

  
/*==========END MODULE INSTANCES==========*/



  
/*============CONTROL CONNECTIONS============*/

/*============END CONTROL CONNECTIONS============*/
  
/*============DATAPATH CONNECTIONS============*/
  always@(posedge clk)
  begin
    /*   Instruction Stage   */
    
    /*   Data Read Stage   */
    ALUPort1 = readReg1Input;
    ALUPort2 = readReg2Input;
    /*   Execution Stage   */
    writeRegDataInput = ALUResult;
    
    /*   Data Memory Stage   */
    
    /* Write Back Stage   */
  end
/*============END DATAPATH CONNECTIONS============*/
  
/*============SET OUTPUT OF PROCESSOR============*/
  /*   Set processorOutequal to 1   */
  initial begin
    processorOut = 1;
  end
/*============END SET OUTPUT OF PROCESSOR============*/
endmodule

/*Structure of processor:
This is a test
Input: Instr, clk
Output: register file? (would need to make rF an output of regFle)

Control:
  - always@(instr[31:26]): update control lines to correct values for instruction
  - 
*/
