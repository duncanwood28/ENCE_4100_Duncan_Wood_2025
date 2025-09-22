# Lab 2: Numbers & Displays
*Duncan Wood* <br>
*09/16/2025*



## Part I
Verilog code was written to display hexadecimal digits 0-9 on four 7-segment displays (HEX3-HEX0) based on switch inputs (SW0-3). The code used Boolean expressions to manually derive the logic for each segment.
<div align="center">
  <img src="img/digi_lab2_p1a.jpg" alt="FPGA Output 1" width="400"/><br>
  <em>Figure 1: Part 1 Verilog Code - Main Module.</em>
</div>
<div align="center">
  <img src="img/digi_lab2_p1b.jpg" alt="FPGA Output 2" width="600"/><br>
  <em>Figure 2: Part 1 Verilog Code - Main Module cont. .</em>
</div>



## Part II
Verilog code was written to convert a 4-bit binary number (0-15) into two decimal digits for display. The code includes a comparator to check if the value was greater than 9 and uses multiplexers to control the output.
<div align="center">
  <img src="img/digi_lab2_p2maina.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 3: Part 1 Verilog Code - 7 Segment Decoder Module.</em>
</div>
<div align="center">
  <img src="img/digi_lab2_p2mainb.jpg" alt="FPGA Output 1" width="400"/><br>
  <em>Figure 4: Part 1 Verilog Code - Main Module.</em>
</div>


[▶️ Watch the demo](digi_lab2.mp4)



## Part III
Verilog code was written to implement a 4-bit ripple-carry adder using four full-adder modules connected in series. The circuit was designed to add two 4-bit binary numbers with a carry-in and produce a sum and carry-out.
<div align="center">
  <img src="img/digi_lab2_p3main.jpg" alt="FPGA Output 1" width="500"/><br>
  <em>Figure 5: Part III Verilog Code - Main Module.</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p3FA.jpg" alt="FPGA Output 2" width="600"/><br>
  <em>Figure 6: Part III Verilog Code - Full Adder Module.</em>
</div>
<div align="center">
  <img src="img/digi_lab2_p3adder4a.jpg" alt="FPGA Output 1" width="300"/><br>
  <em>Figure 7: Part III Verilog Code - Adder Module.</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p3adder4b.jpg" alt="FPGA Output 2" width="200"/><br>
  <em>Figure 8: Part III Verilog Code - Adder Module cont..</em>
</div>


## Part IV
Verilog code was written to create a single-digit BCD (Binary Coded Decimal) adder that added two BCD digits (0-9) plus a carry-in to produce a two-digit BCD result. The code included error checking for invalid BCD inputs (values > 9)
<div align="center">
  <img src="img/digi_lab2_p4main.jpg" alt="FPGA Output 1" width="500"/><br>
  <em>Figure 9: Part IV Verilog Code - Main Module.</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p4main2.jpg" alt="FPGA Output 2" width="600"/><br>
  <em>Figure 10: Part 1V Verilog Code - Main Module Cont..</em>
</div>
<div align="center">
  <img src="img/digi_lab2_p4bcd1.jpg" alt="FPGA Output 1" width="500"/><br>
  <em>Figure 11: Part IV Verilog Code - BCD Module.</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p4bcd2.jpg" alt="FPGA Output 2" width="500"/><br>
  <em>Figure 12: Part 1V Verilog Code - BCD Module cont..</em>
</div>
<div align="center">
  <img src="img/digi_lab2_p4bcd3.jpg" alt="FPGA Output 2" width="200"/><br>
  <em>Figure 13: Part 1V Verilog Code - BCD Module cont..</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1360.jpg" alt="FPGA Output 1" width="400"/><br>
  <em>Figure 14: FPGA displaying output for test case A.</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1359.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 15: FPGA displaying output for test case B.</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1358.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 16: FPGA displaying output for test case C.</em>
</div>


## Part V
Verilog code was written to build a 2-digit BCD adder using two instances of the single-digit BCD adder from Part IV. The circuit was designed to add two 2-digit BCD numbers and produce a 3-digit BCD sum.
<div align="center">
  <img src="img/digi_lab2_p5a.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 17: .</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p5b.jpg" alt="FPGA Output 1" width="400"/><br>
  <em>Figure 18: .</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p5c.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 19:.</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p5d.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 20 .</em>
</div>
<div align="center">
  <img src="img/thumbnail_IMG_1361.jpg" alt="FPGA Output 1" width="400"/><br>
  <em>Figure 21: FPGA displaying output for test case A.</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1362.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 22: FPGA displaying output for test case B.</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1363.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 23: FPGA displaying output for test case C.</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1364.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 24: FPGA displaying output for test case C.</em>
</div>

## Part VI
Verilog code was written to redesign the 2-digit BCD adder using high-level Verilog constructs (if-else statements, comparison operators) instead of basic logic gates. This demonstrated algorithmic versus structural design approaches.
<div align="center">
  <img src="img/digi_lab2_p6main.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 25: .</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p6a.jpg" alt="FPGA Output 1" width="400"/><br>
  <em>Figure 26: .</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p6b.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 27:.</em>
</div>
<div align="center">
  <img src="img/thumbnail_IMG_1366.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 28: FPGA displaying output for test case A.</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1367.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 29: FPGA displaying output for test case B.</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1368.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 30: FPGA displaying output for test case C.</em>
</div>




## Part VII
Verilog code was written to create a 6-bit binary to 2-digit BCD converter that took a binary number (0-63) and displayed it as a decimal number on two 7-segment displays.
<div align="center">
  <img src="img/digi_lab2_p7main.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 31: .</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p7a.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 32: .</em>
</div>

<div align="center">
  <img src="img/digi_lab2_p7a.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 33: .</em>
</div>
<div align="center">
  <img src="img/thumbnail_IMG_1369.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 34: FPGA displaying output for test case A.</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1370.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 35: FPGA displaying output for test case B.</em>
</div>

<div align="center">
  <img src="img/thumbnail_IMG_1371.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 36: FPGA displaying output for test case C.</em>
</div>


