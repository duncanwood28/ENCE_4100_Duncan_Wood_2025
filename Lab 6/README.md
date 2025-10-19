# Lab 6: Chess Timer FSM
*Duncan Wood* <br>
*10/14/2025*

## FSM Derivation
Four possible states:
<br>
idle - Waiting for game to begin
<br>
Player A - Player A's timer is active, Player B's timer is paused.
<br>
Player B - Player B's timer is active, Player A's timer is paused.
<br>
Game Over - One of the timers reached zero.
<br>
<div align="center">
  <img src="img/FSM_diagram.jpg" alt="FSM Diagram" width="500"/><br>
  <em>Figure 1: FSM Diagram </em>
</div>

## Chess Timer FSM Module
As per usual the module starts out by declaring inputs, outputs, and local parameters for the function. This includes the clock and reset for the memory elements, inputs and output counters, and the FSM states as parameters.
<br>
Next the state register is written to decide whether to start over with reset or move on to the next state based on the logic.
<div align="center">
  <img src="img/chess_fsm1.jpg" alt="FSM Verilog" width="400"/><br>
  <em>Figure 2: FSM Verilog </em>
</div>
<br>
The next-state logic is written based on the FSM designed earlier, switching between the 4 states in reaction to the 1-bit input w (buttons) and order of such.
<br>
<div align="center">
  <img src="img/chess_fsm2.jpg" alt="FSM Verilog" width="500"/><br>
  <em>Figure 3: FSM Verilog </em>
</div>
<br>
Next the output logic is declared using a case statement. The case statement runs each of the counters based on the present state of the system.
<br>
<div align="center">
  <img src="img/chess_fsm3.jpg" alt="FSM Verilog" width="400"/><br>
  <em>Figure 4: FSM Verilog </em>
</div>

## Top-Level Code
<div align="center">
  <img src="img/chess_main1.jpg" alt="Top-Level Verilog" width="500"/><br>
  <em>Figure 5: Top-Level Verilog </em>
</div>
<br>
<div align="center">
  <img src="img/chess_main2.jpg" alt="Top-Level Verilog" width="500"/><br>
  <em>Figure 6: Top-Level Verilog </em>
</div>
<br>
<div align="center">
  <img src="img/chess_main3.jpg" alt="Top-Level Verilog" width="500"/><br>
  <em>Figure 7: Top-Level Verilog </em>
</div>
<br>
<div align="center">
  <img src="img/chess_main4.jpg" alt="Top-Level Verilog" width="500"/><br>
  <em>Figure 8: Top-Level Verilog </em>
</div>
