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
  <img src="img/ad_L7_main3.jpg" alt="Top-Level Module" width="400"/><br>
  <em>Figure 4: Top-Level Module </em>
</div>

## Asynchronous Receiver


## 7-Segment Decoder


## 5-Seconds Counter



## Word Detector FSM

<div align="center">
  <img src="img/hello_detector_1.jpg" alt="FSM" width="400"/><br>
  <em>Figure 3: Word Detector FSM </em>
</div>
<div align="center">
  <img src="img/hello_detector_2jpg.jpg" alt="FSM" width="400"/><br>
  <em>Figure 3: Word Detector FSM </em>
</div>
<div align="center">
  <img src="img/hello_detector_3jpg.jpg" alt="FSM" width="600"/><br>
  <em>Figure 3: Word Detector FSM </em>
</div>
<div align="center">
  <img src="img/hello_detector_4jpg.jpg" alt="FSM" width="300"/><br>
  <em>Figure 3: Word Detector FSM </em>
</div>


