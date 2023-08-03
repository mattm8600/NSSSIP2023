# YOLOV5 READ-ME

## File Structure:

### bbox - Contains labels/bounding box coordinates for images in labeled_images folder

### labeled_images(NOTE: These are the images that we labeled, not ones run through the classifier at this time) - Contains the images that our classifier was trained/validated with (~5000 images with associated labels in bbox folder)

NOTE: The above two folders are currently empty becuase they have been divided into the train/val folders. To add more images simply add more images to labeled_images and labels to bbox and then run the data_split.py script. 

### runs - This contains the results of each run we did of the classifier. 
	
	detect - Contains the results of the validation sets (images with bounding boxes)
	
	train - Contains the best.pt (best weights) for each of our training iterations. The latest is located in exp9

	val - contains the results of running the val.py script. This shows some various statistics about how our classifier is performing


### train - contains the labels and images for the training set

### val - contains the labels and images for the validation set

### data_split.py - This script will take in the bbox and labeled_images files and do a 80/20 train/val split and put these results in the train/val folders respectively


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Notes 

Yolov5 Download - https://github.com/ultralytics/yolov5.git
	- pip install -r requirements.txt --Note: you may need to manually install pytorch for cuda  
	- Ensure you have updated NVIDIA drivers that support pytorch 11.7 or 11.8  
	- Recommended to install in dedicated conda environment  

# Using Yolov5

## 1. 
obtain labeled imagery
## 1b. 
if making your own I suggest using Modified Open Labeling -https://github.com/ivangrov/ModifiedOpenLabelling

## 2. 
Create a .yaml file -> I made a copy of the coco128.yaml and replaced the file paths with my own. This is what will allow you to call your data when training/testing. Also mine is named "custom.yaml" which is used in step 5a

## 3. 
Put images in a folder within your Yolov5 folder. Personally, I made a new folder called "dataset" where I had my bbox, labeled_images, and data_split.py 

## 4. 
open terminal and cd into Yolov5 folder

## 5a. 
For training run the following command: $ python -m torch.distributed.run --nproc_per_node 3 --master_port 47770 train.py --data custom.yaml --batch-size 18 --weights yolov5s.pt --img 640 --device 0,1,2

If above doesnt work try: $ python train.py --data custom.yaml --weights yolov5s.pt --img 640

NOTES: 
-batch-size must be a multiple of the number of gpus you are using
-weights can be any of the yolo sizes, for our application we were using yolo small. Also, this can be used to retrain a current model by inputing its weights
-img 640 is not necessary, it is just saying that yolo should expect a 640x640 image. However, I believe it adapts to whatever size it is given as long as it is consistent. 
-device 0,1,2 --> This is telling yolo to use all three gpus in my computer. This will need to be adjusted depending on the number of gpu's. Also, if you want to run this through cpu only, you will need to install the cpu version of pytorch
-Default epochs is 100, to set a custom amount add "--epochs #" to the training command. I like to do 10000 because yolo will stop itself when it stops improving 

## 5b. 
For testing run the following command - $ python val.py --weights "path 2 weights" --data custom.yaml --img 640

## 5c.
For actually using yolo we want to run the detect.py script

$ python detect.py --weights "path to weights" --source (input source from list below)

0                               # webcam
img.jpg                         # image
vid.mp4                         # video
screen                          # screenshot
path/                           # directory
list.txt                        # list of images
list.streams                    # list of streams
'path/*.jpg'                    # glob
'https://youtu.be/Zgi9g1ksQHc'  # YouTube
'rtsp://example.com/media.mp4'  # RTSP, RTMP, HT


