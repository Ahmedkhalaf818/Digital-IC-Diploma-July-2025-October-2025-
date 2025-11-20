module RX_TOP #(parameter DATA_LENGTH=8)(
input   wire       CLK_RX,
input   wire       RST_RX,
input   wire       RX_IN_RX,
input   wire       PAR_EN_RX,
input   wire       PAR_TYP_RX,
input   wire [5:0] prescale_RX,
//output
output  wire [DATA_LENGTH-1:0] P_DATA_RX,
output  wire                   data_valid_RX,
output  wire                   parity_error_RX,
output  wire                   stop_error_RX
);

// strt_check_RX linking FSM
wire strt_chk_en_wire;
wire strt_glitch_wire;
// parity_check_RX linking FSM
wire par_chk_en_wire;
wire parity_error_wire;
// stop_check_RX linking FSM
wire stp_chk_en_wire;
wire Stp_Error_wire;
// deserializer_RX linking FSM
wire deser_en_wire;
// edge_bit_counter_RX linking FSM
wire enable_wire;
wire [5:0] bit_cnt_wires;
// data_sampling_RX linking FSM
wire data_samp_en_wire;
// general
wire sample_bit_wire;
wire [5:0]  edge_cnt_wires;




strt_check_RX strt_check_RX1(
//.CLK_start(CLK_RX),
//.RST_start(RST_RX),
.strt_chk_en(strt_chk_en_wire),
.sample_bit_par_chk(sample_bit_wire),
.strt_glitch_chk(strt_glitch_wire)
);

parity_check_RX parity_check_RX1(
.CLK_par(CLK_RX),
.RST_par(RST_RX),
.P_DATA_par_chk(P_DATA_RX),
.PAR_TYP_par_chk(PAR_TYP_RX),
.par_chk_en(par_chk_en_wire),
.sample_bit_par_chk(sample_bit_wire),
.par_err_chk(parity_error_wire),
.par_err(parity_error_RX)
);
stop_check_RX stop_check_RX1(
.CLK_stop(CLK_RX),
.RST_stop(RST_RX),
.stp_chk_en(stp_chk_en_wire),
.sample_bit_par_chk(sample_bit_wire),
.stp_err_chk(Stp_Error_wire),
.Stop_Error(stop_error_RX)
);
deserializer_RX deserializer_RX1(
.CLK_des(CLK_RX),
.RST_des(RST_RX),
.sample_bit_deser(sample_bit_wire),
.edge_cnt(edge_cnt_wires),
.prescale_FSM(prescale_RX),
.deser_en(deser_en_wire),
.P_DATA_des(P_DATA_RX)
);
data_sampling_RX data_sampling_RX1(
.CLK_SAM(CLK_RX),
.RST_SAM(RST_RX),
.RX_IN(RX_IN_RX),
.data_samp_en(data_samp_en_wire),
.edge_cnt(edge_cnt_wires),
.prescale(prescale_RX),
.sample_bit_samp(sample_bit_wire)
);

edge_bit_counter_RX edge_bit_counter_RX1(
.CLK_EDGE(CLK_RX),
.RST_EDGE(RST_RX),
.enable_edge(enable_wire),
.prescale_edge(prescale_RX),
.bit_cnt_edge(bit_cnt_wires),
.edge_cnt_edge(edge_cnt_wires)
);



FSM_RX FSM_RX1(
.CLK_FSM(CLK_RX),
.RST_FSM(RST_RX),
.RX_IN(RX_IN_RX),
.bit_cnt_FSM(bit_cnt_wires),
.edge_cnt_FSM(edge_cnt_wires),

.PAR_EN_FSM(PAR_EN_RX),
.par_err_FSM(parity_error_wire),
.strt_glitch_FSM(strt_glitch_wire),
.stp_err_FSM(Stp_Error_wire),
.prescale_FSM(prescale_RX),

.par_chk_en_FSM(par_chk_en_wire),
.strt_chk_en_FSM(strt_chk_en_wire),
.stp_chk_en_FSM(stp_chk_en_wire),
.enable_FSM(enable_wire),
.data_samp_en_FSM(data_samp_en_wire),
.data_valid_FSM(data_valid_RX),
.deser_en_FSM(deser_en_wire)   
);
endmodule