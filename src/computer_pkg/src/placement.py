import rospy
import numpy as np
from computer_pkg.srv import PlaceSensor, PlaceSensorResponse

def find_sensor_placement(req):
    #input parameters
    lat0 = req.latitude
    lon0 = req.longitude
    bat = req.battery

    #result of spot search
    tar_lat = lat0+0.0001 * (np.random.rand() - 0.5) * 2
    tar_lon = lon0+0.0001 * (np.random.rand() - 0.5) * 2

    target_pos = PlaceSensorResponse()
    target_pos.target_latitude = tar_lat
    target_pos.target_longitude = tar_lon

    return target_pos

def place_sensor_server():
    rospy.init_node('placement')
    placement_server = rospy.Service('find_spot', PlaceSensor, find_sensor_placement)
    print("Placement server is now running.")
    rospy.spin()

if __name__ == "__main__":
    place_sensor_server()