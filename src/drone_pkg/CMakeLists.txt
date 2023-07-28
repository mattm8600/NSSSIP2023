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

find_package(
  cmake_modules REQUIRED
  Eigen 3.1.2 Required
)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

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

find_library (GeographicLib_LIBRARIES Geographic
  PATHS "${CMAKE_INSTALL_PREFIX}/../GeographicLib/lib")

if (GeographicLib_LIBRARIES)
  get_filename_component (GeographicLib_LIBRARY_DIRS
    "${GeographicLib_LIBRARIES}" PATH)

  get_filename_component (_ROOT_DIR "${GeographicLib_LIBRARY_DIRS}" PATH)
  set (GeographicLib_INCLUDE_DIRS "${_ROOT_DIR}/../include")
  set (GeographicLib_BINARY_DIRS "${_ROOT_DIR}/../bin")

  # Required for Debian-alike systems
  find_library (GeographicLib_LIBRARIES_DEBIAN libGeographic.so
    PATHS "/usr/lib/x86_64-linux-gnu")
  if (GeographicLib_LIBRARIES_DEBIAN)
    set (GeographicLib_LIBRARIES ${GeographicLib_LIBRARIES_DEBIAN})
    get_filename_component (GeographicLib_LIBRARY_DIRS
      "${GeographicLib_LIBRARIES}" PATH)
  endif ()
endif ()

## Declare a catkin package
catkin_package(
DEPENDS Eigen roscpp  
CATKIN_DEPENDS 
  message_runtime
  roscpp
  sensor_msgs
  std_msgs
  geometry_msgs
)

include_directories(include
  ${catkin_INCLUDE_DIRS}
  ${Eigen_INCLUDE_DIRS}
)

## Add executables, libraries, and dependencies
add_executable(drone_offboard src/drone_offboard.cpp)
add_executable(PID_controller src/PID_controller.cpp)
target_link_libraries(drone_offboard ${catkin_LIBRARIES})