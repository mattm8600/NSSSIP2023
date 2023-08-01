# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "perception_pkg: 0 messages, 1 services")

set(MSG_I_FLAGS "")

# Find all generators

add_custom_target(perception_pkg_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/arl/NSSSIP2023/src/perception_pkg/srv/PlaceSensor.srv" NAME_WE)
add_custom_target(_perception_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "perception_pkg" "/home/arl/NSSSIP2023/src/perception_pkg/srv/PlaceSensor.srv" ""
)

#
#  langs = 
#


