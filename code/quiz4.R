
# Code for Quiz 4

# Question 1: The American Community Survey distributes downloadable data about 
# United States communities. Download the 2006 microdata survey about housing
# for the state of Idaho using download.file() from here: 
fileAddress <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 

# ...and load the data into R. 
acsHousingDat <- read.csv("data/acsHousingData.csv") # exists from Quiz 1

# Apply strsplit() to split all the names of the data frame on the characters 
# "wgtp". What is the value of the 123 element of the resulting list?
acsStrSplit <- strsplit(names(acsHousingDat), split = "wgtp")
acsStrSplit[123]


# Question 2: Load the Gross Domestic Product data for the 190 ranked countries
# in this data set: 
fileAddress <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" 
gdpDat <- read.csv("data/FGDP.csv", skip = 3) # exists from Quiz 3

gdpDat <- gdpDat[, c(-3,-6,-7,-8,-9,-10)]
gdpDat <- gdpDat[gdpDat$Ranking %in% 1:190, ]

# Remove the commas from the GDP numbers in millions of dollars and average
# them. What is the average? 
gdpDollars <- as.numeric(gsub(",", "", gdpDat$US.dollars.))
mean(gdpDollars)


# Question 3: In the data set from Question 2 what is a regular expression that
# would allow you to count the number of countries whose name begins with 
# "United"? Assume that the variable with the country names in it is named 
# countryNames. How many countries begin with United?
countryNames <- as.character(gdpDat$Economy)
countryNames[grep("^United", countryNames)]


# Question 4: Load the Gross Domestic Product data for the 190 ranked countries
# in this data set: 

fileAddress <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" 

# Load the educational data from this data set: 

fileAddress <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
edDat <- read.csv("data/FEDSTATS_Country.csv") # exists from Quiz 3

# Match the data based on the country shortcode. Of the countries for which the
# end of the fiscal year is available, how many end in June?
mergeDat <- merge(x = gdpDat, y = edDat, by.x = "X", by.y = "CountryCode")
mergeDat <- mergeDat[mergeDat$Ranking %in% 1:190, ]

mergeDatNotes <- as.character(mergeDat$Special.Notes)
mergeDatYearEnd <- mergeDatNotes[grep("Fiscal year end", mergeDatNotes)]
fyeJune <- mergeDatYearEnd[grep("June", mergeDatYearEnd)]
fyeJune


# Question 5: You can use the quantmod (http://www.quantmod.com/) package to 
# get historical stock prices for publicly traded companies on the NASDAQ and 
# NYSE. Use the following code to download data on Amazon's stock price and get 
# the times the data was sampled.

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

# How many values were collected in 2012? How many values were collected on 
# Mondays in 2012?

sampleDates <- as.Date(sampleTimes)
sampleDay <- format(sampleDates, "%a")
sampleYear <- format(sampleDates, "%Y")

total2012 <- sum(sampleYear == "2012")
monIn2012 <- (sampleDay == "Mon") & (sampleYear == "2012")
sum(monIn2012)
