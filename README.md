# NSSSIP2023
This repository contains the Autonomy and Perception Team's work from the National Security Scholars Summer Internship 2023. We designed an autonomous system for autonomous sensor placement and replacement. 

### Capabilities:
- Vision Based Precision Landing
- Custom Trained yolov5 classifier
- Flying in circles around a target
- Fly drone to any point via GUIs

## Autonomy Team Abstract:
The Aerial Autonomy team developed a system to autonomously place, relocate, and retrieve unattended ground sensors. The project was broken into two main subgroups, including a Perception team and a Mechanical/Autonomy team. The principle challenge for the Autonomy team was to autonomously land on the ground sensor, and design a mechanism to pick it up. Initially, we used april tags and a PD controller to detect the sensor and minimize landing error. Although this worked well in simulation, its reliability and accuracy was limited by the size of the april tag, which could not exceed the size of the sensor box. Our next approach integrated the sensor classification from the Perception team to determine the relative position of the sensor using computer vision. From there we could utilize the PD controller we previously developed to center the drone above the sensor. Additionally, to accommodate a variety of lighting conditions, an IR camera was added to the drone to detect an IR beacon on the sensor. If computer vision is unable to detect the sensor, the IR camera provides an alternative landing approach. Both approaches could be used in a GPS-Denied environment, assuming line of sight to the sensor.

## Perception Team Abstract:
The Aerial Autonomy team developed a system to autonomously place, relocate, and retrieve unattended ground sensors. The project was broken into two main subgroups, including a Perception team and a Mechanical/Autonomy team. The perception tackled two separate problems, the first of which was where to place the sensor. We utilized aerial and LiDar data to develop a decision making algorithm. Our end goal is to properly identify locations of interest within a set radius from the drone. We focused on locations nearby road networks and narrowed down the placement spots via image analysis techniques. The second problem that we faced was how the drone was going to identify and locate the sensor on the ground. We collected and labeled aerial imagery from the drone as well as created synthetic data using Unity Game Engine to train a Yolov5 model for object detection. The classifier was then converted to a TensorFlow Lite model that is capable of running onboard the drone in real-time.

## Documentation
- [Autonomy Quickstart Guide](https://github.com/mattm8600/NSSSIP2023/tree/main/docs/quickstart_guide.md)
- [Perception Team Readme](https://github.com/mattm8600/NSSSIP2023/tree/main/src/perception_pkg)
- [Vision System](https://github.com/mattm8600/NSSSIP2023/tree/main/docs/vision_docs.md)
- [IR Lock](https://github.com/mattm8600/NSSSIP2023/tree/main/docs/irlock_docs.md)
- [System Architecture](https://github.com/mattm8600/NSSSIP2023/tree/main/system_architecture.md)
- [Using yolov5](https://github.com/mattm8600/NSSSIP2023/tree/main/src/perception_pkg/src/perception_yolo/readme.md)
- [Launch File Docs](https://github.com/mattm8600/NSSSIP2023/tree/main/launch/launch_docs.md)
- [Drone Modifications](https://github.com/mattm8600/NSSSIP2023/tree/main/parts)
- [Teensy System](https://github.com/mattm8600/NSSSIP2023/tree/main/teensy_servo_control/README.md)

## Installation 

### Computer Setup
0. Prerequisites
	- Install NVIDIA Drivers to run Pytorch
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
5. Install *GDAL*
```
sudo apt update
sudo apt install gdal-bin libgdal-dev
```

### Drone Setup
0. **TODO:** Add how to setup a docker container (melodic or noetic ROS 1)
1. Create a new catkin workspace and copy the drone_pkg into its src directory (or add package to existing workspace)
```
mkdir -p ~/drone_ws/src
cp -r NSSSIP2023/src/drone_pkg drone_ws/src
```
2. Connect to the drone via Micro USB and ADB push it to the drone
```
adb push drone_ws/ /data
```
3. Go into your docker container and catkin_make
```
voxl-docker -i ubuntu18:nsssip
cd drone_ws
catkin_make
```

**Note:** The only thing required on the drone is [drone_pkg](https://github.com/mattm8600/NSSSIP2023/tree/main/src/drone_pkg), feel free to use whatever catkin workspace or ROS melodic/Noetic docker container you wish

## Autonomy RQT Graph
![RQT Graph](https://github.com/mattm8600/NSSSIP2023/blob/main/docs/pics/rqt_graph.png)

## Perception Algorithm Flow Chart
![Perception Algorithm](https://github.com/mattm8600/NSSSIP2023/blob/main/docs/pics/perception_flowchart.png)
## References
- [detection_msgs](https://github.com/mats-robotics/detection_msgs/tree/6c251ef4eaf4d712722b72923c96a96f1cbea6e8)
- [yolov5_ros](https://github.com/mattm8600/NSSSIP2023/tree/main/src/yolov5_ros/src)
