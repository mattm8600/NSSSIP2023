# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "computer_msgs: 1 messages, 0 services")

set(MSG_I_FLAGS "-Icomputer_msgs:/home/arl/NSSSIP2023/src/computer_msgs/msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(computer_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg" NAME_WE)
add_custom_target(_computer_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "computer_msgs" "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(computer_msgs
  "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/computer_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(computer_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/computer_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(computer_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(computer_msgs_generate_messages computer_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg" NAME_WE)
add_dependencies(computer_msgs_generate_messages_cpp _computer_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(computer_msgs_gencpp)
add_dependencies(computer_msgs_gencpp computer_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS computer_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(computer_msgs
  "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/computer_msgs
)

### Generating Services

### Generating Module File
_generate_module_eus(computer_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/computer_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(computer_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(computer_msgs_generate_messages computer_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg" NAME_WE)
add_dependencies(computer_msgs_generate_messages_eus _computer_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(computer_msgs_geneus)
add_dependencies(computer_msgs_geneus computer_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS computer_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(computer_msgs
  "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/computer_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(computer_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/computer_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(computer_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(computer_msgs_generate_messages computer_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg" NAME_WE)
add_dependencies(computer_msgs_generate_messages_lisp _computer_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(computer_msgs_genlisp)
add_dependencies(computer_msgs_genlisp computer_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS computer_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(computer_msgs
  "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/computer_msgs
)

### Generating Services

### Generating Module File
_generate_module_nodejs(computer_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/computer_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(computer_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(computer_msgs_generate_messages computer_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg" NAME_WE)
add_dependencies(computer_msgs_generate_messages_nodejs _computer_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(computer_msgs_gennodejs)
add_dependencies(computer_msgs_gennodejs computer_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS computer_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(computer_msgs
  "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/computer_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(computer_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/computer_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(computer_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(computer_msgs_generate_messages computer_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/arl/NSSSIP2023/src/computer_msgs/msg/AiDetection.msg" NAME_WE)
add_dependencies(computer_msgs_generate_messages_py _computer_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(computer_msgs_genpy)
add_dependencies(computer_msgs_genpy computer_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS computer_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/computer_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/computer_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/computer_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/computer_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/computer_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/computer_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/computer_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/computer_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/computer_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/computer_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/computer_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
