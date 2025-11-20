module FIFO_MEM_CNTRL #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 5 // depth = 2^ADDR_WIDTH-1
)(
    input  wire                   i_w_clk,
    input  wire                   i_rst_n,
    input  wire                   i_w_inc,
    input  wire                   i_w_full,
    input  wire  [DATA_WIDTH-1:0] i_wr_data,
    input  wire  [ADDR_WIDTH-1:0] i_wr_addr,
    input  wire  [ADDR_WIDTH-1:0] i_rd_addr,
    output wire  [DATA_WIDTH-1:0] o_rd_data
    
);
//address width determines depth
// address width must be  > depths 
// depth must be less than or equal 2^address_width

localparam DEPTH =  2**ADDR_WIDTH;

integer i;

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

wire i_w_clk_en;

assign i_w_clk_en = i_w_inc & ~i_w_full;

always @(posedge i_w_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        for (i = 0; i < DEPTH; i = i + 1) begin
            mem[i] <= 0;
        end
    end else if (i_w_clk_en) begin
        mem[i_wr_addr] <= i_wr_data;
    end
end

assign o_rd_data = mem[i_rd_addr]; 

endmodule