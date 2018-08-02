module smoothing_tb();

	wire clk;
	reg [9:0] SW;
	reg [15:0] data_x;
	reg [15:0] data_y;
	reg [15:0] v_sync;
	reg data_update;
	wire [15:0] out_x;
	wire [15:0] out_y;
	
	smoothing UUT(.clk(clk), .SW(SW), .data_x(data_x), .data_y(data_y), .v_sync(v_sync), .data_update(data_update),
						.out_x(out_x), .out_y(out_y));
	
	integer i;
	
	initial begin
		data_update = 1'b1;
		SW[0] = 1'b1;
		SW[1] = 1'b1;
		#100
				
		for(i = 0; i < 65536; i = i + 1) begin
			v_sync = 1'b0;
			#100;
			data_x = i;
			data_y = i;
			v_sync = 1'b1;
			#100;
		end

	end
endmodule
