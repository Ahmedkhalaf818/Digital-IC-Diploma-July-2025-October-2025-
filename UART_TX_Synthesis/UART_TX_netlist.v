/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Mon Sep  8 22:12:04 2025
/////////////////////////////////////////////////////////////


module MUX4x1 ( CLK_mux, RST_mux, start_bit_mux, stop_bit_mux, ser_data_mux, 
        parity_bit_mux, mux_sel_mux, TX_OUT_mux );
  input [1:0] mux_sel_mux;
  input CLK_mux, RST_mux, start_bit_mux, stop_bit_mux, ser_data_mux,
         parity_bit_mux;
  output TX_OUT_mux;
  wire   n5, TX_OUT_mux_c, n1, n2, n3;

  DFFRX1M TX_OUT_mux_reg ( .D(TX_OUT_mux_c), .CK(CLK_mux), .RN(RST_mux), .Q(n5) );
  BUFX10M U3 ( .A(n5), .Y(TX_OUT_mux) );
  INVX2M U4 ( .A(mux_sel_mux[0]), .Y(n1) );
  OAI2B2X1M U5 ( .A1N(mux_sel_mux[1]), .A0(n2), .B0(mux_sel_mux[1]), .B1(n3), 
        .Y(TX_OUT_mux_c) );
  AOI22X1M U6 ( .A0(start_bit_mux), .A1(n1), .B0(stop_bit_mux), .B1(
        mux_sel_mux[0]), .Y(n3) );
  AOI22X1M U7 ( .A0(ser_data_mux), .A1(n1), .B0(parity_bit_mux), .B1(
        mux_sel_mux[0]), .Y(n2) );
endmodule


module parity_calc_8 ( CLK, RST, P_DATA, PAR_TYP, PAR_EN, busy, Data_Valid, 
        par_bit );
  input [7:0] P_DATA;
  input CLK, RST, PAR_TYP, PAR_EN, busy, Data_Valid;
  output par_bit;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17;
  wire   [7:0] par_data;

  OAI2BB2X1M U2 ( .B0(n1), .B1(n2), .A0N(par_bit), .A1N(n2), .Y(n8) );
  CLKINVX1M U3 ( .A(PAR_EN), .Y(n2) );
  XOR3XLM U4 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3XLM U5 ( .A(par_data[1]), .B(par_data[0]), .C(n5), .Y(n4) );
  XNOR2X1M U6 ( .A(par_data[2]), .B(par_data[3]), .Y(n5) );
  XOR3XLM U7 ( .A(par_data[5]), .B(par_data[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U8 ( .A(par_data[7]), .B(par_data[6]), .Y(n6) );
  AO2B2X1M U9 ( .B0(P_DATA[0]), .B1(n17), .A0(par_data[0]), .A1N(n17), .Y(n9)
         );
  AO2B2X1M U10 ( .B0(P_DATA[1]), .B1(n17), .A0(par_data[1]), .A1N(n17), .Y(n10) );
  AO2B2X1M U11 ( .B0(P_DATA[2]), .B1(n17), .A0(par_data[2]), .A1N(n17), .Y(n11) );
  AO2B2X1M U12 ( .B0(P_DATA[3]), .B1(n17), .A0(par_data[3]), .A1N(n17), .Y(n12) );
  AO2B2X1M U13 ( .B0(P_DATA[4]), .B1(n17), .A0(par_data[4]), .A1N(n17), .Y(n13) );
  AO2B2X1M U14 ( .B0(P_DATA[5]), .B1(n17), .A0(par_data[5]), .A1N(n17), .Y(n14) );
  AO2B2X1M U15 ( .B0(P_DATA[6]), .B1(n17), .A0(par_data[6]), .A1N(n17), .Y(n15) );
  AO2B2X1M U16 ( .B0(P_DATA[7]), .B1(n17), .A0(par_data[7]), .A1N(n17), .Y(n16) );
  DFFRX1M par_bit_reg ( .D(n8), .CK(CLK), .RN(RST), .Q(par_bit) );
  DFFRX1M \par_data_reg[7]  ( .D(n16), .CK(CLK), .RN(RST), .Q(par_data[7]) );
  DFFRX1M \par_data_reg[6]  ( .D(n15), .CK(CLK), .RN(RST), .Q(par_data[6]) );
  DFFRX1M \par_data_reg[5]  ( .D(n14), .CK(CLK), .RN(RST), .Q(par_data[5]) );
  DFFRX1M \par_data_reg[4]  ( .D(n13), .CK(CLK), .RN(RST), .Q(par_data[4]) );
  DFFRX1M \par_data_reg[3]  ( .D(n12), .CK(CLK), .RN(RST), .Q(par_data[3]) );
  DFFRX1M \par_data_reg[2]  ( .D(n11), .CK(CLK), .RN(RST), .Q(par_data[2]) );
  DFFRX1M \par_data_reg[1]  ( .D(n10), .CK(CLK), .RN(RST), .Q(par_data[1]) );
  DFFRX1M \par_data_reg[0]  ( .D(n9), .CK(CLK), .RN(RST), .Q(par_data[0]) );
  BUFX10M U17 ( .A(n7), .Y(n17) );
  NOR2BX1M U18 ( .AN(Data_Valid), .B(busy), .Y(n7) );
endmodule


module SERIALIZER_8 ( P_DATA, ser_en, CLK, RST, Data_Valid, busy, ser_done, 
        ser_data );
  input [7:0] P_DATA;
  input ser_en, CLK, RST, Data_Valid, busy;
  output ser_done, ser_data;
  wire   N24, N25, N26, N27, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26;
  wire   [7:1] data;
  wire   [3:0] counter;

  DFFSQX1M \data_reg[7]  ( .D(n19), .CK(CLK), .SN(RST), .Q(data[7]) );
  DFFSQX1M \data_reg[6]  ( .D(n20), .CK(CLK), .SN(RST), .Q(data[6]) );
  DFFSQX1M \data_reg[5]  ( .D(n21), .CK(CLK), .SN(RST), .Q(data[5]) );
  DFFSQX1M \data_reg[4]  ( .D(n22), .CK(CLK), .SN(RST), .Q(data[4]) );
  DFFSQX1M \data_reg[3]  ( .D(n23), .CK(CLK), .SN(RST), .Q(data[3]) );
  DFFSQX1M \data_reg[2]  ( .D(n24), .CK(CLK), .SN(RST), .Q(data[2]) );
  DFFSQX1M \data_reg[1]  ( .D(n25), .CK(CLK), .SN(RST), .Q(data[1]) );
  DFFSQX1M \data_reg[0]  ( .D(n18), .CK(CLK), .SN(RST), .Q(ser_data) );
  NOR2X12M U19 ( .A(n3), .B(n26), .Y(n6) );
  DFFRQX2M \counter_reg[1]  ( .D(N25), .CK(CLK), .RN(RST), .Q(counter[1]) );
  DFFRQX2M \counter_reg[2]  ( .D(N26), .CK(CLK), .RN(RST), .Q(counter[2]) );
  DFFRX1M \counter_reg[3]  ( .D(N27), .CK(CLK), .RN(RST), .Q(counter[3]), .QN(
        n1) );
  DFFRQX4M \counter_reg[0]  ( .D(N24), .CK(CLK), .RN(RST), .Q(counter[0]) );
  NAND3X1M U3 ( .A(counter[0]), .B(ser_en), .C(counter[1]), .Y(n14) );
  XNOR2X1M U4 ( .A(counter[0]), .B(counter[1]), .Y(n17) );
  AOI2B1X2M U5 ( .A1N(counter[1]), .A0(ser_en), .B0(N24), .Y(n16) );
  NOR2X2M U6 ( .A(n3), .B(counter[0]), .Y(N24) );
  INVX4M U7 ( .A(ser_en), .Y(n3) );
  NOR2X8M U8 ( .A(n26), .B(n6), .Y(n4) );
  BUFX6M U9 ( .A(n7), .Y(n26) );
  NOR2BX1M U10 ( .AN(Data_Valid), .B(busy), .Y(n7) );
  OAI2BB1X2M U11 ( .A0N(n4), .A1N(data[6]), .B0(n8), .Y(n20) );
  AOI22X1M U12 ( .A0(data[7]), .A1(n6), .B0(P_DATA[6]), .B1(n26), .Y(n8) );
  OAI2BB1X2M U13 ( .A0N(ser_data), .A1N(n4), .B0(n5), .Y(n18) );
  AOI22X1M U14 ( .A0(data[1]), .A1(n6), .B0(P_DATA[0]), .B1(n26), .Y(n5) );
  OAI2BB1X2M U15 ( .A0N(data[1]), .A1N(n4), .B0(n13), .Y(n25) );
  AOI22X1M U16 ( .A0(data[2]), .A1(n6), .B0(P_DATA[1]), .B1(n26), .Y(n13) );
  OAI2BB1X2M U17 ( .A0N(n4), .A1N(data[2]), .B0(n12), .Y(n24) );
  AOI22X1M U18 ( .A0(data[3]), .A1(n6), .B0(P_DATA[2]), .B1(n26), .Y(n12) );
  OAI2BB1X2M U20 ( .A0N(n4), .A1N(data[3]), .B0(n11), .Y(n23) );
  AOI22X1M U21 ( .A0(data[4]), .A1(n6), .B0(P_DATA[3]), .B1(n26), .Y(n11) );
  OAI2BB1X2M U22 ( .A0N(n4), .A1N(data[4]), .B0(n10), .Y(n22) );
  AOI22X1M U23 ( .A0(data[5]), .A1(n6), .B0(P_DATA[4]), .B1(n26), .Y(n10) );
  OAI2BB1X2M U24 ( .A0N(n4), .A1N(data[5]), .B0(n9), .Y(n21) );
  AOI22X1M U25 ( .A0(data[6]), .A1(n6), .B0(P_DATA[5]), .B1(n26), .Y(n9) );
  AO22X1M U26 ( .A0(n4), .A1(data[7]), .B0(P_DATA[7]), .B1(n26), .Y(n19) );
  OAI32X2M U27 ( .A0(n2), .A1(counter[3]), .A2(n14), .B0(n15), .B1(n1), .Y(N27) );
  OA21X2M U28 ( .A0(n3), .A1(counter[2]), .B0(n16), .Y(n15) );
  NOR4X4M U29 ( .A(counter[2]), .B(counter[1]), .C(counter[0]), .D(n1), .Y(
        ser_done) );
  OAI22X1M U30 ( .A0(n16), .A1(n2), .B0(counter[2]), .B1(n14), .Y(N26) );
  NOR2X2M U31 ( .A(n17), .B(n3), .Y(N25) );
  INVX2M U32 ( .A(counter[2]), .Y(n2) );
endmodule


module FSM_TX ( DATA_VALID_FSM, RST_FSM, CLK_FSM, SER_DONE_FSM, PAR_EN_FSM, 
        SER_EN_FSM, BUSY_FSM, MUX_SEL_FSM );
  output [1:0] MUX_SEL_FSM;
  input DATA_VALID_FSM, RST_FSM, CLK_FSM, SER_DONE_FSM, PAR_EN_FSM;
  output SER_EN_FSM, BUSY_FSM;
  wire   n18, BUSY_FSM_c, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16;
  wire   [2:0] cs;
  wire   [2:0] ns;

  OAI221X4M U9 ( .A0(cs[0]), .A1(DATA_VALID_FSM), .B0(n6), .B1(n4), .C0(n14), 
        .Y(MUX_SEL_FSM[0]) );
  DFFRX1M BUSY_FSM_reg ( .D(BUSY_FSM_c), .CK(CLK_FSM), .RN(RST_FSM), .Q(n18)
         );
  DFFRX4M \cs_reg[1]  ( .D(ns[1]), .CK(CLK_FSM), .RN(RST_FSM), .Q(cs[1]), .QN(
        n5) );
  DFFRQX4M \cs_reg[0]  ( .D(ns[0]), .CK(CLK_FSM), .RN(RST_FSM), .Q(cs[0]) );
  DFFRQX4M \cs_reg[2]  ( .D(n3), .CK(CLK_FSM), .RN(RST_FSM), .Q(cs[2]) );
  AOI21X1M U3 ( .A0(n6), .A1(n5), .B0(cs[2]), .Y(ns[1]) );
  NAND3X1M U4 ( .A(n5), .B(n4), .C(cs[0]), .Y(n13) );
  BUFX10M U5 ( .A(n18), .Y(BUSY_FSM) );
  INVX2M U6 ( .A(cs[2]), .Y(n4) );
  NOR2X2M U7 ( .A(n4), .B(cs[1]), .Y(n15) );
  INVX2M U8 ( .A(SER_EN_FSM), .Y(n1) );
  INVX2M U10 ( .A(PAR_EN_FSM), .Y(n8) );
  INVX2M U11 ( .A(n9), .Y(n3) );
  AOI31X2M U12 ( .A0(SER_DONE_FSM), .A1(n8), .A2(n10), .B0(n11), .Y(n9) );
  NAND4BX1M U13 ( .AN(n11), .B(n16), .C(n13), .D(n2), .Y(BUSY_FSM_c) );
  NAND3BX2M U14 ( .AN(n15), .B(n6), .C(DATA_VALID_FSM), .Y(n16) );
  OAI21X6M U15 ( .A0(SER_DONE_FSM), .A1(n2), .B0(n13), .Y(SER_EN_FSM) );
  INVX2M U16 ( .A(n10), .Y(n2) );
  AOI211X2M U17 ( .A0(SER_DONE_FSM), .A1(n10), .B0(n11), .C0(n15), .Y(n14) );
  OAI21X2M U18 ( .A0(n2), .A1(n8), .B0(n1), .Y(MUX_SEL_FSM[1]) );
  OAI31X2M U19 ( .A0(n12), .A1(cs[0]), .A2(n7), .B0(n1), .Y(ns[0]) );
  XNOR2X2M U20 ( .A(n4), .B(cs[1]), .Y(n12) );
  INVX2M U21 ( .A(DATA_VALID_FSM), .Y(n7) );
  INVX4M U22 ( .A(cs[0]), .Y(n6) );
  NOR3X6M U23 ( .A(n6), .B(cs[2]), .C(n5), .Y(n10) );
  NOR3X6M U24 ( .A(cs[0]), .B(cs[2]), .C(n5), .Y(n11) );
endmodule


module TOP_TX ( RST, CLK, P_DATA, PAR_TYP, PAR_EN, DATA_VALID, TX_OUT, BUSY );
  input [7:0] P_DATA;
  input RST, CLK, PAR_TYP, PAR_EN, DATA_VALID;
  output TX_OUT, BUSY;
  wire   ser_data, par_bit, ser_en, ser_done, n1;
  wire   [1:0] mux_sel;

  MUX4x1 mux ( .CLK_mux(CLK), .RST_mux(RST), .start_bit_mux(1'b0), 
        .stop_bit_mux(1'b1), .ser_data_mux(ser_data), .parity_bit_mux(par_bit), 
        .mux_sel_mux(mux_sel), .TX_OUT_mux(TX_OUT) );
  parity_calc_8 PAR ( .CLK(CLK), .RST(RST), .P_DATA(P_DATA), .PAR_TYP(PAR_TYP), 
        .PAR_EN(PAR_EN), .busy(BUSY), .Data_Valid(n1), .par_bit(par_bit) );
  SERIALIZER_8 SER ( .P_DATA(P_DATA), .ser_en(ser_en), .CLK(CLK), .RST(RST), 
        .Data_Valid(n1), .busy(BUSY), .ser_done(ser_done), .ser_data(ser_data)
         );
  FSM_TX FSM1 ( .DATA_VALID_FSM(n1), .RST_FSM(RST), .CLK_FSM(CLK), 
        .SER_DONE_FSM(ser_done), .PAR_EN_FSM(PAR_EN), .SER_EN_FSM(ser_en), 
        .BUSY_FSM(BUSY), .MUX_SEL_FSM(mux_sel) );
  BUFX4M U3 ( .A(DATA_VALID), .Y(n1) );
endmodule

