#include <ros/ros.h>
#include <mavros_msgs/PositionTarget.h>
#include <geometry_msgs/PoseStamped.h>
#include <offboard_testing/AiDetection.h>
#include <std_msgs/String.h>
#include <iostream>
#include <Eigen/Dense>

geometry_msgs::PoseStamped bb_vector;
geometry_msgs::PoseStamped current_pose;
int getting_pose = 0;
offboard_testing::AiDetection tflite_data;
int getting_tflite = 0;
int detected_flag = 0;

float threshold = 0;

// CAMERA MATRIX VALUES
/*
| kuf | 0   | u_0 | 0 |
| 0   | kvf | v_0 | 0 |
| 0   | 0   | 1   | 0 |
| 0   | 0   | 0   | 1 |

*/


float sensor_height = 0.028;

void pose_callback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
    current_pose = *msg;
    getting_pose = 1;
}

void tflite_callback(const offboard_testing::AiDetection::ConstPtr& msg) {
    tflite_data = *msg;
    getting_tflite = 1;
    if(tflite_data.class_confidence > 0) {
        detected_flag = 1;
    }
    else {
        detected_flag = 0;
    }
}

int main(int argc, char **argv) {

Eigen::Matrix4f intrinsics_matrix;
intrinsics_matrix << 281.938264, 0, 323.052198, 0, 0, 281.901123, 237.072802, 0, 0, 0, 1, 0, 0, 0, 0, 1;

Eigen::Matrix4f cam_to_body_tfm;
cam_to_body_tfm << 0, 1, 0, 0.08, 1, 0, 0, -0.015, 0, 0, 1, -0.008, 0, 0, 0, 1;

ros::init(argc, argv, "camera_conversion_node");
ros::NodeHandle nh;
ros::Publisher vector_pub = nh.advertise<geometry_msgs::PoseStamped>("bb_camera_vector", 100);
ros::Subscriber pose_sub = nh.subscribe<geometry_msgs::PoseStamped>("mavros/local_position/pose", 100, pose_callback);
ros::Subscriber tflite_sub = nh.subscribe<offboard_testing::AiDetection>("tflite_data", 100, tflite_callback);
ros::Rate loop_rate(10.0);
assert(nh.getParam("/detect/confidence_threshold", threshold));

while (ros::ok())
{
    if(getting_pose == 0) {
         ROS_INFO("Waiting for pose\n");
         ros::spinOnce();
         loop_rate.sleep();
     }
    else if(getting_tflite == 0) {
        ROS_INFO("Waiting for tflite");
        ros::spinOnce();
        loop_rate.sleep();
    }
     else if(detected_flag) {
        float Zc = current_pose.pose.position.z - sensor_height;

        float u_coord = tflite_data.x_min + (tflite_data.x_max - tflite_data.x_min)/2;
        float v_coord = tflite_data.y_min + (tflite_data.y_max - tflite_data.y_min)/2;
        
        // float kuf = 281.938264;
        // float kvf = 281.901123;
        // float u_0 = 323.052198;
        // float v_0 = 237.072802; 
        // float Yc = (Zc*(u_coord-u_0))/kuf;
        // float Xc = (Zc*(v_coord-v_0))/kvf;
        // bb_vector.pose.position.x = Xc;
        // bb_vector.pose.position.y = Yc;
        // bb_vector.pose.position.z = Zc;
        // ROS_INFO("Xc: %f, Yc: %f, Zc: %f\n", Xc, Yc, Zc);

        Eigen::Vector4f uv_coords(Zc*u_coord, Zc*v_coord, Zc, 1);
        Eigen::Vector4f body_coords = cam_to_body_tfm*intrinsics_matrix.inverse()*uv_coords;
        bb_vector.pose.position.x = body_coords(0);
        bb_vector.pose.position.y = body_coords(1);
        bb_vector.pose.position.z = body_coords(2);
        ROS_INFO("Xc: %f, Yc: %f, Zc: %f\n", body_coords(0), body_coords(1), body_coords(2));

        bb_vector.header.stamp = ros::Time::now();
        bb_vector.header.frame_id = "Hires Camera Frame";

        vector_pub.publish(bb_vector);
        
        ros::spinOnce();
        loop_rate.sleep();
    } 
    else {
        ROS_INFO("Not detected");
        bb_vector.pose.position.z = -1*(current_pose.pose.position.z - sensor_height);
        vector_pub.publish(bb_vector);
        ros::spinOnce();
        loop_rate.sleep();
    }
}

return 0;

}