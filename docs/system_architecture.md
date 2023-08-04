The system diagram shows the connections between the various nodes and packages with solid lines represting topics and dotted lines representing services. The white nodes are run on the drone and the grey nodes are run on the computer. The light grey nodes are part of the computer package and the dark grey node is in the perception package
![system_diagram](https://github.com/mattm8600/NSSSIP2023/blob/main/docs/pics/system_diagram.png)

## How it works
### Placement
1. Ground Station
From here you can use the /start_drone_op service with a value of 0 to start a placement operation
2. Drone Offboard Node
Once the offboard node recieves a call to start a placment or retrieval operation it first checks if the drone is already in operation. If not, it will then call the /find_spot server in the placement node with the current global position of the drone.
3. Placement Node
Once the placement node recieves a call on the find_spot service it will either return hard coded random values if the perception_mode was set to 0 on launch or return the percieved optimal sensor location if the perception_mode was set to 1 on launch.
4. Drone Offboard Node
When the offboard node recieves the response from the find_spot service it will arm the drone, takeoff to its cruising height, and then fly to the target location. Once it gets within 0.5 meters of the target destination it will hover briefly, lower to 0.3 meters, release the sensor, mark its location in an array, and then return home.

### Retrieval
1. Ground Station
From the ground station you can call for a sensor retrieval on the /start_drone_op server with a value of 1
2. Drone Offboard Node
The offboard node will first check if the drone is busy and if there are any sensors available for retrieval. It will then parse through all placed sensor locations to find the closest sensor to target. From there it will fly to the sensor and check if the sensor has been detected before relinquishing control to the PID Controller Node
*Specifics on sensor detection and localization can be seen in the [Vision Docs](https://github.com/mattm8600/NSSSIP2023/blob/main/docs/vision_docs.md)
3. PID Controller Node
The PID controller will utilize the detect and camera convert nodes, which classify the sensor and localize the error between the sensor and the camera. It then sends body frame velocity commands to the drone to minimize this error, thereby centering the drone above the sensor. Once the drone is below 0.4m height and 0.1m of error in each direction it will quikcly land and send control back to the offboard node
4. Drone Offboard Node
When control is returned to the Drone Offboard Node it will close the gripper mechanism, re-arm the drone, takeoff to its search height, and then check if the gripper mechanism closed all the way. Electrical contacts on the arms of the gripper can detect if the arms close all the way or if the sensor is wedged imbetween. IF the drone succesfully picked up the sensor it will return home. If not, it will return control to the PID Controller Node and attempt another pickup.
