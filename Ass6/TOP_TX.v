module TOP_TX #(parameter DATA_LENGTH =4'd8)(
        input  wire RST,
        input  wire CLK,
        input  wire [DATA_LENGTH-1:0] P_DATA,
        input  wire PAR_TYP,
        input  wire PAR_EN,
        input  wire DATA_VALID,
        output wire TX_OUT,
        output wire BUSY
);
wire [1:0] mux_sel;
wire ser_data;
wire par_bit;
wire ser_done;
wire ser_en;
MUX4x1 mux(
.CLK_mux(CLK),
.RST_mux(RST),
.start_bit_mux(1'b0),
.stop_bit_mux(1'b1),
.ser_data_mux(ser_data),
.parity_bit_mux(par_bit),
.mux_sel_mux(mux_sel),
.TX_OUT_mux(TX_OUT)
);

parity_calc #(.DATA_LENGTH(DATA_LENGTH)) PAR (
.CLK(CLK),
.RST(RST),
.P_DATA(P_DATA),
.PAR_TYP(PAR_TYP),
.Data_Valid(DATA_VALID),
.par_bit(par_bit)
);

SERIALIZER #(.DATA_LENGTH(DATA_LENGTH)) SER(
.P_DATA(P_DATA),
.ser_en(ser_en),
.CLK(CLK),
.RST(RST),
.Data_Valid(DATA_VALID),
.busy(BUSY),
.ser_done(ser_done),
.ser_data(ser_data)
);
FSM_TX FSM1(
.DATA_VALID_FSM(DATA_VALID),
.RST_FSM(RST),
.CLK_FSM(CLK),
.SER_DONE_FSM(ser_done),
.PAR_EN_FSM(PAR_EN),
.SER_EN_FSM(ser_en),
.BUSY_FSM(BUSY),
.MUX_SEL_FSM(mux_sel)

);
endmodule
