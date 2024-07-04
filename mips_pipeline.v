module mips_pipeline(
	input clk,
	input reset
);

	wire id_ex_jump;
	wire wb_reg_wr_en;
	wire id_ex_mem_to_reg_wr;
	wire id_ex_mem_wr_en;
	wire id_ex_alu_src_sel;
	wire id_ex_reg_wr_en;
	wire [31:0] id_ex_pc_branch;
	wire [31:0] id_ex_pc_jump;
	wire [31:0] if_id_pc_plus_4;
	wire [31:0] if_id_instr;
	wire [31:0] wb_reg_wr_data;
	wire [4:0] wb_reg_wr_addr;
	wire [2:0] id_ex_alu_ctrl;
	wire [4:0] id_ex_reg_wr_addr;
	wire [31:0] id_ex_reg_rd_data1;
	wire [31:0] id_ex_reg_rd_data2;
	wire [31:0] id_ex_sign_imm_ext;
	wire ex_jump;
	wire ex_pc_src;
	wire ex_mem_mem_to_reg_wr;
	wire ex_mem_mem_wr_en;
	wire ex_mem_reg_wr_en;
	wire [31:0] ex_pc_branch;
	wire [31:0] ex_pc_jump;
	wire [4:0] ex_mem_reg_wr_addr;
	wire [31:0] ex_mem_alu_result;
	wire [31:0] ex_mem_mem_wr_data;
	wire mem_wb_reg_wr_en;
	wire mem_wb_mem_to_reg_wr;
	wire [4:0] mem_wb_reg_wr_addr;
	wire [31:0] mem_wb_mem_rd_data;
	wire [31:0] mem_wb_alu_result;
	
	instr_fetch instr_fetch_inst(
		.clk(clk),
		.reset(reset),
		.jump(ex_jump),
		.pc_src(ex_pc_src),
		.pc_branch(ex_pc_branch),
		.pc_jump(ex_pc_jump),
		.if_id_instr(if_id_instr),
		.if_id_pc_plus_4(if_id_pc_plus_4)
	);
	
	instr_decode instr_decode_inst(
		.clk(clk),
		.reset(reset),
		.instr(if_id_instr),
		.pc_plus_4(if_id_pc_plus_4),
		.reg_wr_data(wb_reg_wr_data),
		.reg_wr_addr(wb_reg_wr_addr),
		.reg_wr_en(wb_reg_wr_en),
		.id_ex_jump(id_ex_jump),
		.id_ex_mem_to_reg_wr(id_ex_mem_to_reg_wr),
		.id_ex_mem_wr_en(id_ex_mem_wr_en),
		.id_ex_alu_src_sel(id_ex_alu_src_sel),
		.id_ex_branch(id_ex_branch),
		.id_ex_reg_wr_en(id_ex_reg_wr_en),
		.id_ex_pc_branch(id_ex_pc_branch),
		.id_ex_pc_jump(id_ex_pc_jump),
		.id_ex_alu_ctrl(id_ex_alu_ctrl),
		.id_ex_reg_wr_addr(id_ex_reg_wr_addr),
		.id_ex_reg_rd_data1(id_ex_reg_rd_data1),
		.id_ex_reg_rd_data2(id_ex_reg_rd_data2),
		.id_ex_sign_imm_ext(id_ex_sign_imm_ext)
	);
	
	execute execute_inst(
		.clk(clk),
		.reset(reset),
		.branch(id_ex_branch),
		.jump(id_ex_jump),
		.mem_to_reg_wr(id_ex_mem_to_reg_wr),
		.mem_wr_en(id_ex_mem_wr_en),
		.reg_wr_en(id_ex_reg_wr_en),
		.alu_src_sel(id_ex_alu_src_sel),
		.alu_ctrl(id_ex_alu_ctrl),
		.pc_branch(id_ex_pc_branch),
		.pc_jump(id_ex_pc_jump),
		.reg_wr_addr(id_ex_reg_wr_addr),
		.reg_rd_data1(id_ex_reg_rd_data1),
		.reg_rd_data2(id_ex_reg_rd_data2),
		.sign_imm_ext(id_ex_sign_imm_ext),
		.ex_pc_src(ex_pc_src),
		.ex_jump(ex_jump),
		.ex_pc_branch(ex_pc_branch),
		.ex_pc_jump(ex_pc_jump),
		.ex_mem_mem_to_reg_wr(ex_mem_mem_to_reg_wr),
		.ex_mem_mem_wr_en(ex_mem_mem_wr_en),
		.ex_mem_reg_wr_en(ex_mem_reg_wr_en),
		.ex_mem_reg_wr_addr(ex_mem_reg_wr_addr),
		.ex_mem_alu_result(ex_mem_alu_result),
		.ex_mem_mem_wr_data(ex_mem_mem_wr_data)
	);
	
	memory_write memory_write_inst(
		.clk(clk),
		.reset(reset),
		.reg_wr_en(ex_mem_reg_wr_en),
		.mem_wr_en(ex_mem_mem_wr_en),
		.mem_to_reg_wr(ex_mem_mem_to_reg_wr),
		.reg_wr_addr(ex_mem_reg_wr_addr),
		.alu_result(ex_mem_alu_result),
		.mem_wr_data(ex_mem_mem_wr_data),
		.mem_wb_reg_wr_en(mem_wb_reg_wr_en),
		.mem_wb_mem_to_reg_wr(mem_wb_mem_to_reg_wr),
		.mem_wb_reg_wr_addr(mem_wb_reg_wr_addr),
		.mem_wb_mem_rd_data(mem_wb_mem_rd_data),
		.mem_wb_alu_result(mem_wb_alu_result)
	);
	
	write_back write_back_inst(
		.reg_wr_en(mem_wb_reg_wr_en),
		.mem_to_reg_wr(mem_wb_mem_to_reg_wr),
		.alu_result(mem_wb_alu_result),
		.mem_rd_data(mem_wb_mem_rd_data),
		.reg_wr_addr(mem_wb_reg_wr_addr),
		.wb_reg_wr_en(wb_reg_wr_en),
		.wb_reg_wr_data(wb_reg_wr_data),
		.wb_reg_wr_addr(wb_reg_wr_addr)
	);
		
endmodule