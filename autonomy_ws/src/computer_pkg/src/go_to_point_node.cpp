#include <ros/ros.h>
#include <mavros_msgs/PositionTarget.h>
#include <geometry_msgs/PoseStamped.h>

geometry_msgs::PoseStamped target_pose;
geometry_msgs::PoseStamped current_pose;

void pose_callback(const geometry_msgs::PoseStamped::ConstPtr& pose) {
    current_pose = *pose;
}
int main(int argc, char **argv) {
ros::init(argc, argv, "circular_node");
ros::NodeHandle nh;

ros::Subscriber local_pos_sub_mavros = nh.subscribe<geometry_msgs::PoseStamped>("mavros/local_position/pose", 100, pose_callback);
ros::Publisher targ_pos_pub = nh.advertise<geometry_msgs::PoseStamped>("mavros/setpoint_position/local", 10);
ros::Rate rate(20.0);

double point[3] = {-1,-1,-1};
printf("We have launchoff\n");

while (ros::ok())
{
assert(nh.getParam("/go_to_point_node/x_coord", point[0]));
assert(nh.getParam("/go_to_point_node/y_coord", point[1]));
assert(nh.getParam("/go_to_point_node/z_coord", point[2]));
target_pose.pose.position.x = point[0];
target_pose.pose.position.y = point[1];
target_pose.pose.position.z = point[2];
    target_pose.header.stamp = ros::Time::now();
    targ_pos_pub.publish(target_pose);
    ros::spinOnce();
    rate.sleep();
}


}
