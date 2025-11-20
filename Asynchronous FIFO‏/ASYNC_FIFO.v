module ASYNC_FIFO #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 5,
    parameter NUM_STAGES = 2
)(
    
    input wire wclk,
    input wire rclk,
    input wire wrst_n,
    input wire rrst_n,
    input wire W_INC,
    input wire R_INC,
    input wire [DATA_WIDTH-1:0] wr_data,
    output wire FULL,
    output wire EMPTY,
    output wire [DATA_WIDTH-1:0] rd_data
);
wire  [ADDR_WIDTH-1:0] waddr;
wire  [ADDR_WIDTH-1:0] raddr;
wire  [ADDR_WIDTH:0] wptr_async;
wire  [ADDR_WIDTH:0] rptr_async;
wire  [ADDR_WIDTH:0] rq2_wptr_sync;
wire  [ADDR_WIDTH:0] wq2_rptr_sync;
// instintiation modules
FIFO_MEM_CNTRL #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) fifo_mem_cntrl (
    .i_w_clk(wclk),
    .i_rst_n(wrst_n),
    .i_w_inc(W_INC),
    .i_w_full(FULL),
    .i_wr_data(wr_data),
    .i_wr_addr(waddr), 
    .i_rd_addr(raddr),
    .o_rd_data(rd_data)
);
// from write block to read block
DF_SYNC #(
    .ADDR_WIDTH(ADDR_WIDTH)
) bit_sync_waddr (
    .i_clk(rclk),
    .i_rst_n(rrst_n),
    .i_r_d_ptr(wptr_async),
    .wq2_r_d_ptr(rq2_wptr_sync)
);
// from read block to write block
DF_SYNC #(
    .ADDR_WIDTH(ADDR_WIDTH)
) bit_sync_raddr (
    .i_clk(wclk),
    .i_rst_n(wrst_n),
    .i_r_d_ptr(rptr_async),
    .wq2_r_d_ptr(wq2_rptr_sync)
);
FIFO_RD #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) fifo_rd (
    .i_r_clk(rclk),
    .i_rst_n(rrst_n),
    .i_r_inc(R_INC),
    .rq2_wptr(rq2_wptr_sync),
    .o_r_empty(EMPTY),
    .o_rd_addr(raddr),
    .o_rptr(rptr_async)
);
FIFO_WR #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) fifo_wr (
    .i_w_clk(wclk),
    .i_rst_n(wrst_n),
    .i_w_inc(W_INC),
    .wq2_rptr(wq2_rptr_sync),
    .o_w_full(FULL),
    .o_wr_addr(waddr),
    .o_wptr(wptr_async)
);

endmodule