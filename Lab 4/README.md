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


## Part V

