module RST_SYN #(parameter NUM_STAGE = 2)(
    input  wire CLK,
    input  wire RST,
    output wire SYNC_RST
);
reg [NUM_STAGE-1:0] rst_shift_reg;
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        rst_shift_reg <= 0;
    end else begin
        rst_shift_reg <= {rst_shift_reg[NUM_STAGE-2:0], 1'b1};
    end
end
assign SYNC_RST = rst_shift_reg[NUM_STAGE-1];
endmodule