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
5. [Part 5: 2 Wheel Balancing Robot (program code review included)](#part-5-2-wheel-balancing-robot)
6. [Part 6: Conclusion and Future Work](#part-6-conclusion-and-future-work)

---
# Part 1: System Design

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_system1.png" alt="2 Wheel Schematic" width="600">

**Figure 1: System Block Diagram**

The robot was designed around an STM32 microcontroller acting as the central controller for sensing, communication, and motor control. An MPU6050 IMU was used to measure robot orientation, while a quadrature encoder provided wheel speed feedback. Motor control was implemented through a TB6612 motor driver, allowing bidirectional control of two DC motors. Power was supplied by a battery pack mounted directly to the chassis. The goal of the system was to create a self-balancing 2 wheel robot capable of maintaining an upright position using feedback control.

**Component Selection:**
- **STM32:** Microcontroller for embedded software
- **ESP-015:** Wifi module for remote control
- **MPU6050:** accelerometer + gyroscope for complimentary filter used for angle measurement.
- **TB6612:** Motor driver to control wheels.
- **Encoder:** Velocity feedback for balancing.
- **2 DC Motors:** Balancing torque for the wheels.


# Part 2: PCB Design

## 2.1 Schematic

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_schem.png" alt="2 Wheel Schematic" width="600">

**Figure 2: PCB Schematic**

The STM32 communicates with the IMU through the I2C connection. PWM outputs from the processor drive the motor driver to control motor speed and direction. Encoder outputs are connected to GPIO pins to allow accurate speed measurement. 

Decoupling capacitors and resistors were added around the voltage connections and power sources to mitigate damage from reverse connections and high voltage.

## 2.2 Layout

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_layout.png" alt="2 Wheel Layout" width="600">

**Figure 3: Layout**

Component placement was performed to minimize wiring complexity and reduce trace lengths between the components and bottom layer connections were minimized to avoid EMI. High-current motor traces were kept wider than signal traces to support motor loads. Connectors were positioned near the board edge to simplify assembly and maintenance. Switches and buttons were placed in open locations to allow user to reach them.

## 2.3 3D View

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_3D.png" alt="2 Wheel Schematic" width="600">

**Figure 4: PCB 3D View**

The 3D PCB view was used to verify component footprints and ensure compatibility with the robot chassis. Additional attention was given to module heights and connector accessibility to avoid interference with the battery pack and wheel assembly.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_3D2.png" alt="2 Wheel Schematic" width="600">

**Figure 5: PCB 3D Tilted View**


## 2.4 Printed Board

The PCB was successfully ordered, fabricated, and received from PCBWay.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Unsoldered_Top.jpg" alt="2 Wheel Schematic" width="500">

**Figure 6: Printed PCB Top View**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Unsoldered_Back.jpg" alt="2 Wheel Schematic" width="500">

**Figure 7: Printed PCB Back View**


# Part 3: Assembly

## 3.1 Assembled PCB

Assembly of the PCB was completed by soldering the passive components first, followed by connectors and larger modules. The drives were tested to check for damage or soldering defects.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Assembled_Top.jpg" alt="2 Wheel Schematic" width="500">

**Figure 8: Fully Soldered PCB**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Assembled_Modules.jpg" alt="2 Wheel Schematic" width="500">

**Figure 9: Fully Soldered PCB with Modules**\

Following assembly, basic electrical tests were conducted before applying full power. Power rails were verified using a multimeter, and communication with the IMU was confirmed through debug messages and an oscilloscope.

The IMU and Wifi modules were then added and sucessfully tested for any inefficiency.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/PCB_Assembled_Back.jpg" alt="2 Wheel Schematic" width="500">

**Figure 10: Fully Soldered PCB Back View**

## 3.2 Assembled Robot

The chassis was designed to be the platform of the 3 wheel robot with screw holes to fit the PCB, battery box, and wheel connections without any overlap. The battery pack was mounted at the front of the vehicle due to available mounting locations, although this placement shifted the center of mass forward. This decision later influenced balancing performance for the 2 wheel design.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_Assembled.jpg" alt="2 Wheel Schematic" width="600">

**Figure 11: Assembled 3 Wheel Robot**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_Assembled_Front.jpg" alt="2 Wheel Schematic" width="400">

**Figure 12: Assembled 3 Wheel Robot Front View**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_Assembled_Left.jpg" alt="2 Wheel Schematic" width="400">

**Figure 13: Assembled 3 Wheel Robot Left Side View**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_Assembled_Right.jpg" alt="2 Wheel Schematic" width="400">

**Figure 14: Assembled 3 Wheel Robot Right Side View**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_Assembled_Back.jpg" alt="2 Wheel Schematic" width="400">

**Figure 15: Assembled 3 Wheel Robot back View**

# Part 4: 3 Wheel Robot
For the first phase of troubleshooting the prototype, the test code was used to drive the robot with 3 wheels without having to balance it.

The remote control web application was used to control the robot and move it forward, left, right, and stop it when needed. Demos are shown below.

**ISSUE:** Motor B is only able to move forward at max speed, likely due to a wiring issue with the TB6612 driver. The physical motors were traded between the two plugs, and the one attached to "Motor B" still had the same issue, showing the motors themselves are fine. Motor A works great, so nothing is wrong with the MPU or its connection. Because Motor B only runs at full speed, Motor A's speed was changed to full speed to allow the robot to drive safe.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/3Wheel_Top.jpg" alt="3 Wheel Robot Top View" width="600">

**Figure 16: 3 Wheel Robot Top View**

The online remote control shown below was used to control the 3 Wheel robot.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/3_wheel_remote.png" alt="3 Wheel Robot Top View" width="400">

**Figure 17: Online Remote Control (IP 192.168.4.1)**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/3Wheel_Forward.gif" alt="3 Wheel Robot Moving Forward" width="600">

 **Demo 1: 3 Wheel Robot Moving Forward**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/3Wheel_Right.gif" alt="3 Wheel Robot Moving Right" width="400">

 **Demo 2: 3 Wheel Robot Moving Right**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/3Wheel_Left.gif" alt="3 Wheel Robot Moving Left" width="400">

 **Demo 3: 3 Wheel Robot Moving Left**
 

# Part 5: 2 Wheel Balancing Robot
<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_Side.png" alt="2 Wheel Schematic" width="400">

**Figure 18: Assembled 2 Wheel Robot**

Ideally, creating the 2 Wheel Balancing Robot would involve driving the wheels using a PID control algorithm based on the IMU readings and the speed from the encoder. As mentioned before, Motor B only moves in the forward direction at high speed thus unable to be controled (speed and direction cannot change). Additionally, the encoder is attached to Motor B making it essentially useless to balance the robot. Because of these issues, the 2 wheel balancing system requires creative solutions.

## 5.1 Strategy A: Motor B Fixed

As a starting point, a program was created to balance the robot with Motor B locked in place while Motor A is in motion. Program flowchart shown below.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_OptionA.png" alt="2 Wheel" width="600">

**Figure 19: Strategy A Flowchart**

The demo below shows the robot being tilted in the air by hand. It can be seen that the motor correctly responds based on the angle measured by the IMU: Speeds forward when it is tilted far backward, speeds backward when tilted far forward, and runs at lower speeds when tilted at lower angles in the proper direction.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/2wheelbalance.gif" alt="3 Wheel Robot Moving Forward" width="500">

**Demo 4: Handheld Balancing**

Then it was attempted on the table, demo shown below. It can be seen that although Motor A is attempting to balance it out, it obviously can't due to several reasons. It didn't help that the axel is off from the center of mass, but the main reason is that it is simply unable to be effective with only one active motor.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/2Wheel_OptionA.gif" alt="3 Wheel Robot Moving Forward" width="400">

**Demo 5: Attempted Floor Balance**

## 5.2 Strategy B: Forward Motion with Motor B Ticks

Next, effective balanced forward motion was attempted by adding "ticks" of motion from Motor B to asist Motor A in moving the robot forward. Program flowchart shown below.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2Wheel_OptionB.png" alt="2 Wheel" width="600">

**Figure 20: Strategy B Flowchart**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/2Wheel_BalanceHand.gif" alt="3 Wheel Robot Moving Forward" width="400">

**Demo 6: 2 Wheel Handheld Balance**

In Demo 6 it can be seen that Motor A (facing screen) is behaving the same way as it did in Demo 4: running forward when IMU is tilted back and running backward when IMU is tilted forward. In this program Motor B was added with a similar function to assist in balancing the robot. Because of Motor B's hardware issue, it only responds when the robot falls backward in which the motor moves forward (the only direction it can) to give the robot forward thrust. 

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/gif/2Wheel_Floor1.gif" alt="3 Wheel Robot Moving Forward" width="400">

**Demo 7: 2 Wheel Balance Attempt**

In Demo 7 the robot is seen attempting to balance. It starts with the back tipped down and thus both motors move forward with the goal of giving the robot forward thrust to balance. The motors do give the robot thrust, but it fully tips forward triggering Motor A to reverse at full speed and Motor B to brake causing the robot to oscillate in circles. There are three clear issues causing the robot's inefficiencies:

- **Center of mass:** Using the 3 Wheel chassis puts the axle far off from the center of mass. The heaviest component, the battery set, is at the front of the vehicle on the edge of the axle making it hard to balance with 2 wheels.

- **PID Calibration:** The PID control parameters could be calibrated for better response time and error correction.
- **Motor B:** Once again, the hardware problems with Motor B is not helping: it can only go in one direction at one speed. Because of this the 2 motors in the 2 wheel system cannot be controlled symmetrically, making long-term balancing impossible.

For now, the problems with Motor B and the COM cannot be changed. Further PID calibration was attempted but robot purformance was not improved.

## 5.3 Program Code Review

**NOTE:** The program given in class was used as a template for the code.

### 5.3.1 Software Scheduler

Rather than using a real-time operating system, the main code implements a time-based scheduler using HAL_GetTick(), which returns the system uptime in milliseconds driven by the SysTick interrupt. Each task stores its own last_X_tick timestamp and executes only when the elapsed time since the last run meets or exceeds its target interval. The three scheduled tasks are the LED heartbeat (100 ms), the IMU update (10 ms), and the telemetry transmission (100 ms), with the PID control loop also running at 10 ms. Since all intervals are checked independently at each iteration, a task running slightly late does not delay other tasks.

### 5.3.2 Motor Setup
Both motors are driven by a TB6612 driver, controlled through TIM2 in PWM mode. TIM2 is configured with a prescaler of 83 (84−1) and a period of 99 (100−1), giving a PWM frequency of 10 kHz on an 84 MHz clock. Motor A uses TIM2 Channel 2 and Motor B uses TIM2 Channel 1. Each motor struct stores its direction control pins (IN1, IN2), PWM timer handle, and an offset value of −1 and +1 respectively, which accounts for the physical mirroring of the two motors on opposite sides of the chassis so that a positive drive command produces forward motion on both. Both motors are braked immediately after initialisation, ensuring the robot is stationary before the balance loop begins.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_motor.png" alt="3 Wheel Robot Moving Forward" width="300">

**Figure 21: Motor Control Setup**



### 5.3.3 Telemetry

Every 100 ms, four state variables are packed into a formatted ASCII string and transmitted over UART1 at 115200 baud using interrupt-driven transmission (HAL_UART_Transmit_IT), which returns immediately without blocking the scheduler. The figure below shows the packet format, where speed is the wheel velocity in degrees per second from the MT6701 encoder, roll is the lateral tilt angle from the complementary filter, pitch is the tilt angle used by the PID, and counter is a rolling integer from 0–19 used to verify packet continuity at the receiving end.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_telemetry1.png" alt="3 Wheel Robot Moving Forward" width="400">

**Figure 22: Telemetry Code Part 1**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_telemetry2.png" alt="3 Wheel Robot Moving Forward" width="400">

**Figure 23: Telemetry Code Part 2**

### 5.3.4 UART Commands
Single-byte ASCII commands are received over UART1 using interrupt-driven reception (HAL_UART_Receive_IT), which fires HAL_UART_RxCpltCallback on each received byte. The callback stores the byte in gUART_Cmd and immediately re-arms the receiver for the next byte. In the main code, gUART_Cmd is checked each iteration and processed through a switch statement supporting five commands: w (forward), s (backward), a (turn left), d (turn right), and x (stop/brake). Each command also updates the RGB LED color to provide a visual indication of the current drive state. gUART_Cmd is cleared to zero after processing to prevent the same command from repeating on subsequent loop iterations. A separate HAL_UART_ErrorCallback re-arms reception in the event of a UART overrun error, ensuring the command channel never silently stops responding.

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_cmd1.png" alt="3 Wheel Robot Moving Forward" width="300">

**Figure 24: UART Commands Code Part 1**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_cmd2.png" alt="3 Wheel Robot Moving Forward" width="300">

**Figure 25: UART Commands Code Part 2**

### 5.3.5 Magnetic Encoder

The magnetic encoder is connected over I2C3 and provides wheel position and velocity data. It is initialised with MT6701_Init and its zero reference is set at startup with MT6701_SetZero. The encoder is updated at 10 Hz inside HAL_TIM_PeriodElapsedCallback, triggered by TIM3 which is configured with a prescaler of 8399 (8400−1) and a period of 999 (1000−1), yielding a 10 Hz interrupt on the 84 MHz clock. The MT6701_Update function computes the angular velocity velocity_deg_s which is included in the telemetry stream and is available for future closed-loop speed control.

### 5.3.6 PID Controller
<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_PID3.png" alt="3 Wheel Robot Moving Forward" width="300">

**Figure 26: PID Controller Parameters/Global Variables**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_PID1.png" alt="3 Wheel Robot Moving Forward" width="400">

**Figure 27: PID Controller Code Part 1**

<img src="https://github.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/blob/main/Embedded%20Systems/Final%20Project/images/2wheel_PID2.png" alt="3 Wheel Robot Moving Forward" width="400">

**Figure 28: PID Controller Code Part 2**

The control loop executes every 10 ms, synchronised with the IMU update rate. Each iteration begins by reading the current pitch angle from the complementary filter (gCompFilter.pitch), which combines the data of the accelerometer and gyroscope to produce a stable angle estimate in degrees.

If the pitch exceeds PID_THRESHOLD, the robot is considered to have fallen. Both motors are braked and the PID internal state is reset, clearing pid_integral and pid_prev_error, so that accumulated history does not cause a jolt when the robot is stopped and restarted.

When the robot is within the recoverable range, the PID output is computed:

**Error** is the difference between the target angle (PID_SETPOINT) and the measured pitch. A positive error means the robot is leaning backward and the negative means forward.

**Proportional term** (KP x error) produces an output directly proportional to how far the robot is from the balanced point. Increasing KP makes corrections more aggressive but risks oscillation, decreasing it makes the robot sluggish and more likely to fall.

**Integral term** (KI x accumuated error x dt) corrects for persistent steady-state lean caused by physical asymmetrues such as an off-center mass. Variable pid_integral accumulates over time and is reset on a fall to prevent windup.Too high a value of KI causes slow-growing oscillation.

**Derivative Term** (KD x rate of change of error) acts as a damper, opposing rapid changes in pitch. It predicts where the robot is heading and attempts to counteract it. Too high a value amplifies sensor noise and causes jitter.

The three terms are summed and clamped to the range [−100, +100], which maps directly to the motor driver's duty cycle scale.

Motor A receives the full proportional output. Motor B, constrained to forward-only full-speed operation, is engaged via a hysteresis mechanism: it activates when output exceeds B_ENGAGE_THRESHOLD and only deactivates once output drops below B_DISENGAGE_THRESHOLD. This prevents rapid switching and tries to work around the faults of Motor B to help Motor A in the balancing.



# Part 6: Conclusion and Future Work

## Future Work

If the project were to be continued then the first step would be to troubleshoot the soldered PCB, particularly around the motor driver to diagnose what the issue is with Motor B. As mentioned earlier, since Motor A works fine there is no issue with the IMU and it is more than likely to be something on the Motor B side of the driver such as inefficient soldering on the drive pins or damage on the drive itself affecting Motor B. So an oscillascope would be used to do continuity tests on the pins connected to Motor B to check for soldering issues, otherwise solder in a new driver.

Next, a new chassis and overall robot body would be designed to give symmetric weight to the robot and make it easier to balance between the two wheels. One of the keys to this would be placing the battery box in the middle of the chassis by creating a shield to go over the PCB and place the batteries which would prevent the front or back of the robot from being overwhelmed with mass.

Both of these changes would eliminate the hardware issues currently hindering an effective 2 wheel balancing robot.

## Conclusion

This project demonstrated the complete development process of an embedded robotic system, including system design, PCB development, hardware assembly, software implementation, and system testing. A custom PCB was successfully designed, manufactured, assembled, and integrated into a mobile robotic platform using an STM32F407 microcontroller, MPU6050 IMU, TB6612 motor driver, ESP 15 Wifi module, and wheel encoder.

Testing confirmed that the sensing, wireless communication, and motor control subsystems operated as intended. The robot was successfully driven using a web-based remote control interface, and balancing control algorithms were implemented and evaluated using real-time IMU feedback. Multiple balancing strategies were developed and tested to compensate for hardware limitations encountered during development.

Although stable long-term balancing was not achieved, the testing process identified the primary factors limiting performance. A fault affecting Motor B prevented symmetric motor control, while the chassis geometry placed the center of mass away from the wheel axle, making balancing significantly more difficult. Despite these limitations, the control software demonstrated the expected response to changes in robot orientation and validated the overall control approach.

Overall, the project achieved its primary objective of designing and implementing a functional embedded robotic platform while providing valuable experience in PCB design, sensor integration, motor control, wireless communication, troubleshooting, and closed-loop control systems. The lessons learned throughout development establish a strong foundation for future improvements that could ultimately result in a fully self-balancing robot.



