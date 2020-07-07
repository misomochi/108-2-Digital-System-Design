// Top module of your design, you cannot modify this module!!
module CHIP (	clk,
				rst_n,
//----------for slow_memD------------
				mem_read_D,
				mem_write_D,
				mem_addr_D,
				mem_wdata_D,
				mem_rdata_D,
				mem_ready_D,
//----------for slow_memI------------
				mem_read_I,
				mem_write_I,
				mem_addr_I,
				mem_wdata_I,
				mem_rdata_I,
				mem_ready_I,
//----------for TestBed--------------				
				DCACHE_addr, 
				DCACHE_wdata,
				DCACHE_wen   
			);
input			clk, rst_n;
//--------------------------

output			mem_read_D;
output			mem_write_D;
output	[31:4]	mem_addr_D;
output	[127:0]	mem_wdata_D;
input	[127:0]	mem_rdata_D;
input			mem_ready_D;
//--------------------------
output			mem_read_I;
output			mem_write_I;
output	[31:4]	mem_addr_I;
output	[127:0]	mem_wdata_I;
input	[127:0]	mem_rdata_I;
input			mem_ready_I;
//----------for TestBed--------------
output	[29:0]	DCACHE_addr;
output	[31:0]	DCACHE_wdata;
output			DCACHE_wen;
//--------------------------

// wire declaration
wire        ICACHE_ren;
wire        ICACHE_wen;
wire [29:0] ICACHE_addr;
wire [31:0] ICACHE_wdata;
wire        ICACHE_stall;
wire [31:0] ICACHE_rdata;

wire        DCACHE_ren;
wire        DCACHE_wen;
wire [29:0] DCACHE_addr;
wire [31:0] DCACHE_wdata;
wire        DCACHE_stall;
wire [31:0] DCACHE_rdata;

wire         mem_read_I_internal;
wire         mem_write_I_internal;
wire [31:4]  mem_addr_I_internal;
wire [127:0] mem_wdata_I_internal;
wire [127:0] mem_rdata_I_internal;
wire         mem_ready_I_internal;

wire         mem_read_D_internal;
wire         mem_write_D_internal;
wire [31:4]  mem_addr_D_internal;
wire [127:0] mem_wdata_D_internal;
wire [127:0] mem_rdata_D_internal;
wire         mem_ready_D_internal;

//=========================================
	// Note that the overall design of your MIPS includes:
	// 1. pipelined MIPS processor
	// 2. data cache
	// 3. instruction cache
	// 4. L2 cache (unified)


	MIPS_Pipeline i_MIPS(
		// control interface
		.clk            (clk)           , 
		.rst_n          (rst_n)         ,
//----------I cache interface-------		
		.ICACHE_ren     (ICACHE_ren)    ,
		.ICACHE_wen     (ICACHE_wen)    ,
		.ICACHE_addr    (ICACHE_addr)   ,
		.ICACHE_wdata   (ICACHE_wdata)  ,
		.ICACHE_stall   (ICACHE_stall)  ,
		.ICACHE_rdata   (ICACHE_rdata)  ,
//----------D cache interface-------
		.DCACHE_ren     (DCACHE_ren)    ,
		.DCACHE_wen     (DCACHE_wen)    ,
		.DCACHE_addr    (DCACHE_addr)   ,
		.DCACHE_wdata   (DCACHE_wdata)  ,
		.DCACHE_stall   (DCACHE_stall)  ,
		.DCACHE_rdata   (DCACHE_rdata)
	);
	
	cache D_cache(
        .clk        (clk)                  ,
        .proc_reset (~rst_n)               ,
        .proc_read  (DCACHE_ren)           ,
        .proc_write (DCACHE_wen)           ,
        .proc_addr  (DCACHE_addr)          ,
        .proc_rdata (DCACHE_rdata)         ,
        .proc_wdata (DCACHE_wdata)         ,
        .proc_stall (DCACHE_stall)         ,
        .mem_read   (mem_read_D_internal)  ,
        .mem_write  (mem_write_D_internal) ,
        .mem_addr   (mem_addr_D_internal)  ,
        .mem_wdata  (mem_wdata_D_internal) ,
        .mem_rdata  (mem_rdata_D_internal) ,
        .mem_ready  (~mem_ready_D_internal)
	);

	cache I_cache(
        .clk        (clk)                  ,
        .proc_reset (~rst_n)               ,
        .proc_read  (ICACHE_ren)           ,
        .proc_write (ICACHE_wen)           ,
        .proc_addr  (ICACHE_addr)          ,
        .proc_rdata (ICACHE_rdata)         ,
        .proc_wdata (ICACHE_wdata)         ,
        .proc_stall (ICACHE_stall)         ,
        .mem_read   (mem_read_I_internal)  ,
        .mem_write  (mem_write_I_internal) ,
        .mem_addr   (mem_addr_I_internal)  ,
        .mem_wdata  (mem_wdata_I_internal) ,
        .mem_rdata  (mem_rdata_I_internal) ,
        .mem_ready  (~mem_ready_I_internal)
	);

	L2_cache l2_cache(
		.clk          (clk)                 ,
		.proc_reset   (~rst_n)              ,
		.proc_read_I  (mem_read_I_internal) ,
		.proc_write_I (mem_write_I_internal),
		.proc_addr_I  (mem_addr_I_internal) ,
		.proc_rdata_I (mem_rdata_I_internal),
		.proc_wdata_I (mem_wdata_I_internal),
		.proc_stall_I (mem_ready_I_internal) ,
		.mem_read_I   (mem_read_I)          ,
		.mem_write_I  (mem_write_I)         ,
		.mem_addr_I   (mem_addr_I)          ,
		.mem_rdata_I  (mem_rdata_I)         ,
		.mem_wdata_I  (mem_wdata_I)         ,
		.mem_ready_I  (mem_ready_I)         ,
		.proc_read_D  (mem_read_D_internal) ,
		.proc_write_D (mem_write_D_internal),
		.proc_addr_D  (mem_addr_D_internal) ,
		.proc_rdata_D (mem_rdata_D_internal),
		.proc_wdata_D (mem_wdata_D_internal),
		.proc_stall_D (mem_ready_D_internal) ,
		.mem_read_D   (mem_read_D)          ,
		.mem_write_D  (mem_write_D)         ,
		.mem_addr_D   (mem_addr_D)          ,
		.mem_rdata_D  (mem_rdata_D)         ,
		.mem_wdata_D  (mem_wdata_D)         ,
		.mem_ready_D  (mem_ready_D)
	);
endmodule
