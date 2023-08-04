#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Ctrl + Shift + P > Python: Select Interpreter > Select the environment's Python
# Also, install the dependencies (pip install screeninfo, pip install gdal) in the environment

import numpy as np
import mss
import os
import subprocess
from osgeo import gdal, osr
import shutil
import time
import warnings
import glob

# User-defined parameters
region_path = "/home/arl/sensor_placement/Middle River MD/imagery/Middle_River_MD.kml"
res = 0.1 # desired image resolution in meters per pixel
output_tiles = True
overlap = 0.01 # tile overlap as a fraction of tile_w_px or tile_h_px (whichever is smaller)
delay_1 = 0.2 # delay in seconds between hitting Ctrl+O and start typing the name of the kml file (depends on how fast is the computer, can't be zero)
delay_2 = 0.5 # delay in seconds between opening the kml and taking the screenshot (depends on how fast is the internet connection to load new imagery, can't be zero)
monitor_number = 2
top_offset_px = 49 # Height of menu bar and Save Image bar in Save Image mode while in fullscreen, plus 3 pixels
bottom_offset_px = 3
left_offset_px = 3
right_offset_px = 3

# Constant parameters
coef_E_W_meters_per_long_degree = [1.1131807995e5, -3.35813044e-3, -1.6840061888e1, -1.3023234e-4, 4.0909332e-4, -2.38936345e-7, 3.0050341e-9, -5.8877193e-11, 3.255011e-13, -1.452134e-15, 3.798218e-18]
coef_N_S_meters_per_lat_degree = [1.10572900133e5, 1.32793868e-3, 3.3825421977e-1, -4.41313078e-5, -2.825211148e-5, -2.95556716e-7, 1.07014877e-8, -1.8125497e-10, 2.0312706e-12, -1.26069492e-14, 3.2501092e-17]
coef_E_W_meters_per_alt_meter = [1.15410200035772e0, 2.78369990526706e-7, 1.14830723192609e-6, -1.57859882534083e-9, 2.6942459081664e-10, -2.4459590062806e-11, 7.9246128384021e-13, -1.4640294452702e-14, 1.5870865280213e-16, -9.3526429063741e-19, 2.3146568993276e-21]

# Global variables
kml_path = os.path.dirname(region_path) + "/camera.kml"
mosaic_path = os.path.splitext(region_path) + "_GE_imagery.tif"
images_folder_path = os.path.dirname(region_path) + "/tiles"
with mss.mss() as sct:
    tile_w_px = sct.monitors[monitor_number]["width"] - left_offset_px - right_offset_px # tile width in pixels
    tile_h_px = sct.monitors[monitor_number]["height"] - top_offset_px - bottom_offset_px # tile height in pixels
tile_w_m = tile_w_px * res # Real-life East-West distance covered in one tile, in meters
tile_h_m = tile_h_px * res # Real-life North-South distance covered in one tile, in meters
overlap_meters = min(tile_w_m, tile_h_m) * overlap # Real-life overlap between vertically or horizontally adjacent tiles, in meters
lon_min = 0
lon_max = 0
lon_max_captured = float("-inf")
lat_min = 0
lat_max = 0
lat_max_captured = float("-inf")

def read_polygon():
    global lon_min, lon_max, lat_min, lat_max
    str_line = ""
    row = 0
    col = 0
    get_coordinates = False
    try:
        with open(region_path, 'r') as fstream:
            for line in fstream:
                str_line = line.strip()
                if get_coordinates:
                    while len(str_line) > 0:
                        next_separator = str_line.find(',')
                        if next_separator == -1:
                            next_separator = len(str_line)
                        coordinate = float(str_line[:next_separator])
                        if col == 0:
                            if coordinate < lon_min or row == 0:
                                lon_min = coordinate
                            if coordinate > lon_max or row == 0:
                                lon_max = coordinate
                        else:
                            if coordinate < lat_min or row == 0:
                                lat_min = coordinate
                            if coordinate > lat_max or row == 0:
                                lat_max = coordinate
                        try:
                            str_line = str_line[next_separator + 1 + 2 * col:]
                        except Exception:
                            str_line = ""
                        row += col
                        col += 1 - 2 * col
                    break
                get_coordinates = str_line.find("<coordinates>") > -1
    except Exception as e:
        print("Error:", e)

def capture_imagery():
    global lon_max_captured, lat_max_captured
    # 1. Delete previously created mosaic file and tiles folder, and create new tiles folder
    if os.path.exists(mosaic_path):
        os.remove(mosaic_path)
    if os.path.exists(images_folder_path):
        shutil.rmtree(images_folder_path)
    os.makedirs(images_folder_path, exist_ok = True)
    # 2. Activate Google Earth window
    for command in ["xdotool search --onlyvisible --name 'Google Earth Pro' windowactivate --sync", f"sleep 2"]:
        subprocess.run(command, shell= True)
    # 3. Set longitude and latitude of first tile
    center_lat = lat_min + (0.5 * tile_h_m) / get_N_S_meters_per_lat_degree(lat_min)
    center_lon = lon_min + (0.5 * tile_w_m) / get_E_W_meters_per_lon_degree(center_lat)
    tile_col = 1
    tile_row = 1
    # 4. Loop all latitudes
    keep_capturing = True
    while keep_capturing and center_lat - (0.5 * tile_h_m - overlap_meters) / get_N_S_meters_per_lat_degree(center_lat) <= lat_max:
        # 4.1. Update altitude 
        current_alt = tile_w_m / np.polyval(coef_E_W_meters_per_alt_meter[::-1], center_lat)
        # 4.2. Loop all longitudes
        while keep_capturing and center_lon - (0.5 * tile_w_m - overlap_meters) / get_E_W_meters_per_lon_degree(center_lat) <= lon_max:
            print(f"Capturing tile for row {tile_row} col {tile_col}. ", end = '')
            # 4.2.1. Write kml file with the updated camera view
            with open(kml_path, 'w') as file:
                file.write(f'<?xml version="1.0" encoding="UTF-8"?>\n<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">\n<Document>\n\t<LookAt>\n\t\t<longitude>{center_lon}</longitude>\n\t\t<latitude>{center_lat}</latitude>\n\t\t<range>{current_alt}</range>\n\t</LookAt>\n</Document></kml>')
            # 4.2.2. Send commands to Google Earth to open the kml file and fly to the location
            keep_capturing = False
            if ("Google Earth" in subprocess.check_output(f"xdotool getwindowname {subprocess.check_output('xdotool getactivewindow', shell=True).decode().strip()}", shell=True).decode().strip()):
                for command in ["xdotool key ctrl+o", f"sleep {delay_1}"]:
                    subprocess.run(command, shell = True)
                if ("Open" == subprocess.check_output(f"xdotool getwindowname {subprocess.check_output('xdotool getactivewindow', shell=True).decode().strip()}", shell=True).decode().strip()):
                    for command in [f"xdotool type --delay 0 '{kml_path}'", "xdotool key Return", f"sleep {delay_2}"]:
                        subprocess.run(command, shell = True)
                    keep_capturing = True
                os.remove(kml_path)
            if (keep_capturing):
                # 4.2.3. Take screenshot
                with mss.mss() as sct: image_data = np.array(sct.grab({ "top": sct.monitors[monitor_number]["top"] + top_offset_px, "left": sct.monitors[monitor_number]["left"] + left_offset_px, "width": tile_w_px, "height": tile_h_px, "mon": monitor_number }))
                # 4.2.4. Save screenshot as TIFF
                tile_path = f"{images_folder_path}/{os.path.splitext(os.path.basename(region_path))[0]}_GE_imagery_{tile_row}_{tile_col}.tif"
                tile_ds = gdal.GetDriverByName("GTiff").Create(tile_path, tile_w_px, tile_h_px, 3, gdal.GDT_Byte) # path, width, height, bands
                srs = osr.SpatialReference()
                srs.SetWellKnownGeogCS("WGS84")
                tile_ds.SetGeoTransform((center_lon - 0.5 * tile_w_m / get_E_W_meters_per_lon_degree(center_lat), res / get_E_W_meters_per_lon_degree(center_lat), 0, center_lat + 0.5 * tile_h_m / get_N_S_meters_per_lat_degree(center_lat), 0, - res / get_N_S_meters_per_lat_degree(center_lat))) # left, delta lon per pixel, 0, top, 0, delta lat per pixel
                tile_ds.SetProjection(srs.ExportToWkt())
                for band in range(3):
                    tile_ds.GetRasterBand(3 - band).WriteArray(image_data[:, :, band])
                tile_ds = None
            # 4.2.5. Update longitude for next iteration
            lon_max_captured = max(lon_max_captured, center_lon + 0.5 * tile_w_m / get_E_W_meters_per_lon_degree(center_lat))
            center_lon += (tile_w_m - overlap_meters) / get_E_W_meters_per_lon_degree(center_lat)
            tile_col += 1
            minutes, seconds = divmod(time.time() - start_time, 60)
            print(f"Elapsed time: {int(minutes):02d}:{int(seconds):02d}")
        # 4.3. Update latitude and longitude for next iteration
        lat_max_captured = max(lat_max_captured, center_lat + 0.5 * tile_h_m / get_N_S_meters_per_lat_degree(center_lat))
        center_lat +=  (tile_h_m - overlap_meters) / get_N_S_meters_per_lat_degree(center_lat)
        tile_row += 1
        center_lon = lon_min + (0.5 * tile_w_m) / get_E_W_meters_per_lon_degree(center_lat)
        tile_col = 1
    # 5. Merge tiles
    print(f"Merging tiles. ", end = '')
    tile_list = "\" \"".join(glob.glob(os.path.join(images_folder_path, "*.tif")))
    subprocess.run(f'gdal_merge.py -o "{mosaic_path}" "{tile_list}"', shell = True, stdout = subprocess.DEVNULL)
    minutes, seconds = divmod(time.time() - start_time, 60)
    print(f"Elapsed time: {int(minutes):02d}:{int(seconds):02d}\nRegion captured: longitude from {lon_min} to {lon_max_captured}, latitude from {lat_min} to {lat_max_captured}")
    # 5. Delete tiles folder if desired
    if not output_tiles and os.path.exists(images_folder_path):
        shutil.rmtree(images_folder_path)

def get_E_W_meters_per_lon_degree(lat):
    return np.polyval(coef_E_W_meters_per_long_degree[::-1], lat)

def get_N_S_meters_per_lat_degree(lat):
    return np.polyval(coef_N_S_meters_per_lat_degree[::-1], lat)

warnings.filterwarnings("ignore", category = FutureWarning)
warnings.filterwarnings("ignore", message="XGetWindowProperty\\[ NET WM DESKTOP\\] failed \\(code=1\\)")
start_time = time.time()
read_polygon()
capture_imagery()


