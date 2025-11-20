
###################################################################
########################### Variables #############################
###################################################################

set SSLIB "/home/IC/Assignments/Ass_Formal_2.0/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Assignments/Ass_Formal_2.0/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "//home/IC/Assignments/Ass_Formal_2.0/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

###################################################################
############################ Guidance #############################
###################################################################

# Synopsys setup variable

set synopses_auto_setup true
set verification_verify_directly_undriven_output false
# Formality Setup File

set_svf "/home/IC/Assignments/Ass_Formal_2.0/syn/UART_TX.svf"

###################################################################
###################### Reference Container ########################
###################################################################

# Read Reference Design Verilog Files

read_verilog -container r "/home/IC/Assignments/Ass_Formal_2.0/rtl/TOP_TX.v"
read_verilog -container r  "/home/IC/Assignments/Ass_Formal_2.0/rtl/FSM_TX.v"
read_verilog -container r  "/home/IC/Assignments/Ass_Formal_2.0/rtl/SERIALIZER.v"
read_verilog -container r  "/home/IC/Assignments/Ass_Formal_2.0/rtl/mux2X1.v"
read_verilog -container r  "/home/IC/Assignments/Ass_Formal_2.0/rtl/parity_calc.v"
read_verilog -container r  "/home/IC/Assignments/Ass_Formal_2.0/rtl/MUX4x1.v"

# Read Reference technology libraries

read_db -container r [list $SSLIB $TTLIB $FFLIB]

# set the top Reference Design 

#set_reference_design TOP_TX
set_top TOP_TX

###################################################################
#################### Implementation Container #####################
###################################################################

# Read Implementation Design Files

read_verilog -netlist -container i "/home/IC/Assignments/Ass_Formal_2.0/dft/DFT_UART_TX_netlist.v"

# Read Implementation technology libraries

read_db -container i [list $SSLIB $TTLIB $FFLIB]

# set the top Implementation Design

#set_implementation_design UART_TX_netlist
#set_implementation_design  TOP_TX
set_top TOP_TX

set_dont_verify_points -type port r:/WORK/TOP_TX/SO
set_constant r:/WORK/TOP_TX/SE 0
set_constant r:/WORK/TOP_TX/SI 0
set_constant i:/WORK/TOP_TX/SE 0
set_constant i:/WORK/TOP_TX/SI 0
###################### Matching Compare points ####################

match

######################### Run Verification ########################

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

########################### Reporting ############################# 
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_failing_points -inputs unmatched -inputs undriven > "failing_points_details.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"



start_gui

