/**
 * @file offb_node.cpp
 * @brief Offboard control example node, written with MAVROS version 0.19.x, PX4 Pro Flight
 * Stack and tested in Gazebo SITL
 * 
 * from https://docs.px4.io/master/en/ros/mavros_offboard.html
 */

#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/PositionTarget.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/GlobalPositionTarget.h>
#include <sensor_msgs/Joy.h>
#include <geometry_msgs/PoseStamped.h>
#include <cstdlib>


#include <Eigen/Dense>

mavros_msgs::PositionTarget pose_vel;
//sensor_msgs::Joy joy_in;
geometry_msgs::PoseStamped at_in_data;
geometry_msgs::PoseStamped lpp_data;

bool lpp_data_in = 0;
bool at_in = 0;
bool all_in = 0;

//variables for x-y control
float prev_err_x = 0.0;
float prev_err_y = 0.0;
float dt = 20.0;
float err_x = 0.0;
float err_y = 0.0;
float der_err_x = 0.0;
float der_err_y = 0.0;
float total_err_x = 0.0;
float total_err_y = 0.0;
float g1 = 0.0;
float g2 = 0.0;
float calc_vel_x = 0.0;
float calc_vel_y = 0.0;

bool land = 0;

//variables for altitude control
float g1_alt = 0.0;
float err_z = 0.0; //height of drone
float calc_vel_z = 0.0;

bool climb_to_search_alt = 0;
float confidence_level = 0.0;
int undetected_counter = 0;
bool sensor_not_visible = 0;
int landing_counter = 0;

Eigen::Matrix3d Rmat(const Eigen::Quaternion<double>& q)
{
double x,y,z,w;
x = q.x();
y = q.y();
z = q.z();
w = q.w();

Eigen::MatrixXd R(3,3);
R(0,0) = 1-2*y*y-2*z*z;
R(0,1) = 2*x*y+2*w*z;
R(0,2) = 2*x*z-2*w*y;
R(1,0) = 2*x*y-2*w*z;
R(1,1) = 1-2*x*x-2*z*z;
R(1,2) = 2*y*z+2*w*x;
R(2,0) = 2*x*z+2*w*y;
R(2,1) = 2*y*z-2*w*x;
R(2,2) = 1-2*x*x-2*y*y;

return R;
}


// void joy_cb(const sensor_msgs::Joy::ConstPtr& joy_msg){
//    joy_in = *joy_msg;
//    //std::cout << joy_in.axes[0] << std::endl;
// }

void at_cb(const geometry_msgs::PoseStamped::ConstPtr& at_msg){
   at_in_data = *at_msg;
   at_in = 1;

}

void lpp_callback(const geometry_msgs::PoseStamped::ConstPtr& lpp_msg){

lpp_data = *lpp_msg;
lpp_data_in = 1;

}

// void taginertialAltCallback(const geometry_msgs::PoseStamped::ConstPtr& msg){ //just proportional control for now
//     err_z = msg->pose.position.z;
//     ROS_INFO("Drone's height is %f", err_z);

//     g1_alt = 0.2; //gain value for proportional control
//     calc_vel_z = (err_z * g1_alt);
//     calc_vel_z *= -1; //I think because we want opposite behavior??
//     if()


//     pose_vel.velocity.z = calc_vel_z;
//     ROS_INFO("CALC_VEL_Z is %f", calc_vel_z);

//     if((err_z > -0.40) && abs(msg->pose.position.x < 0.10) && abs(msg->pose.position.y < 0.10)){ //condition for landing
//         ROS_INFO("LANDING!!!!");
//         pose_vel.velocity.x = 0.0;
//         pose_vel.velocity.y = 0.0;
//         pose_vel.velocity.z = 0.0;
//     }
// }

// void testing(const mavros_msgs::Float64::ConstPtr& msg){
//     ROS_INFO("%f", msg->data);
// }

void camErrCallback(const geometry_msgs::PoseStamped::ConstPtr& msg){
    err_x = msg->pose.position.x; 
    err_y = msg->pose.position.y;
    err_z = msg->pose.position.z;
}

void taginertialCallback(const geometry_msgs::PoseStamped::ConstPtr& msg){
    // err_x = msg->pose.position.x; 
    // err_y = msg->pose.position.y;
    // err_z = msg->pose.position.z;

    g1 = 0.40; //proportional gain value
    g2 = 0.10; //derivative gain value
    g1_alt = 0.15; //proportional altitude gain value

    //determines x-velocity
    der_err_x = (err_x - prev_err_x)/dt; //dt = how often the PID is calculated -> (1/20 Hz) = 0.05 sec
    prev_err_x = err_x;
    calc_vel_x = (err_x*g1) + (der_err_x*g2) + (total_err_x*0);
    if(err_x < 0 && calc_vel_x < 0){
        calc_vel_x *= -1;
    }else if(err_x > 0 && calc_vel_x > 0){
        calc_vel_x *= -1;
    }
    total_err_x += err_x * dt;

    //determines y-velocity
    der_err_y = (err_y - prev_err_y)/dt; //dt = how often the PID is calculated -> (1/20 Hz) = 0.05 sec
    prev_err_y = err_y;
    calc_vel_y = (err_y*g1) + (der_err_y*g2) + (total_err_y*0);
    if(err_y < 0 && calc_vel_y < 0){
        calc_vel_y *= -1;
    }else if(err_y > 0 && calc_vel_y > 0){
        calc_vel_y *= -1;
    }
    total_err_y += err_y * dt;

    //determines z-velocity
    calc_vel_z = (err_z * g1_alt);
    if(err_z < 0 && calc_vel_z < 0){
        calc_vel_z *= -1;
    }else if(err_z > 0 && calc_vel_z > 0){
        calc_vel_z *= -1;
    }

    //holding altitude at 1 until x and y are centered
    if( ((abs(err_x) > 0.40) || (abs(err_y) > 0.40)) && (abs(err_z) > 1.0) ){
        err_z = err_z - 1.0;
        calc_vel_z = (err_z * g1_alt);
        if(err_z < 0 && calc_vel_z < 0){
            calc_vel_z *= -1;
        }else if(err_z > 0 && calc_vel_z > 0){
            calc_vel_z *= -1;
        }
    }

    //handling case where sensor box isn't visible
    // if(err_z < 0){
    //     undetected_counter += 1;
    //     sensor_not_visible = 1;
    //     err_z *= -1;
    //     if(undetected_counter > 30){
    //         if(abs(err_z) <= 0.3){
    //             land = 1;
    //         }else{
    //             climb_to_search_alt = 1;
    //         }
    //     }
    // }else{
    //     undetected_counter = 0;
    // }
    //else if((err_z >= 0) && (undetected_counter != 0) && ()){
    //    undetected_counter = 0;
    //}

    if((err_z < 0.85) && (err_z > 0.3)){
        landing_counter += 1;
    }else if(err_z > 0.85){
        landing_counter = 0;
    }

    if(landing_counter > 300){
        climb_to_search_alt = 1;
    }

    //climb to search altitude
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
    if(((abs(err_z) < 0.30) && (abs(err_x) < 0.10) && (abs(err_y) < 0.10)) || (land == 1)){
        //calc_vel_x = 0.0;
        //calc_vel_y = 0.0;
        if(landing_counter != 0){
            calc_vel_z = -4.0;
        }
        ROS_INFO("LANDING!!!!");
    }

    pose_vel.velocity.x = calc_vel_x;
    pose_vel.velocity.y = calc_vel_y;
    pose_vel.velocity.z = calc_vel_z;

    ROS_INFO("ERR_X is %f", err_x);
    ROS_INFO("ERR_Y is %f", err_y);
    ROS_INFO("Drone's height is %f", err_z);
    ROS_INFO("CALC_VEL_X is %f", calc_vel_x);
    ROS_INFO("CALC_VEL_Y is %f", calc_vel_y);
    ROS_INFO("CALC_VEL_Z is %f", calc_vel_z);
    ROS_INFO("LANDING STATE is %d", land);
    ROS_INFO("LANDING COUNTER is %d", landing_counter);
}

int main(int argc, char **argv)
{
    
    at_in_data.pose.position.x = 0;
    at_in_data.pose.position.y = 0;
    at_in_data.pose.position.z = 0;


    ros::init(argc, argv, "offb_node");
    ros::NodeHandle nh;
    

    ros::Publisher local_pos_pub_mavros = nh.advertise<mavros_msgs::PositionTarget>("mavros/setpoint_raw/local", 5);
    //ros::Subscriber joy_sub = nh.subscribe<sensor_msgs::Joy>("/joy", 1, joy_cb);
    ros::Subscriber at_sub = nh.subscribe<geometry_msgs::PoseStamped>("/tag_detections/tagpose", 1, at_cb);
    ros::Subscriber local_info_sub = nh.subscribe <geometry_msgs::PoseStamped> ("/mavros/local_position/pose", 10, lpp_callback);
    ros::Publisher target_body_pub = nh.advertise<geometry_msgs::PoseStamped>("/tag_detections/tagpose_body", 10);
    ros::Publisher target_lpp_pub = nh.advertise<geometry_msgs::PoseStamped>("/tag_detections/tagpose_inertial", 10);
    ros::Publisher target_body_stab_pub = nh.advertise<geometry_msgs::PoseStamped>("/tag_detections/tagpose_body_stabilized", 10);
    ros::Subscriber tag_sub = nh.subscribe<geometry_msgs::PoseStamped>("/tag_detections/tagpose_inertial", 1000, taginertialCallback);
    ros::Subscriber cam_err = nh.subscribe<geometry_msgs::PoseStamped>("/bb_camera_vector", 1000, camErrCallback);
    // ros::Subscriber compass = nh.subscribe<std_msgs::Float64>("/tag_detections/tagpose_inertial", 1000, testing);

    //joy_in.axes.resize(8);
    //joy_in.buttons.resize(8);
    
    
    //the setpoint publishing rate MUST be faster than 2Hz
    ros::Rate rate(20.0);

    //mavros_msgs::PositionTarget pose_vel;


    // Note that this type_mask is assuming you are affecting VELOCITY control over the vehicle.  See the original offboard example for the position type mask
    pose_vel.coordinate_frame = pose_vel.FRAME_BODY_NED;//pose_vel.FRAME_LOCAL_NED;
    pose_vel.type_mask =  pose_vel.IGNORE_AFX | pose_vel.IGNORE_AFY | pose_vel.IGNORE_AFZ | pose_vel.FORCE | pose_vel.IGNORE_YAW | pose_vel.IGNORE_PX | pose_vel.IGNORE_PY | pose_vel.IGNORE_PZ;



    ros::Time last_request = ros::Time::now();

    int last_button_val = 0;
    float phase = 0;
    double sinusoid_val;
    int count = 0;
    
    while(ros::ok()){
  
        if(at_in && lpp_data_in){
        all_in=1;
        }

        // The position of the drone relative to the local inertial frame (vehicle starts along y axis using indoor parameters)
        // Drone axes are x = forward, y = left, z = up (FLU)
        // Vehicle should start with initial orientation of 90 deg right; quaternion = (0,0,-0.707, -0.707)
        double xp = lpp_data.pose.position.x;
        double yp = lpp_data.pose.position.y;
        double zp = lpp_data.pose.position.z;

        // Position of the apriltag in the camera coordinate frame.  Z coincident with optical axis; Y down in camera frame; X to the right when looking from vehicle out
        double xt = at_in_data.pose.position.x;
        double yt = at_in_data.pose.position.y;
        double zt = at_in_data.pose.position.z;

        // EIGEN's convention is to have the SCALAR value FIRST!!!
        Eigen::Quaterniond quat_lpp(lpp_data.pose.orientation.w, lpp_data.pose.orientation.x, lpp_data.pose.orientation.y, lpp_data.pose.orientation.z);
        Eigen::Matrix3d R_lpp = quat_lpp.toRotationMatrix();

        // Populating a homogenous transformation matrix with /mavros/local_position/pose data
        // converting quaternion to rotation matrix
        Eigen::Matrix4d H_lpp;
        H_lpp.block(0,0,4,4) = Eigen::Matrix4d::Constant(4,4, 0.0);
        H_lpp.block(0,0,3,3) = R_lpp;
        H_lpp(3,3) = 1.0;
        H_lpp(0,3) = xp;
        H_lpp(1,3) = yp;
        H_lpp(2,3) = zp;

        // A fixed homogenous transformation (zero translation) to convert between camera frame and local body FLU frame
        // Camera is pointing 45 deg down looking forward. = tracking camera
        // This matrix takes points in the body frame and converts to camera frame
        Eigen::Matrix4d H_M_B;
        //H_M_B_old << 0,-1,0,0,-0.707,0,-0.707, 0, 0.707, 0, -0.707, 0, 0, 0, 0, 1;
        H_M_B << 0, -1, 0, 0, -1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1;

        // create a vector with apriltag position relative to camera
        Eigen::Vector4d r4vec(4);
        r4vec << xt,yt,zt,1;

        // Rotate the apriltag position from camera coordinates to FLU coordinates
        // inverse H_M_B converts from camera to body coordinates.
        // Note: For unitary transformation (unitary rotation matrix) transpose of matrix = inverse of matrix
        Eigen::Vector4d P_r_B(4);
        P_r_B = H_M_B.inverse()*r4vec;

        Eigen::Vector4d P_r_I(4);
        P_r_I = H_lpp*P_r_B;

        // This computes P_r_I2 which is the computed location of the Apriltag in the local inertial mavros lpp frame
        Eigen::Vector4d P_r_I2(4);
        Eigen::Matrix4d H_lpp_nopos;
        H_lpp_nopos = H_lpp;
        H_lpp_nopos(0,3) = 0;
        H_lpp_nopos(1,3) = 0;
        H_lpp_nopos(2,3) = 0;
        P_r_I2 = H_lpp_nopos*H_M_B.inverse()*r4vec;

        // This computes the difference between the inertial location of the apriltag and inertial location of the vehicle
        Eigen::Vector4d I_diff;
        I_diff = P_r_I2-P_r_I;

        // This computes the Euler angles associated with the mavros/local_position/pose quaternion in yaw->pitch->roll format.
        Eigen::Vector3d euler_ang = quat_lpp.toRotationMatrix().eulerAngles(2,1,0);

        // This creates a rotation matrix considering ONLY the heading (not roll/pitch) so we can rotate between body and inertial heading
        // I'm mentally thinking of this as body referenced, but "stabilized" by removing roll and pitch 
        Eigen::Matrix3d rotation_matrix;
        rotation_matrix << cos(euler_ang(0)), -sin(euler_ang(0)), 0, sin(euler_ang(0)),  cos(euler_ang(0)), 0, 0, 0, 1;

        // create the location of the tag not in inertial, but in local body referenced heading coordinates
        Eigen::Vector3d body_diff;
        body_diff = rotation_matrix.transpose()*I_diff.block<3,1>(0,0);

        // populate and publish the apriltag in body FLU coordinates
        geometry_msgs::PoseStamped body_pub_data;
        body_pub_data.header.stamp = lpp_data.header.stamp;
        body_pub_data.pose.position.x = P_r_B(0);
        body_pub_data.pose.position.y = P_r_B(1);
        body_pub_data.pose.position.z = P_r_B(2);
        target_body_pub.publish(body_pub_data);

        // populate and publish the apriltag in inertial coordinates
        geometry_msgs::PoseStamped lpp_pub_data;
        lpp_pub_data.header.stamp = lpp_data.header.stamp;
        lpp_pub_data.pose.position.x = P_r_I(0);
        lpp_pub_data.pose.position.y = P_r_I(1);
        lpp_pub_data.pose.position.z = P_r_I(2);
        target_lpp_pub.publish(lpp_pub_data);

        // populate and publish the apriltag in stabilized body coordindates
        geometry_msgs::PoseStamped body_stab_pub_data;
        body_stab_pub_data.header.stamp = lpp_data.header.stamp;
        body_stab_pub_data.pose.position.x = body_diff(0);
        body_stab_pub_data.pose.position.y = body_diff(1);
        body_stab_pub_data.pose.position.z = body_diff(2);
        target_body_stab_pub.publish(body_stab_pub_data);

        // if (count < 100){
        //     pose_vel.velocity.x = 0.2;
        //     pose_vel.velocity.y = 0.0;
        // }else if(count < 200){
        //     pose_vel.velocity.x = 0.0;
        //     pose_vel.velocity.y = 0.2;
        // }else if(count < 300){
        //     pose_vel.velocity.x = -0.2;
        //     pose_vel.velocity.y = 0.0;
        // }else if(count < 400){
        //     pose_vel.velocity.x = 0.0;
        //     pose_vel.velocity.y = -0.2;
        // }else{
        //     count  = 0;
        // }
        // ROS_INFO("Counter is %d", count);
        // ROS_INFO("X Velocity is %f", pose_vel.velocity.x);
        // ROS_INFO("Y Velocity is %f", pose_vel.velocity.y);

        // if(joy_in.buttons[0]==0 && last_button_val==0){
        // last_button_val = 0;
        // count = 0;
        // sinusoid_val = 0;
        // }
        // else if(joy_in.buttons[0]==1 && last_button_val==0){            
        // last_button_val = 1;
        // count = 0;
        // sinusoid_val = 0;
        // }
        // else if(joy_in.buttons[0]==0 && last_button_val==1){
        // last_button_val = 0;
        // sinusoid_val = 0;
        // count = 0;
        // }
        // else if(joy_in.buttons[0]==1 && last_button_val==1){
        // last_button_val = 1;
        // phase = ((float)count/10);
        // sinusoid_val = 1.5*sin(phase);
        // }
    
        // pose_vel.header.stamp = ros::Time::now();
        // pose_vel.yaw_rate = (double)joy_in.axes[0];
        // pose_vel.velocity.x = (double)joy_in.axes[4];
        // pose_vel.velocity.y = (double)joy_in.axes[3]+sinusoid_val; 
        // pose_vel.velocity.z = (double)joy_in.axes[1];

        local_pos_pub_mavros.publish(pose_vel);

        
        ros::spinOnce();
        rate.sleep();
        count++;

    }

    return 0;
}