module SHIFT_UNIT #(parameter width =16 )(
    input wire [width-1:0] A,
    input wire [width-1:0] B,
    input wire [1:0] SHIFT_ALu_op,
    input wire SHIFT_Enable_unit,
    input wire CLK,
    input wire RST,
    output reg [width -1:0] SHIFT_Out_unit,
    output reg SHIFT_Flag_unit
);
reg [width -1:0] SHIFT_Out_unit_reg;
reg SHIFT_Flag_unit_reg;

always @ (posedge CLK or negedge RST) begin
if (!RST) begin
    SHIFT_Out_unit <= 'd0;
    SHIFT_Flag_unit <= 1'b0;
end
else begin
    SHIFT_Out_unit <= SHIFT_Out_unit_reg;
    SHIFT_Flag_unit <= SHIFT_Flag_unit_reg;
end
end

always @ (*) begin
if (SHIFT_Enable_unit) begin
    SHIFT_Flag_unit_reg=1'b1;
    case (SHIFT_ALu_op)
        2'b00: SHIFT_Out_unit_reg = A >> 1 ;
        2'b01: SHIFT_Out_unit_reg = A << 1  ;
        2'b10: SHIFT_Out_unit_reg = B >> 1  ;
        2'b11: SHIFT_Out_unit_reg = B << 1  ;
    endcase
end
else begin
    SHIFT_Out_unit_reg = 'd0;
    SHIFT_Flag_unit_reg=1'b0;
end
end
endmodule