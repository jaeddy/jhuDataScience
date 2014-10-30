
# Code for Quiz 1

# Question 1: The American Community Survey distributes downloadable data about 
# United States communities. Download the 2006 microdata survey about housing 
# for the state of Idaho using download.file() from here: 
fileAddress <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

if(!file.exists("data")){
    dir.create("data")
}

download.file(fileAddress, "data/acsHousingData.csv", method = "curl")

# ...and load the data into R.
acsHousingDat <- read.csv("data/acsHousingData.csv")

# The code book, describing the variable names is here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

# How many housing units in this survey were worth more than $1,000,000?
oneMilHouses <- subset(acsHousingDat, VAL == 24)


# Question 2: Use the data you loaded from Question 1. Consider the variable 
# FES in the code book. Which of the "tidy data" principles does this variable 
# violate?


# Question 3: Download the Excel spreadsheet on Natural Gas Aquisition Program 
# here: 
fileAddress <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileAddress, "data/natGasAquisition.xlsx", method = "curl")

# Read rows 18-23 and columns 7-15 into R and assign the result to a variable 
# called 'dat'.
library(xlsx)
dat <- read.xlsx("data/natGasAquisition.xlsx", sheetIndex = 1, 
                 rowIndex = 18:23, colIndex = 7:15)

# What is the value of:
sum(dat$Zip*dat$Ext,na.rm=T) 


# Question 4: Read the XML data on Baltimore restaurants from here: 
fileAddress <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

library(XML)
bmoreRestDat <- xmlTreeParse("data/bmoreRestaurants.xml", 
                             useInternalNodes = TRUE)

# How many restaurants have zipcode 21231?
rootNode <- xmlRoot(bmoreRestDat)
zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
sum(zipcodes == "21231")


# Question 5: The American Community Survey distributes downloadable data about 
# United States communities. Download the 2006 microdata survey about housing 
# for the state of Idaho using download.file() from here: 
fileAddress <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileAddress, "data/acsIdahoData.csv", method = "curl")

# using the fread() command load the data into an R object 'DT'
library(data.table)
DT <- fread("data//acsIdahoData.csv")

# Which of the following is the fastest way to calculate the average value of 
# the variable 'pwgtp15' broken down by sex using the data.table package?
system.time(mean(DT$pwgtp15,by=DT$SEX)) # doesn't work

system.time(DT[,mean(pwgtp15),by=SEX]) # .001

system.time(tapply(DT$pwgtp15,DT$SEX,mean)) # .007

system.time(mean(DT[DT$SEX==1,]$pwgtp15)) # .026
system.time(mean(DT[DT$SEX==2,]$pwgtp15)) # .024

system.time(rowMeans(DT)[DT$SEX==1]) # doesn't work
system.time(rowMeans(DT)[DT$SEX==2])

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)) # .003
