module instr_fetch(
	input clk,
	input reset,
	input jump,
	input pc_src,
	input stall_if,
	input stall_id,
	input [31:0] pc_branch,
	input [31:0] pc_jump,
	output [31:0] if_id_pc_plus_4,
	output [31:0] if_id_instr
);
	
	wire [31:0] instr;
	wire [31:0] pc;
	wire [31:0] pc_plus_4;
	wire [31:0] next_pc_br;
	wire [31:0] next_pc;
	
	mux2 pc_branch_mux_inst(
		.a(pc_plus_4),
		.b(pc_branch),
		.sel(pc_src),
		.out(next_pc_br)
	);
	
	mux2 pc_jump_mux_inst(
		.a(next_pc_br),
		.b(pc_jump),
		.sel(jump),
		.out(next_pc)
	);
	
	d_ff pc_ff_inst(
		.clk(clk),
		.reset(reset),
		.en(stall_if),
		.d(next_pc),
		.q(pc)
	);
	
	instr_mem instr_mem_inst(
		.instr_addr(pc[7:2]),
		.instr(instr)
	);
	
	adder pc_plus_4_inst(
		.a(4),
		.b(pc),
		.sum(pc_plus_4)
	);
	
	d_ff if_id_pc_plus_4_inst(
		.clk(clk),
		.reset((reset | pc_src)),
		.en(stall_id),
		.d(pc_plus_4),
		.q(if_id_pc_plus_4)
	);
	
	d_ff if_id_instr_inst(
		.clk(clk),
		.reset((reset | pc_src)),
		.en(stall_id),
		.d(instr),
		.q(if_id_instr)
	);

endmodule