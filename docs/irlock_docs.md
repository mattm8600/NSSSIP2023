# Precision Landing with IR Lock
As a possible method for precision landing we experimented with the IR-LOCK approach. This approach uses an IR camera which we mounted to our drone via I2C and an IR beacon which we attached to our sensor box. With the IR camera registered on the drone, PX4 is able to localize the relative position of the IR beacon to the drone. By switching the drone’s flight mode to precision landing, if the drone detects the beacon, it should be able to autonomously land on top of it.

## IR Lock Setup
Note: for us IR-LOCK precision landing was only compatible with PX4 firmware version 1.12.3
1. Connect the IR-LOCK camera to the drone via I2C. Refer to this [webpage](https://irlock.readme.io/docs/4-connect-sensor-to-copter-pixhawk-1) for the pinout of the I/O port on the camera. Connect the 5V, SCL, SDA, and GND to the VOXL Flight, refer to this [webpage](https://docs.modalai.com/voxl-flight-datasheet-connectors/#j1011---i2c2-safety-button-input) (J1012) for their respective connections. If the lidar is already connected to I2C then solder the wires from the connections from the I/O port of the camera to their respective wire connections on the lidar. 

2. Install the PixyMon software, refer to the installation documentation [here](https://docs.pixycam.com/wiki/doku.php?id=wiki:v2:installing_pixymon_on_linux)

3. Connect the IR camera to your computer via USB, launch PixyMon, and you should be able to connect to your device and view the output of the IR camera.
   
4. If you click the steak icon in the top left corner, it should display the raw video, and if you click Action and default program it should display the video with bounding box detection.    
5. Power the IR beacon and check that it is visible in the PixyMon output video, then slightly twist the lens so that the beacon is slightly out of focus. This gives the IR camera maximum range of detection.

6. Click File, Configure, Interface, then set Data out port to I2C, keep note of what I2C address it is set to.
   
7. Open QGroundControl, click Analyze Tools (click Q icon in top left corner), Mavlink Console, and type in the command i2cdetect -b 2. This should show the I2C devices connected on bus 2 and whatever I2C address that was set on PixyMon should pop up after running this command. If this doesn’t work unplug and replug in the I2C connection and retry the command. If this doesn’t work try bus 1, 3, and 4. If this doesn’t work then there must be some faulty wiring connection.
   
8. Once the address shows up in the I2C bus then run the command irlock start -X -b 2 (or whatever bus number the address showed up on) on Mavlink Console. This should output a confirmation saying that the irlock has started. You will need to run the detect and start command everytime you set the drone up for irlock precision landing.
   
9. To set up the parameters for precision landing, in QGroundControl click the Q icon, click vehicle setup, and parameters. Set the parameter SENS_EN_IRLOCK to 1, this will enable the IR-LOCK sensor. Other useful parameters to set are PLD_HACC_RAD, PLD_BTOUT, PLD_FAPPR_ALT, and PLD_MAX_SRCH. Setting these parameters will allow you to customize how the precision landing is done.
   
10. To see if the irlock can see and localize the beacon, go to Mavlink Console and run the command listener irlock_report. This should output the x and y distance the drone is from the beacon and the timestamp it was seen at. 
   
11. To test out the IR-LOCK, fly the drone 2 meters above the powered beacon, switch to precision landing flight mode in QGroundControl and observe precision landing. *Warning: If the beacon is not seen, the drone may exhibit odd behavior, so be prepared to take control very quickly.

## Results
When we tested precision landing using the IR-LOCK system we found that the behavior was not consistent and overall an unreliable method for precision landing. Over the course of multiple tests, the IR-LOCK landing only worked a couple of times but still only got as close as 5 inches to the IR beacon. Majority of the tests the drone would be unable to find the beacon even within its 60 foot marketed detection range. We found the detection range to be at about 5 meters, but even with the beacon in range, the drone’s flight response was sometimes unpredictable, with the drone shooting up to the top of the net or quickly veering off to the side. Even when the precision landing was successful, being within 5 inches from the beacon wasn’t enough to successfully execute a sensor pick up. Although the reason for this behavior could have been user error, we found that as we weren’t running any of our code and instead using PX4’s built in precision landing flight mode, it would be hard to debug and overall not a viable solution for our sensor pickup and replacement task.