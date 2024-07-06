//3:1 MUX
module mux3 #(parameter WIDTH=32)(
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	input [WIDTH-1:0] c,
	input [1:0] sel,
	output [WIDTH-1:0] out
);

	assign out = (sel == 2'b10) ? c :
						((sel == 2'b01) ? b :
							((sel == 2'b00) ? a : 32'd0));
							
endmodule