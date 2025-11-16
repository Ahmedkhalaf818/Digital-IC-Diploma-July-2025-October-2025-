module MUX4x1(
input wire CLK_mux,
input wire RST_mux,
input wire start_bit_mux,
input wire stop_bit_mux,
input wire ser_data_mux,
input wire parity_bit_mux,
input wire [1:0] mux_sel_mux,
output reg TX_OUT_mux);
reg TX_OUT_mux_c;
always @(posedge CLK_mux or negedge RST_mux ) begin
    if (!RST_mux) begin
        TX_OUT_mux <=1'b0;
    end
    else begin
        TX_OUT_mux <=TX_OUT_mux_c;
    end
end
always @(*) begin
    case (mux_sel_mux) 
    2'b00: TX_OUT_mux_c = start_bit_mux; 
    2'b01: TX_OUT_mux_c = stop_bit_mux;
    2'b10: TX_OUT_mux_c = ser_data_mux; 
    2'b11: TX_OUT_mux_c = parity_bit_mux;
    endcase
end

endmodule
