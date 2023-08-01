cmake_minimum_required(VERSION 3.0.2)
project(computer_pkg)

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
  Eigen 3.4.0 REQUIRED
)

## Generate messages in the 'msg' folder
add_message_files(
  FILES
  AiDetection.msg
)

## Generate services in the 'srv' folder
add_service_files(
  FILES
  PlaceSensor.srv
)

## Generate added messages and services with any dependencies listed here
generate_messages(
  DEPENDENCIES 
  geographic_msgs
  mavros_msgs 
  sensor_msgs 
  std_msgs
  geometry_msgs
)

catkin_install_python(
  PROGRAMS 
  scripts/go_to_point_gui.py
  scripts/sim_launch.sh
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
  CATKIN_DEPENDS
  message_runtime
  geographic_msgs
  roscpp
  rospy
  sensor_msgs
  std_msgs
  Eigen
)

include_directories(include
  ${catkin_INCLUDE_DIRS}
  ${Eigen_INCLUDE_DIRS}
)

#add c++ executables
add_executable(go_to_point_node src/go_to_point_node.cpp)
add_executable(camera_convert_node src/camera_convert_node.cpp)
add_executable(circular_flight src/circular_flight.cpp)
add_executable(tflite_filter src/tflite_filter.cpp)

add_dependencies(camera_convert_node computer_pkg_generate_messages_cpp)
add_dependencies(tflite_filter computer_pkg_generate_messages_cpp)

target_link_libraries(go_to_point_node
   ${catkin_LIBRARIES}
)
target_link_libraries(camera_convert_node
    ${catkin_LIBRARIES}
)
target_link_libraries(circular_flight
    ${catkin_LIBRARIES}
)
target_link_libraries(tflite_filter
    ${catkin_LIBRARIES}
)