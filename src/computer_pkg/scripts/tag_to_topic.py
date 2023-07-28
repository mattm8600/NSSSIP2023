#!/usr/bin/env python
import sys
import rospy
from std_msgs.msg import String

def talker():
    pub = rospy.Publisher('terminal', String, queue_size=10)
    rospy.init_node('tag_to_topic', anonymous=True)
    rate = rospy.Rate(10)
    while not rospy.is_shutdown:
        pub.publish("Hello World")
        rate.sleep()
        # print("Running")
        # try:
        #    line = input()
        #    pub.publish(line)
        # except EOFError:
        #    print("Done")

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass