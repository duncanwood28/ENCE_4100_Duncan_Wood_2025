# Lab 4: Counters
*Duncan Wood* <br>
*09/29/2025*

---
## Part I
First a 1 bit T flip flop was created

<div align="center">
  <img src="img/tflipflop_1bit.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 1: 1 Bit T Flip Flop.</em>
</div>
<br>
Next, an 8-bit flip flop was created
<div align="center">
  <img src="img/tflipflop_8bit.jpg" alt="Part I Verilog Code" width="500"/><br>
  <em>Figure 2: 8 Bit T Flip Flop.</em>
</div>
<br>
Then the 8 bit flip flop module was instantiated into the top-level code and connected to 2 7-segment displays
<div align="center">
  <img src="img/advD_l4_p1_main.jpg" alt="Part I Verilog Code" width="500"/><br>
  <em>Figure 3: T Flip Flop Counter Top-Level Code.</em>
</div>
<br>

### RTL View
<div align="center">
  <img src="img/rtl_L4_p1_main.jpg" alt="Part I Verilog Code" width="600"/><br>
  <em>Figure 4: Top-Level RTL View.</em>
</div>
<br>
<div align="center">
  <img src="img/rtl_tflipflop.jpg" alt="Part I Verilog Code" width="500"/><br>
  <em>Figure 5: T Flip Flop Counter RTL View.</em>
</div>
<br>


## Part II
A 16 bit counter was created
<div align="center">
  <img src="img/counter_16bit.jpg" alt="Part I Verilog Code" width="300"/><br>
  <em>Figure 6: 16 Bit Counter Module.</em>
</div>
<br>
Next a shift register was created using the 16 bit counter module on the main code with 2 7-segment displays connected.
<div align="center">
  <img src="img/advD_l4_p2_main.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 7: Part II Top-level Code.</em>
</div>
<br>


## Part III
A ciruit with the same functionality as Part II was created using an LPM from the Library of Parameterized modules to implement a 16-bit counter.
<div align="center">
  <img src="img/advD_l4_p3_main.jpg" alt="Part I Verilog Code" width="500"/><br>
  <em>Figure 8: Part III Top-level Code.</em>
</div>
No noticeable differences were seen in the performance of this code compared to that of Part II.

## Part IV
a verilog code was created that blinks digits 0-9 on HEX0 7-segment display in 1 second intervals, resetting and continuing in loops.
<div align="center">
  <img src="img/advD_lab4_p4a.jpg" alt="Part I Verilog Code" width="600"/><br>
  <em>Figure 9: e.</em>
</div>
<div align="center">
  <img src="img/advD_lab4_p4b.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 10: e.</em>
</div>
<p align="center">
  <img src="img/advD_lab4_4a.gif" alt="Demo GIF" width="400"/><br>
  <em>Figure 11:.</em>
</p>
<p align="center">
  <img src="img/advD_lab4_4b.gif" alt="Demo GIF" width="400"/><br>
  <em>Figure 12:.</em>
</p>


## Part V
<div align="center">
  <img src="img/advD_lab4_p5a.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 13: .</em>
</div>
<div align="center">
  <img src="img/advD_lab4_pba.jpg" alt="Part I Verilog Code" width="500"/><br>
  <em>Figure 14: .</em>
</div>
<div align="center">
  <img src="img/advD_lab4_pc.jpg" alt="Part I Verilog Code" width="300"/><br>
  <em>Figure 15: .</em>
</div>
<div align="center">
  <img src="img/advD_lab4_pd.jpg" alt="Part I Verilog Code" width="300"/><br>
  <em>Figure 16: .</em>
</div>
<div align="center">
  <img src="img/advD_lab4_pe.jpg" alt="Part I Verilog Code" width="300"/><br>
  <em>Figure 17: .</em>
</div>
<div align="center">
  <img src="img/advD_lab4_pf.jpg" alt="Part I Verilog Code" width="300"/><br>
  <em>Figure 18: .</em>
</div>
<p align="center">
  <img src="img/IMG_1395.gif" alt="Demo GIF" width="400"/><br>
  <em>Figure 19:.</em>
</p>
