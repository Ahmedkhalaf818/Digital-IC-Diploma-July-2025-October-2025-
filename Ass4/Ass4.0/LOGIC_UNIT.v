module LOGIC_UNIT #(parameter width = 16 )(
    input wire  [width-1:0] A,
    input wire [width-1:0] B,
    input wire [1:0] Logic_ALu_op,
    input wire logic_Enable_unit,
    input wire CLK,
    input wire RST,
    output reg [width -1:0] Logic_Out_unit,
    output reg Logic_Flag_Unit
);
reg [width -1:0] Logic_Out_unit_reg;
reg Logic_Flag_Unit_reg;

always @ (posedge CLK or negedge RST) begin
if (!RST) begin
    Logic_Out_unit <= 'd0;
    Logic_Flag_Unit <= 1'b0;
end
else begin
    Logic_Out_unit <= Logic_Out_unit_reg;
    Logic_Flag_Unit <= Logic_Flag_Unit_reg;
end
end

always @ (*) begin
if (logic_Enable_unit) begin
    Logic_Flag_Unit_reg=1'b1;
    case (Logic_ALu_op)
        2'b00: Logic_Out_unit_reg = A & B ;
        2'b01: Logic_Out_unit_reg = A | B ;
        2'b10: Logic_Out_unit_reg = ~(A & B) ;
        2'b11: Logic_Out_unit_reg = ~(A | B) ;
    endcase
end
else begin
    Logic_Out_unit_reg = 'd0;
    Logic_Flag_Unit_reg=1'b0;
end
end
endmodule