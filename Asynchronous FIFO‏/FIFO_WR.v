module FIFO_WR #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 5
)(
    input  wire                 i_w_clk,
    input  wire                 i_rst_n,
    input  wire                 i_w_inc,
    input  wire [ADDR_WIDTH:0]  wq2_rptr,

    output wire                 o_w_full,
    output wire [ADDR_WIDTH-1:0] o_wr_addr,
    output wire [ADDR_WIDTH:0]  o_wptr
);

wire o_w_full_reg;
reg [ADDR_WIDTH:0] o_wptr_reg;

always @(posedge i_w_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        o_wptr_reg <= 0;
    end else if (i_w_inc & ~o_w_full) begin
        o_wptr_reg <= o_wptr_reg + 1;
    end
end

assign  o_wr_addr = o_wptr_reg[ADDR_WIDTH-1:0];

// convert to gray code
assign o_wptr = (o_wptr_reg >> 1 ) ^ o_wptr_reg;

assign o_w_full = ((o_wptr[ADDR_WIDTH-2:0] == wq2_rptr [ADDR_WIDTH-2:0]) && (o_wptr[ADDR_WIDTH-1] != wq2_rptr [ADDR_WIDTH-1]) && (o_wptr[ADDR_WIDTH] != wq2_rptr [ADDR_WIDTH]));



endmodule