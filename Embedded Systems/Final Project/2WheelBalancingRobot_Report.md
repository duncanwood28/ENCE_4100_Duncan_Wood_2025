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


# Part 2: PCB Design

## 2.1 Schematic

## 2.2 Layout

## 2.3 3D View

# Part 3: Assembly

## 3.1 Assembled PCB

## 3.2 Assembled Robot

# Part 4: 3 Wheel Robot
For the first phase of troubleshooting the prototype, the test code was used to drive the robot with 3 wheels without having to balance it.

The remote control web application was used to control the robot and move it forward, left, right, and stop it when needed. Demos are shown below.

**ISSUE:** Motor B is only able to move forward at max speed, likely due to a wiring issue with the TB6612 driver. The physical motors were traded between the two plugs, and the one attached to "Motor B" still had the same issue, showing the motors themselves are fine. Motor A works great, so nothing is wrong with the MPU or its connection. Because Motor B only runs at full speed, Motor A's speed was changed to full speed to allow the robot to drive safe.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/3Wheel_Top.jpg" alt="3 Wheel Robot Top View" width="600">

**Figure: 3 Wheel Robot Top View**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/3Wheel_Forward.gif" alt="3 Wheel Robot Moving Forward" width="600">

 **Demo 1: 3 Wheel Robot Moving Forward**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/3Wheel_Right.gif" alt="3 Wheel Robot Moving Right" width="400">

 **Demo 2: 3 Wheel Robot Moving Right**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/3Wheel_Left.gif" alt="3 Wheel Robot Moving Left" width="400">

 **Demo 3: 3 Wheel Robot Moving Left**
 

# Part 5: 2 Wheel Balancing Robot

Ideally, creating the 2 Wheel Balancing Robot would involve driving the wheels using a PID control algorithm based on the IMU readings and the speed from the encoder. As mentioned before, Motor B only moves in the forward direction at high speed thus unable to be controled (speed and direction cannot change). Additionally, the encoder is attached to Motor B making it essentially useless to balance the robot. Because of these issues, the 2 wheel balancing system requires creative solutions.

## Strategy A: Motor B Fixed

As a starting point, a program was created to balance the robot with Motor B locked in place while Motor A is in motion.



## Strategy B: Forward Motion with Motor B Ticks




# Part 6: 2 Wheel Balancing Robot with Pendulum
