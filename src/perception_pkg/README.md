# NSSSIP2023 - Perception Package

This package (perception_pkg) contains the best-location-for-sensor-placement algorithm. This algorithm reads and analyzes a semantic segmented aerial imagery of some region, as well as the corresponding LiDAR data. 

## Program Overview:
- This algorithm determines the best location to place a sensor based on a few parameters. For this internship, the perception team decided our algorithm should focus flatness of the terrain. As such, our algorithm will output a single (lat,long) coordinate.
- Some of the parameters this algorithm uses to decide the best location for sensor-placement involves a radius of interest and the starting coordinates, which serves as the center of the circle that is internally used.
- Regardless of how many bands the Digital Elevation Model (DEM) has, only the minimum band is used.

![Logic of Algorithm](https://github.com/mattm8600/NSSSIP2023/blob/main/docs/pics/perception_flowchart.png)
## Program Requirements:
- This program requires a variety of libraries, which are located in the requirements.txt file. You can install all of the libraries at by running the terminal-command **pip install -r requirements.txt**. 
- In order for the algorithm to analyze a region of interest, it requires the aerial imagery (that has been run through a semantic segmented algorithm) and the corresponding LiDAR data. It is advised to also have the Digital Elevation Model (DEM) image. All images must be in a .tif format.
- For this internship, we only focused on finding the flattest region to place a sensor.

## Example:
- In this package, if one wishes to see how the algorithm works without using the drone, you may look at the example provided.
- This example consists of a region in Cedar Park, Texas. The exact lat, long coords of the region are 30.503877, -97.776747. 
- In order to run this example, it is strongly advised (once again) to run the terminal command **pip install -r requirements.txt**. This ensures that you have all of the required libraries for this algorithm to work properly.
- In order to run this example, simply clone **perception_pkg**. Ensure all of the images/data/DEM images for this example are in the same repository.
- In the source code, there are few parameters that you can adjust, such as the radius, the latitude/longitude coordinates of interest (which is hardcoded), and more.
- You can then simply execute the program. This program, when not being used with the drone, will output a pair of (longitude, latitude) coordinates that the algorithm decided is the best area.
- This example will simply find the flattest point to place the sensor. 

## Using the Algorithm:
*This step assumes you are running the algorithm without using the drone and not using the perception.launch file -- this step just assumes you use the script alone.* 
1) In order to utilize this algorithm, it requires two important files: aerial imagery of a region that has been through a semantic segmentation algorithm and the corresponding LiDAR data for that region. The LiDAR data must be converted to a Digital Elevation Mode (DEM) image -- this can be done by using the GDAL library. The semantic segmentated aerial imagery and the DEM image must use the .tif extension.
2) Put all of images in the same directory as the source code for the algorithm.
3) Throughout the source code, you must add the names of your images in the respective locations. There are comments in the source code that tell where each image needs to go.
4) Adjust the parameters, such as the radius and the starting coordinates, to the appropriate area in your region of interest.
5) Run the program. As the program executes, the program generates a bunch of plots that show the pixel/pixels of interest. These plots are not necessary for the algorithm.
6) The final output will be a pair of latitude and longitude coordinates that represent the flattest region. This will be printed to the console.
