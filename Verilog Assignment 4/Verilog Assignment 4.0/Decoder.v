module Decoder(
    input wire [1:0] Dec_ALu_op,
    output reg Arith_Enable_Dec,
    output reg logic_Enable_Dec,
    output reg CMP_Enable_Dec,
    output reg Shift_Enable_Dec
);
always @(Dec_ALu_op) begin
    Arith_Enable_Dec = 1'b0;
    logic_Enable_Dec = 1'b0;
    CMP_Enable_Dec = 1'b0;
    Shift_Enable_Dec = 1'b0;
    case(Dec_ALu_op)
        2'b00: Arith_Enable_Dec = 1'b1 ;
        2'b01: logic_Enable_Dec = 1'b1 ;
        2'b10: CMP_Enable_Dec = 1'b1 ;
        2'b11: Shift_Enable_Dec = 1'b1 ;
    endcase
end
endmodule