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

# Utility rule file for computer_pkg_geneus.

# Include any custom commands dependencies for this target.
include computer_pkg/CMakeFiles/computer_pkg_geneus.dir/compiler_depend.make

# Include the progress variables for this target.
include computer_pkg/CMakeFiles/computer_pkg_geneus.dir/progress.make

computer_pkg_geneus: computer_pkg/CMakeFiles/computer_pkg_geneus.dir/build.make
.PHONY : computer_pkg_geneus

# Rule to build all files generated by this target.
computer_pkg/CMakeFiles/computer_pkg_geneus.dir/build: computer_pkg_geneus
.PHONY : computer_pkg/CMakeFiles/computer_pkg_geneus.dir/build

computer_pkg/CMakeFiles/computer_pkg_geneus.dir/clean:
	cd /home/arl/NSSSIP2023/build/computer_pkg && $(CMAKE_COMMAND) -P CMakeFiles/computer_pkg_geneus.dir/cmake_clean.cmake
.PHONY : computer_pkg/CMakeFiles/computer_pkg_geneus.dir/clean

computer_pkg/CMakeFiles/computer_pkg_geneus.dir/depend:
	cd /home/arl/NSSSIP2023/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/arl/NSSSIP2023/src /home/arl/NSSSIP2023/src/computer_pkg /home/arl/NSSSIP2023/build /home/arl/NSSSIP2023/build/computer_pkg /home/arl/NSSSIP2023/build/computer_pkg/CMakeFiles/computer_pkg_geneus.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : computer_pkg/CMakeFiles/computer_pkg_geneus.dir/depend

