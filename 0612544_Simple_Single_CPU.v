//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles

wire     [31:0]currentPC;
wire     [31:0]nextPC; 
wire     [31:0]rs;
wire     [31:0]rt;
wire     [31:0]result;
wire     [31:0]muxOut;
wire    [3-1:0]aluOP;
wire           aluSrc;
wire           regWrite;
wire           regDst;
wire     [31:0]seqPC;
wire     [31:0]branPC;  
wire           zero;
wire      [4:0]writeToReg;
wire      [3:0]aluCtrl;
wire           branch;                       
wire     [31:0]inst;
wire     [31:0]extendOut;
wire     [31:0]jump;
wire     selectPC;
assign   selectPC = zero&branch;	
//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(nextPC) ,   
	    .pc_out_o(currentPC) 
	    );
	
Adder Adder1(
        .src1_i(currentPC),     
	    .src2_i(32'd4),     
	    .sum_o(seqPC)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(currentPC),  
	    .instr_o(inst)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(inst[20:16]),
        .data1_i(inst[15:11]),
        .select_i(regDst),
        .data_o(writeToReg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(inst[25:21]) ,  
        .RTaddr_i(inst[20:16]) ,  
        .RDaddr_i(writeToReg) ,  
        .RDdata_i(result)  , 
        .RegWrite_i(regWrite),
        .RSdata_o(rs) ,  
        .RTdata_o(rt)   
        );
	
Decoder Decoder(
        .instr_op_i(inst[31:26]), 
	    .RegWrite_o(regWrite), 
	    .ALU_op_o(aluOP),   
	    .ALUSrc_o(aluSrc),   
	    .RegDst_o(regDst),   
		.Branch_o(branch)   
	    );

ALU_Ctrl AC(
        .funct_i(inst[5:0]),   
        .ALUOp_i(aluOP),   
        .ALUCtrl_o(aluCtrl) 
        );
	
Sign_Extend SE(
        .data_i(inst[15:0]),
        .data_o(extendOut)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(rt),
        .data1_i(extendOut),
        .select_i(aluSrc),
        .data_o(muxOut)
        );	
		
ALU ALU(
        .src1_i(rs),
	    .src2_i(muxOut),
	    .ctrl_i(aluCtrl),
	    .result_o(result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(seqPC),     
	    .src2_i(jump),     
	    .sum_o(branPC)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(extendOut),
        .data_o(jump)
        ); 	

MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(seqPC),
        .data1_i(branPC),
        .select_i(selectPC),
        .data_o(nextPC)
        );	

endmodule
		  


