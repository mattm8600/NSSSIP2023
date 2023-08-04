import os
import shutil
import random

def split_data(src_images_folder, src_labels_folder, train_ratio=0.8):
    # Create the train and test folders if they don't exist
    train_folder = "train"
    test_folder = "test"
    if not os.path.exists(train_folder):
        os.makedirs(train_folder)
    if not os.path.exists(test_folder):
        os.makedirs(test_folder)

    # Create subfolders "images" and "labels" within the train and test folders
    train_images_folder = os.path.join(train_folder, "images")
    train_labels_folder = os.path.join(train_folder, "labels")
    test_images_folder = os.path.join(test_folder, "images")
    test_labels_folder = os.path.join(test_folder, "labels")
    if not os.path.exists(train_images_folder):
        os.makedirs(train_images_folder)
    if not os.path.exists(train_labels_folder):
        os.makedirs(train_labels_folder)
    if not os.path.exists(test_images_folder):
        os.makedirs(test_images_folder)
    if not os.path.exists(test_labels_folder):
        os.makedirs(test_labels_folder)

    # Get list of image files
    image_files = [f for f in os.listdir(src_images_folder) if os.path.isfile(os.path.join(src_images_folder, f))]
    total_images = len(image_files)

    # Get list of label files
    label_files = [f for f in os.listdir(src_labels_folder) if os.path.isfile(os.path.join(src_labels_folder, f))]
    total_labels = len(label_files)

    if total_images != total_labels:
        raise ValueError("Number of images and labels don't match. Check your data.")

    # Combine image and label filenames into pairs
    data_pairs = list(zip(image_files, label_files))

    # Shuffle the data pairs using the provided random_seed
    #random.seed(random_seed)
    #random.shuffle(data_pairs)

    # Calculate the number of samples for the training set
    num_train_samples = int(train_ratio * total_images)

    # Split data into train and test sets
    train_data = data_pairs[:num_train_samples]
    test_data = data_pairs[num_train_samples:]

    # Move images and labels to their respective train and test folders
    for image_file, label_file in train_data:
        shutil.move(os.path.join(src_images_folder, image_file), os.path.join(train_images_folder, image_file))
        shutil.move(os.path.join(src_labels_folder, label_file), os.path.join(train_labels_folder, label_file))

    for image_file, label_file in test_data:
        shutil.move(os.path.join(src_images_folder, image_file), os.path.join(test_images_folder, image_file))
        shutil.move(os.path.join(src_labels_folder, label_file), os.path.join(test_labels_folder, label_file))

if __name__ == "__main__":
    src_images_folder = "labeled_images"
    src_labels_folder = "bbox"
    train_test_ratio = 0.8
    #random_seed = 42

    split_data(src_images_folder, src_labels_folder, train_test_ratio)#, random_seed)
