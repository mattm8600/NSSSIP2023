# NSSSIP2023
This repository contains the Autonomy and Perception Team's work from the National Security Scholars Summer Internship 2023. We designed an autonomous system for autonomous sensor placement and replacement. Here are each team's abstracts:

## Perception Team Abstract:
The Aerial Autonomy team developed a system to autonomously place, relocate, and retrieve unattended ground sensors. The project was broken into two main subgroups, including a Perception team and a Mechanical/Autonomy team. The perception tackled two separate problems, the first of which was where to place the sensor. We utilized aerial and LiDar data to develop a decision making algorithm. Our end goal is to properly identify locations of interest within a set radius from the drone. We focused on locations nearby road networks and narrowed down the placement spots via image analysis techniques. The second problem that we faced was how the drone was going to identify and locate the sensor on the ground. We collected and labeled aerial imagery from the drone as well as created synthetic data using Unity Game Engine to train a Yolov5 model for object detection. The classifier was then converted to a TensorFlow Lite model that is capable of running onboard the drone in real-time.

## Autonomy Team Abstract:
The Aerial Autonomy team developed a system to autonomously place, relocate, and retrieve unattended ground sensors. The project was broken into two main subgroups, including a Perception team and a Mechanical/Autonomy team. The principle challenge for the Autonomy team was to autonomously land on the ground sensor, and design a mechanism to pick it up. Initially, we used april tags and a PD controller to detect the sensor and minimize landing error. Although this worked well in simulation, its reliability and accuracy was limited by the size of the april tag, which could not exceed the size of the sensor box. Our next approach integrated the sensor classification from the Perception team to determine the relative position of the sensor using computer vision. From there we could utilize the PD controller we previously developed to center the drone above the sensor. Additionally, to accommodate a variety of lighting conditions, an IR camera was added to the drone to detect an IR beacon on the sensor. If computer vision is unable to detect the sensor, the IR camera provides an alternative landing approach. Both approaches could be used in a GPS-Denied environment, assuming line of sight to the sensor.

## Further Documentation
- [Vision System](https://github.com/mattm8600/NSSSIP2023/tree/main/docs/vision_docs.md)
- [IR Lock](https://github.com/mattm8600/NSSSIP2023/tree/main/docs/irlock_docs.md)
- [Sensor Pickup/Placement Architecture](https://github.com/mattm8600/NSSSIP2023/tree/main/placement_architecture.md)
- [Using yolov5](https://github.com/mattm8600/NSSSIP2023/tree/main/docs/yolov5_docs.md)
## Installation 
0. Prerequisites
	- Install NVIDIA Drivers to run pytorch
	- Install [ROS Noetic](http://wiki.ros.org/noetic/Installation/Ubuntu)
	- Install [MAVROS](https://docs.px4.io/main/en/ros/mavros_installation.html)
1. Clone our repository and setup the git sub-modules
```
git clone https://github.com/mattm8600/NSSSIP2023
cd NSSSIP2023
git submodule init
git submodule update
```
2. Install [Pytorch](https://pytorch.org/get-started/locally/)
3. Install the pip requirements
```
pip install -r requirements.txt
```
4. Download [Eigen 3.4.0 C++](https://eigen.tuxfamily.org/index.php?title=3.4)
	- Run the following for the workspace to recognize the library:
```
cd ~/usr/include
sudo ln -sf eigen3/Eigen Eigen
sudo ln -sf eigen3/unsupported unsupported
```

# TO DO
- Label which code we wrote, which code other people wrote
- Make the RQT Graph
- Make a file describing our process in detail
- ACTUALLY COMMENT OUR CODE
- Describe each launch file
- Link docs to each of the packages and the src
- Add reference