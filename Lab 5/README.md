# Lab 4: Subtractors and Multipliers
*Duncan Wood* <br>
*10/7/2025*

---
## Part I

<div align="center">
  <img src="img/advD_lab5_p1main.jpg" alt="Part I Main Verilog" width="300"/><br>
  <em>Figure 1: Part I Top-Level Verilog </em>
</div>
<br>
<div align="center">
  <img src="img/advD_lab5_acc8b.jpg" alt="Part I Accumulator Verilog" width="350"/><br>
  <em>Figure 2: 8-Bit Accumulator </em>
</div>
<br>

## Part II

<div align="center">
  <img src="img/advD_lab5_p2main.jpg" alt="Part I Main Verilog" width="350"/><br>
  <em>Figure 3: Part II Top-Level Verilog</em>
</div>
<br>
<div align="center">
  <img src="img/advD_lab5_accsub.jpg" alt="Part I Adder/Subtractor Verilog" width="550"/><br>
  <em>Figure 4: 8-Bit Accumulator - Add and Subtract </em>
</div>
<br>


## Part III
<div align="center">
  <img src="img/advD_lab5_p3main.jpg" alt="Part I Main Verilog" width="300"/><br>
  <em>Figure 6: Part III Top-Level Verilog </em>
</div>
<br>
<div align="center">
  <img src="img/advD_lab5_mult4x4a.jpg" alt="Part I Main Verilog" width="500"/><br>
  <em>Figure 6: 4 x 4 Multiplier </em>
</div>
<br>
<div align="center">
  <img src="img/advD_lab5_mult4x4b.jpg" alt="Part I Adder/Subtractor Verilog" width="300"/><br>
  <em>Figure 7: 4 x 4 Multiplier continued </em>
</div>
<br>
<div align="center">
  <img src="img/advD_lab5_mult4x4c.jpg" alt="Part I Adder/Subtractor Verilog" width="300"/><br>
  <em>Figure 8: 4 x 4 Multiplier continued </em>
</div>
<br>

## Part IV
<div align="center">
  <img src="img/advD_lab5_p4main1.jpg" alt="Part I Adder/Subtractor Verilog" width="400"/><br>
  <em>Figure 9: Part IV Top-Level Verilog </em>
</div>
<br>
<div align="center">
  <img src="img/advD_lab5_p4main2.jpg" alt="Part I Adder/Subtractor Verilog" width="300"/><br>
  <em>Figure 10: Part IV Top-Level Verilog continued </em>
</div>
<br>
<div align="center">
  <img src="img/advD_lab5_mult8x8a.jpg" alt="Part I Main Verilog" width="400"/><br>
  <em>Figure 11: 8 x 8 Multiplier </em>
</div>
<br>
<div align="center">
  <img src="img/advD_lab5_mult8x8b.jpg" alt="Part I Adder/Subtractor Verilog" width="300"/><br>
  <em>Figure 12: 8 x 8 Multiplier continued </em>
</div>

## Part V
A new 8x8 multiplier was created with the same functionality as Part IV but using the Adder Tree method instead of the Ripple-Carry method.
<div align="center">
  <img src="img/advD_adder_tree1.jpg" alt="Part I Adder/Subtractor Verilog" width="500"/><br>
  <em>Figure 13: Adder Tree </em>
</div>
The generate block creates a "loop" that instantiates multiple copies of identical logic, resulting in 8 partial product wires.
<br>
The block builds the partial product array without having to write out eight repetitive lines.
<div align="center">
  <img src="img/advD_adder_tree2.jpg" alt="Part I Adder/Subtractor Verilog" width="500"/><br>
  <em>Figure 14: Adder Tree Continued </em>
</div>
The parallel summations are created by structuring the given tree using defined wires.
