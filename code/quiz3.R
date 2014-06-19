
# Code for Quiz 3

# Question 1: The American Community Survey distributes downloadable data about 
# United States communities. Download the 2006 microdata survey about housing
# for the state of Idaho using download.file() from here: 
fileAddress <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 

# ...and load the data into R. 
acsHousingDat <- read.csv("data/acsHousingData.csv") # exists from Quiz 1

# The code book, describing the variable names is 
# here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

# Create a logical vector that identifies the households on greater than 10 
# acres who sold more than $10,000 worth of agriculture products. Assign that
# logical vector to the variable agricultureLogical. Apply the which() function
# like this to identify the rows of the data frame where the logical vector is 
# TRUE. which(agricultureLogical) What are the first 3 values that result?
agricultureLogical <- (acsHousingDat$ACR == 3) & (acsHousingDat$AGS == 6)
sum(agricultureLogical, na.rm = TRUE)
head(which(agricultureLogical),3)


# Question 2: Using the jpeg package read in the following picture of your 
# instructor into R 

fileAddress <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileAddress, "data/jeff.jpg", method = "curl")

# Use the parameter native=TRUE. 
library(jpeg)
jpegDat <- readJPEG("data/jeff.jpg", native = TRUE)

# What are the 30th and 80th quantiles of the resulting data? (some Linux 
# systems may produce an answer 638 different for the 30th quantile)
quantile(jpegDat, c(.3, .8))

# Question 3: Load the Gross Domestic Product data for the 190 ranked countries
# in this data set: 

fileAddress <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" 
download.file(fileAddress, "data/FGDP.csv", method = "curl")
gdpDat <- read.csv("data/FGDP.csv", skip = 3)

gdpDat <- gdpDat[, c(-3,-6,-7,-8,-9,-10)]
gdpDat <- gdpDat[gdpDat$Ranking %in% 1:190, ]

complete.cases(gdpDat)

# Load the educational data from this data set: 

fileAddress <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileAddress, "data/FEDSTATS_Country.csv", method = "curl")
edDat <- read.csv("data/FEDSTATS_Country.csv")

# Match the data based on the country shortcode. How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is 
# last). What is the 13th country in the resulting data frame? 
library(plyr)
mergeDat <- merge(x = gdpDat, y = edDat, by.x = "X", by.y = "CountryCode")
mergeDat <- mergeDat[mergeDat$Ranking %in% 1:190, ]
mergeDat$Ranking <- as.numeric(levels(mergeDat$Ranking))[mergeDat$Ranking]

mergeDatSort <- arrange(mergeDat, Ranking, decreasing = TRUE)
head(mergeDatSort, 13)

# Original data sources: 
# http://data.worldbank.org/data-catalog/GDP-ranking-table 
# http://data.worldbank.org/data-catalog/ed-stats


# Question 4: What is the average GDP ranking for the "High income: OECD" and
# "High income: nonOECD" group?
groupGdp <- ddply(mergeDat, ~ Income.Group, summarize,
                  meanGdpRank = mean(Ranking))

# Question 5: Cut the GDP ranking into 5 separate quantile groups. Make a table
# versus Income.Group. How many countries are Lower middle income but among the
# 38 nations with highest GDP?
rankQuintiles <- quantile(mergeDat$Ranking, seq(0, 1, 0.2))
quintFactor <- cut(mergeDat$Ranking, breaks = rankQuintiles, 
                   labels = c("1st", "2nd", "3rd", "4th", "5th"))
mergeDat$quintile <- quintFactor

with(mergeDat, table(quintile, Income.Group))
