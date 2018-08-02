module smoothing(
	input		clk,
	input    [9:0]    SW,
	input		[15:0]	data_x,
	input		[15:0]	data_y,
	input		v_sync,
	input		data_update,
	output reg [9:0] LEDR,
	output reg [15:0]	out_x,
	output reg [15:0] out_y);
	
	reg [15:0] ff0,ff1,ff2,ff3,ff4,ff5,ff6,ff7,ff8,ff9,ff10,ff11,ff12,ff13,ff14,ff15;
	reg [15:0] ff0y,ff1y,ff2y,ff3y,ff4y,ff5y,ff6y,ff7y,ff8y,ff9y,ff10y,ff11y,ff12y,ff13y,ff14y,ff15y;
	reg [16:0] sum_x_1, sum_y_1;
	reg [17:0] sum_x_2, sum_y_2;
	reg [19:0] sum_x_3, sum_y_3;
	reg [15:0] c_out_x;
	reg [15:0] c_out_y;
	
	always@(*) begin
		LEDR = out_x[9:0];
		case({SW[1],SW[0]})
			2'b00: begin
					c_out_x = data_x;
					c_out_y = data_y;
			end
			
			2'b01: begin
					sum_x_1 = {ff0[15],ff0} + {ff1[15],ff1};
					c_out_x = sum_x_1 >> 1;
				
					sum_y_1 = {ff0y[15],ff0y} + {ff1y[15],ff1y};
					c_out_y = sum_y_1 >> 1;
			end
			
			2'b10: begin
					sum_x_2 = {ff0[15],ff0[15],ff0} + {ff1[15],ff1[15],ff1} + {ff2[15],ff2[15],ff2} + {ff3[15],ff3[15],ff3};
					c_out_x = sum_x_2 >> 2;
					
					sum_y_2 = {ff0y[15],ff0y[15],ff0y} + {ff1y[15],ff1y[15],ff1y} + {ff2y[15],ff2y[15],ff2y} + {ff3y[15],ff3y[15],ff3y};
					c_out_y = sum_y_2 >> 2;
			end
			
			2'b11: begin
					sum_x_3 = {{4{ff0[15]}},ff0} + {{4{ff1[15]}},ff1} + {{4{ff2[15]}},ff2} + {{4{ff3[15]}},ff3} + {{4{ff4[15]}},ff4} + {{4{ff5[15]}},ff5} + 
					{{4{ff6[15]}},ff6} + {{4{ff7[15]}},ff7} + {{4{ff8[15]}},ff8} + {{4{ff9[15]}},ff9} + {{4{ff10[15]}},ff10} + {{4{ff11[15]}},ff11} + 
					{{4{ff12[15]}},ff12} + {{4{ff13[15]}},ff13} + {{4{ff14[15]}},ff14} + {{4{ff15[15]}},ff15};
					c_out_x = sum_x_3 >> 4;
					
					sum_y_3 = {{4{ff0y[15]}},ff0y} + {{4{ff1y[15]}},ff1y} + {{4{ff2y[15]}},ff2y} + {{4{ff3y[15]}},ff3y} + {{4{ff4y[15]}},ff4y} + {{4{ff5y[15]}},ff5y} + 
					{{4{ff6y[15]}},ff6y} + {{4{ff7y[15]}},ff7y} + {{4{ff8y[15]}},ff8y} + {{4{ff9y[15]}},ff9y} + {{4{ff10y[15]}},ff10y} + {{4{ff11y[15]}},ff11y} + 
					{{4{ff12y[15]}},ff12y} + {{4{ff13y[15]}},ff13y} + {{4{ff14y[15]}},ff14y} + {{4{ff15y[15]}},ff15y};
					c_out_y = sum_y_3 >> 4;
			end
		endcase
	end
	
	always@(posedge v_sync) begin	
		out_x <= c_out_x;
		out_y <= c_out_y;
		
		ff15 <= #1 ff14;
		ff14 <= #1 ff13;
		ff13 <= #1 ff12;
		ff12 <= #1 ff11;
		ff11 <= #1 ff10;
		ff10 <= #1 ff9;
		ff9 <= #1 ff8;
		ff8 <= #1 ff7;
		ff7 <= #1 ff6;
		ff6 <= #1 ff5;
		ff5 <= #1 ff4;
		ff4 <= #1 ff3;
		ff3 <= #1 ff2;
		ff2 <= #1 ff1;
		ff1 <= #1 ff0;
		ff0 <= #1 data_x;

		ff15y <= #1 ff14y;
		ff14y <= #1 ff13y;
		ff13y <= #1 ff12y;
		ff12y <= #1 ff11y;
		ff11y <= #1 ff10y;
		ff10y <= #1 ff9y;
		ff9y <= #1 ff8y;
		ff8y <= #1 ff7y;
		ff7y <= #1 ff6y;
		ff6y <= #1 ff5y;
		ff5y <= #1 ff4y;
		ff4y <= #1 ff3y;
		ff3y <= #1 ff2y;
		ff2y <= #1 ff1y;
		ff1y <= #1 ff0y;
		ff0y <= #1 data_y;
	end // shift registers
	
endmodule
