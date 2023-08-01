cmake_minimum_required(VERSION 2.8.3)
project(perception_pkg)

## Find catkin and any catkin packages
find_package(catkin REQUIRED COMPONENTS
    rospy
)

## Generate services in the 'srv' folder
add_service_files(
  FILES
  PlaceSensor.srv
)

## Generate added messages and services with any dependencies listed here
generate_messages()

catkin_install_python(
    PROGRAMS 
    src/placement.py
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

## Declare a catkin package
catkin_package(
    CATKIN_DEPENDS
    rospy
)

## Your package locations should be listed before other locations
include_directories(include 
    ${catkin_INCLUDE_DIRS}
)

