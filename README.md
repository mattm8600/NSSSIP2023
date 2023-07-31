# NSSSIP2023

# TO DO
- Finish the README.md
- Make the RQT Graph
- Make a file describing our process in detail
- ACTUALLY COMMENT OUR CODE
- Describe each launch file



This repository contains the Autonomy and Perception Team's work from the National Security Scholars Summer Internship 2023. We designed an autonomous system for autonomous sensor placement and replacement. Here are each team's abstracts:

## Perception Team Abstract:
The Aerial Autonomy team developed a system to autonomously place, relocate, and retrieve unattended ground sensors. The project was broken into two main subgroups, including a Perception team and a Mechanical/Autonomy team. The perception tackled two separate problems, the first of which was where to place the sensor. We utilized aerial and LiDar data to develop a decision making algorithm. Our end goal is to properly identify locations of interest within a set radius from the drone. We focused on locations nearby road networks and narrowed down the placement spots via image analysis techniques. The second problem that we faced was how the drone was going to identify and locate the sensor on the ground. We collected and labeled aerial imagery from the drone as well as created synthetic data using Unity Game Engine to train a Yolov5 model for object detection. The classifier was then converted to a TensorFlow Lite model that is capable of running onboard the drone in real-time.

## Autonomy Team Abstract:
The Aerial Autonomy team developed a system to autonomously place, relocate, and retrieve unattended ground sensors. The project was broken into two main subgroups, including a Perception team and a Mechanical/Autonomy team. The principle challenge for the Autonomy team was to autonomously land on the ground sensor, and design a mechanism to pick it up. Initially, we used april tags and a PD controller to detect the sensor and minimize landing error. Although this worked well in simulation, its reliability and accuracy was limited by the size of the april tag, which could not exceed the size of the sensor box. Our next approach integrated the sensor classification from the Perception team to determine the relative position of the sensor using computer vision. From there we could utilize the PD controller we previously developed to center the drone above the sensor. Additionally, to accommodate a variety of lighting conditions, an IR camera was added to the drone to detect an IR beacon on the sensor. If computer vision is unable to detect the sensor, the IR camera provides an alternative landing approach. Both approaches could be used in a GPS-Denied environment, assuming line of sight to the sensor.

## Installation
- Add requirements.txt file
- Git clone the repo
- Setup the submodules
- Other things that are required (PX4, etc)

## How to run stuff
- Launch files and what they do

## RQT Graph

