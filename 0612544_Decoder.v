	//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter

parameter addi = 6'b001000, slti = 6'b001010, r_format = 6'b000000,  beq = 6'b000100;

//Main function
always@(*)
  case(instr_op_i)
    addi   : begin
      RegWrite_o = 1'b1;
      ALU_op_o = 3'b110;
      ALUSrc_o = 1'b1;
      RegDst_o = 1'b0;
      Branch_o = 1'b0;
    end
    slti   : begin
      RegWrite_o = 1'b1;
      ALU_op_o = 3'b111;
      ALUSrc_o = 1'b1;
      RegDst_o = 1'b0;
      Branch_o = 1'b0;
    end
    r_format: begin
      RegWrite_o = 1'b1;
      ALU_op_o = 3'b010;
      ALUSrc_o = 1'b0;
      RegDst_o = 1'b1;
      Branch_o = 1'b0;
    end
    beq: begin
      RegWrite_o = 1'b0;
      ALU_op_o = 3'b001;
      ALUSrc_o = 1'b0;
      RegDst_o = 1'b0;
      Branch_o = 1'b1;
    end
  endcase
               
endmodule





                    
                    