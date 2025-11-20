`timescale 1ns / 1ps
module RST_SYN_TB ();
reg CLK;
reg RST;    
wire SYNC_RST;
parameter NUM_STAGE = 2;
RST_SYN #(.NUM_STAGE(NUM_STAGE)) DUT  (
    .CLK(CLK),
    .RST(RST),
    .SYNC_RST(SYNC_RST)
);
localparam period = 10;
 // rst synchronizer to each clock domain 
initial begin
    CLK = 1'b0;
    RST = 1'b0;
    #24;
    RST = 1'b1;
    #99;
    RST = 1'b0;
    #33;
    RST = 1'b1;
    #101;
    RST = 1'b0;
    # (period * 2);
    RST = 1'b1;
    # (period);
    RST = 1'b0;
    # (period * 5);
    RST = 1'b1;
    # (period);
    #101;
    $stop;
end

always #(period / 2.0) CLK = ~CLK;

endmodule