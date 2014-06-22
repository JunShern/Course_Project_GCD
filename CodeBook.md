#CodeBook

##Introduction
This Code Book describes the data, procedures and analyses involved in this project. 


##About the data
The data used in this project comes from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. Using the words from the website, the data is a "Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors."

The following information has been extracted from the UCI HAR website for the data:
* The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

* The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


##Variables
A complete list of all the features for which measurements were taken can be found in "UCI HAR Dataset/features.txt".

In the analysis, many of the original variables/measurements have been left out of the final data set in the interest of keeping the data set small enough for analysts to focus on the most important variables - the mean and standard deviation variables. As a result, we have retained a total of 88 variables which are set as the names of their respective columns in the dataset. 

The names of the variables follow a naming convention which allows the variable name to be short enough for easy presentation but still descriptive enough to understand what the variable is: The names are simple abbreviations of their full descriptions. Variables with a prefix "t" are signals measured in the time domain, and those with a prefix "f" are signals measured in the frequency domain. Other abbreviations are easier to spot - "Acc" stands for "acceleration", "gyro" is "gyroscope", "Mag" is "magnitude", and "XYZ" is used to denote 3-axial signals in the X, Y and Z directions.

Details about how the measurements were taken can be found in "UCI HAR Dataset/features_info.txt"; that is beyond the scope of this analysis.

###Units
For each of the variables in the data set, the measurements have been normalised - that is, each measurement has been divided by its range, so the values in the data set are dimensionless. This allows us to not worry about unit conversions, and makes the data easier to interpret. 


##Procedure & Analysis
The following explanations are meant to be used as a reference to the run_analysis.R script:

###Data Cleaning
1. The data measured has been separated into two parts in the UCI HAR Dataset folder, namely test cases and training cases. This separation is useful for Machine Learning purposes, but not necessary for our analysis. Therefore, we read in all the cases using the read.table() function, and combine them together using the rbind() function. Now we have one big data set instead of two parts of the same data.
(Lines 1-16)

2. In row 19, we use the feature names found in "UCI HAR Dataset/features.txt" to rename the column variables for our data frame. 
(Lines 18-19)

3. As mentioned above in "Variables", we are only interested in keeping the mean and standard deviation readings, so we use the grep() function to help us pick out the columns with "mean" or "std" in the data, and subset only these columns into our data frame. 
	* The majority of the variables use mean and std as a separate parameter at the end of their names, but there are a few variables: gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, and tBodyGyroJerkMean which are named a little differently. These variables should not be left out because they offer other interesting measurements which are not covered in the variables. Thus, special care is taken to pass the "ignore.case=TRUE" parameters to the grep() functions so that these variables with an uppercase "Mean" are not ignored when matching for the pattern "mean". 
(Lines 21-24)

4. The original variable names taken from "UCI HAR Dataset/features.txt" contain many special characters such as "(", ")", "," and "-" which can cause problems when used as variable names in R. To avoid difficulty using the variable names, the function gsub() is used to remove or replace each of these special characters. 
(Lines 26-31)

5. The data we get from "UCI HAR Dataset/test/y\_test.txt" and "UCI HAR Dataset/train/y\_train.txt" give us information of what activity was being carried out during the measurements. However, these activities were recorded using numeric symbols in place of their English descriptors. To make this information more human readable, we replace the numeric symbols with the English descriptors, given to us in "UCI HAR Dataset/activity_labels.txt".
(Lines 33-35)

6. We now merge our data sets together so that it is neatly displayed in the first column who is performing the task, and the second column will show which activity the person is doing, followed by all the sensor readings in the next columns.
(Lines 37-38)

7. Finally, we polish up the data frame by renaming the first two columns with clean, readable names.
(Lines 40-42)

###Creating a new tidy data frame
1. We will now summarize our data by calculating the mean of each sensor reading for each activity carried out by each person. 

2. First, we convert the factor names of our "Activity" column back to their numeric representations so that R will not give us any complaints when we later ask it to calculate the means of all the columns in our data frame.
(Lines 45-47)

3. The data frame is then split up by subject and activity, so that we can separately calculate the means for our variables in each portion of the split. 
(Lines 48-50)

4. We then calculate the means of each column for every portion of the split using sapply(). 
(Line 51)

5. sapply() returns a matrix where our variables are now listed as rows, but we want them to be columns so we use the t() function to transpose the matrix, then convert the matrix back into a data frame using data.frame().
(Lines 52-53) 

6. Not forgetting to make our data frame human readable again, we convert the numbers in "Activity" back to English factors.
(Lines 54-56)

7. The order or our data frame was changed a little through our splitting and recombining, so we sort our data frame rows once again first by Subject, then by Activity using the order() function. This makes the data easier to understand.
(Lines 57-58)

8. Our data is now clean, tidy and summarized, so we can use write.table() to write our final data frame to a text file for easy access and distribution.(Lines 60-61)


