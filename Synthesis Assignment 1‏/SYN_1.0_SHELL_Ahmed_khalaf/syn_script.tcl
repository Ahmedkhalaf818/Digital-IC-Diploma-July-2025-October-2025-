
################################ Design Compiler Libraray Files ################################

lappend search_path /home/IC/Assignments/Ass_Syn_1.0_SHELL/std_cells
lappend search_path /home/IC/Assignments/Ass_Syn_1.0_SHELL/rtl

set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"

## Standard cell libraries
set target_library [list $TTLIB]

## Standard cell & Hard Macros libraries
set link_library [list * $TTLIB]


################################ Reading RTL Files ##############################################

read_file -format verilog Down_Counter.v

link

################################ Mapping and optimization #######################################

compile

#################################################################################################
#				Write out Design after initial compile				#
#################################################################################################

write_file -format verilog -output Down_Counter_netlist.v

exit
