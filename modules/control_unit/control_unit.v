//controller module
module control_unit(
	input [5:0] funct,
	input [5:0] opcode,
	output mem_to_reg_wr,
	output mem_wr_en,
	output jump,
	output alu_src_sel,
	output reg_file_dst_sel,
	output reg_wr_en,
	output branch,
	output [2:0] alu_ctrl
);
	
	wire [1:0] alu_op;

	alu_decoder alu_decoder_inst(
		.funct(funct),
		.alu_op(alu_op),
		.alu_ctrl(alu_ctrl)
	);
	
	main_decoder main_decoder_inst(
		.opcode(opcode),
		.mem_to_reg_wr(mem_to_reg_wr),
		.mem_wr_en(mem_wr_en),
		.branch(branch),
		.alu_src_sel(alu_src_sel),
		.reg_file_dst_sel(reg_file_dst_sel),
		.reg_wr_en(reg_wr_en),
		.jump(jump),
		.alu_op(alu_op)
	);
	
endmodule
