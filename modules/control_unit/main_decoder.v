//main-decoder
module main_decoder(
	input [5:0] opcode,
	output mem_to_reg_wr,
	output mem_wr_en,
	output branch,
	output alu_src_sel,
	output reg_file_dst_sel,
	output reg_wr_en,
	output jump,
	output [1:0] alu_op
);
	
	reg [8:0] controls;
	
	always@(*) begin
		case(opcode)
		  6'b000000: controls <= 9'b110000010; //R-type
        6'b100011: controls <= 9'b101001000; //LW
        6'b101011: controls <= 9'b0x101x000; //SW
        6'b000100: controls <= 9'b0x010x001; //BEQ
        6'b001000: controls <= 9'b101000000; //ADDI
        6'b000010: controls <= 9'b0xxx0x1xx; //J
        default:   controls <= 9'bxxxxxxxxx;
		endcase
	end
	
	assign {reg_wr_en, reg_file_dst_sel, alu_src_sel, branch, mem_wr_en, mem_to_reg_wr, jump, alu_op} = controls;
	
endmodule 