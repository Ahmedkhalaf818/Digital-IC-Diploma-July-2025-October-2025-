module parity_check_RX #(parameter DATA_LENGTH=8)(
input  wire  CLK_par,
input  wire  RST_par,
input  wire [DATA_LENGTH-1:0] P_DATA_par_chk,
input  wire  PAR_TYP_par_chk,
input  wire  par_chk_en,
input  wire  sample_bit_par_chk,

output reg  par_err_chk,
output reg  par_err
);

reg par_reg;

always @(*) begin
    if (PAR_TYP_par_chk)
        par_reg = ~^ P_DATA_par_chk;
    else 
        par_reg = ^ P_DATA_par_chk;
end
always @(par_reg or sample_bit_par_chk or par_chk_en) begin
if(par_chk_en) begin
par_err_chk =(sample_bit_par_chk != par_reg);
end
else begin
par_err_chk =0;
end
end
always @(posedge CLK_par or negedge RST_par) begin
    if(!RST_par)  begin
        par_err <= 1'b0;
    end
    else 
    par_err <= par_err_chk;
end


    


endmodule
