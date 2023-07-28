#!/usr/bin/env python3
from tkinter import *
from tkinter import ttk
import rospy
root = Tk()
root.geometry("400x200")
frm = ttk.Frame(root, padding=10)
frm.grid()
ttk.Label(frm, text="Input Coordinates Here", font=("Arial", 12)).grid(column=0, row=0)
ttk.Label(frm, text="X coordinate: ", font=("Georgia", 12)).grid(column=0, row=1)
ttk.Label(frm, text="Y coordinate: ", font=("Arial", 12)).grid(column=0,row=2)
ttk.Label(frm, text="Z coordinate: ", font=("Arial", 12)).grid(column=0,row=3)
x_ent = ttk.Entry(frm)
x_ent.grid(column=1, row = 1)
y_ent = ttk.Entry(frm)
y_ent.grid(column=1, row = 2)
z_ent = ttk.Entry(frm)
z_ent.grid(column=1, row = 3)

def button_callback():
    x = x_ent.get()
    y = y_ent.get()
    z = z_ent.get()
    if x is not None:
        print("Setting x to "+ x)
        rospy.set_param("/go_to_point_node/x_coord", float(x))
    if y is not None:    
        print("Setting y to " + y)
        rospy.set_param("/go_to_pont_node/y_coord", float(y))
    if z is not None:
        print("Setting z" + z)
        rospy.set_param("/go_to_point_node/z_coord", float(z))


exec_button = Button(text="Go to coordinate", font=("Arial", 12), command=button_callback).grid(column=0,row=4)
root.mainloop()
