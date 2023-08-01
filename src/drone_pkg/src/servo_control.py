#!/usr/bin/env python

import sys
import rospy
import serial
import time
from serial.tools import list_ports
from std_msgs.msg import Int32

VENDOR_ID = "16C0"
PRODUCT_ID = "0483"
SERIAL_NUMBER = "4353800"

response_pub = rospy.Publisher('servo_response', Int32, queue_size=10)
timeout = 1

def getTeensyPort():
    for port in list(list_ports.comports()):
        #print(port[2])
        if VENDOR_ID in port[2] and PRODUCT_ID in port[2] and SERIAL_NUMBER in port[2]:
            return port[0]
       
def wait_teensy_response():
    time_start = time.time()
    no_timeout = True
    while teensy.in_waiting == 0:
        #print("waiting for response")
        if time.time() > time_start + timeout:
            no_timeout = False
            break
    
    if no_timeout:
        response = teensy.readline()
        decoded_response = int(response.decode())
        return decoded_response
    else:
        return 2
    #print("Received: " + str(decoded_response))


def callback(data):
    print("Sending: " + str(data.data))
    teensy.write(str(data).encode())
    teensy.flush()

def setup():
    rospy.init_node('servo_node', anonymous=True)
    rospy.Subscriber("servo_command", Int32, callback)
    print("Servo node started")
    

if __name__ == '__main__':

    teensy_port = getTeensyPort() 
    try:
        teensy = serial.Serial(port=teensy_port, baudrate=115200, timeout=.1)
        print("Connected to teensy on port " + teensy_port)
    except:
        print("Can't find teensy")

    setup()

    while not rospy.is_shutdown():
        
        response = wait_teensy_response()
        print(response)

        rospy.sleep(0.02)
    

    



