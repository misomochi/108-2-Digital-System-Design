module cache(
    clk,
    proc_reset,
    proc_read,
    proc_write,
    proc_addr,
    proc_rdata,
    proc_wdata,
    proc_stall,
    mem_read,
    mem_write,
    mem_addr,
    mem_rdata,
    mem_wdata,
    mem_ready
);
  
  localparam IDLE = 2'b00, COMPARE_TAG = 2'b01, WRITE_BACK = 2'b10, ALLOCATE = 2'b11;
//==== input/output definition ============================
    input          clk;
    // processor interface
    input          proc_reset;
    input          proc_read, proc_write;
    input   [29:0] proc_addr; //tag: proc_addr[29:5], index: proc_addr[4:2], offset: proc_addr[1:0]
    input   [31:0] proc_wdata;
    output         proc_stall;
    output  [31:0] proc_rdata;
    // memory interface
    input  [127:0] mem_rdata;
    input          mem_ready;
    output         mem_read, mem_write;
    output  [27:0] mem_addr;
    output [127:0] mem_wdata;
    
//==== wire/reg definition ================================
    reg [154:0] block [0:7]; //valid: 1 bit, dirty: 1 bit, tag: 25 bits, block: 4 words/16 bytes/128 bits
    reg [154:0] next_block [0:7];
    reg [154:0] mapped_block, block_write;
    reg [127:0] block_data, mem_wdata_r, mem_wdata_w;
    reg [27:0] mem_addr_r, mem_addr_w;
    reg [24:0] block_tag;
    reg [31:0] block_word, proc_rdata_r, proc_rdata_w;
    reg block_hit, block_valid, block_dirty, proc_stall_r, proc_stall_w, mem_read, mem_write;

    reg [1:0] current_state, next_state; 

    wire [24:0] tag;
    wire [2:0] index;
    wire [1:0] offset;

    integer i, j, k;
    //integer hit_counter = 0, miss_counter = 0, write_hit_counter = 0, write_miss_counter = 0, access_counter = 0, stall_counter = 0, execution_counter = 0;

    assign tag 	  = proc_addr[29:5];
    assign index  = proc_addr[4:2]; //block index
    assign offset = proc_addr[1:0];

    assign proc_rdata = proc_rdata_r;
    assign proc_stall = proc_stall_r;

    assign mem_wdata = mem_wdata_r;
    assign mem_addr  = mem_addr_r;

//==== combinational circuit ==============================
	always @(*) begin
		mapped_block = block[index]; //(block number) mod (number of cache blocks)
		block_valid  = mapped_block[154];
		block_dirty  = mapped_block[153];
		block_tag 	 = mapped_block[152:128];
		block_data 	 = mapped_block[127:0];

		block_hit = (block_tag == tag) & block_valid;

		case (offset)
			2'b00: begin
				block_word 	= block_data[31:0];
				block_write = {1'b1, 1'b1, tag, block_data[127:32], proc_wdata}; //dirty
			end
			2'b01: begin
				block_word 	= block_data[63:32];
				block_write = {1'b1, 1'b1, tag, block_data[127:64], proc_wdata, block_data[31:0]}; //dirty
			end
			2'b10: begin
				block_word 	= block_data[95:64];
				block_write = {1'b1, 1'b1, tag, block_data[127:96], proc_wdata, block_data[63:0]}; //dirty
			end
			2'b11: begin
				block_word 	= block_data[127:96];
				block_write = {1'b1, 1'b1, tag, proc_wdata, block_data[95:0]}; //dirty
			end
			default : begin
				block_word = 32'b0;
				block_write = 155'b0;
			end
		endcase

	end

	//next-state logic
	always @(*) begin
		case (current_state)
			IDLE: begin
				if (proc_read | proc_write) next_state = COMPARE_TAG;
				else next_state = IDLE;
			end
			COMPARE_TAG: begin
				if (block_hit) next_state = IDLE; //hit
				else if (~block_dirty) next_state = ALLOCATE; //miss & clean
				else if (block_dirty) next_state = WRITE_BACK; //miss & dirty
				else next_state = COMPARE_TAG;
			end
			WRITE_BACK: begin
				if (mem_ready) next_state = ALLOCATE; //memory ready
				else next_state = WRITE_BACK; //memory not ready
			end
			ALLOCATE: begin
				if (mem_ready) next_state = COMPARE_TAG; //memory ready
				else next_state = ALLOCATE; //memory not ready
			end
			default : next_state = IDLE;
		endcase
	end

	always @(*) begin
		//default
		for (k = 0; k < 8; k = k + 1) next_block[k] = block[k];
		proc_rdata_w = proc_rdata_r;
		mem_addr_w 	 = mem_addr_r;
		mem_wdata_w  = mem_wdata_r;

		case (current_state)
			IDLE: begin
				proc_stall_w = (proc_read | proc_write) ? 1'b1 : 1'b0;
				mem_read  = 1'b0;
				mem_write = 1'b0;
			end
			COMPARE_TAG: begin
				mem_read  = 1'b0;
				mem_write = 1'b0;
				if (proc_read) begin
					if (block_hit) begin //read hit
						proc_stall_w = 1'b0;
						proc_rdata_w = block_word;
					end else begin //read miss
						proc_stall_w = 1'b1;
						if (block_dirty) begin //write back
							mem_addr_w 	= {block_tag, index};
							mem_wdata_w = block_data;				
						end else mem_addr_w = proc_addr[29:2];
					end
				end else if (proc_write) begin
					if (block_hit) begin //write hit
						proc_stall_w = 1'b0;
						next_block[index] = block_write;
					end else begin //write miss
						proc_stall_w = 1'b1;
						if (block_dirty) begin //write back
							mem_addr_w 	= {block_tag, index};
							mem_wdata_w = block_data;
						end else mem_addr_w = proc_addr[29:2];
					end
				end else proc_stall_w = 1'b0;
			end
			WRITE_BACK: begin
				proc_stall_w = 1'b1;
				mem_read 	 = 1'b0;
				if (mem_ready) begin
					mem_write  		  = 1'b0;
					mem_addr_w 		  = proc_addr[29:2];
					next_block[index] = {1'b1, 1'b0, tag, block_data}; //clean
				end else begin
					mem_write = 1'b1;
				end
			end
			ALLOCATE: begin
				proc_stall_w = 1'b1;
				mem_write 	 = 1'b0;
				if (mem_ready) begin
					mem_read 	 	  = 1'b0;
					next_block[index] = {1'b1, 1'b0, tag, mem_rdata};
				end else mem_read = 1'b1;
			end
			default : begin
				proc_stall_w = 1'b0;
				mem_read 	 = 1'b0;
				mem_write	 = 1'b0;
			end
		endcase
	end

	/*always @(posedge proc_stall_w) begin
		if (proc_read) begin
			miss_counter = miss_counter + 1;
		end else if (proc_write) begin
			write_miss_counter = write_miss_counter + 1;
		end
	end

	always @(negedge proc_stall_w) begin
		if (proc_read) begin
			hit_counter = hit_counter + 1;
		end else if (proc_write) begin
			write_hit_counter = write_hit_counter + 1;
		end
	end

	always @(proc_addr) begin
		access_counter = access_counter + 1;
	end

	always @(posedge clk) begin
		if (proc_stall) begin
			stall_counter = stall_counter + 1;
		end else execution_counter = execution_counter + 1;
	end*/

//==== sequential circuit =================================
	always@( posedge clk ) begin
	    if( proc_reset ) begin
	    	for (i = 0; i < 8; i = i + 1) block[i] <= 155'b0;
	    	proc_rdata_r  <= 32'b0;
	    	proc_stall_r  <= 1'b0;
	    	mem_addr_r 	  <= 28'b0;
	    	mem_wdata_r   <= 128'b0;
	    	current_state <= IDLE;
	    end
	    else begin
	    	for (j = 0; j < 8; j = j + 1) block[j] <= next_block[j];
	    	proc_rdata_r  <= proc_rdata_w;
	    	proc_stall_r  <= proc_stall_w;
	    	mem_addr_r 	  <= mem_addr_w;
	    	mem_wdata_r   <= mem_wdata_w;
	    	current_state <= next_state;
	    end
	end

endmodule
