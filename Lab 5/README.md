# Lab 4: Subtractors and Multipliers
*Duncan Wood* <br>
*10/7/2025*

---
## Part I
For Part I an 8-bit accumulator was created.
<div align="center">
  <img src="img/advD_lab5_acc8b.jpg" alt="Part I Accumulator Verilog" width="350"/><br>
  <em>Figure 1: 8-Bit Accumulator </em>
</div>
<br>
On each rising clock edge, the accumulator adds the new input value to the stored sum, updates the result registers, and retains the overflow flag until the next reset.

<div align="center">
  <img src="img/advD_lab5_p1main.jpg" alt="Part I Main Verilog" width="300"/><br>
  <em>Figure 2: Part I Top-Level Verilog </em>
</div>

Each time the clock button is pressed, the accumulator adds the switch value to its running total. The result is displayed both in binary (on LEDs) and in decimal form (on the seven-segment displays).

## Part II
An 8 bit accumulator was created capable of both adding and subtracting
<div align="center">
  <img src="img/advD_lab5_accsub.jpg" alt="Part I Adder/Subtractor Verilog" width="550"/><br>
  <em>Figure 4: 8-Bit Accumulator - Add and Subtract </em>
</div>
This module can add or subtract the input value from the stored total on each clock pulse.
<br>
<div align="center">
  <img src="img/advD_lab5_p2main.jpg" alt="Part I Main Verilog" width="350"/><br>
  <em>Figure 3: Part II Top-Level Verilog</em>
</div>
The top-level module performs 8-bit addition or subtraction using switch inputs and displays the result on LEDs and 7-segment displays. It sends the switch input to the accumulator module, which updates the result each clock cycle. The output is converted from binary to BCD for display on three 7-segment digits.

## Part III
For Part II a 4x4 multiplier was created.
<div align="center">
  <img src="img/advD_lab5_p3main.jpg" alt="Part I Main Verilog" width="300"/><br>
  <em>Figure 6: Part III Top-Level Verilog </em>
</div>
The multiplier verilog module was created using partial products and a chain of full adders. It forms partial product rows by ANDing bits of the inputs, then sums them using full adders.
<br>
<br>
The top-level module multiplies two 4-bit numbers entered through switches and displays the 8-bit product on LEDs and 7-segment displays. It uses the multiplier_4x4 module to compute the result, converts the binary output to BCD, and shows the decimal value across three HEX displays
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
For the 8x8 multiplier module, each bit of the second operand generates a partial product, which are then added sequentially using adders to form the product.
<br>
<br>
The top-level module multiplies an 8-bit input from switches by a fixed value of 100 using the multiplier_8x8 module and displays the 16-bit product on LEDs and five 7-segment displays. Input values are stored in registers to synchronize with the clock, and the product is stored in a 16-bit register before conversion to BCD for display.
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
