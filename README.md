#README

This project tidies up an existing dataset of sensor data, and performs basic analysis on the data.

##File Overview
The repository contains:

1. UCI HAR Dataset 
	* This folder is taken directly from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, and contains all the sensor data which is used in this project.

2. run_analysis.R 
	* This script performs all the work on the dataset, and will be explored further in the section "Script Functions" below.

3. tidydata.txt 
	* This is the output of run_analysis.R. It is a space-separated data file produced using the "write.table()" function in R, and has been tested to be easily read into a data frame in R using 
~~~~
read.table("tidydata.txt")
~~~~

4. README.md 
	* This file you are reading, which summarizes the project.

5. CodeBook.md 
	* A markdown document which describes in detail the variables, data and work performed to clean up the data.


##Script Functions
Here is a summary of the work carried out by the script run_analysis.R:
1. First, it reads the test data, training data, feature labels and activities from the UCI HAR Dataset. 

2. Merges the test and training datasets together to form a large dataset.

3. Replaces the column names with descriptive variable names. 

4. Trims down the data set by removing all data columns except those containing mean and standard devation measurements.

5. Summarizes the data by finding the means for all measurements, grouped by the activity performed by each subject. 

6. Creates a new dataframe for this neat, summarized data and writes it to a space-delimited file "tidydata.txt".

