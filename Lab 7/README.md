# Lab 7: Word Detector with UART
*Duncan Wood* <br>
*10/20/2025*


## Objective
The objective of this lab was to develop a Verilog design that enables character transmission from a PC to an FPGA board via UART communication. The FPGA receives and interprets the incoming characters, and when the sequence "HELLO" is detected, it displays the word on the on-board 7-segment displays. In essence, characters entered through a serial terminal on the PC are sent over a UART connection to the FPGA, which continuously monitors the input stream and triggers the 7-segment display output when the word "HELLO" is typed.
<br>
<br>
***Note: Full Verilog text documents included in "doc" folder

## Word Detector FSM Module
First, the module is defined with its inputs and outputs.
<br>
Then the 6 states are declared as local parameters and the registers are setup to handle the transitions between the states.
<div align="center">
  <img src="img/hello_detector_1.jpg" alt="Hello Detector 1" width="400"/><br>
  <em>Figure 1: Hello Word Detector </em>
</div>
<br>
Next the timer logic is setup for blinking the HEX displays when HELLO is detected and displayed.
<br>
<div align="center">
  <img src="img/hello_detector_2jpg.jpg" alt="Hello Detector 2" width="400"/><br>
  <em>Figure 2: Hello Word Detector </em>
</div>
<br>
The state register and next-state logic is defined through always statements. The next state logic uses a case statement defining which state should be active based on the ascii characters.
<br>
<div align="center">
  <img src="img/hello_detector_3jpg.jpg" alt="Hello Detector 3" width="600"/><br>
  <em>Figure 3: Hello Word Detector </em>
</div>
<br>
An always statement is used to determine if the display is in a blinking state.
<div align="center">
  <img src="img/hello_detector_4jpg.jpg" alt="Hello Detector 4" width="300"/><br>
  <em>Figure 4: Hello Word Detector </em>
</div>


## Top-Level Main
<div align="center">
  <img src="img/ad_L7_main1.jpg" alt="Top Level 1" width="400"/><br>
  <em>Figure 5: Lab 7 Main </em>
</div>
<br>
<div align="center">
  <img src="img/ad_L7_main2.jpg" alt="Top Level 2" width="350"/><br>
  <em>Figure 6: Lab 7 Main </em>
</div>
<br>
<div align="center">
  <img src="img/ad_L7_main3.jpg" alt="Top Level 3" width="400"/><br>
  <em>Figure 7: Lab 7 Main </em>
</div>
