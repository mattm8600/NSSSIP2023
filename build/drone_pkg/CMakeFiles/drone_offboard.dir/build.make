# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.25

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/arl/.local/lib/python3.8/site-packages/cmake/data/bin/cmake

# The command to remove a file.
RM = /home/arl/.local/lib/python3.8/site-packages/cmake/data/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/arl/NSSSIP2023/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/arl/NSSSIP2023/build

# Include any dependencies generated for this target.
include drone_pkg/CMakeFiles/drone_offboard.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include drone_pkg/CMakeFiles/drone_offboard.dir/compiler_depend.make

# Include the progress variables for this target.
include drone_pkg/CMakeFiles/drone_offboard.dir/progress.make

# Include the compile flags for this target's objects.
include drone_pkg/CMakeFiles/drone_offboard.dir/flags.make

drone_pkg/CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.o: drone_pkg/CMakeFiles/drone_offboard.dir/flags.make
drone_pkg/CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.o: /home/arl/NSSSIP2023/src/drone_pkg/src/drone_offboard.cpp
drone_pkg/CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.o: drone_pkg/CMakeFiles/drone_offboard.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/arl/NSSSIP2023/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object drone_pkg/CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.o"
	cd /home/arl/NSSSIP2023/build/drone_pkg && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT drone_pkg/CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.o -MF CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.o.d -o CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.o -c /home/arl/NSSSIP2023/src/drone_pkg/src/drone_offboard.cpp

drone_pkg/CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.i"
	cd /home/arl/NSSSIP2023/build/drone_pkg && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/arl/NSSSIP2023/src/drone_pkg/src/drone_offboard.cpp > CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.i

drone_pkg/CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.s"
	cd /home/arl/NSSSIP2023/build/drone_pkg && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/arl/NSSSIP2023/src/drone_pkg/src/drone_offboard.cpp -o CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.s

# Object files for target drone_offboard
drone_offboard_OBJECTS = \
"CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.o"

# External object files for target drone_offboard
drone_offboard_EXTERNAL_OBJECTS =

/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: drone_pkg/CMakeFiles/drone_offboard.dir/src/drone_offboard.cpp.o
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: drone_pkg/CMakeFiles/drone_offboard.dir/build.make
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /opt/ros/noetic/lib/libroscpp.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /usr/lib/x86_64-linux-gnu/libpthread.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /usr/lib/x86_64-linux-gnu/libboost_chrono.so.1.71.0
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so.1.71.0
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /opt/ros/noetic/lib/librosconsole.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /opt/ros/noetic/lib/librosconsole_log4cxx.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /opt/ros/noetic/lib/librosconsole_backend_interface.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /usr/lib/x86_64-linux-gnu/liblog4cxx.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /usr/lib/x86_64-linux-gnu/libboost_regex.so.1.71.0
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /opt/ros/noetic/lib/libxmlrpcpp.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /opt/ros/noetic/lib/libroscpp_serialization.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /opt/ros/noetic/lib/librostime.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /usr/lib/x86_64-linux-gnu/libboost_date_time.so.1.71.0
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /opt/ros/noetic/lib/libcpp_common.so
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /usr/lib/x86_64-linux-gnu/libboost_system.so.1.71.0
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /usr/lib/x86_64-linux-gnu/libboost_thread.so.1.71.0
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: /usr/lib/x86_64-linux-gnu/libconsole_bridge.so.0.4
/home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard: drone_pkg/CMakeFiles/drone_offboard.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/arl/NSSSIP2023/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable /home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard"
	cd /home/arl/NSSSIP2023/build/drone_pkg && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/drone_offboard.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
drone_pkg/CMakeFiles/drone_offboard.dir/build: /home/arl/NSSSIP2023/devel/lib/drone_pkg/drone_offboard
.PHONY : drone_pkg/CMakeFiles/drone_offboard.dir/build

drone_pkg/CMakeFiles/drone_offboard.dir/clean:
	cd /home/arl/NSSSIP2023/build/drone_pkg && $(CMAKE_COMMAND) -P CMakeFiles/drone_offboard.dir/cmake_clean.cmake
.PHONY : drone_pkg/CMakeFiles/drone_offboard.dir/clean

drone_pkg/CMakeFiles/drone_offboard.dir/depend:
	cd /home/arl/NSSSIP2023/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/arl/NSSSIP2023/src /home/arl/NSSSIP2023/src/drone_pkg /home/arl/NSSSIP2023/build /home/arl/NSSSIP2023/build/drone_pkg /home/arl/NSSSIP2023/build/drone_pkg/CMakeFiles/drone_offboard.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : drone_pkg/CMakeFiles/drone_offboard.dir/depend

