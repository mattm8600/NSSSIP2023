This guide will show you how to get the drone placement and replacement up and running. See [placement architecture] and [computer vision] guides for more detailed looks at the individual systems (and how to run them individually)

## Physical Setup
1. Setup a 5Ghz router and connect your ground station and the drone to it
	- SoftAP doesn't work because the image feed interferes with the 2.4Ghz controller signal
	- If you do the classification onboard, you don't need the router
2. Place the sensor directly under the drone
	- The drone grabs the sensor initially on its own
1. Plug in the drone

## Drone Setup
1. Create a new catkin workspace and put only drone_pkg and computer_msgs on it
```
mkdir drone_ws
cp -r NSSSIP2023/ drone_ws/
rm -r build/ devel/ docs/ src/perception_pkg src/detection_msgs src/computer_pkg src/yolov5_ros
```
2. Cpnnect via Micro USB and ADB push it to the drone
```
adb push drone_ws/ /data
```
3. Go into the docker container and catkin_make
```
voxl-docker -i ubuntu18:nsssip
cd drone_ws
catkin_make
```

Drone Launch
COmputer Launch
mpa_to_ros
## Drone Run
1. Setup your `ROS_IP` and `ROS_MASTER_URI` in two terminals
2. In the first terminal run:
```
roslaunch voxl_mpa_to_ros voxl_mpa_to_ros
```
3. In the second terminal, go into the docker container, and run the drone.launch file
```
voxl-docker -i ubuntu18:nsssip
cd NSSSIP2023
source devel/setup.bash
roslaunch launch/drone.launch
```
**Note**: There is an active issue with VOXL drones where their cameras randomly stop publishing. Relaunching `voxl_mpa_to_ros` should fix the issue

### Computer Run
1. Setup your `ROS_IP` and `ROS_MASTER_URI`
2. Run the computer.launch file
```
cd NSSSIP2023
source devel/setup.bash
roslaunch launch/computer.launch
```
- If you are successful, you should see a window pop up with the downward pointing camera
**Note**: If the popup window with the camera view closes it means that yolov5 is not running anymore, relaunch the computer.launch to fix this

### TODO: What to run after everything is set up
## Additional Notes:
- There are launch arguments that allow you to rosbag several parts of the vision system
- There are other arguments that allow you to isolate certain systems (vision, perception, etc)