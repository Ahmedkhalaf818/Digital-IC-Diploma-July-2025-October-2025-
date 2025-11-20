module DF_SYNC #(
    parameter ADDR_WIDTH = 5

) (
    input wire i_clk,
    input wire i_rst_n,
    input wire [ADDR_WIDTH:0] i_r_d_ptr,
    output wire [ADDR_WIDTH:0] wq2_r_d_ptr
);
reg [ADDR_WIDTH:0] R1, R2;

always @(posedge i_clk, negedge i_rst_n) begin
    if(!i_rst_n)begin
        R1 <= 'b0;
        R2 <= 'b0;
    end
    else begin
        R1 <= i_r_d_ptr;
        R2 <= R1;
    end
end

assign wq2_r_d_ptr = R2; 


endmodule
