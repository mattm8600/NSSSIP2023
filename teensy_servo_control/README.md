
Written by Jonathan Kampia

///////////////////////////////////////////////

Teensy 3.2 PINOUT: 

PIN 1: Servo signal pin
PIN 2: Bear trap / claw continuity read pin

Other 2 connections are GND

//////////////////////////////////////////////

How it works:

If there is serial data available (drone has sent signal) teensy reads in 0 or 1 integer and actuates servo accordingly (command 1 -> close beartrap, 0 -> open beartrap)
In every iteration of main loop, teensy will check for the position of the bear trap. If the leads on the beartrap are connected (pin 2 is connected to GND) pin 2 will read 0, hence digitalRead(2). Each iteration, this result is published back to python ROS node via serial. 

The logic behind checking for continuity on the beartrap is: if digitalRead(2) returns 1 (HIGH), the beartrap is not closed after the servo attempted to move to the closed position -> there must be something in the jaws. If it reads 0 (LOW), it was able to close completely, and thus there is nothing in it. 

The 'locked' and 'unlocked' positions (servo angles) are declared as global const int, and can be changed depending on the orientation / nature of the servo motor. 



