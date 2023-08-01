#!/usr/bin/env python3
from tkinter import *
from tkinter import ttk
import rospy
root = Tk()
root.geometry("400x200")
frm = ttk.Frame(root, padding=10)
frm.grid()
ttk.Label(frm, text="Input Coordinates Here", font=("Arial", 12)).grid(column=0, row=0)
ttk.Label(frm, text="Lat coordinate: ", font=("Georgia", 12)).grid(column=0, row=1)
ttk.Label(frm, text="Lon coordinate: ", font=("Arial", 12)).grid(column=0,row=2)
lat_ent = ttk.Entry(frm)
lat_ent.grid(column=1, row = 1)
lon_ent = ttk.Entry(frm)
lon_ent.grid(column=1, row = 2)

def button_callback():
    lat = lat_ent.get()
    lon = lon_ent.get()
    if lat is not None:
        print("Setting Latitude to "+ lat)
        rospy.set_param("/main.py/lat", float(lat))
    if lon is not None:    
        print("Setting Longitude to " + lon)
        rospy.set_param("/main.py/lon", float(lon))

exec_button = Button(text="Go to coordinate", font=("Arial", 12), command=button_callback).grid(column=0,row=4)
root.mainloop()