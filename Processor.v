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
  reg [0:4] OpcodeInput;
 
  //OUTPUTS
  wire controlOutRegDst, controlOutALUSrc, controlOutMemtoReg, controlOutRegWrite,  controlOutMemRead, controlOutMemWrite, controlOutBranch, controlOutJump;
  wire [1:0] controlOutALUOp;
/*---------END ControlUnit---------*/
  
  
  
  
/*-----------MUXRegDst-----------*/
  //INPUTS
  reg [4:0] MUXRegDstInputA;
  reg [4:0] MUXRegDstInputB;
  reg MUXRegDstControl;
  
  //OUTPUTS
  wire [4:0] MUXRegDstOut;
/*---------END MUXRegDst---------*/
  


*-----------MUXALUSrc-----------*/
  //INPUTS
  reg [31:0] MUXALUSrcInputA;
  reg [31:0] MUXALUSrcInputB;
  reg MUXALUSrcControl;
  
  //OUTPUTS
  wire [31:0] MUXALUSrcOutput;
/*---------END MUXALUSrc---------*/




/*-----------MUXMemtoReg-----------*/
  //INPUTS
  reg [31:0] MUXMemtoRegInputA;
  reg [31:0] MUXMemtoRegInputB;
  reg MUXMemtoRegControl;
  
  //OUTPUTS
  wire [31:0] MUXMemtoRegOutput;
/*---------END MUXMemtoReg---------*/




/*-----------MUXJump-----------*/
  //INPUTS
  reg [31:0] MUXJumpInputA;
  reg [31:0] MUXJumpInputB;
  reg MUXJumpControl;
  
  //OUTPUTS
  wire [31:0] MUXJumpOutput;
/*---------END MUXjump---------*/



  
/*-----------regFile-----------*/
  //INPUTS
  reg[4:0] writeRegInput, readReg1Input, readReg2Input;
  reg[31:0] writeRegDataInput;
  
  //OUTPUTS
  wire [31:0] regData1Output;
  wire [31:0] regData2Output;
/*---------END regFile---------*/




  
/*-----------Memory-----------*/
  //INPUTS
  reg [32:1] instr_addr;
  reg [32:1] data_addr;
  reg [31:0] data_in;
  reg        mem_read;
  reg        mem_write;
  
  //OUTPUTS
  wire [31:0] instr;
  wire [31:0] data_out;
/*---------END Memory---------*/




/*-----------ALU-----------*/
  //INPUTS
  reg [31:0] ALUPort1Input, 
  reg [31:0] ALUPort2Input;
  reg [3:0]  ALUControlInput;
  
  //OUTPUTS
  wire [31:0] ALUResultOutput;
  wire        ALUZeroResultOutput; //Set to 1 if the result of the result of the ALU operation is '0'
/*---------END ALU---------*/




/*-----------ALUControl-----------*/
  //INPUTS
  reg [5:0] ALUFunctInput;
  reg [1:0] ALUOpInput;
  
  //OUTPUTS
  wire [3:0] ALUOperationOutput;
/*---------END ALUControl---------*/


/*==========END DECLERATIONS==========*/




/*============MODULE INSTANCES============*/


/*-----------RegFile-----------*/
  regFile myRegFile(.readAddress0(readReg1), .readAddress1(readReg2), .writeAddress(writeReg), .writeData(writeRegData), .writeEnable(1'b1), .clk(clk), .readData0(regData1), .readData1(regData2));
/*---------END RegFile---------*/




/*-----------ALU-----------*/
  ALU myALU(.ALUControl(4'b0010), .DataIn0(regData1), .DataIn1(regData2), .DataOut(ALUResult), .ZeroOut(ALUZeroResult));
  //why did we pass in 4'b0010 into ALU control? - chris
/*---------END ALU---------*/




/*-----------ALUControl-----------*/
  //ALUControl myALUControl( .ALUOp(ALUFunctInput), .Funct(ALUOpInput), .Operation(ALUOperationOutput) );;
/*---------END ALUControl---------*/

  
/*==========END MODULE INSTANCES==========*/



  
/*============CONTROL CONNECTIONS============*/

  MUXRegDstControl = controlOutRegDst;
  MUXALUSrcControl = controlOutALUSrc;
  MUXMemtoRegControl = controlOutMemtoReg;
  MUXJumpControl = controlOutJump;

/*============END CONTROL CONNECTIONS============*/
  



/*============DATAPATH CONNECTIONS============*/
  always@(posedge clk)
  begin
    /*-----------Instruction Stage-----------*/

    OpcodeInput = instruction[26 +: 6];
    MUXRegDstInputA = instruction[16 +: 5];
    MUXRegDstInputB = instruction[11 +: 5];
    #10 writeRegInput = MUXRegDstOut; //Need to delay to let MUX change output...not sure how much delay is needed (if any)
    /*-----------End Instruction Stage-----------*/

    
    /*-----------Data Read Stage-----------*/

    ALUPort1 = readReg1Input;
    ALUPort2 = readReg2Input;

    /*-----------End Data Read Stage-----------*/


    /*-----------Execution Stage-----------*/

    writeRegDataInput = ALUResult;

    /*-----------End Execution Stage-----------*/
    

    /*-----------Data Memory Stage-----------*/


    
    /*-----------End Data Memory Stage-----------*/


    /*-----------Write Back Stage-----------*/



    /*-----------End Write Back Stage-----------*/
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
Input: Instr, clk
Output: system print of the contents of the register file
*/
