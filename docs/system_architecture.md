### Placement
1. In a new terminal source devel/setup.bash and scripts/router_start.sh or export ROS_ID and ROS_IP
```
source devel/setup.bash
&&
source scripts/router_start.sh
OR
export ROS_IP=computerIP
export ROS_MASTER_URI=http://droneIP:11311
```
2. Call the start drone op service with a 0
```
rosservice call /start_drone_op 0
```

### Retrieval
1. In a new terminal source devel/setup.bash and scripts/router_start.sh or export ROS_ID and ROS_IP
```
source devel/setup.bash
&&
source scripts/router_start.sh
OR
export ROS_IP=computerIP
export ROS_MASTER_URI=http://droneIP:11311
```
2. Call the start drone op service with a 1
```
rosservice call /start_drone_op 1
```
