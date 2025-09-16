# Lab 1: Intro To Verilog
*Duncan Wood* <br>
*09/10/2025*

---

## Part I
First, a Verilog code was written to create a simple circuit inside the FPGA that directly connects the 10 toggle switches to their respective LEDs. When one switch is turned on, so does the red LED above it.<br>
<div align="center">
  <img src="img/quartus_L1a.jpg" alt="Part I Verilog Code" width="300"/><br>
  <em>Figure 1: Part I Code.</em>
</div>

---

## Part II

### 2-to-1 Multiplexer
<div align="center">
  <img src="img/A2to1mux.jpg" alt="2-to-1 Multiplexer" width="300"/><br>
  <em>Figure 2: 2-to-1 Multiplexer.</em>
</div>
<br>
The code below implements a simple 2-to-1 multiplexer based on the diagram and truth table in figure 2 above.
<br>
<div align="center">
  <img src="img/quartus_L1b.jpg" alt="Part II Verilog Code" width="300"/><br>
  <em>Figure 3: Part II Main Code.</em>
</div>

<div align="center">
  <img src="img/quartus_L1b2.jpg" alt="Part II Verilog Code" width="300"/><br>
  <em>Figure 4: Part II 2-to-1 Multiplexer Code.</em>
</div>

### 8 Bit Wide 2-to-1 Multiplexer
<div align="center">
  <img src="img/An8bit2to1mux.jpg" alt="Part II Verilog Code" width="400"/><br>
  <em>Figure 5: 8 bit 2-to-1 Multiplexer </em>
</div>
<br>
To create an 8 bit mux, a series of the simple 2-to-1 muxes were connected together as shown in Figure 5 above. The Verilog code for this circuit is shown in figures 6 & 7 below.
<br>
<div align="center">
  <img src="img/quartus_L1b3.jpg" alt="Part II Verilog Code" width="400"/><br>
  <em>Figure 6: Part II Main Code.</em>
</div>
<br>
<div align="center">
  <img src="img/quartus_L1b4.jpg" alt="Part II Verilog Code" width="500"/><br>
  <em>Figure 7: Part II 8-bit Wide 2-to-1 Multiplexer Code.</em>
</div>

---

## Part III
The two figures below show the diagram and truth table for a 5-to-1 multiplexer
<div align="center">
  <img src="img/A5to1muxa.jpg" alt="3 Bit Multiplexer Main Code" width="200"/><br>
  <em>Figure 8: 5-to-1 Multiplexer Connection .</em>
</div>
<div align="center">
  <img src="img/A5to1muxb.jpg" alt="3 Bit Multiplexer Main Code" width="400"/><br>
  <em>Figure 9: 5-to-1 Multiplexer Table and Symbol.</em>
</div>
<br>

To create a 5-to-1 multiplexer, modules of the simple 2-to-1 multiplexers from Part II were connected as shown in Figure 8.

<div align="center">
  <img src="img/mux_5_1_3bita.jpg" alt="3 Bit 5-to-1 Multiplexer A" width="200"/>
  <img src="img/mux_5_1_3bitb.jpg" alt="3 Bit 5-to-1 Multiplexer B" width="200"/><br>
  <em>Figure 10: 3 Bit 5-to-1 Multiplexer Module.</em>
</div>

<div align="center">
  <img src="img/mux_5_1_3bit_main.jpg" alt="3 Bit Multiplexer Main Code" width="500"/><br>
  <em>Figure 11: Main Code Setup.</em>
</div>
Figures 10 shows the 5-to-1 multiplexer module code, and Figure 11 shows the module instantiated onto the main code.

---

## Part IV
<div align="center">
  <img src="img/A7segdecoder.jpg" alt="7-Segment Display Module" width="400"/><br>
  <em>Figure 12: 7 Segment Display Decoder Diagram.</em>
</div>
<div align="center">
  <img src="img/A7segdecoder_table.jpg" alt="7-Segment Display Module" width="200"/><br>
  <em>Figure 13: 7 Segment Display Decoder Truth Table.</em>
</div>
<br>

Verilog code was written for a decoder that converts 3 bit binary codes into control signals for a 7-segment display as shown in figure 12. It can display H,E,L,O, and blank, with each segment controlled by Boolean expressions.
<br>
Figures 14 and 15 show the verilog code for the 7-segment display decoder.
<br>


<div align="center">
  <img src="img/seg7_3bit.jpg" alt="7-Segment Display Module" width="800"/><br>
  <em>Figure 14: 7-Segment Display Module.</em>
</div>

<div align="center">
  <img src="img/seg7_3bit_main.jpg" alt="7-Segment Display Main Code" width="500"/><br>
  <em>Figure 15: Main Code Setup.</em>
</div>

---

## Part V
<div align="center">
  <img src="img/partVdisplay.jpg" alt="5-to-1 3 Bit Multiplexer" width="500"/><br>
  <em>Figure 16: 5-to-1 3-bit Input 7-Segment Decoder Diagram.</em>
</div>
<div align="center">
  <img src="img/partVdisplay_table.jpg" alt="5-to-1 3 Bit Multiplexer" width="300"/><br>
  <em>Figure 17: 5-to-1 3-bit Input 7-Segment Decoder Truth Table.</em>
</div>

The 5-to-1 multiplexer from Part III and the 7-segment decoder from Part IV were combined to create a circuit that can select and display "HELLO" at various positions. Demonstrates how character patterns can be rotated across five 7-segment displays based on the select switches. The Verilog code can be found in Figures 18-22.

<div align="center">
  <img src="img/mux_3bit_5to1.jpg" alt="5-to-1 3 Bit Multiplexer" width="500"/><br>
  <em>Figure 18: 5-to-1 3-bit Input Multiplexer.</em>
</div>
Figure 18 shows the Verilog code for the 5-to-1 Multiplexer Module used in the main code.
<div align="center">
  <img src="img/char_7seg.jpg" alt="3 Bit 7-Segment Decoder" width="400"/><br>
  <em>Figure 19: 3-bit Input 7-Segment Decoder.</em>
</div>
Figure 19 shows the Verilog code for the 7 segment display decoder module used in the main code.
<div align="center">
  <img src="img/part5_main_a.jpg" alt="Rotating HELLO Main Code A" width="500"/><br>
  <em>Figure 20: Rotating HELLO Main Code A.</em>
</div>

<div align="center">
  <img src="img/part5_main_b.jpg" alt="Rotating HELLO Main Code B" width="500"/><br>
  <em>Figure 21: Rotating HELLO Main Code B.</em>
</div>

<div align="center">
  <img src="img/part5_main_c.jpg" alt="Rotating HELLO Main Code C" width="600"/><br>
  <em>Figure 22: Rotating HELLO Main Code C.</em>
</div>

---

### FPGA Output<br>
Figures 23-27 show all the display outputs from each of the 3 bit code combinations from the Verilog model of Part V.
<div align="center">
  <img src="img/p5a.jpg" alt="FPGA Output 1" width="400"/><br>
  <em>Figure 23: FPGA Output 1.</em>
</div>

<div align="center">
  <img src="img/p5b.jpg" alt="FPGA Output 2" width="400"/><br>
  <em>Figure 24: FPGA Output 2.</em>
</div>

<div align="center">
  <img src="img/p5c.jpg" alt="FPGA Output 3" width="400"/><br>
  <em>Figure 25: FPGA Output 3.</em>
</div>

<div align="center">
  <img src="img/p5d.jpg" alt="FPGA Output 4" width="400"/><br>
  <em>Figure 26: FPGA Output 4.</em>
</div>

<div align="center">
  <img src="img/p5e.jpg" alt="FPGA Output 5" width="400"/><br>
  <em>Figure 27: FPGA Output 5.</em>
</div>

---

## Part VI
Part VI expands Part V to use all eight 7-segment displays on the FPGA board, creating s a system that can display 5-character words and rotate them across the displays, with blank characters filling unused positions. Shows advanced multiplexer interconnection patterns for creating scrolling text effects.
<br>
<div align="center">
  <img src="img/partVIdisplay_table.jpg" alt="Updated 8-to-1 Multiplexer" width="400"/><br>
  <em>Figure 28: Updated 8-to-1 3-bit Input Multiplexer.</em>
</div>
<br>
The truth table in figure 28 above shows the Boolean logic for each display position.
<br>
<div align="center">
  <img src="img/mux_3bit_5to1_updated.jpg" alt="Updated 8-to-1 Multiplexer" width="500"/><br>
  <em>Figure 29: Updated 8-to-1 3-bit Input Multiplexer.</em>
</div>

Using the 8-to-1 3 Bit Mux code from Part V was not fully successful.  
The first 3 input combinations worked, but the remaining only displayed "_HELLO" due to logic difficulties. Thus the 8-to-1 Multiplexer was written using a different method.
<br>
Figures 30-32 show the main Verilog code for Part VI
<br>

<div align="center">
  <img src="img/part6_main_a.jpg" alt="Part 6 Rotating HELLO Main Code A" width="500"/><br>
  <em>Figure 30: Part 6 Rotating HELLO Main Code A.</em>
</div>

<div align="center">
  <img src="img/part6_main_b.jpg" alt="Part 6 Rotating HELLO Main Code B" width="500"/><br>
  <em>Figure 31: Part 6 Rotating HELLO Main Code B.</em>
</div>

<div align="center">
  <img src="img/part6_main_c.jpg" alt="Part 6 Rotating HELLO Main Code C" width="600"/><br>
  <em>Figure 32: Part 6 Rotating HELLO Main Code C.</em>
</div>

---
### FPGA Output
Figures 33-40 show the FPGA output for each Boolean 3 bit code.
<div align="center">
  <img src="img/IMG_1345.jpg" alt="FPGA Output 1 P6" width="400"/><br>
  <em>Figure 33: FPGA Output 1 Part VI.</em>
</div>

<div align="center">
  <img src="img/IMG_1346.jpg" alt="FPGA Output 2 p6" width="400"/><br>
  <em>Figure 34: FPGA Output 2 Part VI.</em>
</div>

<div align="center">
  <img src="img/IMG_1347.jpg" alt="FPGA Output 3 P6" width="400"/><br>
  <em>Figure 35: FPGA Output 3 Part VI.</em>
</div>

<div align="center">
  <img src="img/IMG_1348.jpg" alt="FPGA Output 4 P6" width="400"/><br>
  <em>Figure 36: FPGA Output 4 Part VI.</em>
</div>

<div align="center">
  <img src="img/IMG_1349.jpg" alt="FPGA Output 5 P6" width="400"/><br>
  <em>Figure 37: FPGA Output 5 Part VI.</em>
</div>

<div align="center">
  <img src="img/IMG_1350.jpg" alt="FPGA Output 6 P6" width="400"/><br>
  <em>Figure 38: FPGA Output 6 Part VI.</em>
</div>

<div align="center">
  <img src="img/IMG_1351.jpg" alt="FPGA Output 7 P6" width="400"/><br>
  <em>Figure 39: FPGA Output 7 Part VI.</em>
</div>

<div align="center">
  <img src="img/IMG_1352.jpg" alt="FPGA Output 8 P6" width="400"/><br>
  <em>Figure 40: FPGA Output 8 Part VI.</em>
</div>

---
## Automatic 7-Segment Display Message
<div align="center">
  <img src="img/auto7seg_diagram.jpg" alt="FPGA Output 8 P6" width="500"/><br>
  <em>Figure 41:.</em>
</div>
A code was written to expand on Part VI by making the rotating display automatic without manually turning switches.
<div align="center">
  <img src="img/clk_divider.jpg" alt="FPGA Output 8 P6" width="500"/><br>
  <em>Figure 42: Clock Divider.</em>
</div>
Above is the Verilog module for the clock divider
<div align="center">
  <img src="img/scroll_counter.jpg" alt="FPGA Output 8 P6" width="500"/><br>
  <em>Figure 43: Counter.</em>
</div>
Above is the Verilog module for the counter. 
<div align="center">
  <img src="img/hello_scroller_auto_1.jpg" alt="FPGA Output 8 P6" width="500"/><br>
  <em>Figure 44: Automatic Rotating Display A.</em>
</div>
<div align="center">
  <img src="img/hello_scroller_auto_2.jpg" alt="FPGA Output 8 P6" width="400"/><br>
  <em>Figure 45: Automatic Rotating Display B.</em>
</div>
Figures 44 and 45 above show the Verilog module for the automatic rotating 7-segment display
<div align="center">
  <img src="img/hello_scroller_auto_main.jpg" alt="FPGA Output 8 P6" width="500"/><br>
  <em>Figure 46: Automatic Rotating Display Main Code.</em>
</div>

### FPGA Output Demo
<p align="center">
  <img src="img/FullSizeRender.gif" alt="Demo GIF" width="400"/><br>
  <em>Figure 47: FPGA Demo.</em>
</p>

