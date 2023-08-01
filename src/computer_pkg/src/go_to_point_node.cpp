#include <ros/ros.h>
#include <mavros_msgs/PositionTarget.h>
#include <geometry_msgs/PoseStamped.h>

/*
This node was written by the NSSSIP interns. It's purpose is to fly to
any point in the local frame. It gets its commands from a Tkinker
GUI.The drone hovers once it reaches its detection.

Node Name: go_to_point_node

Topics Subscribed to:
- /mavros/local_position/pose
Topics Published to:
- /mavros/setpoint_position/local

Parameters:
- Starting XYZ position (defaulted to 0,0,0)
  NOTE: You have to set these through the launch file or ROS Params
*/

geometry_msgs::PoseStamped target_pose;
geometry_msgs::PoseStamped current_pose;

// Get the pose messages
void pose_callback(const geometry_msgs::PoseStamped::ConstPtr& pose) {
    current_pose = *pose;
}
int main(int argc, char **argv) {
ros::init(argc, argv, "go_to_point");
ros::NodeHandle nh;

// Set up Subscribers and Publishers
ros::Subscriber local_pos_sub_mavros = nh.subscribe<geometry_msgs::PoseStamped>("mavros/local_position/pose", 100, pose_callback);
ros::Publisher targ_pos_pub = nh.advertise<geometry_msgs::PoseStamped>("mavros/setpoint_position/local", 10);
ros::Rate rate(20.0);

double point[3] = {-1,-1,-1};
printf("We have launchoff\n");

while (ros::ok())
{

// Get the x,y,z to go to (stored in ROS Parameters)
assert(nh.getParam("/go_to_point_node/x_coord", point[0]));
assert(nh.getParam("/go_to_point_node/y_coord", point[1]));
assert(nh.getParam("/go_to_point_node/z_coord", point[2]));

// Store them in a message
target_pose.pose.position.x = point[0];
target_pose.pose.position.y = point[1];
target_pose.pose.position.z = point[2];
    target_pose.header.stamp = ros::Time::now();

    //Publish the message
    targ_pos_pub.publish(target_pose);
    ros::spinOnce();
    rate.sleep();
}


}
