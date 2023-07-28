#include <iostream>
#include <vector>
#include <cmath>
using namespace std;

#include "ros/ros.h"
#include "std_msgs/Int32.h"
#include "geometry_msgs/PoseStamped.h"
#include "sensor_msgs/BatteryState.h"
#include "sensor_msgs/NavSatFix.h"
#include "mavros_msgs/PositionTarget.h"
#include "drone_pkg/PlaceSensor.h"
#include "drone_pkg/DroneOp.h"

//create parameters
double x;
double y;
double z;
array<double,2> target_xy;

double lat;
double lon;
double alt;

float bat;

bool waiting_for_op = true;
bool placing_sensor = false;
bool retrieving_sensor = false;

vector<double> sensor_pos[2];
std_msgs::Int32 servo_state;
mavros_msgs::PositionTarget target_pose;

void local_pos_cb(geometry_msgs::PoseStamped local_pos){
    x = local_pos.pose.position.x;
    y = local_pos.pose.position.y;
    z = local_pos.pose.position.z;
}

void global_pos_cb(sensor_msgs::NavSatFix global_pos){
    lat = global_pos.latitude;
    lon = global_pos.longitude;
    alt = global_pos.altitude;
}

void bat_cb(sensor_msgs::BatteryState battery){
    bat = battery.percentage;
}

bool start_drone_op(drone_pkg::DroneOp::Request  &req, 
                    drone_pkg::DroneOp::Response &res){
    res.success = false;
    if(waiting_for_op){
        if(req.mode == 0){
            placing_sensor = true;
            waiting_for_op = false;
            res.success = true;
        }   
        else if(req.mode == 1){
            if(sensor_pos[0].empty()){
                cout << "There are currently no sensors in need of retrieval" << endl;
            }
            else{
            retrieving_sensor = true;
            waiting_for_op = false;
            res.success = true;
            }
        }
        else{
            cout << "Invalid mode. Use 0 to place sensor and 1 to retrieve sensor" << endl;
        }
    }
    else{
        cout << "The drone is busy and cannot perform another operation at the moment. Try again later" << endl;
    }
    
    return true;
}

double calc_dist(double x, double y, double tar_x, double tar_y){
    double dist = sqrt(pow((x-tar_x),2)+pow((y-tar_y),2));
    return dist;
}


void set_global2local_target(double lat1, double lon1, double lat2, double lon2){
    //convert degrees to radians
    lat1 = lat1 * M_PI / 180;
    lat2 = lat2 * M_PI / 180;
    lon1 = lon1 * M_PI / 180;
    lon2 = lon2 * M_PI / 180;

    //difference between points (radians)
    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;
    
    //calculate distance between points (m)
    double a = sin(dLat/2.0) * sin(dLat/2.0) + cos(lat1) * cos(lat2) * sin(dLon/2.0) * sin(dLon/2.0);
    double c = 2.0 * atan2(sqrt(a), sqrt(1.0-a));
    double EARTH_RADIUS_METERS = 6371008.8;
    double distance = EARTH_RADIUS_METERS * c;

    double bearing = atan2(sin(lon2 - lon1) * cos(lat2), cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2-lon1));

    target_xy[0] = distance * cos(bearing);
    target_xy[1] = distance * sin(bearing);

    //cout << "localized target coords = [" << target_xy[0] << "," << target_xy[1] << "]" << endl;
}

void fly_to_target(ros::Publisher pos_pub_mavros, ros::Rate loop_rate){
    //raise to cruising height
    target_pose.position.z = 5.0;
    for(int i = 60; ros::ok() && i > 0; --i){
        pos_pub_mavros.publish(target_pose);
        loop_rate.sleep();
    }

    //set target coordinates
    target_pose.position.x = target_xy[0];
    target_pose.position.y = target_xy[1];
    
    //fly to target coordinates
    while(calc_dist(x, y, target_xy[0], target_xy[1]) > 0.5){
        pos_pub_mavros.publish(target_pose);     
        loop_rate.sleep();
        ros::spinOnce();
    }


    //hover for three seconds to settle
    for(int i = 60; ros::ok() && i > 0; --i){
        pos_pub_mavros.publish(target_pose);
        loop_rate.sleep();
    }

}

int main(int argc, char **argv){
    ros::init(argc,argv, "drone_offboard");
    ros::NodeHandle n;

    target_pose.type_mask = target_pose.IGNORE_VX | target_pose.IGNORE_VY | target_pose.IGNORE_VZ | target_pose.IGNORE_AFZ | target_pose.IGNORE_AFY | target_pose.IGNORE_AFX;
    target_pose.coordinate_frame = 1;
    target_pose.yaw = 3.141592/2;
    
    //create publishers and client
    ros::Publisher servo_pub = n.advertise<std_msgs::Int32>("servo_command",10);
    ros::Publisher local_pos_pub_mavros = n.advertise<mavros_msgs::PositionTarget>("mavros/setpoint_raw/local", 5);
    ros::ServiceClient placement_client = n.serviceClient<drone_pkg::PlaceSensor>("find_spot");

    //create subscrivers and service
    ros::Subscriber local_pos_sub = n.subscribe("mavros/local_position/pose", 10, local_pos_cb);
    ros::Subscriber global_pos_sub = n.subscribe("mavros/global_position/global", 10, global_pos_cb);
    ros::Subscriber bat_sub = n.subscribe("mavros_msgs/battery", 10, bat_cb);
    ros::ServiceServer drone_op_server = n.advertiseService("start_drone_op", start_drone_op);

    cout << fixed << setprecision(7);
    cout << "DroneOp server is now running." << endl;

    ros::Rate loop_rate(20.0);
    ros::Time last_request = ros::Time::now();

    while (ros::ok()){
        if(placing_sensor){
            drone_pkg::PlaceSensor drone_state;
            ros::spinOnce();
            drone_state.request.latitude = lat;
            drone_state.request.longitude = lon;
            drone_state.request.battery = bat;

            if(placement_client.call(drone_state)){
                cout << "Found spot to place sensor at [" << drone_state.response.target_latitude 
                    << "," << drone_state.response.target_longitude << "]" << endl;              
                

                //pickup sensor
                servo_state.data = 1;
                servo_pub.publish(servo_state);

                //set local target
                ros::spinOnce();
                set_global2local_target(lat, lon, drone_state.response.target_latitude, drone_state.response.target_longitude);

                //fly to target
                fly_to_target(local_pos_pub_mavros, loop_rate);
                
                //lower height
                target_pose.position.z = 0.5;
                for(int i = 60; ros::ok() && i > 0; --i){
                    local_pos_pub_mavros.publish(target_pose);
                    loop_rate.sleep();
                }

                //drop sensor and store location
                servo_state.data = 0;
                servo_pub.publish(servo_state);
                sensor_pos[0].push_back(drone_state.response.target_latitude);
                sensor_pos[1].push_back(drone_state.response.target_longitude);
                cout << "Placed sensor " << calc_dist(lat, lon, drone_state.response.target_latitude, drone_state.response.target_longitude) << " m from the target spot" << endl;

                //print sensor_pos
                cout << "|Sensor Locations|" << endl;
                for ( const auto &row : sensor_pos)
                {
                    for ( const auto &s : row ) cout << s << ' ';
                    cout << endl;
                }

                //return home
                target_xy[0] = 0;
                target_xy[1] = 0;
                fly_to_target(local_pos_pub_mavros, loop_rate);

                //land

                //reset
                placing_sensor = false;
                waiting_for_op = true;
            }
            else
            {
                ROS_ERROR("Failed to call service find_spot");
            }
        }
        if(retrieving_sensor){
            double target_dist;
            
            ros::spinOnce();
            double min_dist = calc_dist(x, y, sensor_pos[0][0], sensor_pos[1][0]);
            double target_lat = sensor_pos[0][0];
            double target_lon = sensor_pos[1][0];
            int target_index = 0;

            //find closest sensorS
            for(int i = 1; i < sensor_pos[0].size(); i++){
                ros::spinOnce();
                target_dist = calc_dist(lat, lon, sensor_pos[0][i], sensor_pos[i][1]);
                if(target_dist < min_dist){
                    min_dist = target_dist;
                    target_lat = sensor_pos[0][i];
                    target_lon = sensor_pos[1][i];
                    target_index = i;
                }
            }
            
            cout << "Retrieving sensor from [" << target_lat << "," << target_lon <<"]" << endl;

            //open gripper
            servo_state.data = 0;
            servo_pub.publish(servo_state);

            //convert global target to local target
            ros::spinOnce();
            set_global2local_target(lat, lon, target_lat, target_lon);

            //fly to target locations
            fly_to_target(local_pos_pub_mavros, loop_rate);

            //precision land

            //pickup sensor
            servo_state.data = 1;
            servo_pub.publish(servo_state);
                
            //return home
            target_xy[0] = 0;
            target_xy[1] = 0;
            fly_to_target(local_pos_pub_mavros, loop_rate);

            //land

            //release sensor
            servo_state.data = 0;
            servo_pub.publish(servo_state);
            cout << "Retrieved sensor and returned home" << endl;
            //cout << "Retrieved sensor and returned to [" << lat << "," << lon << "]" << endl;

            //remove sensor from placed sensors list
            for(auto& r : sensor_pos) r.erase(r.begin()+target_index);
            
            //print sensor_pos
            cout << "|Sensor Locations|" << endl;
            for ( const auto &row : sensor_pos)
            {
                for ( const auto &s : row ) cout << s << ' ';
                cout << endl;
            }

            //reset 
            retrieving_sensor = false;
            waiting_for_op = true;
        }
        
        local_pos_pub_mavros.publish(target_pose);
        ros::spinOnce();
        loop_rate.sleep();
    }

    return 0;
}
