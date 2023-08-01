# anirud_kashProgram determines the best location for sensor placement. In order for
# program to be used, it requires aerial imagery of some region, as well as 
# the corresponding LiDAR data. 
# 
# This program outputs various graphs to allow one to visualize the algorithm. 
# The plots are not needed, and you may remove it.

# Required python libraries
import cv2
import rospy
import numpy as np
from computer_pkg.srv import PlaceSensor, PlaceSensorResponse
import matplotlib.pyplot as plt
import rasterio
from rasterio.warp import transform_geom
from osgeo import gdal
import pyproj
from shapely.geometry import Point

#sets perception mode based of rosparam
# perception_mode = 0 | creates find_spot service but returns hardcoded values
# perception_mode = 1 | creates find_spot service and returns percieved target
# perception_mode = 2 | prints percieved target from inputed location
perception_mode = rospy.get_param("/perception_mode")

# Function that converts the lat/long coordinates (received from the drone),
# and returns the corresponding coordinates in the dest_crs coordinate system
def convert_coordinates(lat, lon, src_crs, dest_crs):

    transformer = pyproj.Transformer.from_crs(src_crs, dest_crs, always_xy=True)
    x, y = transformer.transform(lon, lat)
    return x,y 

# Function that calculates the slope of two pixel coordinates and returns the
# slope
def calculate_slope(elevation_data, x1, y1, x2, y2):

    elevation_pixel1 = elevation_data[int(y1), int(x1)]
    elevation_pixel2 = elevation_data[int(y2), int(x2)]
    distance = np.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)

    if distance == 0 or np.isnan(elevation_pixel1) or np.isnan(elevation_pixel2):
        return np.nan

    slope = (elevation_pixel2 - elevation_pixel1) / distance

    return slope

def place_sensor_server():
    rospy.init_node('placement')
    placement_server = rospy.Service('find_spot', PlaceSensor, sensor_placement_server)
    print("Placement server is now running.")
    rospy.spin()

def sensor_placement_server(req):
    #request parameters
    lat = req.latitude
    lon = req.longitude
    bat = req.battery

    if(perception_mode == 0):
        #set target to hardcoded random placement
        tar_lat = lat+0.0001 * (np.random.rand() - 0.5)
        tar_lon = lon+0.0001 * (np.random.rand() - 0.5)

    else:
        #set target to percieved location
        target_latlon = find_sensor_placement()
        tar_lat = target_latlon[0]
        tar_lon = target_latlon[1]

    #generate and return response
        target_pos = PlaceSensorResponse()
        target_pos.target_latitude = tar_lat
        target_pos.target_longitude = tar_lon
        return target_pos

def find_sensor_placement(target_lat, target_lon):
    # Opens image
    image = cv2.imread('Updated_Texas_Final.png')

    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # This block of code creates a filtered image
    # (only contains roads in pink)
    mask = cv2.inRange(image, np.array([255, 0, 255]), np.array([255, 0, 255]))
    combined_mask = mask
    combined_mask_inv = 255 - combined_mask
    combined_mask_rgb = cv2.cvtColor(combined_mask_inv, cv2.COLOR_GRAY2BGR)

    # Writes the filtered out image to result.png
    final = cv2.max(image, combined_mask_rgb)
    cv2.imwrite('result.png', final)

    # Assigns the newly made result.png into filtered_image
    filtered_image = cv2.imread('result.png')
    kernel = np.ones((5,5), np.uint8)
    dilated = cv2.erode(filtered_image, kernel, iterations=5)

    # Writes the newly-dilated image into dilated_result.png
    cv2.imwrite('dilated_result.png', dilated)

    dilated_image = cv2.imread('dilated_result.png')
    difference = cv2.absdiff(dilated_image, filtered_image)
    cv2.imwrite('difference_result.png', difference)

    # Reads the side of the road mask -- line not needed
    dilated_image = cv2.imread('difference_result.png')

    # Magenta
    specific_color = (0, 255, 0)

    # Finds all of the pixels covered in magenta in the semantic segmented image
    matching_pixels = np.where(np.all(np.abs(dilated_image - specific_color) <= 10, axis=-1))

    # Extracts the row,col pixels of the pixels covered in magenta
    row_indices, col_indices = matching_pixels

    # Puts the pixels into a coordinate_matrix
    coordinate_matrix = np.column_stack((col_indices, row_indices))

    # Opens up the semantic segmented image
    with rasterio.open('Updated_Texas_Final.tif') as src:

        # Extracts the transformation matrix associated w/ the image
        transform = src.transform

        # Puts the transformation matrix into an object that can be used
        transform_matrix = np.array([[transform.a, transform.b, transform.c],
                                    [transform.d, transform.e, transform.f],
                                    [0, 0, 1]])
        
        # Returns the transform_matrix's matrix dimensions
        n,m = coordinate_matrix.shape

        # Creates a filler/useless column of ones
        z = np.ones((n,1))

        # Puts it into one matrix
        coordinate_matrix = np.column_stack((coordinate_matrix, z))

        # Does the transformation & assigns the result to transformation
        transformation = np.dot(coordinate_matrix, transform_matrix.T)

        # Opens up the dem image
        with rasterio.open('dem_example.tif') as dem:

            # Retrieves the transformation matrix
            dem_transform = dem.transform

            # Represents transf. matrix of DEM
            dem_matrix = np.array([[dem_transform.a, dem_transform.b, dem_transform.c],
                                [dem_transform.d, dem_transform.e, dem_transform.f],
                                [0, 0, 1]])
            
            # Determines the inverse of the matrix 
            dem_matrix_inv = np.linalg.inv(dem_matrix)

            pixel_transformation = np.dot(transformation, dem_matrix_inv.T)
            pixel_transformation = np.delete(pixel_transformation, 2, axis=1)

            x = pixel_transformation[:,0]
            y = pixel_transformation[:,1]
            test = cv2.imread('dem_example.png')

            dem_dataset = gdal.Open('dem_example.tif')

            if dem_dataset is None:
                print("File could not be opened")
                exit(1)

            geo_transform = dem_dataset.GetGeoTransform()
            projection = dem_dataset.GetProjection()

            band = dem_dataset.GetRasterBand(1)

            elevation_data = band.ReadAsArray()

            elevation_data = np.ma.masked_equal(elevation_data, -9999)

            valid_data = elevation_data.data
            valid_data = np.ma.filled(elevation_data, np.nan)

            max_elevation = np.nanmax(valid_data)

            img = gdal.Open("dem_example.tif")

            # Extracts the min. band
            band = img.GetRasterBand(1)

            image_array = band.ReadAsArray()

            # Takes in the lat,long from gui
            latitude = target_lat
            longitude = target_lon

            # Converts the lat,long coords into pixel coordinates 
            x, y = convert_coordinates(latitude, longitude, src.crs, 4326)

            target_pixel = (x,y)

            # Radius set to 1 km away from the x,y 
            radius = 1 / 0.3174234500875771636 * 1000

            # Bounding box coordinates. Used to create a "circle"
            min_x = x - radius
            min_y = y - radius
            
            max_x = x + radius
            max_y = y + radius

            pixels_list = []

            # Iterates through all of the pixels along the road
            for pixel in pixel_transformation:
                x,y = pixel
                
                # Checks to see if the current pixel is within the bounding box
                if min_x <= x <= max_x and min_y <= y <= max_y:
                    
                    # Compures the distance 
                    distance = np.sqrt((x - target_pixel[0]) ** 2 + (y - target_pixel[1]) ** 2)
                    
                    # Checks to see if the current pixel is within the radius
                    if distance <= radius:
                        pixels_list.append((x,y))          

            x_new = [pixel[0] for pixel in pixels_list]
            y_new = [pixel[1] for pixel in pixels_list] 

            # 
            near_pixels = np.column_stack((x_new,y_new))

            common_elements = np.concatenate((near_pixels, pixel_transformation), axis=0)

            min_average_slope = float('inf')  
            flattest_pixel = None

            # O(n^2) - This part takes a long time, as it iterates through all of the pixels in
            # common_elements and calculates the slope of the current pixel and the other_pixel. 
            # This only considers the other_pixels that are only 100 pixels away from the current pixel
            for pixel in common_elements:

                if isinstance(pixel, np.float64):
                    continue
                
                x1, y1 = int(pixel[0]), int(pixel[1])  
                average_slope = 0.0

                for other_pixel in common_elements:

                    slope = 0
                    x2, y2 = int(other_pixel[0]), int(other_pixel[1])
                    distance = np.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)

                    if 0 < distance <= 100:
                        slope = calculate_slope(elevation_data, x1, y1, x2, y2)

                    average_slope += slope

                    average_slope /= len(pixels_list) - 1

                    if average_slope < min_average_slope:
                        min_average_slope = average_slope
                        flattest_pixel = pixel

            # Final output
            #print("Flattext pixel:", flattest_pixel)
            
            target_latlon = {target_lat,target_lon}
            return target_latlon



if __name__ == "__main__":
    if(perception_mode == 2):
        target_lat = rospy.get_param("/placment/lat")
        target_lon = rospy.get_param("/placement/lon")
        target_latlon = find_sensor_placement(target_lat,target_lon)
        print("Target latitude = " + target_latlon[0] + "\n")
        print("Target longitude = " + target_latlon[1] + "\n")
    else:
        place_sensor_server()