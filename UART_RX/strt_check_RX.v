module strt_check_RX (
//input  wire  CLK_start,
//input  wire  RST_start,
input  wire  strt_chk_en,
input  wire  sample_bit_par_chk,
output reg  strt_glitch_chk
);

always @(*) begin
    if (strt_chk_en) begin
        strt_glitch_chk = sample_bit_par_chk;    
    end
    else begin
        strt_glitch_chk = 1'b0;
    end
end
/*
always @(posedge CLK_start or negedge RST_start) begin
    if(!RST_start)  begin
        strt_glitch_chk <= 1'b0;
    end
    else if (strt_chk_en) begin
        strt_glitch_chk <= sample_bit_par_chk;
    end
    else begin
        strt_glitch_chk <= 1'b0;
    end
end*/
endmodule
