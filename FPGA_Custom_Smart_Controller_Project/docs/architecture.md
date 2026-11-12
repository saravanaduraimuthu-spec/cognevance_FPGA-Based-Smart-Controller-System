# Architecture and FSM

Async controls/sensors -> two-flop synchronizers -> FSM.
Clock-enable generator -> 1-cycle tick -> countdown timer.
Configuration ROM -> selected duration -> timer load.
FSM drives motor_enable, heater_enable, alarm and state_debug.

| State | Meaning | Motor | Heater | Alarm |
|---|---|---:|---:|---:|
| IDLE | Waiting for start | 0 | 0 | 0 |
| STARTUP | Sensor-ready/startup | 0 | 0 | 0 |
| RUNNING | Timed operation | 1 | 1 | 0 |
| PAUSED | Timer holds | 0 | 0 | 0 |
| COMPLETE | Timer reached zero | 0 | 0 | 0 |
| FAULT | Emergency/over-temperature | 0 | 0 | 1 |

Transitions: IDLE->STARTUP on start and sensor_ready; STARTUP->RUNNING when
sensor_ready; RUNNING->PAUSED on pause; PAUSED->RUNNING on resume;
RUNNING->COMPLETE at zero; active states->IDLE on stop; active states->FAULT
on emergency/over-temperature; FAULT->IDLE only after clear_fault and fault
inputs inactive. COMPLETE can restart with start.
