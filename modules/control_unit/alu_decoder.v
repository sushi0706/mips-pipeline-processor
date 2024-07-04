//alu-decoder
module alu_decoder(
	input [5:0] funct,
	input [1:0] alu_op,
	output reg [2:0] alu_ctrl
);

	always@(*) begin
		case(alu_op) 
			2'b00: alu_ctrl=3'b010;					//ADD
			2'b01: alu_ctrl=3'b110;					//SUB
			default: begin
				case(funct)								//R-type
					6'b100000: alu_ctrl=3'b010;	//ADD
					6'b100010: alu_ctrl=3'b110;	//SUB
					6'b100100: alu_ctrl=3'b000;	//AND
					6'b100101: alu_ctrl=3'b001;	//OR
					6'b101010: alu_ctrl=3'b111;	//SLT
					default: alu_ctrl=3'bxxx;
				endcase
			end
		endcase
	end

endmodule 