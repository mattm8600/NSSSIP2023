/**
 * @file PID_controller.cpp
 * @brief PID controller node, written with MAVROS version 0.19.x, PX4 Pro Flight
 * Stack and tested in Gazebo SITL
 * 
 */

#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/PositionTarget.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/CommandLong.h>
#include <mavros_msgs/GlobalPositionTarget.h>
#include <sensor_msgs/Joy.h>
#include <geometry_msgs/PoseStamped.h>
#include <cstdlib>

mavros_msgs::PositionTarget pose_vel;
ros::ServiceClient force_arm_client;

//variables for controls
float err_x = 0.0;
float err_y = 0.0;
float err_z = 0.0; //height of drone
float prev_err_x = 0.0;
float prev_err_y = 0.0;
float der_err_x = 0.0;
float der_err_y = 0.0;

bool climb_to_search_alt = 0;
int landing_counter = 0;
int precision_land_param;
int landed_counter = 0;
int land = 0;

void precisionLand();

void camErrCallback(const geometry_msgs::PoseStamped::ConstPtr& msg){
    err_x = msg->pose.position.x;
    err_y = msg->pose.position.y;
    err_z = msg->pose.position.z;

    ros::param::get("/PID_control", precision_land_param);
    if(precision_land_param == 1){
        precisionLand();
    }
}

void precisionLand(){
    float g1;
    float g2;
    float g1_alt;
    float dt = 20.0;
    float calc_vel_x;
    float calc_vel_y;
    float calc_vel_z;

    g1 = 0.48; //proportional gain value
    g2 = 0.10; //derivative gain value
    g1_alt = 0.09; //proportional z gain value

    //determines x-velocity
    der_err_x = (err_x - prev_err_x)/dt; //dt = how often the PID is calculated -> (1/20 Hz) = 0.05 sec
    prev_err_x = err_x;
    calc_vel_x = (err_x*g1) + (der_err_x*g2);
    if(err_x < 0 && calc_vel_x < 0){
        calc_vel_x *= -1;
    }else if(err_x > 0 && calc_vel_x > 0){
        calc_vel_x *= -1;
    }

    //determines y-velocity
    der_err_y = (err_y - prev_err_y)/dt;
    prev_err_y = err_y;
    calc_vel_y = (err_y*g1) + (der_err_y*g2);
    if(err_y < 0 && calc_vel_y < 0){
        calc_vel_y *= -1;
    }else if(err_y > 0 && calc_vel_y > 0){
        calc_vel_y *= -1;
    }

    //determines z-velocity to 0.40 meters (typically last height where sensor can be clearly seen)
    err_z = err_z - 0.40;
    calc_vel_z = (err_z * g1_alt);
    if(err_z < 0 && calc_vel_z < 0){
        calc_vel_z *= -1;
    }else if(err_z > 0 && calc_vel_z > 0){
        calc_vel_z *= -1;
    }

    //holding altitude at 0.75 meters until x and y are centered within 0.20 meters
    if( ((abs(err_x) > 0.20) || (abs(err_y) > 0.20)) && (abs(err_z) > 0.85) && (abs(err_z) < 1.2)){
        err_z = err_z - 0.75;
        calc_vel_z = (err_z * g1_alt);
        if(err_z < 0 && calc_vel_z < 0){
            calc_vel_z *= -1;
        }else if(err_z > 0 && calc_vel_z > 0){
            calc_vel_z *= -1;
        }
    }

    //holding altitude at 0.50 meters until x and y are centered within 0.12 meters
    if( ((abs(err_x) > 0.12) || (abs(err_y) > 0.12)) && (abs(err_z) > 0.65) && (abs(err_z) < 0.85)){
        err_z = err_z - 0.50;
        calc_vel_z = (err_z * g1_alt);
        if(err_z < 0 && calc_vel_z < 0){
            calc_vel_z *= -1;
        }else if(err_z > 0 && calc_vel_z > 0){
            calc_vel_z *= -1;
        }
    }

    //if drone is above 0.5 meters and loses sight of sensor then hold position
    if(err_z < 0){
        calc_vel_x = 0;
        calc_vel_y = 0;
        calc_vel_z = 0;

        err_z *= -1;
    }

    //landing counter allotting 30 seconds for landing otherwise climbing up to search altitude
    if((err_z < 0.65) && (err_z > 0.35)){
       landing_counter += 1;
    }else if(err_z > 0.65){
       landing_counter = 0;
    }

    if(landing_counter != 0 && err_z < 0.65){
       landing_counter += 1;
    }

    if(landing_counter > 600){
       climb_to_search_alt = 1;
    }

    //climb to search altitude of 1 meter
    if(climb_to_search_alt == 1){
        err_z = err_z - 1.0;
        calc_vel_z = (err_z * g1_alt);
        if(err_z < 0 && calc_vel_z < 0){
            calc_vel_z *= -1;
        }else if(err_z > 0 && calc_vel_z > 0){
            calc_vel_z *= -1;
        }
        ROS_INFO("CLIMBING TO SEARCH ALTITUDE");
        if(abs(err_z) > 0.8){
            climb_to_search_alt = 0;
        }
    }

    //landing condition
    if(((abs(err_z) < 0.50) && (abs(err_x) < 0.10) && (abs(err_y) < 0.10)) || (land == 1)){
        calc_vel_z = -2.5;
        ROS_INFO("LANDING!!!!");

        if((precision_land_param == 1)){
            land = 1;
        }

        landed_counter += 1;

        if(landed_counter > 80){
            mavros_msgs::CommandLong arm_cmd;
            arm_cmd.request.param1 = 0; //arming param (0 = disarm, 1 = arm)
            arm_cmd.request.param2 = 21196; //force param (21196 = force)
            landed_counter = 0;
            precision_land_param = 0;
            ros::param::set("/PID_control", 0);
            land = 0;
            if(force_arm_client.call(arm_cmd) && arm_cmd.response.success){
                ROS_INFO("DISARMING!!!!");
                landed_counter = 0;
                land = 0;
                precision_land_param = 0;
                ros::param::set("/PID_control", 0);
            }
        }
    }

    pose_vel.velocity.x = calc_vel_x;
    pose_vel.velocity.y = calc_vel_y;
    pose_vel.velocity.z = calc_vel_z;

    ROS_INFO("ERR_X is %f", err_x);
    ROS_INFO("ERR_Y is %f", err_y);
    ROS_INFO("ERR_Z is %f", err_z);
    ROS_INFO("CALC_VEL_X is %f", calc_vel_x);
    ROS_INFO("CALC_VEL_Y is %f", calc_vel_y);
    ROS_INFO("CALC_VEL_Z is %f", calc_vel_z);
    ROS_INFO("LANDING COUNTER is %d", landing_counter);
}

int main(int argc, char **argv)
{

    ros::init(argc, argv, "offb_node");

    ros::NodeHandle nh;

    nh.getParam("/PID_control", precision_land_param);
    ros::Publisher local_pos_pub_mavros = nh.advertise<mavros_msgs::PositionTarget>("mavros/setpoint_raw/local", 5);
    force_arm_client = nh.serviceClient<mavros_msgs::CommandLong>("mavros/cmd/command");
    ros::Subscriber cam_err = nh.subscribe<geometry_msgs::PoseStamped>("/bb_camera_vector", 1000, camErrCallback);


    //the setpoint publishing rate MUST be faster than 2Hz
    ros::Rate rate(20.0);


    // type_mask assuming you are affecting VELOCITY control over the vehicle
    pose_vel.coordinate_frame = pose_vel.FRAME_BODY_NED;
    pose_vel.type_mask = pose_vel.IGNORE_AFX | pose_vel.IGNORE_AFY | pose_vel.IGNORE_AFZ | pose_vel.FORCE | pose_vel.IGNORE_YAW | pose_vel.IGNORE_PX | pose_vel.IGNORE_PY | pose_vel.IGNORE_PZ;

    ros::Time last_request = ros::Time::now();

    int count = 0;

    while(ros::ok()){
        ros::param::get("/PID_control", precision_land_param);
        if(precision_land_param == 1){
            local_pos_pub_mavros.publish(pose_vel);
        }


        ros::spinOnce();
        rate.sleep();
        count++;

    }

    return 0;
}

