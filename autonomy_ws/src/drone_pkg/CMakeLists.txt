cmake_minimum_required(VERSION 3.0.2)
project(drone_pkg)

## Compile as C++11, supported in ROS Kinetic and newer

## Find catkin and any catkin packages
find_package(catkin REQUIRED COMPONENTS
  mavros_msgs
  sensor_msgs
  roscpp
  rospy
  std_msgs
  geographic_msgs
  geometry_msgs
  message_generation
)

## Generate messages in the 'msg' folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )

## Generate services in the 'srv' folder
add_service_files(
  FILES
  PlaceSensor.srv
  DroneOp.srv
)

## Generate added messages and services with any dependencies listed here
generate_messages(
  DEPENDENCIES 
  mavros_msgs 
  sensor_msgs 
  std_msgs
  geographic_msgs
  geometry_msgs
)

catkin_install_python(PROGRAMS src/servo_control.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

## Declare a catkin package
catkin_package(CATKIN_DEPENDS message_runtime)

include_directories(include
  ${catkin_INCLUDE_DIRS}
)

## Add executables, libraries, and dependencies
add_executable(drone_offboard src/drone_offboard.cpp)
target_link_libraries(drone_offboard ${catkin_LIBRARIES})
# add_dependencies(drone_offboard autonomy_pkg_generate_messages_cpp)