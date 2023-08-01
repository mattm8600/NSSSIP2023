cmake_minimum_required(VERSION 3.0.2)
project(computer_msgs)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

## Find catkin macros and libraries
find_package(catkin REQUIRED
    message_generation
)

## Generate messages in the 'msg' folder
add_message_files(
    FILES
    AiDetection.msg
)

generate_messages()

catkin_package(
    CATKIN_DEPENDS 
    message_runtime
)

include_directories(include
    ${catkin_INCLUDE_DIRS}
)


