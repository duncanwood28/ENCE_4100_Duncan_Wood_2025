# 2 Wheel Balancing Robot 
---
**Course:** ENCE 4231 Embedded Systems Programming

**Student:** Duncan Wood  
**Date:** June 4, 2026  
 

---
## Table of Contents

1. [Part 1: System Design](#part-1-system-design)
2. [Part 2: PCB Design](#part-2-pcb-design)
3. [Part 3: Assembly](#part-3-assembly)
4. [Part 4: 3 Wheel Robot](#part-4-3-wheel-robot)
5. [Part 5: 2 Wheel Balancing Robot](#part-5-2-wheel-balancing-robot)
6. [Part 6: 2 Wheel Balancing Robot with Pendulum](#part-6-2-wheel-balancing-robot-with-pendulum)

---
# Part 1: System Design

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_system1.png" alt="2 Wheel Schematic" width="600">


# Part 2: PCB Design

## 2.1 Schematic

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_schem.png" alt="2 Wheel Schematic" width="600">

**Figure: PCB Schematic**

## 2.2 Layout

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_layout.png" alt="2 Wheel Layout" width="600">

**Figure: Layout**

## 2.3 3D View

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_3D.png" alt="2 Wheel Schematic" width="600">

**Figure: PCB 3D View**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_3D2.png" alt="2 Wheel Schematic" width="600">

**Figure: PCB 3D Tilted View**

## 2.4 Printed Board

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Unsoldered_Top.jpg" alt="2 Wheel Schematic" width="500">

**Figure: Printed PCB Top View**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Unsoldered_Back.jpg" alt="2 Wheel Schematic" width="500">

**Figure: Printed PCB Back View**


# Part 3: Assembly

## 3.1 Assembled PCB

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Assembled_Top.jpg" alt="2 Wheel Schematic" width="500">

**Figure: Fully Soldered PCB**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Assembled_Modules.jpg" alt="2 Wheel Schematic" width="500">

**Figure: Fully Soldered PCB with Modules**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Assembled_Back.jpg" alt="2 Wheel Schematic" width="500">

**Figure: Fully Soldered PCB Back View**

## 3.2 Assembled Robot

# Part 4: 3 Wheel Robot
For the first phase of troubleshooting the prototype, the test code was used to drive the robot with 3 wheels without having to balance it.

The remote control web application was used to control the robot and move it forward, left, right, and stop it when needed. Demos are shown below.

**ISSUE:** Motor B is only able to move forward at max speed, likely due to a wiring issue with the TB6612 driver. The physical motors were traded between the two plugs, and the one attached to "Motor B" still had the same issue, showing the motors themselves are fine. Motor A works great, so nothing is wrong with the MPU or its connection. Because Motor B only runs at full speed, Motor A's speed was changed to full speed to allow the robot to drive safe.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/3Wheel_Top.jpg" alt="3 Wheel Robot Top View" width="600">

**Figure: 3 Wheel Robot Top View**

The online remote control shown below was used to control the 3 Wheel robot.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/3_wheel_remote.png" alt="3 Wheel Robot Top View" width="400">

**Figure: Online Remote Control (IP 192.168.4.1)**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/3Wheel_Forward.gif" alt="3 Wheel Robot Moving Forward" width="600">

 **Demo 1: 3 Wheel Robot Moving Forward**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/3Wheel_Right.gif" alt="3 Wheel Robot Moving Right" width="400">

 **Demo 2: 3 Wheel Robot Moving Right**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/3Wheel_Left.gif" alt="3 Wheel Robot Moving Left" width="400">

 **Demo 3: 3 Wheel Robot Moving Left**
 

# Part 5: 2 Wheel Balancing Robot
<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_Side.png" alt="2 Wheel Schematic" width="400">

**Figure: Assembled 2 Wheel Robot**

Ideally, creating the 2 Wheel Balancing Robot would involve driving the wheels using a PID control algorithm based on the IMU readings and the speed from the encoder. As mentioned before, Motor B only moves in the forward direction at high speed thus unable to be controled (speed and direction cannot change). Additionally, the encoder is attached to Motor B making it essentially useless to balance the robot. Because of these issues, the 2 wheel balancing system requires creative solutions.

## Strategy A: Motor B Fixed

As a starting point, a program was created to balance the robot with Motor B locked in place while Motor A is in motion. Program flowchart shown below.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_OptionA.png" alt="2 Wheel" width="600">

**Figure: Strategy A Flowchart**

The demo below shows the robot being tilted in the air by hand. It can be seen that the motor correctly responds based on the angle measured by the IMU: Speeds forward when it is tilted far backward, speeds backward when tilted far forward, and runs at lower speeds when tilted at lower angles in the proper direction.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/2wheelbalance.gif" alt="3 Wheel Robot Moving Forward" width="500">

**Demo 4: Handheld Balancing**

Then it was attempted on the table, demo shown below. It can be seen that although Motor A is attempting to balance it out, it obviously can't due to several reasons. It didn't help that the axel is off from the center of mass, but the main reason is that it is simply unable to be effective with only one active motor.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/2Wheel_OptionA.gif" alt="3 Wheel Robot Moving Forward" width="400">

**Demo 5: Attempted Floor Balance**

## Strategy B: Forward Motion with Motor B Ticks

Next, effective balanced forward motion was attempted by adding "ticks" of motion from Motor B to asist Motor A in moving the robot forward. Program flowchart shown below.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_OptionB.png" alt="2 Wheel" width="600">

**Figure : Strategy B Flowchart**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/2Wheel_BalanceHand.gif" alt="3 Wheel Robot Moving Forward" width="400">

**Demo 6: 2 Wheel Handheld Balance**

In Demo 6 it can be seen that Motor A (facing screen) is behaving the same way as it did in Demo 4: running forward when IMU is tilted back and running backward when IMU is tilted forward. In this program Motor B was added with a similar function to assist in balancing the robot. Because of Motor B's hardware issue, it only responds when the robot falls backward in which the motor moves forward (the only direction it can) to give the robot forward thrust. 

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/2Wheel_Floor1.gif" alt="3 Wheel Robot Moving Forward" width="400">

**Demo 7: 2 Wheel Balance Attempt**

In Demo 7 the robot is seen attempting to balance. It starts with the back tipped down and thus both motors move forward with the goal of giving the robot forward thrust to balance. The motors do give the robot thrust, but it fully tips forward triggering Motor A to reverse at full speed and Motor B to brake causing the robot to oscillate in circles. There are three clear issues causing the robot's inefficiencies:

- **Center of mass:** Using the 3 Wheel chassis puts the axle far off from the center of mass. The heaviest component, the battery set, is at the front of the vehicle on the edge of the axle making it hard to balance with 2 wheels.

- **PID Calibration:** The PID control parameters could be calibrated for better response time and error correction.
- **Motor B:** Once again, the hardware problems with Motor B is not helping: it can only go in one direction at one speed. Because of this the 2 motors in the 2 wheel system cannot be controlled symmetrically, making long-term balancing impossible.

For now, the problems with Motor B and the COM cannot be changed. Further PID calibration was attempted.

