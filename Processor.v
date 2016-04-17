// Processor that can perform lw

module Processor(instruction, clk, writtenRegAddressOutput, writtenRegDataOutput);


/*============DECLERATIONS============*/


/*-----------ALU-----------*/
  //INPUTS
  reg [31:0] ALUPort0Input; 
  reg [31:0] ALUPort1Input;
  reg [3:0]  ALUControlInput;
  
  //OUTPUTS
  wire [31:0] ALUResultOutput;
  wire        ALUZeroResultOutput; //Set to 1 if the result of the result of the ALU operation is '0'
/*---------END ALU---------*/




/*-----------ALUControl-----------*/
  //INPUTS
  reg [5:0] ALUControlFunctInput;
  reg [1:0] ALUControlOpInput;
  
  //OUTPUTS
  wire [3:0] ALUControlOperationOutput;
/*---------END ALUControl---------*/




/*-----------AndGate-----------*/
  //INPUTS
  reg andGateInput1;
  reg andGateInput2;
  
  //OUTPUTS
  wire andGateOutput;
/*-----------End AndGate-----------*/




/*-----------BranchAdd-----------*/
  //INPUTS
  reg [31:0] branchAddPort0Input; 
  reg [31:0] branchAddPort1Input;
  reg [3:0]  branchAddControlInput;
  
  //OUTPUTS
  wire [31:0] branchAddResultOutput;
  wire        branchAddZeroResultOutput;
/*-----------End BranchAdd-----------*/




/*-----------BranchShiftLeft-----------*/
  //INPUTS
  reg[31:0] branchShiftLeftInput;
  
  //OUTPUTS
  wire[31:0] branchShifLeftOutput;
/*-----------End BranchShiftLeft-----------*/




/*-----------Control-----------*/
  //INPUTS
  reg [0:4] controlOpcodeInput;
 
  //OUTPUTS
  wire controlALUSrcOutput;
  wire controlBranchOutput;
  wire controlJumpOutput;
  wire controlMemtoRegOutput;
  wire controlMemReadOutput;
  wire controlMemWriteOutput;
  wire controlRegWriteOutput;
  wire controlRegDstOutput;
  wire [1:0] controlALUOpOutput;
/*---------END Control---------*/




/*-----------JumpShiftLeft-----------*/
  //INPUTS
  reg[31:0] jumpShiftLeftInput;
  
  //OUTPUTS
  wire[31:0] jumpShifLeftOutput;
/*-----------End JumpShiftLeft-----------*/
  


  
/*-----------Memory-----------*/
  //INPUTS
  reg [31:0] memoryInstAddrInput;
  reg [31:0] memoryDataAddrInput;
  reg [31:0] memoryDataInInput;
  reg        memoryMemReadInput;
  reg        memoryMemWriteInput;
  
  //OUTPUTS
  wire [31:0] memoryInstrOutput;
  wire [31:0] memoryDataOutOutput;
/*---------END Memory---------*/


  
  
/*-----------MUXALUSrc-----------*/
  //INPUTS
  reg [31:0] MUXALUSrcInputA;
  reg [31:0] MUXALUSrcInputB;
  reg MUXALUSrcControlInput;
  
  //OUTPUTS
  wire [31:0] MUXALUSrcOutput;
/*---------END MUXALUSrc---------*/




/*-----------MUXBranch-----------*/
  //INPUTS
  reg [31:0] MUXBranchInputA;
  reg [31:0] MUXBranchInputB;
  reg MUXBranchControlInput;
  
  //OUTPUTS
  wire [31:0] MUXBranchOutput;
/*---------END MUXBranch---------*/




/*-----------MUXJump-----------*/
  //INPUTS
  reg [31:0] MUXJumpInputA;
  reg [31:0] MUXJumpInputB;
  reg MUXJumpControlInput;
  
  //OUTPUTS
  wire [31:0] MUXJumpOutput;
/*---------END MUXJump---------*/




/*-----------MUXMemtoReg-----------*/
  //INPUTS
  reg [31:0] MUXMemtoRegInputA;
  reg [31:0] MUXMemtoRegInputB;
  reg MUXMemtoRegControlInput;
  
  //OUTPUTS
  wire [31:0] MUXMemtoRegOutput;
/*---------END MUXMemtoReg---------*/




/*-----------MUXRegDst-----------*/
  //INPUTS
  reg [4:0] MUXRegDstInputA;
  reg [4:0] MUXRegDstInputB;
  reg MUXRegDstControlInput;
  
  //OUTPUTS
  wire [4:0] MUXRegDstOut;
/*---------END MUXRegDst---------*/




/*-----------PROCESSOR-----------*/
  //INPUTS  
  input clk;
  input [31:0] instruction;
  
  //OUTPUTS
  output reg [4:0] writtenRegAddressOutput ;
  output reg [31:0] writtenRegDataOutput;
/*---------END PROCESSOR---------*/



  
/*-----------PCAdd-----------*/
  //INPUTS
  reg [31:0] PCAddPort0Input; 
  reg [31:0] PCAddPort1Input;
  reg [3:0]  PCAddControlInput;
  
  //OUTPUTS
  wire [31:0] PCAddResultOutput;
  wire        PCAddZeroResultOutput;
/*-----------End PCAdd-----------*/




/*-----------regFile-----------*/
  //INPUTS
  reg[4:0]  regFileWriteRegInput, regFileReadReg0Input, regFileReadReg1Input;
  reg[31:0] regFileWriteRegDataInput;
  reg regFileRegWriteInput;
  
  //OUTPUTS
  wire [31:0] regFileRegData0Output;
  wire [31:0] regFileRegData1Output;
/*---------END regFile---------*/




/*-----------SignExtend-----------*/
  //INPUTS
  reg[15:0] signExtendInput;
  
  //OUTPUTS
  wire[31:0] signExtendOutput;
/*-----------End SignExtend-----------*/


/*==========END DECLERATIONS==========*/




/*============MODULE INSTANCES============*/



/*-----------ALU-----------*/
  ALU myALU( .ALUControl(ALUControlInput), .DataIn0(ALUPort0Input), .DataIn1(ALUPort1Input), .DataOut(ALUResultOutput), .ZeroOut(ALUZeroResultOutput) );
/*---------END ALU---------*/




/*-----------ALUControl-----------*/
  ALUControl myALUControl( .ALUOp(ALUControlFunctInput), .Funct(ALUControlOpInput), .Operation(ALUControlOperationOutput) );
/*---------END ALUControl---------*/




/*-----------AndGate-----------*/
  And_gate myAndGate( .out(andGateOutput), .in1(andGateInput1), .in2(andGateInput2) );
/*---------END AndGate---------*/




/*-----------BranchAdd-----------*/
  ALU myBranchAdd( .ALUControl(branchAddControlInput), .DataIn0(branchAddPort0Input), .DataIn1(branchAddPort1Input), .DataOut(branchAddResultOutput), .ZeroOut(branchAddZeroResultOutput) );
/*---------END BranchAdd---------*/




/*-----------BranchShiftLeft-----------*/
  Shift_left_two myBranchShiftLeft( .out(branchShifLeftOutput), .in(branchShiftLeftInput) );
/*---------END BranchShiftLeft---------*/




/*-----------Control-----------*/
   controlUnit myControl( .Opcode(controlOpcodeInput), .RegDst(controlRegDstOutput), .ALUSrc(controlALUSrcOutput), .MemtoReg(controlMemtoRegOutput), .RegWrite(controlRegWriteOutput), .MemRead(controlMemReadOutput),.MemWrite(controlMemWriteOutput), .Branch(controlBranchOutput), .ALUOp(controlALUOpOutput), .Jump(controlJumpOutput) );
/*---------END Control---------*/




/*-----------JumpShiftLeft-----------*/
  Shift_left_two myJumpShiftLeft( .out(jumpShifLeftOutput), .in(jumpShiftLeftInput) );
/*---------END JumpShiftLeft---------*/




/*-----------Memory-----------*/
  Memory myMemory( .inst_addr(memoryInstAddrInput), .instr(memoryInstrOutput), .data_addr(memoryDataAddrInput), .data_in(memoryDataInInput), .mem_read(memoryMemReadInput), .mem_write(memoryMemWriteInput), .data_out(memoryDataOutOutput) );
/*---------END Memory---------*/




/*-----------MUXALUSrc-----------*/
  Two_to_one_MUX myMUXALUSrc( .out(MUXALUSrcOutput), .A(MUXALUSrcInputA), .B(MUXALUSrcInputB), .sel(MUXALUSrcControlInput) );
/*---------END MUXALUSrc---------*/




/*-----------MUXBranch-----------*/
  Two_to_one_MUX myMUXBranch( .out(MUXBranchOutput), .A(MUXBranchInputA), .B(MUXBranchInputB), .sel(MUXBranchControlInput) );
/*---------END MUXBranch---------*/




/*-----------MUXJump-----------*/
  Two_to_one_MUX myMUXJump( .out(MUXJumpOutput), .A(MUXJumpInputA), .B(MUXJumpInputB), .sel(MUXJumpControlInput) );
/*---------END MUXJump---------*/

  


/*-----------MUXMemtoReg-----------*/
  Two_to_one_MUX myMUXMemtoReg( .out(MUXMemtoRegOutput), .A(MUXMemtoRegInputA), .B(MUXMemtoRegInputB), .sel(MUXMemtoRegControlInput) );
/*---------END MUXMemtoReg---------*/




/*-----------MUXRegDst-----------*/
  Two_to_one_MUX_5bit myMUXRegDst( .out(MUXRegDstOut), .A(MUXRegDstInputA), .B(MUXRegDstInputB), .sel(MUXRegDstControlInput) );
/*---------END MUXRegDst---------*/




/*-----------PROCESSOR-----------*/
//no decleration neccesarry
/*---------END PROCESSOR---------*/




/*-----------PCAdd-----------*/
  ALU myPCAdd( .ALUControl(PCAddControlInput), .DataIn0(PCAddPort0Input), .DataIn1(PCAddPort1Input), .DataOut(PCAddResultOutput), .ZeroOut(PCAddZeroResultOutput) );
/*---------END PCAdd---------*/




/*-----------RegFile-----------*/
  regFile myRegFile(.readAddress0(regFileReadReg0Input), .readAddress1(regFileReadReg1Input), .writeAddress(regFileWriteRegInput), .writeData(regFileWriteRegDataInput), .writeEnable(regFileRegWriteInput), .clk(clk), .readData0(regFileRegData0Output), .readData1(regFileRegData1Output));
/*---------END RegFile---------*/




/*-----------SignExtend-----------*/
  Sign_extend mySignExtend( .out(signExtendOutput), .in(signExtendInput) );
/*---------END SignExtend---------*/

  
/*==========END MODULE INSTANCES==========*/



  
/*============CONTROL CONNECTIONS============*/


  always@(controlRegDstOutput, controlALUSrcOutput, controlMemtoRegOutput, controlRegWriteOutput,  controlMemReadOutput, controlMemWriteOutput, controlBranchOutput, controlJumpOutput, controlALUOpOutput)
  begin
      /*-----------MUX control lines-----------*/
      
      MUXALUSrcControlInput = controlALUSrcOutput;      //For all of these, we need to be careful about which MUX inputs should be 
      MUXBranchControlInput = controlBranchOutput;      //selected when.  Right now when sel is 0 the output follows B, and when
      MUXJumpControlInput = controlJumpOutput;          //sel is 1 the output follows A
      MUXMemtoRegControlInput = controlMemtoRegOutput; 
      MUXRegDstControlInput = controlRegDstOutput;
      
      /*-----------End MUX control lines-----------*/
      
      
      /*-----------Other module control lines-----------*/
      
      regFileRegWriteInput = controlRegWriteOutput;
      memoryMemReadInput = controlMemReadOutput;
      memoryMemWriteInput = controlMemWriteOutput;
      ALUControlOpInput = controlALUOpOutput;
      
      /*-----------End Other module control lines-----------*/
  end
    
/*============END CONTROL CONNECTIONS============*/
  



/*============DATAPATH CONNECTIONS============*/
  always@(posedge clk)
  begin
    /*-----------Instruction Stage-----------*/

    // Getting instruction from instruction address will be here
    
    /*-----------End Instruction Stage-----------*/

    
    
    /*-----------Data Read Stage-----------*/

    controlOpcodeInput = instruction[26 +: 6];
    regFileReadReg0Input = instruction[21 +: 5];
    regFileReadReg1Input = instruction[16 +: 5];
    MUXRegDstInputB = instruction[16 +: 5];
    MUXRegDstInputA = instruction[11 +: 5];
    #1; 
    regFileWriteRegInput = MUXRegDstOut; //Need to delay to let MUX change output...not sure how much delay is needed (if any)
    signExtendInput = instruction[0 +: 16];
    ALUControlFunctInput = instruction[0 +: 6];

    /*-----------End Data Read Stage-----------*/
    
    #1; //Give sign extend time to execute
    
    /*-----------Execution Stage-----------*/

    ALUPort0Input= regFileRegData0Output;
    MUXALUSrcInputB = regFileRegData1Output;
    MUXALUSrcInputA = signExtendOutput;
    #1; 
    ALUPort1Input= MUXALUSrcOutput;
    ALUControlInput = controlALUOpOutput;

    /*-----------End Execution Stage-----------*/
    
    #1; //Give ALU time to execute operation
    
    /*-----------Data Memory Stage-----------*/

    memoryDataAddrInput = ALUResultOutput;
    memoryDataInInput = regFileRegData0Output;
    
    /*-----------End Data Memory Stage-----------*/

    #1; //Give Memory time to be accessed

    /*-----------Write Back Stage-----------*/

    MUXMemtoRegInputB = ALUResultOutput;
    MUXMemtoRegInputA = memoryDataOutOutput;
    #1; 
    regFileWriteRegDataInput = MUXMemtoRegOutput;

    /*-----------End Write Back Stage-----------*/
  end
/*============END DATAPATH CONNECTIONS============*/
  



/*============SET OUTPUT OF PROCESSOR TO WRITTEN REGISTER ============*/


  /*   Set processorOut equal to 1   */
  always@(regFileWriteRegDataInput)
  begin
    writtenRegAddressOutput = regFileRegWriteInput;
    writtenRegDataOutput = regFileWriteRegDataInput;
  end


/*============END SET OUTPUT OF PROCESSOR TO WRITTEN REGISTER============*/




endmodule






















//end
