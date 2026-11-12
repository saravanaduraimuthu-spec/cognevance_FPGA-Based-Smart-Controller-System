module smart_controller_top #(parameter integer CLK_HZ=100_000_000,TICK_HZ=1)(
 input wire clk,rst,
 input wire start_async,pause_async,resume_async,stop_async,
 input wire emergency_async,over_temp_async,sensor_ready_async,clear_fault_async,
 input wire [1:0] profile,
 output wire motor_enable,heater_enable,alarm,tick,
 output wire [7:0] seconds_left, output wire [2:0] state_debug);
wire start_s,pause_s,resume_s,stop_s,emergency_s,over_temp_s,sensor_s,clear_s;
wire [7:0] duration; wire timer_load,timer_enable;
input_synchronizer s0(clk,rst,start_async,start_s);
input_synchronizer s1(clk,rst,pause_async,pause_s);
input_synchronizer s2(clk,rst,resume_async,resume_s);
input_synchronizer s3(clk,rst,stop_async,stop_s);
input_synchronizer s4(clk,rst,emergency_async,emergency_s);
input_synchronizer s5(clk,rst,over_temp_async,over_temp_s);
input_synchronizer s6(clk,rst,sensor_ready_async,sensor_s);
input_synchronizer s7(clk,rst,clear_fault_async,clear_s);
clock_enable #(.CLK_HZ(CLK_HZ),.TICK_HZ(TICK_HZ)) ce(clk,rst,tick);
config_rom rom(profile,duration);
controller_fsm fsm(clk,rst,start_s,pause_s,resume_s,stop_s,emergency_s,
 over_temp_s,sensor_s,clear_s,tick,duration,seconds_left,
 timer_load,timer_enable,motor_enable,heater_enable,alarm,state_debug);
countdown_timer timer(clk,rst,timer_load,timer_enable,tick,duration,seconds_left);
endmodule
