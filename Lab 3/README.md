# Lab 3: Latches, Flip Flops, and Registers
*Duncan Wood* <br>
*09/22/2025*

---

## Part I - Gated SR Latch
A gated sr latch was implemented in verilog code as shown in figures 1 and 2 below. Figure 1 shows the module code for the sr latch and figure 2 shows the sr latch instantiated inside the top-level main code.
<div align="center">
  <img src="img/rs_latch.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 1: RS Latch Module.</em>
</div>
<br>
<div align="center">
  <img src="img/rs_latch_main.jpg" alt="Part I Verilog Code" width="300"/><br>
  <em>Figure 2: Part I Main.</em>
</div>

### RTL Layout
Figure 3 shows the RTL layout of the sr latch.
<div align="center">
  <img src="img/rs_latch_rtl.jpg" alt="Part I RTL Layout" width="600"/><br>
  <em>Figure 3: RS Latch RTL Layout.</em>
</div>

## Part II - Gated D Latch
Figure 4 shows the verilog module code for the gated D latch.
<div align="center">
  <img src="img/d_latch.jpg" alt="Part II Verilog Code" width="400"/><br>
  <em>Figure 4: D Latch Module.</em>
</div>
<br>
Figure 5 shows the D latch module instantiated into the top-level main code.
<div align="center">
  <img src="img/d_latch_main.jpg" alt="Part II Verilog Code" width="400"/><br>
  <em>Figure 5: Part II Main.</em>
</div>

### RTL Layout
Figure 6 shows the RTL layout for the D latch
<div align="center">
  <img src="img/d_latch_rtl.jpg" alt="Part I Verilog Code" width="600"/><br>
  <em>Figure 6: D Latch RTL Layout.</em>
</div>



## Part III - Positive Edge Triggered D Flip Flop
Figure 7 below shows the verilog module code for the d flip flop.
<div align="center">
  <img src="img/d_flipflop.jpg" alt="Part II Verilog Code" width="200"/><br>
  <em>Figure 7: D Flip Flop Module.</em>
</div>
<br>
Figure 8 shows the d flip flop integrated into the top-level main code.
<div align="center">
  <img src="img/d_flipflop_main.jpg" alt="Part II Verilog Code" width="300"/><br>
  <em>Figure 8: Part III Main.</em>
</div>

### RTL Layout
The figure below shows the RTL layout for the gated d flip flop.
<div align="center">
  <img src="img/d_flipflop_rtl.jpg" alt="Part I Verilog Code" width="600"/><br>
  <em>Figure 9: D Flip Flop RTL Layount</em>
</div>

## Part IV
Figure 10 shows the verilog code for part IV, connecting a D latch, positive edge D flip flop, and a negative edge flip flop. To create the negative edge flip flop from the original positive edge, the cases for negating the clock were flipped.
<div align="center">
  <img src="img/advD_L3_p4_main.jpg" alt="Part IV Verilog Code" width="400"/><br>
  <em>Figure 10: Part IV Verilog Code Main.</em>
</div>

### RTL Layout
Figure 11 below shows the RTL design for Part IV.
<div align="center">
  <img src="img/l3_p4_rtl.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 11: RTL Layout.</em>
</div>

## Part V
Figures 12 to 15 show the verilog code module for Part V to create a 16 bit hexidecimal display capable of storing the most recent number.
<div align="center">
  <img src="img/hex_storage_display_a.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 12: Module .</em>
</div>
<div align="center">
  <img src="img/hex_storage_display_b.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 13: Module .</em>
  <div align="center">
  <img src="img/hex_storage_display_c.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 14: Module .</em>
</div>
  <div align="center">
  <img src="img/hex_storage_display_d.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 15: Module .</em>
</div>  
  Figure 16 below shows the verilog module instantiated into the top-level main code.
  <div align="center">
  <img src="img/hex_storage_display_main.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 16: Main .</em>


  ### RTL Layout
  Figure 17 shows the outer view of the RTL layout.
  <div align="center">
  <img src="img/l3_p5a_rtl.jpg" alt="Part I Verilog Code" width="600"/><br>
  <em>Figure 17: RTL Layout .</em>
</div>
Figure 18 shows the internal RTL layout.
  <div align="center">
  <img src="img/l3_p5b_rtl.jpg" alt="Part I Verilog Code" width="400"/><br>
  <em>Figure 18: RTL Layout .</em>
</div>

### Demos
[▶️ Watch the demo](img/IMG_1382.mp4)
