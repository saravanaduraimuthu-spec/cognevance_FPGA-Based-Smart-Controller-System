# Run from project root in Vivado Tcl Console: source ./vivado/run_sim.tcl
create_project FPGA_Smart_Controller ./vivado_project -part xc7a35tcpg236-1 -force
add_files [glob ./rtl/*.v]
add_files -fileset sim_1 [glob ./testbench/*.v]
set_property top smart_controller_top [current_fileset]
set_property top tb_smart_controller [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
launch_simulation
run all
