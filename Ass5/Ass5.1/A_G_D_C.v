module A_G_D_C(
input wire CLK,
input wire RST,
input wire Activate,
input wire UP_Max,
input wire DN_Max,
output reg UP_M,
output reg DN_M
);
localparam IDLE  = 2'b00;
localparam Mv_Up = 2'b01;
localparam Mv_Dn = 2'b11;

reg [1:0] ns ,cs;

always @(posedge CLK or negedge RST) begin
    if (! RST )
        cs <= IDLE;
    else
        cs <= ns; 
end

always @(*) begin

    case (cs)
    IDLE: begin
        if (Activate == 1'b0)
            ns = IDLE;
        else if ((Activate == 1'b1)&&(UP_Max==1'b1) && (DN_Max==1'b0)) begin
            ns = Mv_Dn;
        end
        else if ((Activate == 1'b1)&&(UP_Max==1'b0) && (DN_Max==1'b1)) begin
            ns = Mv_Up;
        end
        else 
            ns = IDLE;
            
    end
    Mv_Up: begin
        if (UP_Max==1'b1)
            ns = IDLE;
        else
            ns = Mv_Up;

    end
    Mv_Dn: begin
        if (DN_Max==1'b1)
            ns = IDLE;
        else
            ns = Mv_Dn;
    end
    endcase
end
always @(*) begin
    case (cs)
    IDLE:  begin UP_M=1'b0;  DN_M=1'b0; end
    Mv_Up: begin UP_M=1'b1;  DN_M=1'b0; end
    Mv_Dn: begin UP_M=1'b0;  DN_M=1'b1; end
    endcase
end
endmodule