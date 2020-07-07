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
    
//==== input/output definition ============================
    input          clk;
    // processor interface
    input          proc_reset;
    input          proc_read, proc_write;
    input   [29:0] proc_addr;
    input   [31:0] proc_wdata;
    output         proc_stall;
    output reg [31:0] proc_rdata;
    // memory interface
    input  [127:0] mem_rdata;
    input          mem_ready;
    output         mem_read, mem_write;
    output reg [27:0] mem_addr;
    output reg [127:0] mem_wdata;
    
    parameter TAG_WIDTH = 25;
    parameter BLOCK_NUMBER = 8;
    parameter INITIAL = 0, RESET = 1, PROCESS = 2, WRITE = 3, READ = 4;
//==== wire/reg definition ================================
    wire isdirty;
    reg writemiss, readmiss;

    reg [127:0] block_data[0:BLOCK_NUMBER-1];//data in cache
    reg [TAG_WIDTH-1:0] block_tag[0:BLOCK_NUMBER-1];//tag in cache
    reg block_valid[0:BLOCK_NUMBER-1];//0==not valid, 1==valid
    reg block_dirty[0:BLOCK_NUMBER-1];//0==not dirty, 1==dirty
    reg [2:0] Q_NOW, Q_NEXT;

    integer i;
//==== combinational circuit ==============================
assign proc_stall = (writemiss||readmiss||Q_NOW==WRITE||Q_NOW==READ)?1:0;
assign mem_write = (Q_NOW==WRITE)?1:0;
assign mem_read = (Q_NOW==READ)?1:0;
assign isdirty = block_dirty[proc_addr[4:2]];

always@(*)begin
    //mem_addr logic
    if(Q_NOW==WRITE)begin
        case(proc_addr[4:2])
            3'd0: mem_addr = {block_tag[0], 3'd0};
            3'd1: mem_addr = {block_tag[1], 3'd1};
            3'd2: mem_addr = {block_tag[2], 3'd2};
            3'd3: mem_addr = {block_tag[3], 3'd3};
            3'd4: mem_addr = {block_tag[4], 3'd4};
            3'd5: mem_addr = {block_tag[5], 3'd5};
            3'd6: mem_addr = {block_tag[6], 3'd6};
            default: mem_addr = {block_tag[7], 3'd7};
        endcase
    end
    else begin
        mem_addr = proc_addr[29:2];
    end
end

always@(*)begin
    //proc_rdata logic
        case(proc_addr[4:2])
            3'd0:begin
                case(proc_addr[1:0])
                    2'b00: proc_rdata = block_data[0][31:0];
                    2'b01: proc_rdata = block_data[0][63:32];
                    2'b10: proc_rdata = block_data[0][95:64];
                    default: proc_rdata = block_data[0][127:96];
                endcase
            end
            3'd1:begin
                case(proc_addr[1:0])
                    2'b00: proc_rdata = block_data[1][31:0];
                    2'b01: proc_rdata = block_data[1][63:32];
                    2'b10: proc_rdata = block_data[1][95:64];
                    default: proc_rdata = block_data[1][127:96];
                endcase
            end
            3'd2:begin
                case(proc_addr[1:0])
                    2'b00: proc_rdata = block_data[2][31:0];
                    2'b01: proc_rdata = block_data[2][63:32];
                    2'b10: proc_rdata = block_data[2][95:64];
                    default: proc_rdata = block_data[2][127:96];
                endcase
            end
            3'd3:begin
                case(proc_addr[1:0])
                    2'b00: proc_rdata = block_data[3][31:0];
                    2'b01: proc_rdata = block_data[3][63:32];
                    2'b10: proc_rdata = block_data[3][95:64];
                    default: proc_rdata = block_data[3][127:96];
                endcase
            end
            3'd4:begin
                case(proc_addr[1:0])
                    2'b00: proc_rdata = block_data[4][31:0];
                    2'b01: proc_rdata = block_data[4][63:32];
                    2'b10: proc_rdata = block_data[4][95:64];
                    default: proc_rdata = block_data[4][127:96];
                endcase
            end
            3'd5:begin
                case(proc_addr[1:0])
                    2'b00: proc_rdata = block_data[5][31:0];
                    2'b01: proc_rdata = block_data[5][63:32];
                    2'b10: proc_rdata = block_data[5][95:64];
                    default: proc_rdata = block_data[5][127:96];
                endcase
            end
            3'd6:begin
                case(proc_addr[1:0])
                    2'b00: proc_rdata = block_data[6][31:0];
                    2'b01: proc_rdata = block_data[6][63:32];
                    2'b10: proc_rdata = block_data[6][95:64];
                    default: proc_rdata = block_data[6][127:96];
                endcase
            end
            3'd7:begin
                case(proc_addr[1:0])
                    2'b00: proc_rdata = block_data[7][31:0];
                    2'b01: proc_rdata = block_data[7][63:32];
                    2'b10: proc_rdata = block_data[7][95:64];
                    default: proc_rdata = block_data[7][127:96];
                endcase
            end
            default: proc_rdata = 0;
        endcase
end

always@(*)begin
    //mem_wdata logic
    case(mem_addr[2:0])
        3'd0: mem_wdata = block_data[0];
        3'd1: mem_wdata = block_data[1];
        3'd2: mem_wdata = block_data[2];
        3'd3: mem_wdata = block_data[3];
        3'd4: mem_wdata = block_data[4];
        3'd5: mem_wdata = block_data[5];
        3'd6: mem_wdata = block_data[6];
        default: mem_wdata = block_data[7];
    endcase
    //writemiss logic
    if(proc_write)begin
        case(proc_addr[4:2])
            3'd0: writemiss = (block_tag[0]==proc_addr[29:5]&&block_valid[0])?0:1;
            3'd1: writemiss = (block_tag[1]==proc_addr[29:5]&&block_valid[1])?0:1;
            3'd2: writemiss = (block_tag[2]==proc_addr[29:5]&&block_valid[2])?0:1;
            3'd3: writemiss = (block_tag[3]==proc_addr[29:5]&&block_valid[3])?0:1;
            3'd4: writemiss = (block_tag[4]==proc_addr[29:5]&&block_valid[4])?0:1;
            3'd5: writemiss = (block_tag[5]==proc_addr[29:5]&&block_valid[5])?0:1;
            3'd6: writemiss = (block_tag[6]==proc_addr[29:5]&&block_valid[6])?0:1;
            default: writemiss = (block_tag[7]==proc_addr[29:5]&&block_valid[7])?0:1;
        endcase
    end
    else writemiss = 0;
    //readmiss logic
    if(proc_read)begin
        case(proc_addr[4:2])
            3'd0: readmiss = (block_tag[0]==proc_addr[29:5]&&block_valid[0])?0:1;
            3'd1: readmiss = (block_tag[1]==proc_addr[29:5]&&block_valid[1])?0:1;
            3'd2: readmiss = (block_tag[2]==proc_addr[29:5]&&block_valid[2])?0:1;
            3'd3: readmiss = (block_tag[3]==proc_addr[29:5]&&block_valid[3])?0:1;
            3'd4: readmiss = (block_tag[4]==proc_addr[29:5]&&block_valid[4])?0:1;
            3'd5: readmiss = (block_tag[5]==proc_addr[29:5]&&block_valid[5])?0:1;
            3'd6: readmiss = (block_tag[6]==proc_addr[29:5]&&block_valid[6])?0:1;
            default: readmiss = (block_tag[7]==proc_addr[29:5]&&block_valid[7])?0:1;
        endcase
    end
    else readmiss = 0;
end
//fsm logic
always@(*)begin
    if(proc_reset) Q_NEXT = RESET;
    else begin
        case(Q_NOW)
            INITIAL: Q_NEXT = (proc_reset)?RESET:INITIAL;
            RESET: Q_NEXT = (~proc_reset)?PROCESS:RESET;
            PROCESS: Q_NEXT = (writemiss||readmiss)?((isdirty)?WRITE:READ):PROCESS;
            WRITE: Q_NEXT = (mem_ready)?READ:WRITE;
            READ: Q_NEXT = (mem_ready)?PROCESS:READ;
            default: Q_NEXT = INITIAL;
        endcase
    end
end
//==== sequential circuit =================================
always@( posedge clk ) begin
    if( proc_reset ) begin
        for(i=0; i<BLOCK_NUMBER; i=i+1)begin
            block_data[i] <= 0;
            block_tag[i] <= 0;
            block_valid[i] <= 0;
            block_dirty[i] <= 0;
        end
    end
    else begin
        
        case(Q_NOW)
            PROCESS:begin
                //block update (write hit)
                if(proc_write&&~writemiss)begin
                    case(proc_addr[4:2])
                        3'd0:begin
                            block_dirty[0] <= 1;
                            block_tag[0] <= proc_addr[29:5];
                            case(proc_addr[1:0])
                                2'b00: block_data[0][31:0] <= proc_wdata;
                                2'b01: block_data[0][63:32] <= proc_wdata;
                                2'b10: block_data[0][95:64] <= proc_wdata;
                                default: block_data[0][127:96] <= proc_wdata;
                            endcase
                        end
                        3'd1:begin
                            block_dirty[1] <= 1;
                            block_tag[1] <= proc_addr[29:5];
                            case(proc_addr[1:0])
                                2'b00: block_data[1][31:0] <= proc_wdata;
                                2'b01: block_data[1][63:32] <= proc_wdata;
                                2'b10: block_data[1][95:64] <= proc_wdata;
                                default: block_data[1][127:96] <= proc_wdata;
                            endcase
                        end
                        3'd2:begin
                            block_dirty[2] <= 1;
                            block_tag[2] <= proc_addr[29:5];
                            case(proc_addr[1:0])
                                2'b00: block_data[2][31:0] <= proc_wdata;
                                2'b01: block_data[2][63:32] <= proc_wdata;
                                2'b10: block_data[2][95:64] <= proc_wdata;
                                default: block_data[2][127:96] <= proc_wdata;
                            endcase
                        end
                        3'd3:begin
                            block_dirty[3] <= 1;
                            block_tag[3] <= proc_addr[29:5];
                            case(proc_addr[1:0])
                                2'b00: block_data[3][31:0] <= proc_wdata;
                                2'b01: block_data[3][63:32] <= proc_wdata;
                                2'b10: block_data[3][95:64] <= proc_wdata;
                                default: block_data[3][127:96] <= proc_wdata;
                            endcase
                        end
                        3'd4:begin
                            block_dirty[4] <= 1;
                            block_tag[4] <= proc_addr[29:5];
                            case(proc_addr[1:0])
                                2'b00: block_data[4][31:0] <= proc_wdata;
                                2'b01: block_data[4][63:32] <= proc_wdata;
                                2'b10: block_data[4][95:64] <= proc_wdata;
                                default: block_data[4][127:96] <= proc_wdata;
                            endcase
                        end
                        3'd5:begin
                            block_dirty[5] <= 1;
                            block_tag[5] <= proc_addr[29:5];
                            case(proc_addr[1:0])
                                2'b00: block_data[5][31:0] <= proc_wdata;
                                2'b01: block_data[5][63:32] <= proc_wdata;
                                2'b10: block_data[5][95:64] <= proc_wdata;
                                default: block_data[5][127:96] <= proc_wdata;
                            endcase
                        end
                        3'd6:begin
                            block_dirty[6] <= 1;
                            block_tag[6] <= proc_addr[29:5];
                            case(proc_addr[1:0])
                                2'b00: block_data[6][31:0] <= proc_wdata;
                                2'b01: block_data[6][63:32] <= proc_wdata;
                                2'b10: block_data[6][95:64] <= proc_wdata;
                                default: block_data[6][127:96] <= proc_wdata;
                            endcase
                        end
                        3'd7:begin
                            block_dirty[7] <=1;
                            block_tag[7] <= proc_addr[29:5];
                            case(proc_addr[1:0])
                                2'b00: block_data[7][31:0] <= proc_wdata;
                                2'b01: block_data[7][63:32] <= proc_wdata;
                                2'b10: block_data[7][95:64] <= proc_wdata;
                                default: block_data[7][127:96] <= proc_wdata;
                            endcase
                        end
                        default:begin
                           for(i=0; i<BLOCK_NUMBER; i=i+1)begin
                                block_data[i] <= block_data[i];
                                block_tag[i] <= block_tag[i];
                                block_dirty[i] <= block_dirty[i];
                            end
                        end
                    endcase
                end
                else begin
                    for(i=0; i<BLOCK_NUMBER; i=i+1)begin
                        block_data[i] <= block_data[i];
                        block_tag[i] <= block_tag[i];
                        block_dirty[i] <= block_dirty[i];
                    end
                end
            end
            READ:begin
                //read miss
                if(mem_ready)begin
                    case(mem_addr[2:0])
                        3'd0:begin
                            block_data[0] <= mem_rdata;
                            block_tag[0] <= mem_addr[27:3];
                            block_dirty[0] <= 0;
                            block_valid[0] <= 1;
                        end
                        3'd1:begin
                            block_data[1] <= mem_rdata;
                            block_tag[1] <= mem_addr[27:3];
                            block_dirty[1] <= 0;
                            block_valid[1] <= 1;
                        end
                        3'd2:begin
                            block_data[2] <= mem_rdata;
                            block_tag[2] <= mem_addr[27:3];
                            block_dirty[2] <= 0;
                            block_valid[2] <= 1;
                        end
                        3'd3:begin
                            block_data[3] <= mem_rdata;
                            block_tag[3] <= mem_addr[27:3];
                            block_dirty[3] <= 0;
                            block_valid[3] <= 1;
                        end
                        3'd4:begin
                            block_data[4] <= mem_rdata;
                            block_tag[4] <= mem_addr[27:3];
                            block_dirty[4] <= 0;
                            block_valid[4] <= 1;
                        end
                        3'd5:begin
                            block_data[5] <= mem_rdata;
                            block_tag[5] <= mem_addr[27:3];
                            block_dirty[5] <= 0;
                            block_valid[5] <= 1;
                        end
                        3'd6:begin
                            block_data[6] <= mem_rdata;
                            block_tag[6] <= mem_addr[27:3];
                            block_dirty[6] <= 0;
                            block_valid[6] <= 1;
                        end
                        3'd7:begin
                            block_data[7] <= mem_rdata;
                            block_tag[7] <= mem_addr[27:3];
                            block_dirty[7] <= 0;
                            block_valid[7] <= 1;
                        end
                        default:begin
                            for(i=0; i<BLOCK_NUMBER; i=i+1)begin
                                block_data[i] <= block_data[i];
                                block_tag[i] <= block_tag[i];
                                block_dirty[i] <= block_dirty[i];
                                block_valid[i] <= block_valid[i];
                            end
                        end
                    endcase
                end
            end
            default:begin
                for(i=0; i<BLOCK_NUMBER; i=i+1)begin
                    block_data[i] <= block_data[i];
                    block_tag[i] <= block_tag[i];
                    block_dirty[i] <= block_dirty[i];
                    block_valid[i] <= block_valid[i];
                end
            end
        endcase
    end
end

always@(posedge clk)begin
    Q_NOW <= Q_NEXT;
end

endmodule
