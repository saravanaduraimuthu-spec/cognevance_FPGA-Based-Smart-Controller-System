# FPGA-Based Custom Smart Controller
Verilog HDL | Xilinx Vivado | Simulation-only (no FPGA board)

## Function
A configurable process/appliance controller with start, pause, resume, stop,
emergency, over-temperature, sensor-ready and fault-clear inputs. Outputs are
motor_enable, heater_enable and alarm. The timer profiles are 5, 10, 20 and 30 s.

## FSM
IDLE -> STARTUP -> RUNNING <-> PAUSED -> COMPLETE.
Emergency or over-temperature in STARTUP/RUNNING/PAUSED enters latched FAULT.
FAULT returns to IDLE only after clear_fault while both fault inputs are low.

## Simulate
1. Extract ZIP and open Vivado.
2. In Tcl Console: cd <project-folder>
3. source ./vivado/run_sim.tcl
4. Run all; inspect waveform and Tcl Console for PASS.

The testbench overrides CLK_HZ=4 and TICK_HZ=1 to accelerate simulation.
The top-level defaults are 100 MHz and 1 Hz.

## Synthesis and timing
Run: source ./vivado/run_synth.tcl
Review reports/utilization_report.txt and reports/timing_summary.txt.
The Tcl uses xc7a35tcpg236-1 as an example part. Change it for an actual device.
A real implementation needs a valid create_clock constraint and board-specific
XDC pin assignments. No board or pin map is included.

## Engineering notes
All sequential logic uses one system clock; tick is a clock enable, not a new clock.
Inputs use two-flop synchronizers. Mechanical switches also need debouncing.
The small constant ROM may map to LUT logic, not block RAM.
Only claim timing closure or power optimization after reviewing actual reports.

## GitHub
git init
git add .
git commit -m "FPGA custom smart controller"
git branch -M main
git remote add origin https://github.com/<username>/<repository>.git
git push -u origin main
