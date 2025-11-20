module FIFO_RD #(
    parameter DATA_WIDTH = 8,   
    parameter ADDR_WIDTH = 5
)( 
    input wire i_r_clk,
    input wire i_rst_n,
    input wire i_r_inc,
    input wire [ADDR_WIDTH:0] rq2_wptr,

    output wire o_r_empty,
    output wire [ADDR_WIDTH-1:0] o_rd_addr,
    output wire [ADDR_WIDTH:0] o_rptr
);

wire rempty_reg;
reg [ADDR_WIDTH:0] o_rptr_reg;

always @(posedge i_r_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        o_rptr_reg <= 0;
    end
    else if (i_r_inc & ~o_r_empty) begin
        o_rptr_reg <= o_rptr_reg + 1;
    end
end

// Gray code conversion
assign o_rptr = (o_rptr_reg >> 1 ) ^ o_rptr_reg;

assign  o_rd_addr = o_rptr_reg[ADDR_WIDTH-1:0];

assign o_r_empty = (o_rptr == rq2_wptr);

endmodule