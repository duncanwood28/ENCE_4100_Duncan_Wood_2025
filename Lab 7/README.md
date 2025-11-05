# Lab 7: Word Detector with UART
*Duncan Wood* <br>
*10/20/2025*


## Table of Contents
- [Objective](#Objective)
- [Top-Level Module](#Top-LevelModule)
- [Asynchronous Transmitter](#AsychronousTransmitter)
- [Asynchronous Receiver](#AsychronousReceiver)
- [7-Segment Decoder](#7-SegmentDecoder)
- [5-Second Counter](#5-SecondCounter)
- [Word Detector FSM](#WordDetectorFSM)
- [Demonstration](#Demonstration)


## Objective
The objective of this lab was to develop a Verilog design that enables character transmission from a PC to an FPGA board via UART communication. The FPGA receives and interprets the incoming characters, and when the sequence "HELLO" is detected, it displays the word on the on-board 7-segment displays. In essence, characters entered through a serial terminal on the PC are sent over a UART connection to the FPGA, which continuously monitors the input stream and triggers the 7-segment display output when the word "HELLO" is typed.
<br>
<br>

## Top-Level Module
<div align="center">
  <img src="img/ad_L7_main1.jpg" alt="Top-Level Module" width="400"/><br>
  <em>Figure 1: Top-Level Module </em>
</div>

<div align="center">
  <img src="img/ad_L7_main2.jpg" alt="Top-Level Module" width="400"/><br>
  <em>Figure 2: Top-Level Module </em>
</div>

<div align="center">
  <img src="img/ad_L7_main3.jpg" alt="Top-Level Module" width="400"/><br>
  <em>Figure 3: Top-Level Module </em>
</div>

## Asynchronous Transmitter

<div align="center">
  <img src="img/async_transmitter1.jpg" alt="Asynchronous Transmitter Module" width="900"/><br>
  <em>Figure 4: Asynchronous Transmitter Module </em>
</div>

<div align="center">
  <img src="img/async_transmitter2.jpg" alt="Asynchronous Transmitter Module" width="600"/><br>
  <em>Figure 5: Asynchronous Transmitter Module </em>
</div>

<div align="center">
  <img src="img/async_transmitter3.jpg" alt="Asynchronous Transmitter Module" width="600"/><br>
  <em>Figure 6: Asynchronous Transmitter Module </em>
</div>

<div align="center">
  <img src="img/async_transmitter_rtl.jpg" alt="Asynchronous Transmitter Module" width="600"/><br>
  <em>Figure 7: Asynchronous Transmitter RTL </em>
</div>

## Asynchronous Receiver

<div align="center">
  <img src="img/async_receiver1.jpg" alt="Asynchronous Receiver Module" width="900"/><br>
  <em>Figure 8: Asynchronous Receiver Module </em>
</div>

<div align="center">
  <img src="img/async_receiver2.jpg" alt="Asynchronous Receiver Module" width="900"/><br>
  <em>Figure 9: Asynchronous Receiver Module </em>
</div>
<div align="center">
  <img src="img/async_receiver3.jpg" alt="Asynchronous Receiver Module" width="800"/><br>
  <em>Figure 10: Asynchronous Receiver Module </em>
</div>
<div align="center">
  <img src="img/async_receiver4.jpg" alt="Asynchronous Receiver Module" width="800"/><br>
  <em>Figure 11: Asynchronous Receiver Module </em>
</div>
<div align="center">
  <img src="img/async_receiver5.jpg" alt="Asynchronous Receiver Module" width="900"/><br>
  <em>Figure 12: Asynchronous Receiver Module </em>
</div>
<div align="center">
  <img src="img/async_receiver_rtl.jpg" alt="Asynchronous Receiver Module" width="900"/><br>
  <em>Figure 13: Asynchronous Receiver RTL </em>
</div>

## 7-Segment Decoder
<div align="center">
  <img src="img/L7_7seg1.jpg" alt="7-Segment" width="600"/><br>
  <em>Figure 14: 7-Segment Decoder </em>
</div>
<div align="center">
  <img src="img/L7_7seg2.jpg" alt="7-Segment" width="300"/><br>
  <em>Figure 15: 7-Segment Decoder </em>
</div>
<div align="center">
  <img src="img/L7_7seg_rtl2.jpg" alt="7-Segment" width="300"/><br>
  <em>Figure 16: 7-Segment Decoder RTL </em>
</div>


## 5-Seconds Counter



## Word Detector FSM

<div align="center">
  <img src="img/hello_detector_1.jpg" alt="FSM" width="400"/><br>
  <em>Figure 17: Word Detector FSM </em>
</div>
<div align="center">
  <img src="img/hello_detector_2jpg.jpg" alt="FSM" width="400"/><br>
  <em>Figure 18: Word Detector FSM </em>
</div>
<div align="center">
  <img src="img/hello_detector_3jpg.jpg" alt="FSM" width="600"/><br>
  <em>Figure 19: Word Detector FSM </em>
</div>
<div align="center">
  <img src="img/hello_detector_4jpg.jpg" alt="FSM" width="300"/><br>
  <em>Figure 20: Word Detector FSM </em>
</div>
<div align="center">
  <img src="img/hello_fsm_rtl.jpg" alt="FSM" width="700"/><br>
  <em>Figure 21: Word Detector FSM RTL </em>
</div>
<div align="center">
  <img src="img/hello_fsm_fsm.jpg" alt="FSM" width="700"/><br>
  <em>Figure 22: Word Detector FSM </em>
</div>

## Demonstration
![DEMO](img/realterm_hello.gif)
![DEMO](img/hello_board.gif)
<br>
Videos are not in sync with each other



