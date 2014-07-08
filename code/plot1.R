
# Create a directory to store data, if one doesn't already exist
if(!file.exists("data/")){
    dir.create("data/")
}

# Download the data from the web and record the date and time
fileAddress <- paste0("https://d396qusza40orc.cloudfront.net/",
                      "exdata%2Fdata%2Fhousehold_power_consumption.zip")

download.file(fileAddress, "data/household_power_consumption.zip", 
              method = "curl")
dateDownloaded <- date()

# Unzip the data file
unzip(zipfile = "data/household_power_consumption.zip", exdir = "data/")
 
# Preview the data using readLines() and the lubridate package to identify rows
# corresponding to the target range of dates (1/2/2007 to 2/2/2007)

# Note: the assignment description states that dates are found in the first 
# column and formatted as "dd/mm/yyyy", but this can also be confirmed by 
# reading and visually inspecting the first several lines
library(lubridate)

con <- file("data/household_power_consumption.txt")
for (n in seq(10000, 200000, 10000)) {
    lines <- readLines(con, n)
    lineParts <- strsplit(tail(lines, 1), ";")
    lineDate <- dmy(unlist(lineParts)[1])
    if (lineDate > dmy("2/2/2007")) {
        break
    }
}
startLine <- min(grep("1/2/2007", lines))
endLine <- max(grep("2/2/2007", lines))
close(con)

# Load the data only up to the end of the desired range
powerDat <- read.table("data/household_power_consumption.txt",
                       nrows = endLine, sep = ";", header = TRUE,
                       na.strings = c("?"))
str(powerDat)

# Subset the data to only include the target date range
powerDat <- powerDat[(startLine-1):endLine, ]

# Convert the Date and Time variables into a new Date/Time class variable using
# lubridate and dplyr
library(dplyr)
powerDat <- mutate(powerDat, dmy_hms(paste(Date, Time)))

# Make plot 1
hist(powerDat$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
title("Global Active Power")
dev.off()
