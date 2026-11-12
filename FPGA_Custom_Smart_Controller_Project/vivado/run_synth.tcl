# Synthesis example. Change part to the exact target device if one is selected.
create_project FPGA_Smart_Controller_Synth ./vivado_synth -part xc7a35tcpg236-1 -force
add_files [glob ./rtl/*.v]
set_property top smart_controller_top [current_fileset]
update_compile_order -fileset sources_1
synth_design -top smart_controller_top -part xc7a35tcpg236-1
report_utilization -file ./reports/utilization_report.txt
report_timing_summary -file ./reports/timing_summary.txt
write_checkpoint -force ./reports/post_synth.dcp
