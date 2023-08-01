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
#include "mavros_msgs/CommandBool.h"
#include "mavros_msgs/SetMode.h"
#include "computer_pkg/AiDetection.h"
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
array<double,2> target_latlon;

float bat;

int control_mode;
bool waiting_for_op = true;
bool placing_sensor = false;
bool retrieving_sensor = false;
int getting_tflite = 0;
int detected_flag = 0;
bool hasSensorBox = false;
bool test = true;

vector<double> sensor_pos[2];
std_msgs::Int32 servo_state;
mavros_msgs::PositionTarget target_pose;
mavros_msgs::SetMode return_set_mode;
mavros_msgs::CommandBool arm_cmd;
computer_pkg::AiDetection tflite_data;

//declare publishers and clients
ros::Publisher servo_pub;
ros::Publisher local_pos_pub_mavros;
ros::ServiceClient placement_client;
ros::ServiceClient set_mode_client;
ros::ServiceClient arming_client;

//declare subscribers and services
ros::Subscriber local_pos_sub;
ros::Subscriber global_pos_sub;
ros::Subscriber bat_sub;
ros::Subscriber tflite_sub;
ros::Subscriber servo_response_sub;
ros::ServiceServer drone_op_server;

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

void tflite_callback(const computer_pkg::AiDetection::ConstPtr& msg) {
    tflite_data = *msg;
    getting_tflite = 1;
    if(tflite_data.class_confidence > 0) {
        detected_flag = 1;
    }
    else {
        detected_flag = 0;
    }
}

void servo_cb(std_msgs::Int32 response){
    if(response.data == 1){
        hasSensorBox = true;
    }
    hasSensorBox = false;
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

void print_sensor_pos(){
    //print sensor positions
    cout << "|Sensor Locations|" << endl;
    for ( const auto &row : sensor_pos)
    {
        for ( const auto &s : row ) cout << s << ' ';
        cout << endl;
    }
}

double calc_dist(double x, double y, double tar_x, double tar_y){
    double dist = sqrt(pow((x-tar_x),2)+pow((y-tar_y),2));
    return dist;
}

int find_target(){
    double target_dist;
            
    ros::spinOnce();
    double min_dist = calc_dist(x, y, sensor_pos[0][0], sensor_pos[1][0]);
    double target_lat = sensor_pos[0][0];
    double target_lon = sensor_pos[1][0];
    int target_index = 0;

    //find closest sensor
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

    target_latlon[0] = target_lat;
    target_latlon[1] = target_lon;

    return target_index;
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

void fly_to_target(double target_lat, double target_lon, ros::Rate loop_rate){
    //raise to cruising height
    target_pose.position.z = 3.0;
    for(int i = 60; ros::ok() && i > 0; --i){
        local_pos_pub_mavros.publish(target_pose);
        loop_rate.sleep();
    }

    //set target coordinates
    ros::spinOnce();
    set_global2local_target(lat, lon, target_lat, target_lon);
    target_pose.position.x = target_xy[0];
    target_pose.position.y = target_xy[1];
    
    //fly to target coordinates
    while(calc_dist(x, y, target_xy[0], target_xy[1]) > 0.5){
        local_pos_pub_mavros.publish(target_pose);     
        loop_rate.sleep();
        ros::spinOnce();
    }


    //hover for three seconds to settle
    for(int i = 60; ros::ok() && i > 0; --i){
        local_pos_pub_mavros.publish(target_pose);
        loop_rate.sleep();
    }

}

void wait_for_detection(ros::Rate loop_rate){
    ros::spinOnce();
    while(detected_flag != 1 && ros::ok()){
        //hover while waiting or add search function
        cout << "Cannot see sensor box" << endl;
        local_pos_pub_mavros.publish(target_pose);
        loop_rate.sleep();
        ros::spinOnce();
    }
}

void start_PID_control(){
    //set control mode to 1 for PID controller to publish velocities
    ros::param::set("/PID_control", 1);
    ros::param::get("/PID_control",control_mode);
    while(control_mode!=0 && ros::ok()){
        //wait for PID_controller to relinquish control (control mode = 0)
        ros::param::get("/PID_control",control_mode);
    }
}

void checkForSensorBox(){
    //close sensor and spin for callback
    servo_state.data = 1;
    servo_pub.publish(servo_state);
    ros::spinOnce();
}

void place_sensor(ros::Rate loop_rate){
    //arm drone
    if(arming_client.call(arm_cmd) && arm_cmd.response.success){
        ROS_INFO("Vehicle armed");
    }

    //take in drone state
    ros::spinOnce();
    drone_pkg::PlaceSensor drone_state;
    drone_state.request.latitude = lat;
    drone_state.request.longitude = lon;
    drone_state.request.battery = bat;

    //call placement node with drone state to recieve target location
    if(placement_client.call(drone_state)){
        cout << "Found spot to place sensor at [" << drone_state.response.target_latitude 
             << "," << drone_state.response.target_longitude << "]" << endl;              
                
        //pickup sensor
        servo_state.data = 1;
        servo_pub.publish(servo_state);

        //fly to target
        fly_to_target(drone_state.response.target_latitude, drone_state.response.target_longitude, loop_rate);
                
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

        //print sensor positions
        print_sensor_pos();

        //return to home
        if( set_mode_client.call(return_set_mode) &&
            return_set_mode.response.mode_sent){
            cout << "returing to home position" << endl;
        }

        //reset
        placing_sensor = false;
        waiting_for_op = true;
    }
    else{
        ROS_ERROR("Failed to call service find_spot");
    }
}

void retrieve_sensor(ros::Rate loop_rate){
    //arms drone
    if(arming_client.call(arm_cmd) && arm_cmd.response.success){
        ROS_INFO("Vehicle armed");
    }

    //find sensor to retrieve
    int target_index = find_target();
    cout << "Retrieving sensor from [" << target_latlon[0] << "," << target_latlon[1] <<"]" << endl;

    //open gripper
    servo_state.data = 0;
    servo_pub.publish(servo_state);

    //fly to target locations
    fly_to_target(target_latlon[0], target_latlon[1], loop_rate);

    //loop until sensor box has been picked up
    while(!hasSensorBox && ros::ok()){
        //ensure gripper is open
        servo_state.data = 0;
        servo_pub.publish(servo_state);
        
        //wait for sensor to be detected
        wait_for_detection(loop_rate);

        //let PID controller attempt to land on sensor
        start_PID_control();

        //attempt to pickup sensor
        servo_state.data = 1;
        servo_pub.publish(servo_state);

        //raise height
        target_pose.position.z = 3.0;
        for(int i = 60; ros::ok() && i > 0; --i){
            local_pos_pub_mavros.publish(target_pose);
            loop_rate.sleep();
        }

        //check if sensor is still in gripper
        checkForSensorBox();
    }

    //return home
    if( set_mode_client.call(return_set_mode) &&
        return_set_mode.response.mode_sent){
        cout << "returing to home position" << endl;
    }

    //release sensor
    servo_state.data = 0;
    servo_pub.publish(servo_state);
    hasSensorBox = false;
    cout << "Retrieved sensor and returned home" << endl;
    //cout << "Retrieved sensor and returned to [" << lat << "," << lon << "]" << endl;

    //remove sensor from placed sensors list
    for(auto& r : sensor_pos) r.erase(r.begin()+target_index);
    
    //print sensor positions
    print_sensor_pos();

    //reset 
    retrieving_sensor = false;
    waiting_for_op = true;
}

int main(int argc, char **argv){
    ros::init(argc,argv, "drone_offboard");
    ros::NodeHandle n;

    //initialize target_pose
    target_pose.type_mask = target_pose.IGNORE_VX | target_pose.IGNORE_VY | target_pose.IGNORE_VZ | target_pose.IGNORE_AFZ | target_pose.IGNORE_AFY | target_pose.IGNORE_AFX;
    target_pose.coordinate_frame = 1;
    target_pose.yaw = 3.141592/2;

    //initialize return set mode to auto return and land
    return_set_mode.request.custom_mode = "AUTO.RTL";

    //initialize arm request to true
    arm_cmd.request.value = true;
    
    //initialize publishers and client
    servo_pub = n.advertise<std_msgs::Int32>("servo_command",10);
    local_pos_pub_mavros = n.advertise<mavros_msgs::PositionTarget>("mavros/setpoint_raw/local", 5);
    placement_client = n.serviceClient<drone_pkg::PlaceSensor>("find_spot");
    set_mode_client = n.serviceClient<mavros_msgs::SetMode>("mavros/set_mode");
    arming_client = n.serviceClient<mavros_msgs::CommandBool>("mavros/cmd/arming");
    
    //initialize subscrivers and service
    local_pos_sub = n.subscribe("mavros/local_position/pose", 10, local_pos_cb);
    global_pos_sub = n.subscribe("mavros/global_position/global", 10, global_pos_cb);
    bat_sub = n.subscribe("mavros_msgs/battery", 10, bat_cb);
    tflite_sub = n.subscribe<computer_pkg::AiDetection>("tflite_data", 100, tflite_callback);
    servo_response_sub = n.subscribe<std_msgs::Int32>("/servo_response", 10, servo_cb);
    drone_op_server = n.advertiseService("start_drone_op", start_drone_op);

    cout << fixed << setprecision(7);
    cout << "DroneOp server is now running." << endl;

    ros::Rate loop_rate(20);
    ros::Time last_request = ros::Time::now();

    while (ros::ok()){
        if(placing_sensor)
        {
            place_sensor(loop_rate);
        }
        
        if(retrieving_sensor)
        {
            retrieve_sensor(loop_rate);
        }

        local_pos_pub_mavros.publish(target_pose);
        ros::spinOnce();
        loop_rate.sleep();
    }

    return 0;
}
