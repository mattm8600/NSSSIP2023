#!/bin/bash
cd ~/PX4-Autopilot
make px4_sitl_default jmavsim &
cd ~/Downloads
./QGroundControl.AppImage
