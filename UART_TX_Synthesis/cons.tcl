#########################################################
 #### Section 1 : Clock Definition ####
#########################################################
set clock_name CLK1
set clock_period 8680
set CLK_SETUP_SKEW 0.25
set CLK_HOLD_SKEW 0.05
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




 #### Section 4 : Driving cells ####
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port P_DATA]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port PAR_TYP]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port PAR_EN]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port DATA_VALID]


set_load 0.5 [get_port TX_OUT]
set_load 0.5 [get_port BUSY]

set_dont_touch_network [get_clocks "$clock_name"]
####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################
set in_delay  [expr 0.3*$clock_period]
set out_delay [expr 0.3*$clock_period]
#Constrain Input Paths
set_input_delay $in_delay -clock $clock_name [get_ports P_DATA]
set_input_delay $in_delay -clock $clock_name [get_ports PAR_TYP]
set_input_delay $in_delay -clock $clock_name [get_ports PAR_EN]
set_input_delay $in_delay -clock $clock_name [get_ports DATA_VALID]
#Constrain Output Paths
set_output_delay $out_delay -clock $clock_name [get_ports TX_OUT]
set_output_delay $out_delay -clock $clock_name [get_ports BUSY]


           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
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
