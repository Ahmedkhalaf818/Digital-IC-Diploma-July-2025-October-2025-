/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : K-2015.06
// Date      : Fri Sep 12 01:05:14 2025
/////////////////////////////////////////////////////////////


module mux2X1_1 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_0 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module MUX4x1_test_1 ( CLK_mux, RST_mux, start_bit_mux, stop_bit_mux, 
        ser_data_mux, parity_bit_mux, mux_sel_mux, TX_OUT_mux, test_si, 
        test_se );
  input [1:0] mux_sel_mux;
  input CLK_mux, RST_mux, start_bit_mux, stop_bit_mux, ser_data_mux,
         parity_bit_mux, test_si, test_se;
  output TX_OUT_mux;
  wire   TX_OUT_mux_c, n3, n4;

  INVX2M U4 ( .A(mux_sel_mux[0]), .Y(n4) );
  OAI2B2X2M U5 ( .A1N(mux_sel_mux[1]), .A0(n3), .B0(mux_sel_mux[1]), .B1(n4), 
        .Y(TX_OUT_mux_c) );
  SDFFRX4M TX_OUT_mux_reg ( .D(TX_OUT_mux_c), .SI(test_si), .SE(test_se), .CK(
        CLK_mux), .RN(RST_mux), .Q(TX_OUT_mux) );
  AOI22X2M U3 ( .A0(ser_data_mux), .A1(n4), .B0(parity_bit_mux), .B1(
        mux_sel_mux[0]), .Y(n3) );
endmodule


module parity_calc_8_test_1 ( CLK, RST, P_DATA, PAR_TYP, PAR_EN, busy, 
        Data_Valid, par_bit, test_si, test_so, test_se );
  input [7:0] P_DATA;
  input CLK, RST, PAR_TYP, PAR_EN, busy, Data_Valid, test_si, test_se;
  output par_bit, test_so;
  wire   n1, n3, n4, n5, n6, n7, n9, n11, n13, n15, n17, n19, n21, n23, n25,
         n2;
  wire   [7:0] par_data;
  assign test_so = par_data[7];

  NOR2BX2M U2 ( .AN(Data_Valid), .B(busy), .Y(n7) );
  OAI2BB2X1M U3 ( .B0(n1), .B1(n2), .A0N(par_bit), .A1N(n2), .Y(n9) );
  INVX2M U4 ( .A(PAR_EN), .Y(n2) );
  XOR3X2M U5 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3X2M U6 ( .A(par_data[5]), .B(par_data[4]), .C(n6), .Y(n3) );
  XOR3X2M U7 ( .A(par_data[1]), .B(par_data[0]), .C(n5), .Y(n4) );
  XNOR2X2M U8 ( .A(par_data[2]), .B(par_data[3]), .Y(n5) );
  AO2B2X2M U9 ( .B0(P_DATA[0]), .B1(n7), .A0(par_data[0]), .A1N(n7), .Y(n11)
         );
  AO2B2X2M U10 ( .B0(P_DATA[1]), .B1(n7), .A0(par_data[1]), .A1N(n7), .Y(n13)
         );
  AO2B2X2M U11 ( .B0(P_DATA[2]), .B1(n7), .A0(par_data[2]), .A1N(n7), .Y(n15)
         );
  AO2B2X2M U12 ( .B0(P_DATA[3]), .B1(n7), .A0(par_data[3]), .A1N(n7), .Y(n17)
         );
  AO2B2X2M U13 ( .B0(P_DATA[4]), .B1(n7), .A0(par_data[4]), .A1N(n7), .Y(n19)
         );
  AO2B2X2M U14 ( .B0(P_DATA[5]), .B1(n7), .A0(par_data[5]), .A1N(n7), .Y(n21)
         );
  AO2B2X2M U15 ( .B0(P_DATA[6]), .B1(n7), .A0(par_data[6]), .A1N(n7), .Y(n23)
         );
  AO2B2X2M U16 ( .B0(P_DATA[7]), .B1(n7), .A0(par_data[7]), .A1N(n7), .Y(n25)
         );
  XOR2X2M U17 ( .A(par_data[7]), .B(par_data[6]), .Y(n6) );
  SDFFRX2M \par_data_reg[7]  ( .D(n25), .SI(par_data[6]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(par_data[7]) );
  SDFFRX2M \par_data_reg[6]  ( .D(n23), .SI(par_data[5]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(par_data[6]) );
  SDFFRX2M \par_data_reg[5]  ( .D(n21), .SI(par_data[4]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(par_data[5]) );
  SDFFRX2M \par_data_reg[4]  ( .D(n19), .SI(par_data[3]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(par_data[4]) );
  SDFFRX2M \par_data_reg[3]  ( .D(n17), .SI(par_data[2]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(par_data[3]) );
  SDFFRX2M \par_data_reg[2]  ( .D(n15), .SI(par_data[1]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(par_data[2]) );
  SDFFRX2M \par_data_reg[1]  ( .D(n13), .SI(par_data[0]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(par_data[1]) );
  SDFFRX2M \par_data_reg[0]  ( .D(n11), .SI(par_bit), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(par_data[0]) );
  SDFFRX2M par_bit_reg ( .D(n9), .SI(test_si), .SE(test_se), .CK(CLK), .RN(RST), .Q(par_bit) );
endmodule


module SERIALIZER_8_test_1 ( P_DATA, ser_en, CLK, RST, Data_Valid, busy, 
        ser_done, ser_data, test_si, test_so, test_se );
  input [7:0] P_DATA;
  input ser_en, CLK, RST, Data_Valid, busy, test_si, test_se;
  output ser_done, ser_data, test_so;
  wire   N24, N25, N26, N27, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n15, n38,
         n39;
  wire   [7:1] data;
  wire   [3:0] counter;
  assign test_so = data[7];

  SDFFSQX1M \data_reg[1]  ( .D(n37), .SI(ser_data), .SE(test_se), .CK(CLK), 
        .SN(RST), .Q(data[1]) );
  INVX2M U16 ( .A(ser_en), .Y(n15) );
  NOR2X2M U17 ( .A(n15), .B(n19), .Y(n18) );
  NOR2X2M U18 ( .A(n19), .B(n18), .Y(n16) );
  OA21X2M U20 ( .A0(n15), .A1(counter[2]), .B0(n28), .Y(n27) );
  NOR4X1M U21 ( .A(counter[2]), .B(counter[1]), .C(counter[0]), .D(n39), .Y(
        ser_done) );
  OAI2BB1X2M U22 ( .A0N(ser_data), .A1N(n16), .B0(n17), .Y(n30) );
  OAI2BB1X2M U24 ( .A0N(data[1]), .A1N(n16), .B0(n25), .Y(n37) );
  AOI22X1M U25 ( .A0(data[2]), .A1(n18), .B0(P_DATA[1]), .B1(n19), .Y(n25) );
  OAI2BB1X2M U26 ( .A0N(n16), .A1N(data[2]), .B0(n24), .Y(n36) );
  AOI22X1M U27 ( .A0(data[3]), .A1(n18), .B0(P_DATA[2]), .B1(n19), .Y(n24) );
  OAI2BB1X2M U28 ( .A0N(n16), .A1N(data[3]), .B0(n23), .Y(n35) );
  AOI22X1M U29 ( .A0(data[4]), .A1(n18), .B0(P_DATA[3]), .B1(n19), .Y(n23) );
  OAI2BB1X2M U30 ( .A0N(n16), .A1N(data[4]), .B0(n22), .Y(n34) );
  AOI22X1M U31 ( .A0(data[5]), .A1(n18), .B0(P_DATA[4]), .B1(n19), .Y(n22) );
  OAI2BB1X2M U32 ( .A0N(n16), .A1N(data[5]), .B0(n21), .Y(n33) );
  OAI2BB1X2M U34 ( .A0N(n16), .A1N(data[6]), .B0(n20), .Y(n32) );
  AOI22X1M U35 ( .A0(data[7]), .A1(n18), .B0(P_DATA[6]), .B1(n19), .Y(n20) );
  OAI22X1M U36 ( .A0(n28), .A1(n38), .B0(counter[2]), .B1(n26), .Y(N26) );
  AOI2B1X2M U37 ( .A1N(counter[1]), .A0(ser_en), .B0(N24), .Y(n28) );
  NAND3X2M U38 ( .A(counter[0]), .B(ser_en), .C(counter[1]), .Y(n26) );
  NOR2X2M U39 ( .A(n15), .B(counter[0]), .Y(N24) );
  NOR2BX2M U41 ( .AN(Data_Valid), .B(busy), .Y(n19) );
  NOR2X2M U42 ( .A(n29), .B(n15), .Y(N25) );
  XNOR2X2M U43 ( .A(counter[0]), .B(counter[1]), .Y(n29) );
  AO22X1M U46 ( .A0(n16), .A1(data[7]), .B0(P_DATA[7]), .B1(n19), .Y(n31) );
  SDFFRX2M \counter_reg[3]  ( .D(N27), .SI(n38), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(counter[3]), .QN(n39) );
  SDFFRX2M \counter_reg[2]  ( .D(N26), .SI(counter[1]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(counter[2]), .QN(n38) );
  SDFFRX2M \counter_reg[1]  ( .D(N25), .SI(counter[0]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(counter[1]) );
  SDFFRX2M \counter_reg[0]  ( .D(N24), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(counter[0]) );
  SDFFSQX1M \data_reg[7]  ( .D(n31), .SI(data[6]), .SE(test_se), .CK(CLK), 
        .SN(RST), .Q(data[7]) );
  SDFFSQX1M \data_reg[6]  ( .D(n32), .SI(data[5]), .SE(test_se), .CK(CLK), 
        .SN(RST), .Q(data[6]) );
  SDFFSQX1M \data_reg[5]  ( .D(n33), .SI(data[4]), .SE(test_se), .CK(CLK), 
        .SN(RST), .Q(data[5]) );
  SDFFSQX1M \data_reg[4]  ( .D(n34), .SI(data[3]), .SE(test_se), .CK(CLK), 
        .SN(RST), .Q(data[4]) );
  SDFFSQX1M \data_reg[3]  ( .D(n35), .SI(data[2]), .SE(test_se), .CK(CLK), 
        .SN(RST), .Q(data[3]) );
  SDFFSQX1M \data_reg[2]  ( .D(n36), .SI(data[1]), .SE(test_se), .CK(CLK), 
        .SN(RST), .Q(data[2]) );
  SDFFSQX1M \data_reg[0]  ( .D(n30), .SI(counter[3]), .SE(test_se), .CK(CLK), 
        .SN(RST), .Q(ser_data) );
  AOI22X2M U3 ( .A0(data[1]), .A1(n18), .B0(P_DATA[0]), .B1(n19), .Y(n17) );
  AOI22X2M U4 ( .A0(data[6]), .A1(n18), .B0(P_DATA[5]), .B1(n19), .Y(n21) );
  OAI32X2M U5 ( .A0(n38), .A1(counter[3]), .A2(n26), .B0(n27), .B1(n39), .Y(
        N27) );
endmodule


module FSM_TX_test_1 ( DATA_VALID_FSM, RST_FSM, CLK_FSM, SER_DONE_FSM, 
        PAR_EN_FSM, SER_EN_FSM, BUSY_FSM, MUX_SEL_FSM, test_si, test_so, 
        test_se );
  output [1:0] MUX_SEL_FSM;
  input DATA_VALID_FSM, RST_FSM, CLK_FSM, SER_DONE_FSM, PAR_EN_FSM, test_si,
         test_se;
  output SER_EN_FSM, BUSY_FSM, test_so;
  wire   BUSY_FSM_c, n13, n14, n15, n16, n17, n18, n19, n20, n6, n7, n8, n9,
         n10, n11, n12, n21;
  wire   [2:0] cs;
  wire   [2:0] ns;
  assign test_so = cs[2];

  INVX2M U8 ( .A(SER_EN_FSM), .Y(n6) );
  OAI21X2M U9 ( .A0(SER_DONE_FSM), .A1(n7), .B0(n17), .Y(SER_EN_FSM) );
  NAND4BX2M U10 ( .AN(n15), .B(n20), .C(n17), .D(n7), .Y(BUSY_FSM_c) );
  NAND3BX2M U11 ( .AN(n19), .B(n9), .C(DATA_VALID_FSM), .Y(n20) );
  INVX2M U12 ( .A(n14), .Y(n7) );
  INVX2M U13 ( .A(n13), .Y(n8) );
  AOI31X2M U14 ( .A0(SER_DONE_FSM), .A1(n12), .A2(n14), .B0(n15), .Y(n13) );
  INVX2M U15 ( .A(PAR_EN_FSM), .Y(n12) );
  AOI211X2M U17 ( .A0(SER_DONE_FSM), .A1(n14), .B0(n15), .C0(n19), .Y(n18) );
  NOR3X2M U18 ( .A(n9), .B(cs[2]), .C(n11), .Y(n14) );
  INVX2M U20 ( .A(DATA_VALID_FSM), .Y(n21) );
  XNOR2X2M U21 ( .A(n10), .B(cs[1]), .Y(n16) );
  NOR3X2M U22 ( .A(cs[0]), .B(cs[2]), .C(n11), .Y(n15) );
  OAI21X2M U23 ( .A0(n7), .A1(n12), .B0(n6), .Y(MUX_SEL_FSM[1]) );
  NAND3X2M U24 ( .A(n11), .B(n10), .C(cs[0]), .Y(n17) );
  AOI21X2M U25 ( .A0(n9), .A1(n11), .B0(cs[2]), .Y(ns[1]) );
  NOR2X2M U27 ( .A(n10), .B(cs[1]), .Y(n19) );
  SDFFRX2M \cs_reg[2]  ( .D(n8), .SI(cs[1]), .SE(test_se), .CK(CLK_FSM), .RN(
        RST_FSM), .Q(cs[2]), .QN(n10) );
  SDFFRX2M \cs_reg[0]  ( .D(ns[0]), .SI(BUSY_FSM), .SE(test_se), .CK(CLK_FSM), 
        .RN(RST_FSM), .Q(cs[0]), .QN(n9) );
  SDFFRX2M BUSY_FSM_reg ( .D(BUSY_FSM_c), .SI(test_si), .SE(test_se), .CK(
        CLK_FSM), .RN(RST_FSM), .Q(BUSY_FSM) );
  SDFFRX2M \cs_reg[1]  ( .D(ns[1]), .SI(cs[0]), .SE(test_se), .CK(CLK_FSM), 
        .RN(RST_FSM), .Q(cs[1]), .QN(n11) );
  OAI221X2M U3 ( .A0(cs[0]), .A1(DATA_VALID_FSM), .B0(n9), .B1(n10), .C0(n18), 
        .Y(MUX_SEL_FSM[0]) );
  OAI31X2M U4 ( .A0(n16), .A1(cs[0]), .A2(n21), .B0(n6), .Y(ns[0]) );
endmodule


module TOP_TX ( SI, SE, scan_clk, scan_rst, test_mode, SO, RST, CLK, P_DATA, 
        PAR_TYP, PAR_EN, DATA_VALID, TX_OUT, BUSY );
  input [7:0] P_DATA;
  input SI, SE, scan_clk, scan_rst, test_mode, RST, CLK, PAR_TYP, PAR_EN,
         DATA_VALID;
  output SO, TX_OUT, BUSY;
  wire   TX_OUT, M_RST, M_CLK, ser_data, par_bit, ser_en, ser_done, n4, n5, n6,
         n8, n9;
  wire   [1:0] mux_sel;
  assign SO = TX_OUT;

  INVX2M U5 ( .A(SE), .Y(n8) );
  INVX2M U6 ( .A(n8), .Y(n9) );
  mux2X1_1 MUX_SCAN_RST ( .IN_0(RST), .IN_1(scan_rst), .SEL(test_mode), .OUT(
        M_RST) );
  mux2X1_0 MUX_SCAN_CLK ( .IN_0(CLK), .IN_1(scan_clk), .SEL(test_mode), .OUT(
        M_CLK) );
  MUX4x1_test_1 mux ( .CLK_mux(M_CLK), .RST_mux(M_RST), .start_bit_mux(1'b0), 
        .stop_bit_mux(1'b1), .ser_data_mux(ser_data), .parity_bit_mux(par_bit), 
        .mux_sel_mux(mux_sel), .TX_OUT_mux(TX_OUT), .test_si(n4), .test_se(n9)
         );
  parity_calc_8_test_1 PAR ( .CLK(M_CLK), .RST(M_RST), .P_DATA(P_DATA), 
        .PAR_TYP(PAR_TYP), .PAR_EN(PAR_EN), .busy(BUSY), .Data_Valid(
        DATA_VALID), .par_bit(par_bit), .test_si(n6), .test_so(n5), .test_se(
        n9) );
  SERIALIZER_8_test_1 SER ( .P_DATA(P_DATA), .ser_en(ser_en), .CLK(M_CLK), 
        .RST(M_RST), .Data_Valid(DATA_VALID), .busy(BUSY), .ser_done(ser_done), 
        .ser_data(ser_data), .test_si(n5), .test_so(n4), .test_se(n9) );
  FSM_TX_test_1 FSM1 ( .DATA_VALID_FSM(DATA_VALID), .RST_FSM(M_RST), .CLK_FSM(
        M_CLK), .SER_DONE_FSM(ser_done), .PAR_EN_FSM(PAR_EN), .SER_EN_FSM(
        ser_en), .BUSY_FSM(BUSY), .MUX_SEL_FSM(mux_sel), .test_si(SI), 
        .test_so(n6), .test_se(n9) );
endmodule

