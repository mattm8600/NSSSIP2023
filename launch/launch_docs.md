# Launch File Documentation

## Rosbag Arguments
`savedata` - Option to run rosbag record on launch
- Default - False
`bag_prefix` - Prefix to bag name

## Computer.launch
Launches yolov5, the placement node, and the camera conversion node on the ground station.
- Has options for rosbags
*Example:* `roslaunch launch/Computer.launch`

*Arguments*:
`launch_placement` - Option to run perception team's placement node
- Default - True
`launch_camera` - Option to launch the camera
- Default - True
`weights` - What weights to run yolov5 with
- Stored in `/computer_pkg/yolo_models/Weights/`
- Supports `.pt` files
`data` - The classes yaml file to run yolov5 with
- Stored in `/computer_pkg/yolo_models/`
`input_topic` - Which image topic to run yolov5 on
- Default - the hires camera (`/hires`)
`confidence_threshold` - The confidence cutoff for yolo's detection
- Default - 0.5

## Drone.launch
Launches MAVROS, the drone control, the servo control, and the PID controller nodes on the drone.
- Has options for rosbags, MAVROS
*Example:* `roslaunch launch/drone.launch`

*Arguments:*
`fcu_url` - The flight controller URL
- Should be set to the IP of the drone
- Use port 14551 for QGroundControl and port 14540 for JMavSim
`gcs_url` - Ground Station URL
- We haven't gotten this to work, but you can directly connect to QGroundControl through MAVROS using this arg
`launch_servo_controller` - Option to launch the servo controller
- Default - True
`launch_PID_controller` - Option to launch the PID controller
- Default - True

## mavros.launch
Can be used to launch MAVROS individually and rosbag its data
*Example:* `roslaunch launch/mavros.launch`

*Arguments:*
`fcu_url` - The flight controller URL
- Should be set to the IP of the drone
- Use port 14551 for QGroundControl and port 14540 for JMavSim
`gcs_url` - Ground Station URL
- We haven't gotten this to work, but you can directly connect to QGroundControl through MAVROS using this arg

## perception.launch
Switches from hard coded location values to calculating them with `placement.py` as well as a GUI
*Example:* `roslaunch launch/perception.launch`

*Arguments:*
`perception_mode` - Option to hardcode or use perception team's node
- Mode 2 means use the perception node to calculate the target lat long
`aerial_file` - Storage location of the aerial picture
- Stored in `perception_pkg/images`
`dem_file` - Storage location of dem file
- Stored in `perception_pkg/images`

## go_to_point.launch
This launch files launches a GUI, a node that will go to any input local location, and MAVROS
*Example:* `roslaunch launch/go_to_point.launch`

*Parameters:*
`x_coord` - Default x coordinate before being sent a target location
`y_coord` - Default y coordinate before being sent a target location
`z_coord` - Default z coordinate before being sent a target location
- Default drone position is (0,0,2)

## circle.launch
Launches MAVROS and an offboard node that will fly in circles of different heights and radiuses around the origin
- No arguments, you can set up your heights and radiuses in the source code
- **TODO:** Add launch arguments for `circle.launch`

## sim_test.launch
Launches everything in `drone.launch` except it has the sim port number