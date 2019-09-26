//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
parameter  AND = 6'b100100, OR = 6'b100101, add = 6'b100000, sub = 6'b100010, slt = 6'b101010;
parameter  r_format = 3'b010,  beq = 3'b001, addi = 3'b110, slti = 3'b111;      
//Select exact operation
always@(*)begin
    case(ALUOp_i)
      r_format: 
	        case(funct_i)
	          AND: ALUCtrl_o = 4'b0000;
	          OR : ALUCtrl_o = 4'b0001;
	          add: ALUCtrl_o = 4'b0010;
	          sub: ALUCtrl_o = 4'b0110;
	          slt: ALUCtrl_o = 4'b0111;
	        endcase
      addi: ALUCtrl_o = 4'b0010;
      beq : ALUCtrl_o = 4'b0110;
      slti: ALUCtrl_o = 4'b0111;
    endcase
end
endmodule     





                    
                    