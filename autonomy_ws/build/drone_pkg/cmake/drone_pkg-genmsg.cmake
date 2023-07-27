# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "drone_pkg: 0 messages, 2 services")

set(MSG_I_FLAGS "-Imavros_msgs:/opt/ros/noetic/share/mavros_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Igeographic_msgs:/opt/ros/noetic/share/geographic_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Iuuid_msgs:/opt/ros/noetic/share/uuid_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(drone_pkg_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv" NAME_WE)
add_custom_target(_drone_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "drone_pkg" "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv" ""
)

get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv" NAME_WE)
add_custom_target(_drone_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "drone_pkg" "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drone_pkg
)
_generate_srv_cpp(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drone_pkg
)

### Generating Module File
_generate_module_cpp(drone_pkg
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drone_pkg
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(drone_pkg_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(drone_pkg_generate_messages drone_pkg_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_cpp _drone_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_cpp _drone_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drone_pkg_gencpp)
add_dependencies(drone_pkg_gencpp drone_pkg_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drone_pkg_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drone_pkg
)
_generate_srv_eus(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drone_pkg
)

### Generating Module File
_generate_module_eus(drone_pkg
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drone_pkg
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(drone_pkg_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(drone_pkg_generate_messages drone_pkg_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_eus _drone_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_eus _drone_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drone_pkg_geneus)
add_dependencies(drone_pkg_geneus drone_pkg_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drone_pkg_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drone_pkg
)
_generate_srv_lisp(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drone_pkg
)

### Generating Module File
_generate_module_lisp(drone_pkg
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drone_pkg
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(drone_pkg_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(drone_pkg_generate_messages drone_pkg_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_lisp _drone_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_lisp _drone_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drone_pkg_genlisp)
add_dependencies(drone_pkg_genlisp drone_pkg_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drone_pkg_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drone_pkg
)
_generate_srv_nodejs(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drone_pkg
)

### Generating Module File
_generate_module_nodejs(drone_pkg
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drone_pkg
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(drone_pkg_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(drone_pkg_generate_messages drone_pkg_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_nodejs _drone_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_nodejs _drone_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drone_pkg_gennodejs)
add_dependencies(drone_pkg_gennodejs drone_pkg_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drone_pkg_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drone_pkg
)
_generate_srv_py(drone_pkg
  "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drone_pkg
)

### Generating Module File
_generate_module_py(drone_pkg
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drone_pkg
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(drone_pkg_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(drone_pkg_generate_messages drone_pkg_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/PlaceSensor.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_py _drone_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/arl/NSSSIP2023/autonomy_ws/src/drone_pkg/srv/DroneOp.srv" NAME_WE)
add_dependencies(drone_pkg_generate_messages_py _drone_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(drone_pkg_genpy)
add_dependencies(drone_pkg_genpy drone_pkg_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS drone_pkg_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drone_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/drone_pkg
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET mavros_msgs_generate_messages_cpp)
  add_dependencies(drone_pkg_generate_messages_cpp mavros_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(drone_pkg_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(drone_pkg_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geographic_msgs_generate_messages_cpp)
  add_dependencies(drone_pkg_generate_messages_cpp geographic_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(drone_pkg_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drone_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/drone_pkg
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET mavros_msgs_generate_messages_eus)
  add_dependencies(drone_pkg_generate_messages_eus mavros_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(drone_pkg_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(drone_pkg_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geographic_msgs_generate_messages_eus)
  add_dependencies(drone_pkg_generate_messages_eus geographic_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(drone_pkg_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drone_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/drone_pkg
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET mavros_msgs_generate_messages_lisp)
  add_dependencies(drone_pkg_generate_messages_lisp mavros_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(drone_pkg_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(drone_pkg_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geographic_msgs_generate_messages_lisp)
  add_dependencies(drone_pkg_generate_messages_lisp geographic_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(drone_pkg_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drone_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/drone_pkg
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET mavros_msgs_generate_messages_nodejs)
  add_dependencies(drone_pkg_generate_messages_nodejs mavros_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(drone_pkg_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(drone_pkg_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geographic_msgs_generate_messages_nodejs)
  add_dependencies(drone_pkg_generate_messages_nodejs geographic_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(drone_pkg_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drone_pkg)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drone_pkg\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/drone_pkg
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET mavros_msgs_generate_messages_py)
  add_dependencies(drone_pkg_generate_messages_py mavros_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(drone_pkg_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(drone_pkg_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geographic_msgs_generate_messages_py)
  add_dependencies(drone_pkg_generate_messages_py geographic_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(drone_pkg_generate_messages_py geometry_msgs_generate_messages_py)
endif()
