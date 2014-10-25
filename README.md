GettingCleaningData
===================

CREATING A TIDY DATASET

Name of r program = run_analysis.r

Program Objective: The goal is to prepare tidy data that can be used for later analysis.

R script called run_analysis.R does the following. 


The script assumes data files have already been unzipped and are available in your working directory
(the script for downloading and unzipping has been included but is inactive)

Step 1
Extracts the individual test and train data files from working directory, along with associated subject and label files.  
Also creates a reference table for activity labels.

Step 2
Names each column with respective descriptors of the measurements; then filters out unwanted columns.  
This helps in extracting only the measurements on the mean and standard deviation for each measurement case. 


Step 3
New data frames for test and train are created by associating information on the respective volunteer/ subject and activity type to the measurement data.
The test and train data sets are then merged to get one single dataset


Step 4
Descriptive activity labels are provided to name the activities in the data set

Step 5
From the final data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
