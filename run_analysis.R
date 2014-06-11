
# Create a directory to store data, if one doesn't already exist
if(!file.exists("data/")){
    dir.create("data/")
}

# Download the data from the web and record the date and time
fileAddress <- 
    paste0("https://d396qusza40orc.cloudfront.net/",
           "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

download.file(fileAddress, "data/smartphoneActivityData.zip", method = "curl")
downloadDate <- date()

# Unzip the data file
unzip(zipfile = "data/smartphoneActivityData.zip", exdir = "data/")
