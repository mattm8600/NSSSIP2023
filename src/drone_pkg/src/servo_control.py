#!/usr/bin/env python

import sys
import rospy
import serial
from serial.tools import list_ports
from std_msgs.msg import Int32

VENDOR_ID = "16C0"
PRODUCT_ID = "0483"
SERIAL_NUMBER = "4353800"

response_pub = rospy.Publisher('servo_response', Int32, queue_size=10)

def getTeensyPort():
    for port in list(list_ports.comports()):
        #print(port[2])
        if VENDOR_ID in port[2] and PRODUCT_ID in port[2] and SERIAL_NUMBER in port[2]:
            return port[0]
        
def wait_teensy_response():
    while teensy.in_waiting == 0:
        #print("waiting for response")
        pass
    response = teensy.readline()
    decoded_response = int(response.decode())
    #print("Received: " + str(decoded_response))
    return decoded_response
        
def callback(data):
    print("Sending: " + str(data.data))
    teensy.write(str(data).encode())
    teensy.flush()
    response = wait_teensy_response()
    
    #print(response)

    if data.data == 1 and response == 0:
        print("No sensor detected in jaws")
        response_pub.publish(response)
    elif data.data == 1 and response == 1:
        print("Sensor picked up")
        response_pub.publish(response)
    elif data.data == 0 and response == 1:
        print("Jaws opened")
    elif data.data == 0 and response == 0:
        print("Error with detection mechanism")

    

def listen():
    rospy.init_node('servo_node', anonymous=True)
    rospy.Subscriber("servo_command", Int32, callback)
    rospy.spin()


    

if __name__ == '__main__':

    teensy_port = getTeensyPort() 
    try:
        teensy = serial.Serial(port=teensy_port, baudrate=115200, timeout=.1)
        print("Connected to teensy on port " + teensy_port)
    except:
        print("Can't find teensy")

    listen()




