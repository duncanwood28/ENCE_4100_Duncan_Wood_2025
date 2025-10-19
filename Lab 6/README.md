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
<div align="center">
  <img src="img/chess_fsm1.jpg" alt="FSM Verilog" width="400"/><br>
  <em>Figure 2: FSM Verilog </em>
</div>
<br>
<div align="center">
  <img src="img/chess_fsm2.jpg" alt="FSM Verilog" width="500"/><br>
  <em>Figure 3: FSM Verilog </em>
</div>
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
