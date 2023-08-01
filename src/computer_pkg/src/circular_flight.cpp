#include <ros/ros.h>
#include <mavros_msgs/PositionTarget.h>
#include <geometry_msgs/PoseStamped.h>

/*
This node was written by the NSSSIP interns. It's purpose is to fly in circles of differing
heights and radiuses around a target point. The purpose was for photography of different angles.

Node Name: circular_node

Topics Subscribed to:
- /mavros/local_position/pose
Topics Published to:
- /mavros/setpoint_position/local

Parameters:
- num_steps -> How precise to fly in a circle
- radius -> radius of the circle
- height -> which height to fly at
*/

geometry_msgs::PoseStamped new_pose;
geometry_msgs::PoseStamped current_pose;
double vec[3] = { 0.0, 0.0, 0.0 };
double num_steps = 32.0;
double step_number = 0;
double radius = 30;
double height = 4;
int run = 0;
int done_flag = 0;

// Subscribe to pose
void pose_callback(const geometry_msgs::PoseStamped::ConstPtr &pose)
{
    current_pose = *pose;
}

int main(int argc, char **argv)
{
    ROS_INFO("WE HAVE LAUNCHOFF");
    ros::init(argc, argv, "circular_node");
    ros::NodeHandle nh;

    // Create publishers and Subscribers
    ros::Subscriber local_pos_sub_mavros = nh.subscribe<geometry_msgs::PoseStamped>("mavros/local_position/pose", 100, pose_callback);
    ros::Publisher targ_pos_pub = nh.advertise<geometry_msgs::PoseStamped>("mavros/setpoint_position/local", 10);
    ros::Rate rate(20.0);
    while (ros::ok())
    {
        // Here we have a simple experiment where we switch between different
        // circle radiuses and heights. Change this for different configuration
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

        // If not finished...
        if(!done_flag) {
            // Calculate the next XYZ point to fly to
            double next_pos[3] = { radius * cos((2 * M_PI * step_number) / num_steps), radius * sin((2 * M_PI * step_number) / num_steps), height };
            double curr_pos[3] = {current_pose.pose.position.x, current_pose.pose.position.y, current_pose.pose.position.z};
            
            // Compare next position vector to current position
            if((abs(next_pos[0]-curr_pos[0])<.3) && (abs(next_pos[1]-curr_pos[1])<.3) && (abs(next_pos[2]-curr_pos[2])<.3)) {
                // Increase the step number (so next calculation will provide the next point)
                step_number = step_number + 1;
            }

            if(step_number <= num_steps) {
                // Publish the setpoint_position command
                new_pose.header.stamp = ros::Time::now();
                new_pose.pose.position.x = next_pos[0];
                new_pose.pose.position.y = next_pos[1];
                new_pose.pose.position.z = next_pos[2];
                targ_pos_pub.publish(new_pose);
                rate.sleep();
            }
            // If the run is finished start back at step 0
            else {
                run = run + 1;
                step_number = 0;
                targ_pos_pub.publish(new_pose);
                rate.sleep();
            }
        }

        // When done fly back to the home position
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