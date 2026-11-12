`timescale 1ns/1ps
module tb_smart_controller;
reg clk=0,rst=1;
reg start_async=0,pause_async=0,resume_async=0,stop_async=0;
reg emergency_async=0,over_temp_async=0,sensor_ready_async=0,clear_fault_async=0;
reg [1:0] profile=0;
wire motor_enable,heater_enable,alarm,tick;
wire [7:0] seconds_left; wire [2:0] state_debug;
integer errors=0;
localparam IDLE=0,RUNNING=2,PAUSED=3,COMPLETE=4,FAULT=5;
always #5 clk=~clk;
smart_controller_top #(.CLK_HZ(4),.TICK_HZ(1)) dut(
.clk(clk),.rst(rst),.start_async(start_async),.pause_async(pause_async),
.resume_async(resume_async),.stop_async(stop_async),.emergency_async(emergency_async),
.over_temp_async(over_temp_async),.sensor_ready_async(sensor_ready_async),
.clear_fault_async(clear_fault_async),.profile(profile),.motor_enable(motor_enable),
.heater_enable(heater_enable),.alarm(alarm),.tick(tick),
.seconds_left(seconds_left),.state_debug(state_debug));
task wait_cycles(input integer n); integer q; begin for(q=0;q<n;q=q+1) @(posedge clk); #1; end endtask
task start_run; begin start_async=1; wait_cycles(5); start_async=0; wait_cycles(4); end endtask
initial begin
 $dumpfile("smart_controller.vcd"); $dumpvars(0,tb_smart_controller);
 $display("Starting FPGA Smart Controller testbench");
 wait_cycles(3); rst=0; sensor_ready_async=1; wait_cycles(5);
 if(state_debug!==IDLE) errors=errors+1;
 start_run();
 if(state_debug!==RUNNING || seconds_left!==5 || !motor_enable || !heater_enable) begin
  $display("ERROR: start/load/run check"); errors=errors+1; end
 pause_async=1; wait_cycles(5); pause_async=0; wait_cycles(4);
 if(state_debug!==PAUSED) begin $display("ERROR: pause"); errors=errors+1; end
 begin reg [7:0] hold; hold=seconds_left; wait_cycles(12);
  if(seconds_left!==hold) begin $display("ERROR: paused timer changed"); errors=errors+1; end end
 resume_async=1; wait_cycles(5); resume_async=0; wait_cycles(4);
 if(state_debug!==RUNNING) begin $display("ERROR: resume"); errors=errors+1; end
 wait_cycles(32);
 if(state_debug!==COMPLETE || motor_enable || heater_enable) begin
  $display("ERROR: completion"); errors=errors+1; end
 start_run(); emergency_async=1; wait_cycles(5); emergency_async=0; wait_cycles(4);
 if(state_debug!==FAULT || !alarm || motor_enable || heater_enable) begin
  $display("ERROR: emergency fault"); errors=errors+1; end
 clear_fault_async=1; wait_cycles(5); clear_fault_async=0; wait_cycles(4);
 if(state_debug!==IDLE || alarm) begin $display("ERROR: clear fault"); errors=errors+1; end
 start_run(); over_temp_async=1; wait_cycles(5); over_temp_async=0; wait_cycles(4);
 if(state_debug!==FAULT || !alarm) begin $display("ERROR: over-temp fault"); errors=errors+1; end
 if(errors==0) $display("PASS: all smart controller tests completed with zero errors.");
 else $display("FAIL: %0d error(s) detected.",errors);
 $finish;
end
endmodule
