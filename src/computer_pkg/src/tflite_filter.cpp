#include <ros/ros.h>
#include <mavros_msgs/PositionTarget.h>
#include <geometry_msgs/PoseStamped.h>
#include <computer_pkg/AiDetection.h>
#include <std_msgs/String.h>

float class_conf_threshold = .2;
float detect_threshold = .4;
computer_pkg::AiDetection current_detection;

void tflite_cb(const computer_pkg::AiDetection::ConstPtr &detection)
{
    current_detection = *detection;
}

int main(int argc, char **argv)
{    
    ROS_INFO("WE HAVE LAUNCHOFF");
    ros::init(argc, argv, "tflite_filter_node");
    ros::NodeHandle nh;
    ros::Subscriber tflite_sub = nh.subscribe<computer_pkg::AiDetection>("tflite_data", 1000, tflite_cb);
    ros::Publisher tflite_repub = nh.advertise<computer_pkg::AiDetection>("filtered_tflite_data", 1000);
    ros::Rate rate(20.0);
    while (ros::ok())
    {
        if(current_detection.class_confidence > class_conf_threshold && current_detection.detection_confidence > detect_threshold) {
            ROS_INFO("Above threshold - sending");
            tflite_repub.publish(current_detection);
        }
        ros::spinOnce();
        rate.sleep();
    }
}