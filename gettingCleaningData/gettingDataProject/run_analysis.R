### 0. Load and process the data set ###
###

# Create a directory to store data, if one doesn't already exist
if(!file.exists("data/")){
    dir.create("data/")
}

# Download the data from the web and record the date and time
fileAddress <- 
    paste0("https://d396qusza40orc.cloudfront.net/",
           "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

download.file(fileAddress, "data/smartphoneActivityData.zip", method = "curl")
dateDownloaded <- date()

# Unzip the data file
unzip(zipfile = "data/smartphoneActivityData.zip", exdir = "data/")

# Load the data common to all samples
features <- read.table("data/UCI HAR Dataset/features.txt")
activities <- read.table("data/UCI HAR Dataset/activity_labels.txt")

# Load and process data for training samples
trainDat <- read.table("data/UCI HAR Dataset/train/X_train.txt")
trainLabels <- read.table("data/UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("data/UCI HAR Dataset/train/subject_train.txt")

# Add label and subject variables to 'trainDat'
trainDat$label <- trainLabels[[1]]
trainDat$subject <- trainSubjects[[1]]

# Load and process data for test samples
testDat <- read.table("data/UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("data/UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

# Add label and subject variables to 'testDat'
testDat$label <- testLabels[[1]]
testDat$subject <- testSubjects[[1]]

# Update the features list to include 'label' and 'subject' as variable names
featuresNew <- append(as.character(features[[2]]), c("label", "subject"))

# Load the 'dplyr' library, which will be useful for several steps below
library(dplyr)


### 1. Merge the training and the test sets to create one data set ###
###

# Use the 'merge()' function to combine all observations for all variables from
# 'trainDat' and 'testDat' to create a new data frame 'allDat'
allDat <- merge(trainDat, testDat, all = TRUE)

# Set the column names of 'allDat' to reflect list of features/variables
# defined above in 'featuresNew'
colnames(allDat) <- featuresNew


### 2. Extract only the measurements on the mean and standard deviation for each
###    measurement ###

# Use the 'grep()' function to find column names matching mean, std, label, or
# subject and keep only these columns
measureMeanStd <- grep(pattern = "(mean|std|label|subject)", x = featuresNew)
allDat <- allDat[, measureMeanStd]

# Also remove columns with 'BodyBody' feature label, as no description of this
# feature is provided with the raw data
allDat2 <- select(allDat, -matches("BodyBody"))


### 3. Use descriptive activity names to name the activities in the data set ###
###

# Match labels in 'allDat' to label/activity pairs in 'activities', replace
# all 'label' integers with corresponding activity name
allDat$label <- activities[match(allDat$label, activities[, 1]), 2]

# Convert activity names to lower case for consistency
allDat$label <- tolower(allDat$label)


### 4. Appropriately label the data set with descriptive variable names ###
###

# Variable names are provided by the 'features' list in the raw data; however,
# these labels are difficult to interpret. Simple string manipulation with 
# regular expressions can be used to clean up variable names and improve 
# clarity.

# First pull out the variable names from 'allDat' for subsequent manipulation
colNames <- colnames(allDat)

# Replace time/frequency letter appreviations with longer labels
colNames <- gsub(pattern = "^f", "freq_", colNames)
colNames <- gsub(pattern = "^t", "time_", colNames)

# Add underscores to improve clarity
colNames <- gsub(pattern = "Body", "Body_", colNames)
colNames <- gsub(pattern = "Gravity", "Gravity_", colNames)

# Spell out the measurements collected from accelerator/gyroscope
colNames <- gsub(pattern = "Acc", "Acceleration_", colNames)
colNames <- gsub(pattern = "Gyro", "AngularVelocity_", colNames)

# Spell out magnitude and add underscores to improve clarity
colNames <- gsub(pattern = "Jerk", "Jerk_", colNames)
colNames <- gsub(pattern = "Mag", "Magnitude_", colNames)

# Replace hyphens with underscores
colNames <- gsub(pattern = ")-", ")_", colNames)
colNames <- gsub(pattern = "-", "", colNames)

# Finally, update the 'label' variable to 'activity' to reflect the 
# transformation in step (3)
colNames <- gsub(pattern = "label", "activity", colNames)

# Update column names of 'allDat'
colnames(allDat)  <- colNames


### 5. Create a second, independent tidy data set with the average of each 
###    variable for each activity and each subject ###

# Use the 'summarise_each()' function from 'dplyr' to group observations first
# by subject, then by activity, and reporting the mean of all other columns
allDatNew <- group_by(allDat, subject, activity) %>% 
    summarise_each(funs(mean), matches("()"))

# Save the new data frame to a new tab-delimited text file under the 
# 'data/tidy' directory
if(!file.exists("data/tidy/")){
    dir.create("data/tidy/")
}
write.table(allDatNew, file = "data/tidy/uciHarClean.txt")

