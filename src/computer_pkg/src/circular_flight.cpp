#include <ros/ros.h>
#include <mavros_msgs/PositionTarget.h>
#include <geometry_msgs/PoseStamped.h>


geometry_msgs::PoseStamped new_pose;
geometry_msgs::PoseStamped current_pose;
float vec[3] = { 0.0, 0.0, 0.0 };
float num_steps = 32.0;
float step_number = 0;
float radius = 30;
float height = 4;
int run = 0;
int done_flag = 0;

// RUN 1,2,3,4 -> 1,2,4,6
// R: 1.5,3



void pose_callback(const geometry_msgs::PoseStamped::ConstPtr &pose)
{
    current_pose = *pose;
}

int main(int argc, char **argv)
{
    
    
    
    ROS_INFO("WE HAVE LAUNCHOFF");
    ros::init(argc, argv, "circular_node");
    ros::NodeHandle nh;
    ros::Subscriber local_pos_sub_mavros = nh.subscribe<geometry_msgs::PoseStamped>("mavros/local_position/pose", 100, pose_callback);
    ros::Publisher targ_pos_pub = nh.advertise<geometry_msgs::PoseStamped>("mavros/setpoint_position/local", 10);
    ros::Rate rate(20.0);
    while (ros::ok())
    {
        switch(run) {
            case 0:
                radius = 1.5;
                height = 1;
                break;
            case 1:
                radius = 3;
                height = 1;
                break;
            case 2:
                radius = 1.5;
                height = 2;
                break;
            case 3:
                radius = 3;
                height = 2;
                break;
            case 4:
                radius = 1.5;
                height = 4;
                break;
            case 5:
                radius = 3;
                height = 4;
                break;
            case 6:
                radius = 1.5;
                height = 6;
                break;
            case 7:
                radius = 3;
                height = 6;
                break;
            case 8:
                printf("Finished");
                done_flag = 1;
                
        }
        ros::spinOnce();
        if(!done_flag) {
            float next_pos[3] = { radius * cos((2 * M_PI * step_number) / num_steps), radius * sin((2 * M_PI * step_number) / num_steps), height };
            float curr_pos[3] = {current_pose.pose.position.x, current_pose.pose.position.y, current_pose.pose.position.z};
            if((abs(next_pos[0]-curr_pos[0])<.3) && (abs(next_pos[1]-curr_pos[1])<.3) && (abs(next_pos[2]-curr_pos[2])<.3)) {
                step_number = step_number + 1;
            }
            if(step_number <= num_steps) {
                new_pose.header.stamp = ros::Time::now();
                new_pose.pose.position.x = next_pos[0];
                new_pose.pose.position.y = next_pos[1];
                new_pose.pose.position.z = next_pos[2];
                targ_pos_pub.publish(new_pose);
                rate.sleep();
            }
            else {
                run = run + 1;
                step_number = 0;
                targ_pos_pub.publish(new_pose);
                rate.sleep();
            }
        }
        else {
            new_pose.header.stamp = ros::Time::now();
            new_pose.pose.position.x = 0;
            new_pose.pose.position.y = 0;
            new_pose.pose.position.z = 0;
            targ_pos_pub.publish(new_pose);
            rate.sleep();
        }
        
    }
}