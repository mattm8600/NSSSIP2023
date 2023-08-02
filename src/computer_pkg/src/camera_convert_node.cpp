#include <ros/ros.h>
#include <mavros_msgs/PositionTarget.h>
#include <geometry_msgs/PoseStamped.h>
#include <computer_msgs/AiDetection.h>
#include <std_msgs/String.h>
#include <iostream>
#include <Eigen/Dense>

/*
This node was written by the NSSSIP interns. The node takes in bounding
boxes from the yolov5 classifier and calculates the distance from the
drone to the sensor. Then it sends the X-Y-Z vector to the PD Controller.

Node Name: camera_convert_node
Topics Subscribed: 
- /tflite_data (published by the yolov5 detect.py or by the drone's on-board classifier)
- /mavros/local_position/pose (Published by MAVROS)
Topics Published:
- /bb_camera_vector (The distance from the drone body to the sensor)

Parameters:
- sensor_height
- intrinsics_matrix -> Camera Intrinsics Matrix (from ROS Camera Calibration)
- cam_to_body_tfm -> Transformation matrix from the camera to the drone body
*/



geometry_msgs::PoseStamped bb_vector;
geometry_msgs::PoseStamped current_pose;
int getting_pose = 0;
computer_msgs::AiDetection tflite_data;
int getting_tflite = 0;
int detected_flag = 0;

float threshold = 0;



// Input the height of the sensor here
float sensor_height = 0.028;

// Gets the pose from MAVROS
void pose_callback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
    current_pose = *msg;
    getting_pose = 1;
}

// Gets the bounding box information from yolo
void tflite_callback(const computer_msgs::AiDetection::ConstPtr& msg) {
    tflite_data = *msg;
    getting_tflite = 1;

    // tflite_data sends messages with a class confidence of 0 if
    // nothing is detected. Here we filter out these messages
    if(tflite_data.class_confidence > 0) {
        detected_flag = 1;
    }
    else {
        detected_flag = 0;
    }
}

int main(int argc, char **argv) {
ROS_INFO("WE HAVE LAUNCHOFF");
/* Input the camera intrinsics matrix here

| kuf | 0   | u_0 | 0 |
| 0   | kvf | v_0 | 0 |
| 0   | 0   | 1   | 0 |
| 0   | 0   | 0   | 1 |

*/

Eigen::Matrix4f intrinsics_matrix;
intrinsics_matrix << 281.938264, 0, 323.052198, 0, 0, 281.901123, 237.072802, 0, 0, 0, 1, 0, 0, 0, 0, 1;


// Input the transformation from the camera frame to the body frame here
Eigen::Matrix4f cam_to_body_tfm;
cam_to_body_tfm << 0, 1, 0, 0.08, 1, 0, 0, -0.015, 0, 0, 1, -0.008, 0, 0, 0, 1;

ros::init(argc, argv, "camera_conversion_node");
ros::NodeHandle nh;

// Declare publishers/Subscribers
ros::Publisher vector_pub = nh.advertise<geometry_msgs::PoseStamped>("bb_camera_vector", 100);
ros::Subscriber pose_sub = nh.subscribe<geometry_msgs::PoseStamped>("mavros/local_position/pose", 100, pose_callback);
ros::Subscriber tflite_sub = nh.subscribe<computer_msgs::AiDetection>("tflite_data", 100, tflite_callback);
ros::Rate loop_rate(10.0);

// Get the detection threshold parameter
assert(nh.getParam("/detect/confidence_threshold", threshold));

while (ros::ok())
{

    // Wait for the first pose to be published
    if(getting_pose == 0) {
         ros::spinOnce();
         loop_rate.sleep();
     }

    // Wait for the classifier to start sending bounding boxes
    else if(getting_tflite == 0) {
        ros::spinOnce();
        loop_rate.sleep();
    }

    // If the sensor was detected...
    else if(detected_flag) {
        float Zc = current_pose.pose.position.z - sensor_height;

        // Calculate the center of the bounding box
        float u_coord = tflite_data.x_min + (tflite_data.x_max - tflite_data.x_min)/2;
        float v_coord = tflite_data.y_min + (tflite_data.y_max - tflite_data.y_min)/2;

        /*Create a vector of the scaled U-V-Lambda coordinates
        NOTE: We assumed lambda equals the z pose value (for our circumstances they do)
        TODO: Incorporate local frame lambda calculation
        */
        Eigen::Vector4f uv_coords(Zc*u_coord, Zc*v_coord, Zc, 1);

        // Calculate the body coordinates
        Eigen::Vector4f body_coords = cam_to_body_tfm*intrinsics_matrix.inverse()*uv_coords;
        
        // Populate a message with these coordinates
        bb_vector.pose.position.x = body_coords(0);
        bb_vector.pose.position.y = body_coords(1);
        bb_vector.pose.position.z = body_coords(2);
        // ROS_INFO("Xc: %f, Yc: %f, Zc: %f\n", body_coords(0), body_coords(1), body_coords(2));

        bb_vector.header.stamp = ros::Time::now();
        bb_vector.header.frame_id = "Hires Camera Frame";

        vector_pub.publish(bb_vector);
        
        ros::spinOnce();
        loop_rate.sleep();
    } 
    // If the sensor was not detected...
    else {
        // ROS_INFO("Not detected");
        // Send a negative z value to indicate that nothing is being detected
        // TODO: Incorporate a ROS param that indicates detection
        bb_vector.pose.position.z = -1*(current_pose.pose.position.z - sensor_height);
        
        // Publish the negative z vector and spin
        vector_pub.publish(bb_vector);
        ros::spinOnce();
        loop_rate.sleep();
    }
}

return 0;

}
