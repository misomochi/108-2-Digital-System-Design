module DFC(clk, reset, datain, cmd, cmd_valid, dataout, output_valid, busy);
input           clk;
input           reset;
input   [7:0]   datain;
input   [1:0]   cmd;
input           cmd_valid;
output  [8:0]   dataout;
output          output_valid;
output          busy;

parameter IDLE      = 3'd0;
parameter LOAD_DATA = 3'd1;
parameter FIFO      = 3'd2;
parameter LIFO      = 3'd3;
parameter OUT       = 3'd4;

wire [8:0] calculated_buf [0:3];

reg busy, output_valid;
reg [8:0] dataout;
reg [7:0] data_buf [0:7];
reg [7:0] nxt_data_buf [0:7];
reg [8:0] y [0:3];
reg [8:0] nxt_y [0:3];
reg [2:0] state, nxt_state;

integer i, j, k, count, nxt_count;

ALU A1	(.out(calculated_buf[0]), .mode(1'b1), .in_a(data_buf[0]), .in_b(data_buf[4]));
ALU A2	(.out(calculated_buf[1]), .mode(1'b1), .in_a(data_buf[1]), .in_b(data_buf[5])); 
ALU A3	(.out(calculated_buf[2]), .mode(1'b1), .in_a(data_buf[2]), .in_b(data_buf[6])); 
ALU A4	(.out(calculated_buf[3]), .mode(1'b1), .in_a(data_buf[3]), .in_b(data_buf[7]));

//========= FSM =================
always @(posedge clk or posedge reset) begin  
	if (reset) state <= IDLE;
	else state <= nxt_state;
end

always@(*) begin
	//default
	nxt_count = count;
	output_valid = 1'b0;
	for (k = 0; k < 8; k = k + 1) begin
		nxt_data_buf[k] = data_buf[k];
		nxt_y[k] = y[k];
	end

	case (state)
        IDLE: begin
        	if (cmd_valid) begin //enable
        		case (cmd)
        			2'd0: nxt_state = LOAD_DATA;
        			2'd1: nxt_state = FIFO;
        			2'd2: nxt_state = LIFO;
        			default : nxt_state = IDLE;
        		endcase
        	end
        	else nxt_state = IDLE;
        end
        LOAD_DATA: begin
        	if (count < 8) begin
        		nxt_state = LOAD_DATA;
        		nxt_data_buf[count] = datain;
        		nxt_count = count + 1;
        	end else begin
        		nxt_state = IDLE;
        		nxt_count = 0;
        	end
        end
        FIFO: begin
        	if (count < 4) begin
        		nxt_state = FIFO;
        		nxt_y[count] = calculated_buf[count];
        		nxt_count = count + 1;
        	end else begin
        		nxt_state = OUT;
        		nxt_count = 0;
        	end
        end
        LIFO: begin
        	if (count < 4) begin
        		nxt_state = LIFO;
        		nxt_y[count] = calculated_buf[3 - count];
        		nxt_count = count + 1;
        	end else begin
        		nxt_state = OUT;
        		nxt_count = 0;
        	end
        end
        OUT: begin
        	output_valid = 1'b1;
            if (count < 4) begin
            	nxt_state = OUT;
            	dataout = y[count];
            	nxt_count = count + 1;
            end else begin
            	output_valid = 1'b0;
            	nxt_state = IDLE;
            	dataout = 8'd0;
            	nxt_count = 0;
            end
        end
        default: begin
        	nxt_state = IDLE;
        	nxt_count = 0;
        end
	endcase
end

//============== Combinational =================

// dataout, output_valid
/*always @(*) begin  
	if (state==OUT) begin
		output_valid = 1'b1;
		dataout = y[count];
	end else begin
		output_valid = 1'b0;
		dataout = 8'd0;
	end
end*/

//busy
always @(*) begin		
	if (state==IDLE) busy = 1'b0;
	else busy = 1'b1;
end
				
//=============== Sequential =================
always @(posedge clk or posedge reset) begin  
	if (reset) begin
		for(i=0;i<8;i=i+1) begin
			data_buf[i] <= 8'd0;
			y[i] <= 9'd0;
		end
		count <= 0;
	end else begin
		for (j = 0; j < 8; j = j + 1) begin
			data_buf[j] <= nxt_data_buf[j];
			y[j] <= nxt_y[j];
		end
		count <= nxt_count;
	end
end

endmodule
