#include <ros/ros.h>
#include <mavros_msgs/PositionTarget.h>
#include <geometry_msgs/PoseStamped.h>
#include <computer_msgs/AiDetection.h>
#include <std_msgs/String.h>

/*
This node was written by the NSSSIP interns. It's purpose is to filter the on-board
VOXL Tflite. The node filters based on class and detection confidences.

Node Name: tflite_filter_node

Topics Subscribed to:
- /tflite_data
Topics Published to:
- /filtered_tflite_data

Parameters:
- class_conf_threshold
- detect_threshold
*/


float class_conf_threshold = .2;
float detect_threshold = .4;
computer_msgs::AiDetection current_detection;

// Get the bounding box data
void tflite_cb(const computer_msgs::AiDetection::ConstPtr &detection)
{
    current_detection = *detection;
}

int main(int argc, char **argv)
{    
    ROS_INFO("WE HAVE LAUNCHOFF");
    ros::init(argc, argv, "tflite_filter_node");
    ros::NodeHandle nh;

    // Create publishers and subscribers
    ros::Subscriber tflite_sub = nh.subscribe<computer_msgs::AiDetection>("tflite_data", 1000, tflite_cb);
    ros::Publisher tflite_repub = nh.advertise<computer_msgs::AiDetection>("filtered_tflite_data", 1000);
    ros::Rate rate(20.0);
    while (ros::ok())
    {
        // Check if the confidences are high enough or if the detection is just noise
        if(current_detection.class_confidence > class_conf_threshold && current_detection.detection_confidence > detect_threshold) {
            ROS_INFO("Above threshold - sending");
            // Publish the tflite message
            tflite_repub.publish(current_detection);
        }
        ros::spinOnce();
        rate.sleep();
    }
}