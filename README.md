Objective. Build a configurable sequential controller using an FSM, synchronizers, clock enable, countdown
timer and configuration ROM.
1. Functional overview
The design models a generic appliance/process controller. It accepts start, pause, resume, stop, emergency,
over-temperature, sensor-ready and fault-clear inputs. It drives motor and heater enables, an alarm, state
debug and remaining-time outputs. No FPGA board is assumed.
2. Architecture
Asynchronous inputs pass through two-flop synchronizers. A clock-enable generator produces a one-cycle
tick. A constant configuration ROM selects a duration of 5, 10, 20 or 30 seconds. The FSM controls the
countdown timer and safe outputs. All sequential logic uses one system clock; tick is an enable, not a separate# cognevance_FPGA-Based-Smart-Controller-System clock.
