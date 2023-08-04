# Computer Vision Pickup System

Outline:
- Introduction
- Capabilities
- Yolov5 Detection
- Camera Localization
- PD Controller
- Assumptions

## Introduction
The CV Pickup is the solution we designed for precision landing. From our testing, GPS and IR Lock were not precise enough for the 2" tolerance to land on the sensor box. Our solution detected the sensor box using yolov5, calculated the relative position of the sensor to the drone, and then used a PD controller to send the correct velocity to center it. Our system is capable of achieving 3" precision consistently and 1.5" in the best conditions (low crosswinds, low glare on the camera). Lastly, we pick it up with the bear claw system.

![Vision Flowchart](https://github.com/mattm8600/NSSSIP2023/blob/main/docs/pics/vision_flowchart.png)

## Yolov5 detection
We use yolov5 to detect our sensor box. We collected and labeled approximately 5000 images which we used to retrain the model. We include two different sets of weights `sensor_detectv1` and `sensor_detectv3`
- Only has the `sensor` class
- Runs on the ground station (can be configured to run on the drone quite easily)
- `sensor_detectv1` is better in all lighting conditions, can detect the sensor consistently to 2 m, but has a lot of false positives
- `sensor_detectv3` has almost no false positives, can detect the sensor to 3 m, but only works in good lighting conditions
- When yolov5 is launched with the Ground Station, it shows the classification real time

## Camera Localization
When the sensor is detected, it sends the confidence and the bounding box coordinates to the camera localization node. The node uses the camera intrinsics matrix and a camera to body frame transformation to calculate the relative position of the sensor to the drone. The node sends a pose stamped geometry message to the PD controller.
- If the detection confidence is under the threshold (set by ros param), the node sends a negative z height to convey the sensor isn't detected
- The node is subscribed to `/tflite_data`, so you can plug in the onboard VOXL tflite server
- Uses the ModalAi `AiDetection` msg type
- Sends (1,1,-1) before the drone detects the sensor (msg initializes with 0,0,-1 otherwise, PD controller tries to land immediately)
- Assumes that $\lambda$ is equal to the drones z pose (from `/mavros/local_posion/pose`)

## PD Controller provides constant clamping force on the sensor while flying
The PD controller takes the relative position of the sensor and outputs the corresponding velocity to center the drone over the sensor. It tries to center itself over the drone until 1 m, and then it hovers. Next, the drone adjusts itself with higher gains until the height is .4 m. Once that height is reached the drone initiates landing.
- Velocity commands are inactive until the drone sees the sensor
- Drone lands very quickly to decrease prop wash effects while falling

## Bear Trap System
After landing, our bear trap system closes with the servo. If the sensor is there, we picked it up. Yay! Otherwise, the trap closes fully and an electric circuit is completed. When there is current across those two pins of the teensy, we know we missed the sensor and restart the PD controller sequence.
- Can hold a payload of approximately 1kg
- Provides constant clamping force on the sensor while flying
- Servo can be manually controlled with the /servo_command topic with a 0 to open the sensor and a 1 to close the sensor
