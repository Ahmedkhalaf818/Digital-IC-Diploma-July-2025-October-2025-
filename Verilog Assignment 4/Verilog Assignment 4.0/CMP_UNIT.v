module CMP_UNIT #(parameter width =16 )(
    input wire [width-1:0] A,
    input wire [width-1:0] B,
    input wire [1:0] CMP_ALu_op,  
    input wire CMP_Enable_unit,
    input wire CLK,
    input wire RST,
    output reg [width -1:0] CMP_Out_unit,
    output reg CMP_Flag_unit
);
reg [width -1:0] CMP_Out_unit_reg;
reg CMP_Flag_unit_reg;

always @ (posedge CLK or negedge RST) begin
if (!RST) begin
    CMP_Out_unit <= 'd0;
    CMP_Flag_unit <= 1'b0;
end
else begin
    CMP_Out_unit <= CMP_Out_unit_reg;
    CMP_Flag_unit <= CMP_Flag_unit_reg;
end
end

always @ (*) begin
if (CMP_Enable_unit) begin
    CMP_Flag_unit_reg=1'b1;
    case (CMP_ALu_op)
        2'b00: CMP_Out_unit_reg = 'b0 ;
        2'b01: 
        begin
                if(A == B) 
                    CMP_Out_unit_reg = 'd1;
                else
                    CMP_Out_unit_reg = 'd0;
        end
        2'b10:
        begin
                if(A > B) 
                    CMP_Out_unit_reg = 'd2;
                else
                    CMP_Out_unit_reg = 'd0;
        end
        2'b11:
        begin
                if(A < B) 
                    CMP_Out_unit_reg = 'd3;
                else
                    CMP_Out_unit_reg = 'd0;
        end
    endcase
end
else begin
    CMP_Out_unit_reg = 'd0;
    CMP_Flag_unit_reg=1'b0;
end
end
endmodule