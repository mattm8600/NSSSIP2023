# Quick Start Guide
This guide will show you how to get the drone placement and replacement up and running. See [system_architecture](https://github.com/mattm8600/NSSSIP2023/blob/main/docs/system_architecture.md) and [computer vision](https://github.com/mattm8600/NSSSIP2023/blob/main/docs/vision_docs.md) guides for more detailed looks at the individual systems (and how to run them individually)

## Physical Setup
1. Setup a 5Ghz router and connect your ground station and the drone to it
	- SoftAP doesn't work because the image feed interferes with the 2.4Ghz controller signal
	- If you do the classification onboard, you don't need the router
2. Place the sensor directly under the drone
	- The drone grabs the sensor initially on its own
1. Plug in the drone

## Launch Drone Package
1. In a new terminal SSH into the drone
```
ssh root@droneIP
(example: ssh root@192.168.1.153)
```
2. Setup your `ROS_IP` and `ROS_MASTER_URI` to match that of the drone
```
export ROS_IP=droneIP
export ROS_MASTER_URI=http://droneIP:11311
(example: export ROS_IP=192.168.1.153
	  export ROS_MASTER_URI=http://192.168.1.153:11311)
```
3. Go into the docker container
```
voxl-docker -i ubuntu18:nsssip
cd drone_ws
source devel/setup.bash
```
4. Launch the drone.launch file
```
roslaunch src/drone_pkg/launch/drone.launch"
```

**Note**: There is an active issue with VOXL drones where their cameras randomly stop publishing. Relaunching `voxl_mpa_to_ros` should fix the issue

### Launch Computer Package
1. In a new terminal setup your `ROS_IP` and `ROS_MASTER_URI`
```
export ROS_IP=computerIP
export ROS_MASTER_URI=http://droneIP:11311
(example: export ROS_IP=192.168.1.171
	  export ROS_MASTER_URI=http://192.168.1.153:11311)
**Note** If you will be doing this repeatedly you can set the export ROS_IP and ROS_MASTER_URI commands in scripts/router_start.sh. Then source it with "source scripts/router_start.sh"
```
2. Run the computer.launch file
```
cd NSSSIP2023
source devel/setup.bash
roslaunch launch/computer.launch
```

## Launch Voxl_mpa_to_ros
1. In a new terminal setup your `ROS_IP` and `ROS_MASTER_URI`
```
export ROS_IP=computerIP
export ROS_MASTER_URI=http://droneIP:11311
(example: export ROS_IP=192.168.1.171
	  export ROS_MASTER_URI=http://192.168.1.153:11311)
```
2. roslaunch voxl_mpa_to_ros voxl_mpa_to_ros

- If you are successful, you should see a window pop up with the downward pointing camera
**Note**: If the popup window with the camera view freezes it means that yolov5 is not running anymore, relaunch computer.launch and voxl_mpa_to_ros to fix this

## Additional Notes:
- There are launch arguments that allow you to rosbag several parts of the vision system
- There are other arguments that allow you to isolate certain systems (vision, perception, etc)


### Start Sensor Placement
1. In a new terminal source devel/setup.bash and scripts/router_start.sh or export ROS_ID and ROS_IP
```
source devel/setup.bash
&&
source scripts/router_start.sh
OR
export ROS_IP=computerIP
export ROS_MASTER_URI=http://droneIP:11311
```
2. Call the start drone op service with a 0
```
rosservice call /start_drone_op 0
```

### Start Sensor Retrieval
1. In a new terminal source devel/setup.bash and scripts/router_start.sh or export ROS_ID and ROS_IP
```
source devel/setup.bash
&&
source scripts/router_start.sh
OR
export ROS_IP=computerIP
export ROS_MASTER_URI=http://droneIP:11311
```
2. Call the start drone op service with a 1
```
rosservice call /start_drone_op 1
```
