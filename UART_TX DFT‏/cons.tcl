#########################################################
 #### Section 1 : Clock Definition ####
#########################################################
set clock_name CLK1
set clock_period 8680
set CLK_SETUP_SKEW 0.025
set CLK_HOLD_SKEW 0.01
set CLK_LAT 0
set CLK_transition 0.1



create_clock -name "$clock_name" -period $clock_period -waveform [list 0 [expr $clock_period/2.0]] [get_ports CLK]
#########################################################
 #### Section 3 : uncertainty ,skew, latency and transiton ####
#########################################################
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks "$clock_name"]
set_clock_uncertainty -hold  $CLK_HOLD_SKEW [get_clocks "$clock_name"]
set_clock_latency $CLK_LAT [get_clocks "$clock_name"]
set_clock_transition  $CLK_transition [get_clocks "$clock_name"]
################### SCAN CLOCK #################
set S_clock_name CLK_SCAN
set S_clock_period 10000
set S_CLK_SETUP_SKEW 0.025
set S_CLK_HOLD_SKEW 0.01
set S_CLK_LAT 0
set S_CLK_transition 0.1

create_clock -name "$S_clock_name" -period $clock_period -waveform [list 0 [expr $S_clock_period/2.0]] [get_ports scan_clk]
#########################################################
 #### Section 3 : uncertainty ,skew, latency and transiton ####
#########################################################
set_clock_uncertainty -setup $S_CLK_SETUP_SKEW [get_clocks "$S_clock_name"]
set_clock_uncertainty -hold  $S_CLK_HOLD_SKEW [get_clocks "$S_clock_name"]
set_clock_latency $S_CLK_LAT [get_clocks "$S_clock_name"]
set_clock_transition  $S_CLK_transition [get_clocks "$S_clock_name"]

set_dont_touch_network "$S_clock_name"

set_clock_groups -asynchronous -group [get_clocks $clock_name] -group [get_clocks $S_clock_name]
 #### Section 4 : Driving cells ####
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port P_DATA]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port PAR_TYP]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port PAR_EN]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port DATA_VALID]
################scan ports#######
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SI]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SE]

set_load 0.1 [get_port TX_OUT]
set_load 0.1 [get_port BUSY]
set_load 0.1 [get_port SO]
set_dont_touch_network [get_clocks "$clock_name"]
set_dont_touch_network [get_clocks "$S_clock_name"]
####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################
set in_delay  [expr 0.3*$clock_period]
set out_delay [expr 0.3*$clock_period]
set S_in_delay  [expr 0.3*$S_clock_period]
set S_out_delay [expr 0.3*$S_clock_period]
#Constrain Input Paths
set_input_delay $in_delay -clock $clock_name [get_ports P_DATA]
set_input_delay $in_delay -clock $clock_name [get_ports PAR_TYP]
set_input_delay $in_delay -clock $clock_name [get_ports PAR_EN]
set_input_delay $in_delay -clock $clock_name [get_ports DATA_VALID]

set_input_delay $S_in_delay -clock $S_clock_name [get_ports SI]
set_input_delay $S_in_delay -clock $S_clock_name [get_ports SE]
#Constrain Output Paths
set_output_delay $out_delay -clock $clock_name [get_ports TX_OUT]
set_output_delay $out_delay -clock $clock_name [get_ports BUSY]

set_output_delay $S_out_delay -clock $S_clock_name [get_ports SO ]

set_case_analysis 1 [get_ports test_mode]



           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

#set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
#############################################################################

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################
# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis
set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" \
-max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"
