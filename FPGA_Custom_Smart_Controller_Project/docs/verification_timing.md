# Verification, synthesis and timing guide

## Testbench scenarios
Reset; start and timer load; pause and count hold; resume; completion;
emergency fault; fault clear; over-temperature fault.

## Capture these waveforms
clk, rst, tick, start_async, pause_async, resume_async, sensor_ready_async,
emergency_async, over_temp_async, state_debug, seconds_left, motor_enable,
heater_enable, alarm. Use Zoom Fit and capture the full test.

## Synthesis
Run vivado/run_synth.tcl. Review LUT/FF utilization, warnings, inferred latches,
and the timing summary. The constant configuration ROM may map to LUTs.

## Timing
Behavioral simulation does not measure physical timing. For hardware, use the
actual target part and a valid create_clock constraint matching its oscillator.
Review WNS, TNS, setup/hold paths after implementation. Without a board and
accurate constraints, do not claim timing closure.

## Power/performance
Use one clock domain and clock enables; avoid fabric-generated clocks.
Synchronize and debounce physical inputs. Use realistic clock and I/O activity
when estimating power. Optimize based on measured reports, not assumptions.
