module ALU_TOP #(parameter width =8 )(
input wire [width-1:0] A,
input wire [width-1:0] B,
input wire [3:0] ALU_FUN,
input wire CLK,
input wire RST,
output wire [2*width-1 : 0] Arith_Out,
output wire Arith_Flag,
output wire [width-1 : 0] Logic_Out,
output wire Logic_Flag,
output wire [width-1 : 0] CMP_Out,
output wire CMP_Flag,
output wire [width-1 : 0] SHIFT_Out,
output wire SHIFT_Flag
); 
wire Arith_Enable;
wire logic_Enable;
wire CMP_Enable;
wire Shift_Enable;

Decoder DEC1 (
    .Dec_ALu_op(ALU_FUN [3:2]),
    .Arith_Enable_Dec(Arith_Enable),
    .logic_Enable_Dec(logic_Enable),
    .CMP_Enable_Dec(CMP_Enable),
    .Shift_Enable_Dec(Shift_Enable)
);

ARITHMETIC_UNIT #(.width(width)) ARITH1 (
    .Arith_ALu_op(ALU_FUN[1:0]),
    .A(A),
    .B(B),
    .Arith_Enable_unit(Arith_Enable),
    .CLK(CLK),
    .RST(RST),
    .Arith_Out_unit(Arith_Out),
    .Arith_Flag_unit(Arith_Flag)
);

LOGIC_UNIT #(.width(width)) Logic1 (
    .Logic_ALu_op(ALU_FUN[1:0]),
    .A(A),
    .B(B),
    .logic_Enable_unit(logic_Enable),
    .CLK(CLK),
    .RST(RST),
    .Logic_Out_unit(Logic_Out),
    .Logic_Flag_Unit(Logic_Flag)
);
CMP_UNIT #(.width(width)) CMP1 (
    .CMP_ALu_op(ALU_FUN[1:0]),
    .A(A),
    .B(B),
    .CMP_Enable_unit(CMP_Enable),
    .CLK(CLK),
    .RST(RST),
    .CMP_Out_unit(CMP_Out),
    .CMP_Flag_unit(CMP_Flag)
);

SHIFT_UNIT #(.width(width)) SHIFT1 (
    .SHIFT_ALu_op(ALU_FUN[1:0]),
    .A(A),
    .B(B),
    .SHIFT_Enable_unit(Shift_Enable),
    .CLK(CLK),
    .RST(RST),
    .SHIFT_Out_unit(SHIFT_Out),
    .SHIFT_Flag_unit(SHIFT_Flag)
);



endmodule