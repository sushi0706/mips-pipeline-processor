module hazard_unit #(parameter WIDTH=5)(
	input id_branch,
	input ex_mem_to_reg_wr,
	input mem_mem_to_reg_wr,
	input ex_reg_wr_en,
	input mem_reg_wr_en,
	input wb_reg_wr_en,
	input [WIDTH-1:0] id_rs,
	input [WIDTH-1:0] id_rt,
	input [WIDTH-1:0] ex_rs,
	input [WIDTH-1:0] ex_rt,
	input [WIDTH-1:0] ex_reg_wr_addr,
	input [WIDTH-1:0] mem_reg_wr_addr,
	input [WIDTH-1:0] wb_reg_wr_addr,
	output stall_if,
	output stall_id,
	output flush_ex,
	output [1:0] forwardA_ex,
	output [1:0] forwardB_ex,
	output forwardA_id,
	output forwardB_id
);

	wire branch_stall;
	wire lw_stall;
	
	assign branch_stall = (id_branch && ex_reg_wr_en && ((ex_reg_wr_addr == id_rs) || (ex_reg_wr_addr == id_rt)))
									|| (id_branch && mem_mem_to_reg_wr && ((mem_reg_wr_addr == id_rs) || (mem_reg_wr_addr == id_rt)));
									
	assign lw_stall = ((id_rs == ex_rt) || (id_rt == ex_rt)) && ex_mem_to_reg_wr;
	
	assign stall_id = lw_stall || branch_stall;
	assign stall_if = lw_stall || branch_stall;
	assign flush_ex = lw_stall || branch_stall;
	
	assign forwardA_ex = ((ex_rs != 0) && (ex_rs == mem_reg_wr_addr) && mem_reg_wr_en) ? 2'b10 :
									(((ex_rs != 0) && (ex_rs == wb_reg_wr_addr) && wb_reg_wr_en) ? 2'b01 :
									2'b00);
									
	assign forwardB_ex = ((ex_rt != 0) && (ex_rt == mem_reg_wr_addr) && mem_reg_wr_en) ? 2'b10 :
									(((ex_rt != 0) && (ex_rt == wb_reg_wr_addr) && wb_reg_wr_en) ? 2'b01 :
									2'b00);
									
	assign forwardA_id = ((id_rs != 0) && (id_rs == mem_reg_wr_addr) && mem_reg_wr_en);
	
	assign forwardB_id = ((id_rt != 0) && (id_rt == mem_reg_wr_addr) && mem_reg_wr_en);
	
endmodule