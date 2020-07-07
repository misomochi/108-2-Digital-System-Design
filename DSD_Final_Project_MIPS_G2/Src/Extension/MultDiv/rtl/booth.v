module booth (
	input 	   		  clk,    // Clock
	input 	   		  rst_n,  // Asynchronous reset active low
	input 	   		  start,
	input 	   [31:0] multiplicand,
	input 	   [31:0] multiplier,
	output reg 		  done,
	output reg [63:0] product
);

localparam IDLE = 1'b0, ITER = 1'b1;

reg 	   state, next_state, next_done, extra_bit, next_extra_bit;
reg  [4:0] count, next_count;
reg [63:0] next_product;

always @(*) begin
	case (state)
		IDLE: begin
			next_count = 5'b0;
			next_state = start ? ITER : IDLE;
		end
		ITER: begin
			if ((multiplicand == 32'd1) | (multiplier == 32'd1) | (multiplicand == 32'd2) | (multiplier == 32'd2) | (multiplier == 32'd4) | (multiplier == 32'd8)) begin
				next_count = 5'b0;
				next_state = IDLE;
			end else begin
				next_count = count + 1'b1;
				next_state = (count < 5'd16) ? ITER : IDLE;
			end
		end
	endcase
end

always @(*) begin
	case (state)
		IDLE: begin
			next_done = 1'b0;
			next_product = start ? {32'b0, multiplier} : product;
			next_extra_bit = start ? 1'b0 : extra_bit;
		end
		ITER: begin
			if ((multiplicand == 32'b1) | (multiplier == 32'b1)) begin
				next_done 			= 1'b1;
				next_product[63:32] = 32'b0;
				next_product[31:0] 	= (multiplicand == 32'b1) ? multiplier : multiplicand;
			end else if ((multiplicand == 32'd2) | (multiplier == 32'd2)) begin
				next_done  	 = 1'b1;
				next_product = {31'b0, (multiplicand == 32'd2) ? multiplier : multiplicand, 1'b0};
			end else if (multiplier == 32'd4) begin
				next_done  	 = 1'b1;
				next_product = {30'b0, multiplicand, 2'b0};
			end else if (multiplier == 32'd8) begin
				next_done 	 = 1'b1;
				next_product = {29'b0, multiplicand, 3'b0};
			end else begin
				if (count < 5'd16) begin
					next_done = 1'b0;
					case ({product[1:0], extra_bit})
						3'b000: {next_product, next_extra_bit} = $signed({product, extra_bit}) >>> 2'd2; //+0
						3'b001: {next_product, next_extra_bit} = $signed({product[63:32] + multiplicand, product[31:0], extra_bit}) >>> 2'd2; //+y
						3'b010: {next_product, next_extra_bit} = $signed({product[63:32] + multiplicand, product[31:0], extra_bit}) >>> 2'd2; //+y
						3'b011: {next_product, next_extra_bit} = $signed({product[63:32] + (multiplicand << 1'b1), product[31:0], extra_bit}) >>> 2'd2; //+2y
						3'b100: {next_product, next_extra_bit} = $signed({product[63:32] + ((~multiplicand + 1'b1) << 1'b1), product[31:0], extra_bit}) >>> 2'd2; //-2y
						3'b101: {next_product, next_extra_bit} = $signed({product[63:32] + (~multiplicand + 1'b1), product[31:0], extra_bit}) >>> 2'd2; //-y
						3'b110: {next_product, next_extra_bit} = $signed({product[63:32] + (~multiplicand + 1'b1), product[31:0], extra_bit}) >>> 2'd2; //-y
						3'b111: {next_product, next_extra_bit} = $signed({product, extra_bit}) >> 2'd2; //-0
					endcase
				end else begin
					next_done 	   = 1'b1;
					next_product   = product;
					next_extra_bit = extra_bit;
				end
			end
		end
	endcase
end

always @(posedge clk) begin
	if(~rst_n) begin
		product   <= 64'b0;
		extra_bit <= 1'b0;
		count 	  <= 5'b0;
		state 	  <= IDLE;
		done 	  <= 1'b0;
	end else begin
		product   <= next_product;
		extra_bit <= next_extra_bit;
		count 	  <= next_count;
		state 	  <= next_state;
		done 	  <= next_done;
	end
end

endmodule