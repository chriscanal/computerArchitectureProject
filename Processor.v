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
  


/*-----------MUXALUSrc-----------*/
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
/*---------END MUXJump---------*/




/*-----------MUXBranch-----------*/
  //INPUTS
  reg [31:0] MUXBranchInputA;
  reg [31:0] MUXBranchInputB;
  reg MUXBranchControl;
  
  //OUTPUTS
  wire [31:0] MUXBranchOutput;
/*---------END MUXBranch---------*/



  
/*-----------regFile-----------*/
  //INPUTS
  reg[4:0] writeRegInput, readReg0Input, readReg1Input;
  reg[31:0] writeRegDataInput;
  reg regWriteInput;
  
  //OUTPUTS
  wire [31:0] regData0Output;
  wire [31:0] regData1Output;
/*---------END regFile---------*/




/*-----------SignExtend-----------*/
  //INPUTS
  reg[15:0] signExtendInput;
  
  //OUTPUTS
  wire[31:0] signExtendOutput
/*-----------End SignExtend-----------*/



  
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
  reg [31:0] ALUPort0Input, 
  reg [31:0] ALUPort1Input;
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
  regFile myRegFile(.readAddress0(readReg0Input), .readAddress1(readReg1Input), .writeAddress(writeRegInput), .writeData(writeRegDataInput), .writeEnable(regWriteInput), .clk(clk), .readData0(regData0Output), .readData1(regData1Output));
/*---------END RegFile---------*/




/*-----------ALU-----------*/
  ALU myALU(.ALUControl(ALUControlInput), .DataIn0(ALUPort0Input), .DataIn1(ALUPort1Input), .DataOut(ALUResultOutput), .ZeroOut(ALUZeroResultOutput));
/*---------END ALU---------*/




/*-----------ALUControl-----------*/
  ALUControl myALUControl( .ALUOp(ALUFunctInput), .Funct(ALUOpInput), .Operation(ALUOperationOutput) );
/*---------END ALUControl---------*/




/*-----------MUXRegDst-----------*/
  Two_to_one_MUX_5bit myMUXRegDst( .out(MUXRegDstOut), .A(MUXRegDstInputA), .B(MUXRegDstInputB), .sel(MUXRegDstControl) );
  /*---------END MUXRegDst---------*/
  
  

/*-----------MUXALUSrc-----------*/
  Two_to_one_MUX myMUXALUSrc( .out(MUXALUSrcOutput), .A(MUXALUSrcInputA), .B(MUXALUSrcInputB), .sel(MUXALUSrcControl) );
/*---------END MUXALUSrc---------*/


  
/*-----------MUXMemtoReg-----------*/
  Two_to_one_MUX myMUXMemtoReg( .out(MUXMemtoRegOutput), .A(MUXMemtoRegInputA), .B(MUXMemtoRegInputB), .sel(MUXMemtoRegControl) );
/*---------END MUXMemtoReg---------*/





/*-----------MUXJump-----------*/
  Two_to_one_MUX myMUXJump( .out(MUXJumpOutput), .A(MUXJumpInputA), .B(MUXJumpInputB), .sel(MUXJumpControl) );
/*---------END MUXJump---------*/




/*-----------MUXBranch-----------*/
  Two_to_one_MUX myMUXBranch( .out(MUXBranchOutput), .A(MUXBranchInputA), .B(MUXBranchInputB), .sel(MUXBranchControl) );
/*---------END MUXBranch---------*/




/*-----------AND-----------*/
  //
/*---------END AND---------*/

  
/*==========END MODULE INSTANCES==========*/



  
/*============CONTROL CONNECTIONS============*/

  always@(controlOutRegDst, controlOutALUSrc, controlOutMemtoReg, controlOutRegWrite,  controlOutMemRead, controlOutMemWrite, controlOutBranch, controlOutJump, controlOutALUOp)
  begin
      /*-----------MUX control lines-----------*/
      
      MUXRegDstControl = controlOutRegDst;      //For all of these, we need to be careful about which MUX inputs should be 
      MUXALUSrcControl = controlOutALUSrc;      //selected when.  Right now when sel is 0 the output follows B, and when
      MUXMemtoRegControl = controlOutMemtoReg;  //sel is 1 the output follows A
      MUXJumpControl = controlOutJump;
      
      /*-----------End MUX control lines-----------*/
      
      
      /*-----------Other module control lines-----------*/
      
      regWriteInput = controlOutRegWrite;
      mem_read = controlOutMemRead;
      mem_write = controlOutMemWrite;
      
      /*-----------End Other module control lines-----------*/
  end
    
/*============END CONTROL CONNECTIONS============*/
  



/*============DATAPATH CONNECTIONS============*/
  always@(posedge clk)
  begin
    /*-----------Instruction Stage-----------*/

    OpcodeInput = instruction[26 +: 6];
    readReg1Input = instruction[21 +: 5];
    readReg2Input = instruction[16 +: 5;
    MUXRegDstInputA = instruction[16 +: 5];
    MUXRegDstInputB = instruction[11 +: 5];
    #10 writeRegInput = MUXRegDstOut; //Need to delay to let MUX change output...not sure how much delay is needed (if any)
    signExtendInput = instruction[0 +: 16];
    ALUFunctInput = instruction[0 +: 6];
    
    /*-----------End Instruction Stage-----------*/

    
    /*-----------Data Read Stage-----------*/

    ALUPort0 = regData0Output;
    MUXALUSrcInputA = regData1Output;
    MUXALUSrcInputB = signExtendOutput;
    #10 ALUPort1 = MUXALUSrcOutput;
    ALUControlInput = ALUOperationOutput;

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




















//end
