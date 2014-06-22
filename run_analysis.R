## Reading from files
test_data = read.table("UCI HAR Dataset/test/X_test.txt")
test_activity = read.table("UCI HAR Dataset/test/y_test.txt")
test_subject = read.table("UCI HAR Dataset/test/subject_test.txt")

train_data = read.table("UCI HAR Dataset/train/X_train.txt")
train_activity = read.table("UCI HAR Dataset/train/y_train.txt")
train_subject = read.table("UCI HAR Dataset/train/subject_train.txt")

activityLabels = read.table("UCI HAR Dataset/activity_labels.txt")
dataLabels = read.table("UCI HAR Dataset/features.txt")

## Merge test and train datasets
data = rbind(test_data, train_data) 
activity = rbind(test_activity, train_activity)
subject = rbind(test_subject, train_subject)

## Rename variables in data using dataLabels
names(data) = dataLabels$V2

## Retain only "mean" or "std" columns
meanCols = grep("mean", names(data), ignore.case=TRUE)
stdCols = grep("std", names(data), ignore.case=TRUE)
data = data[sort(c(meanCols, stdCols))] 

## Remove special characters from variable names
names(data) = gsub("\\(\\)", "", names(data)) # Remove "()"
names(data) = gsub("-", "_", names(data)) # Replace "-" with "_"
names(data) = gsub(",", "_", names(data)) # Replace "," with "_"
names(data) = gsub("\\(", "_", names(data)) # Replace "(" with "_"
names(data) = gsub("\\)", "", names(data)) # Remove ")"

## Replace the integers 1-6 in activity with corresponding labels
activity$V1 = as.factor(activity$V1)
levels(activity$V1) = activityLabels$V2

## Merge subject, activity and data
df = cbind(subject$V1, activity$V1, data)

## Rename messy columns
colnames(df)[colnames(df) == "subject$V1"] = "Subject"
colnames(df)[colnames(df) == "activity$V1"] = "Activity"

## New data frame
# Convert the levels in Activity to integers for now - makes life easier
levels(df$Activity) = c(1,2,3,4,5,6)
df$Activity = as.numeric(df$Activity)
# Split by intersection of Subject & Activity, find means
factors = list(df$Subject,df$Activity)
splitframes = split(df, factors)
splitframes = sapply(splitframes, colMeans)
# Rejoin everything into a new tidy data frame
df2 = data.frame(t(splitframes)) # t will transpose the matrix so that columns are variables
# Convert levels in Activity back to factor labels
df2$Activity = as.factor(df2$Activity)
levels(df2$Activity) = activityLabels$V2
# Sort by subject for neatness
df2 = df2[order(df2$Subject, df2$Activity),]

# Write df2 to a .txt file
write.table(df2, "tidydata.txt")
