module divider (
	input 	   		  clk,    // Clock
	input 	   		  rst_n,  // Asynchronous reset active low
	input 	   		  start,
	input 	   [31:0] dividend,
	input 	   [31:0] divisor,
	output reg 		  done,
	output reg [31:0] quotient, //LO
	output reg [31:0] remainder //HI
);

localparam IDLE = 1'b0, ITER = 1'b1;

reg 		state, next_state, next_done;
reg   [5:0] count, next_count;
reg  [31:0] next_quotient, next_remainder;

wire [31:0] dividend_p, divisor_p, shifted_remainder, difference;
wire 		diff_positive, quotient_sign, remainder_sign;

//convert dividend and divisor to positive
assign dividend_p 		 = dividend[31] ? (~dividend + 1'b1) : dividend;
assign divisor_p 		 = divisor[31]  ? (~divisor  + 1'b1) : divisor;

assign shifted_remainder = {remainder[30:0], quotient[31]}; //<<1
assign difference 		 = shifted_remainder - divisor_p;
assign diff_positive 	 = (shifted_remainder < divisor_p) ? 1'b0 : 1'b1;

assign quotient_sign 	 = dividend[31] ^ divisor[31];
assign remainder_sign 	 = dividend[31];

//next-state logic
always @(*) begin
	case (state)
		IDLE: begin
			next_count = 6'b0;
			next_state = start ? ITER : IDLE;
		end
		ITER: begin
			if ((divisor == 32'b1) | (dividend == divisor) | (divisor == 32'd4) | (divisor == 32'd8)) begin
				next_count = 6'b0;
				next_state = IDLE;
			end else begin
				next_count = count + 1'b1;
				next_state = (count < 6'd32) ? ITER : IDLE;
			end
			//next_count = count + 1'b1;
			//next_state = (count < 6'd32) ? ITER : IDLE;
		end
	endcase
end

//output logic
always @(*) begin
	case (state)
		IDLE: begin
			next_done = 1'b0;
			{next_remainder, next_quotient} = start ? {32'b0, dividend_p} : {remainder, quotient};
		end
		ITER: begin
			if (divisor == 32'b1) begin
				next_done = 1'b1;
				{next_remainder, next_quotient} = {32'b0, dividend};
			end else if (dividend == divisor) begin
				next_done = 1'b1;
				{next_remainder, next_quotient} = 64'b1;
			end else if (divisor == 32'd4) begin
				next_done 	   = 1'b1;
				next_quotient  = {{2{dividend[31]}}, dividend[31:2]};
				next_remainder = {{30{dividend[2]}}, dividend[1:0]};
			end else if (divisor == 32'd8) begin
				next_done 	   = 1'b1;
				next_quotient  = {{3{dividend[31]}}, dividend[31:3]};
				next_remainder = {{29{dividend[2]}}, dividend[2:0]};
			end else begin
				if (count < 6'd32) begin
					next_done = 1'b0;
					{next_remainder, next_quotient} = diff_positive ? {difference, quotient[30:0], 1'b1} : {shifted_remainder, quotient[30:0], 1'b0};
				end else begin
					next_done 	   = 1'b1;
					next_quotient  = quotient_sign  ? ~quotient  + 1'b1 : quotient;
					next_remainder = remainder_sign ? ~remainder + 1'b1 : remainder;
				end
			end
			/*if (count < 6'd32) begin
				next_done = 1'b0;
				{next_remainder, next_quotient} = diff_positive ? {difference, quotient[30:0], 1'b1} : {shifted_remainder, quotient[30:0], 1'b0};
			end else begin
				next_done 	   = 1'b1;
				next_quotient  = quotient_sign  ? ~quotient  + 1'b1 : quotient;
				next_remainder = remainder_sign ? ~remainder + 1'b1 : remainder;
			end*/
		end
	endcase
end

always @(posedge clk) begin
	if(~rst_n) begin
		quotient  <= 32'b0;
		remainder <= 32'b0;
		count 	  <= 6'b0;
		state 	  <= IDLE;
		done 	  <= 1'b0;
	end else begin
		quotient  <= next_quotient;
		remainder <= next_remainder;
		count 	  <= next_count;
		state 	  <= next_state;
		done 	  <= next_done;
	end
end

endmodule