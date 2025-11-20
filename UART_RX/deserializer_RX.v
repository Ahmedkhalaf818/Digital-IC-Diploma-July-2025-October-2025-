module deserializer_RX #(parameter DATA_LENGTH=8)(
input   wire  CLK_des,
input   wire  RST_des,
input   wire  sample_bit_deser,
input   wire  deser_en,
input   wire [5:0]  edge_cnt,
input   wire [5:0]  prescale_FSM,
output  reg [DATA_LENGTH-1:0] P_DATA_des
);

always @(posedge CLK_des or negedge RST_des) begin
		if (!RST_des) begin
            P_DATA_des <= 'b0000_0000;
        end
        else begin
            if ((deser_en ==1'b1))  begin
                P_DATA_des <= {sample_bit_deser,P_DATA_des[DATA_LENGTH-1:1]} ;  
             end 
        end 
end 
/**/

endmodule
