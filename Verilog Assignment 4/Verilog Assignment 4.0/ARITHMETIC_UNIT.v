module ARITHMETIC_UNIT #(parameter width =16 )(
    input wire signed [width-1:0] A,
    input wire signed [width-1:0] B,
    input wire [1:0] Arith_ALu_op,
    input wire Arith_Enable_unit,
    input wire CLK,
    input wire RST,
    output reg signed [( 2 * width )-1:0] Arith_Out_unit,
    output reg Arith_Flag_unit
);
reg signed [( 2 * width ) -1:0] Arith_Out_unit_reg;
reg Arith_Flag_unit_reg;

always @ (posedge CLK or negedge RST) begin
if (!RST) begin
    Arith_Out_unit <= 'd0;
    Arith_Flag_unit <= 1'b0;
end
else begin
    Arith_Out_unit <= Arith_Out_unit_reg;
    Arith_Flag_unit <= Arith_Flag_unit_reg;
end
end

always @ (*) begin
if (Arith_Enable_unit) begin
    Arith_Flag_unit_reg=1'b1;
    case (Arith_ALu_op)
        2'b00: Arith_Out_unit_reg = A + B ;
        2'b01: Arith_Out_unit_reg = A - B ;
        2'b10: Arith_Out_unit_reg = A * B ;
        2'b11: Arith_Out_unit_reg = A / B ;
    endcase
end
else begin
    Arith_Out_unit_reg = 'd0;
    Arith_Flag_unit_reg=1'b0;
end
end
endmodule