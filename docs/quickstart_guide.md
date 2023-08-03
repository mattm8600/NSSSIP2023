This guide will show you how to get the drone placement and replacement up and running. See [placement architecture] and [computer vision] guides for more detailed looks at the individual systems (and how to run them individually)

## Physical Setup
1. Setup a 5Ghz router and connect your ground station and the drone to it
	- SoftAP doesn't work because the image feed interferes with the 2.4Ghz controller signal
	- If you do the classification onboard, you don't need the router
2. Place the sensor directly under the drone
	- The drone grabs the sensor initially on its own
1. Plug in the drone

## Drone Setup
1. Push the nsssip docker container to the drone


2. Create a new catkin workspace and copy the drone_pkg into its src directory (or add package to existing workspace)
```
mkdir -p ~/drone_ws/src
cp -r NSSSIP2023/src/drone_pkg drone_ws/src
```
3. Connect to the drone via Micro USB and ADB push it to the drone
```
adb push drone_ws/ /data
```
3. Go into your docker container and catkin_make
```
voxl-docker -i ubuntu18:nsssip
cd drone_ws
catkin_make
```

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
*If you will be doing this repeatedly you can set the export ROS_IP and ROS_MASTER_URI commands in scripts/router_start.sh. Then source it with "source scripts/router_start.sh"
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
2. roslaunch voxl_mpa_to_ros voxl_mpa_to_ros

- If you are successful, you should see a window pop up with the downward pointing camera
**Note**: If the popup window with the camera view freezes it means that yolov5 is not running anymore, relaunch computer.launch and voxl_mpa_to_ros to fix this

### TODO: What to run after everything is set up
## Additional Notes:
- There are launch arguments that allow you to rosbag several parts of the vision system
- There are other arguments that allow you to isolate certain systems (vision, perception, etc)
