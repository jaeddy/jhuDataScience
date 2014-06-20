---
title: Peer Assessment 2: NOAA Storm Database Exploration
output:
    html_document:
        theme: yeti
---

Peer Assessment 2: NOAA Storm Database Exploration
========================================================

**Synopsis:** The analysis below was designed to explore data from the NOAA 
Storm Database, with the goal of identifying severe weather event types that 
are particularly damaging to population health or that have the greatest 
economic consequences. The data were first downloaded, loaded into R, and then
processed to enable more focused examination of weather events that cause the 
most damage. Population health damage was defined as the sum of fatalities and
injuries for any specific event; economic damage was defined as the sum of
property damage and crop damage.

After using exploratory plotting to inspect the distribution of health or
economic damage for different event types, types were summarized according to
either the mean or sum of all damage caused. Finally, two tables were created 
to report the 10 worst event types in terms of (1) average damage to population
health; and (2) total damage to population health. Two similar tables were
created to report the 10 worst event types for (1) average economic damage; and
(2) total economic damage.

Further documentation on the NOAA storm data can be found at the links below:
* National Weather Service [Storm Data Documentation]
(https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf)
* National Climatic Data Center Storm Events [FAQ]
(https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2FNCDC%20Storm%20
Events-FAQ%20Page.pdf)


## Data Processing

The data was downloaded directly from the web and uncompressed from the `.bz2`
format using the `bunzip2()` function in the `R.utils` package. The resulting
`.csv` file was stored in the `data/` directory.


```r
# Create a directory to store data, if one doesn't already exist
if (!file.exists("data/")) {dir.create("data/")}

# Download the data and record the date downloaded
fileAddress <- 
    "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
#download.file(url = fileAddress, dest = "data/StormData.csv.bz2", 
#              method = "curl")
dateDownloaded <- date()

# Bunzip the file using 'bunzip2' from the 'R.utils' package
library(R.utils)
#bunzip2(filename = "data/StormData.csv.bz2", destname = "data/StormData.csv",
#        overwrite = TRUE)
```

**Note:** the data was downloaded from https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2 on Wed Jun 18 18:56:17 2014.  

After downloading an unzipping the data file, the data was read into R using 
the `read.csv()` function. The structure of the resulting data frame `stormDat` 
was examined using the `str()` function.


```r
# Load the data using 'read.csv' and create the data frame 'stormDat'
stormDat <- read.csv("data/StormData.csv")

# Examine the structure of the data frame
str(stormDat)
```

```
## 'data.frame':	902297 obs. of  37 variables:
##  $ STATE__   : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ BGN_DATE  : Factor w/ 16335 levels "1/1/1966 0:00:00",..: 6523 6523 4242 11116 2224 2224 2260 383 3980 3980 ...
##  $ BGN_TIME  : Factor w/ 3608 levels "00:00:00 AM",..: 272 287 2705 1683 2584 3186 242 1683 3186 3186 ...
##  $ TIME_ZONE : Factor w/ 22 levels "ADT","AKS","AST",..: 7 7 7 7 7 7 7 7 7 7 ...
##  $ COUNTY    : num  97 3 57 89 43 77 9 123 125 57 ...
##  $ COUNTYNAME: Factor w/ 29601 levels "","5NM E OF MACKINAC BRIDGE TO PRESQUE ISLE LT MI",..: 13513 1873 4598 10592 4372 10094 1973 23873 24418 4598 ...
##  $ STATE     : Factor w/ 72 levels "AK","AL","AM",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ EVTYPE    : Factor w/ 985 levels "   HIGH SURF ADVISORY",..: 834 834 834 834 834 834 834 834 834 834 ...
##  $ BGN_RANGE : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ BGN_AZI   : Factor w/ 35 levels "","  N"," NW",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ BGN_LOCATI: Factor w/ 54429 levels ""," Christiansburg",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ END_DATE  : Factor w/ 6663 levels "","1/1/1993 0:00:00",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ END_TIME  : Factor w/ 3647 levels ""," 0900CST",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ COUNTY_END: num  0 0 0 0 0 0 0 0 0 0 ...
##  $ COUNTYENDN: logi  NA NA NA NA NA NA ...
##  $ END_RANGE : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ END_AZI   : Factor w/ 24 levels "","E","ENE","ESE",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ END_LOCATI: Factor w/ 34506 levels ""," CANTON"," TULIA",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ LENGTH    : num  14 2 0.1 0 0 1.5 1.5 0 3.3 2.3 ...
##  $ WIDTH     : num  100 150 123 100 150 177 33 33 100 100 ...
##  $ F         : int  3 2 2 2 2 2 2 1 3 3 ...
##  $ MAG       : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ FATALITIES: num  0 0 0 0 0 0 0 0 1 0 ...
##  $ INJURIES  : num  15 0 2 2 2 6 1 0 14 0 ...
##  $ PROPDMG   : num  25 2.5 25 2.5 2.5 2.5 2.5 2.5 25 25 ...
##  $ PROPDMGEXP: Factor w/ 19 levels "","-","?","+",..: 17 17 17 17 17 17 17 17 17 17 ...
##  $ CROPDMG   : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ CROPDMGEXP: Factor w/ 9 levels "","?","0","2",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ WFO       : Factor w/ 542 levels ""," CI","%SD",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ STATEOFFIC: Factor w/ 250 levels "","ALABAMA, Central",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ ZONENAMES : Factor w/ 25112 levels "","                                                                                                                               "| __truncated__,..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ LATITUDE  : num  3040 3042 3340 3458 3412 ...
##  $ LONGITUDE : num  8812 8755 8742 8626 8642 ...
##  $ LATITUDE_E: num  3051 0 0 0 0 ...
##  $ LONGITUDE_: num  8806 0 0 0 0 ...
##  $ REMARKS   : Factor w/ 436781 levels "","\t","\t\t",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ REFNUM    : num  1 2 3 4 5 6 7 8 9 10 ...
```

The `EVTYPE` variable in `stormDat` was found to have 
985 unique levels, in contrast to the 48 event types
described in the data documentation. Manual inspection of the levels revealed
that different event labels were largely produced by formatting and spelling
errors or discrepancies. The `gsub()` function was subsequently used to _clean_
the event labels and reduce spurrious differences. **Note:** the `gsub()` 
function searches for a specified query pattern and replaces any matches with 
the specified replacement string.


```r
# Create a character vector with all event type labels
eventTypes <- as.character(stormDat$EVTYPE)

# Convert all labels to lower case
eventTypes <- tolower(eventTypes)

# Correct typos and abbreviations
eventTypes <- gsub("avalance", "avalanche", eventTypes)
eventTypes <- gsub("tstm", "thunderstorm", eventTypes)
eventTypes <- gsub("sml", "small", eventTypes)
eventTypes <- gsub("fld", "flood", eventTypes)

# Remove different qualifiers and variations of major event types
eventTypes <- gsub("^(.*)flash flood(.*)$", "flash flood", eventTypes)
eventTypes <- gsub("^(.*)hurricane(.*)$", "hurricane", eventTypes)
eventTypes <- gsub("^(.*)tropical storm(.*)$", "tropical storm", eventTypes)
eventTypes <- gsub("^(.*)tornado(.*)$", "tornado", eventTypes)
eventTypes <- gsub("^(.*)thunderstorm(.*)$", "thunderstorm", eventTypes)
eventTypes <- gsub("g[[:digit:]]+", "", eventTypes)
eventTypes <- gsub("(excessive|record|extreme)", "", eventTypes)

# Remove smaller variations such as trailing 's's or 'ing's
eventTypes <- gsub("(s)+$", "", eventTypes)
eventTypes <- gsub("s(/|\\s)", "/", eventTypes)
eventTypes <- gsub("[^lightn]ing$", "", eventTypes)

# Remove any spaces and special characters
eventTypes <- gsub("[^[:alpha:]]", "", eventTypes)

# Add the new list of event labels as a variable in 'stormDat'
stormDat$eventType <- factor(eventTypes)
```

The resulting list of event types in `eventType` contains 
547 levels, which is still far greater than 48. 
However, further improvement would require extensive manual curation and time.
As many entries in `stormDat` and their corresponding event type labels will be
removed in subsquent processing steps, this preliminary step of semi-automated
cleaning was deemed sufficient.

The data was next processed to facilitate analysis for the questions below. 
Specifically, entries were filtered according to the amount of damage to 
population health (measured by the sum of `FATALITIES` and `INJURIES`) or by
the amount of economic damage (detailed in `PROPDMG`, `PROPDMGEXP`, 
`CROPDMG`, and `CROPDMGEXP`). Only the top 1% of event entries were kept for
either category.


```r
# Summarize population health damage as the sum of fatalities and injuries
healthDmg <- stormDat$FATALITIES + stormDat$INJURIES
stormDat$HEALTHDMG <- healthDmg

# Calculate the 99th percentile of health damage numbers
highHlthDmg <- quantile(healthDmg, c(.99), na.rm = TRUE)

# Summarizing the economic damage is more complicated, and requires a simple 
# function to convert the combination of 'DMG' (amount) and 'DMGEXP' 
# (exponent of 10) to the total amount 'prod' (amount * 10^exponent); 'expKey'
# is a named vector to keep track of the conversion from 'DMGEXP' labels to
# actual exponent
expKey <- c("0" = 0, "1" = 1, "h" = 2, "2" = 2, "k" = 3, "3" = 3, "4" = 4,
             "5" = 5, "m" = 6, "6" = 6, "7" = 7, "8" = 8, "b" = 9)

expCalc <- function(amt, exp) {
    exp <- tolower(as.character(exp))
    if (exp %in% names(expKey)) {
        prod <- amt * 10^expKey[names(expKey) %in% exp]    
    } else {
        prod <- 0
    }
    prod
}

# Use 'expCalc' to calculate the total property damage for all events
propDmg <- vector("numeric", nrow(stormDat))
for (i in 1:length(propDmg)) {
    propDmg[i] <- expCalc(stormDat[i, "PROPDMG"], stormDat[i, "PROPDMGEXP"])
}

# Use 'expCalc' to calculate the total crop damage for all events
cropDmg <- vector("numeric", nrow(stormDat))
for (i in 1:length(cropDmg)) {
    cropDmg[i] <- expCalc(stormDat[i, "CROPDMG"], stormDat[i, "CROPDMGEXP"])
}

# Summarize economic damage as the sum of property and crop damage
econDmg <- propDmg + cropDmg
stormDat$ECONDMG <- econDmg

# Calculate the 99th percentile of economic damage numbers
highEconDmg <- quantile(econDmg, c(.99), na.rm = TRUE)

# Create a smaller data frame containing only those events with high damage to
# population health
stormDatHealthDmg <- stormDat[healthDmg > highHlthDmg, ]

# Create a smaller data frame containing only those events with high economic
# damage
stormDatEconDmg <- stormDat[econDmg > highEconDmg, ]
```

After restricting to the highest (99th) percentile of damage to population
health and economic damage, the analyses below were reduced to comparisons
among 88 and 
86 different event
types, respectively.


## Exploratory Analysis

The data was initially inspected using basic plotting. Specifically, the
`ggplot2` package was used to create box plots for both health and economic
damage, showing the distribution of values for each event type.


```r
library(ggplot2)
ggplot(stormDatHealthDmg,
       aes(x = eventType, y = log10(HEALTHDMG))) + 
    geom_boxplot(fill = "#E69F00") + 
    xlab("Event Type") + ylab("log10(Fatalities + Injuries)") +
    theme(axis.text.x = element_blank())
```

![plot of chunk dataBoxPlot1](figure/dataBoxPlot1.png) 

**Figure 1:** Distribution of damage to population health (fatalities + injuries) 
for each event type.


```r
ggplot(stormDatEconDmg, 
       aes(x = eventType, y = log10(ECONDMG))) + 
    geom_boxplot(fill = "#E69F00") + 
    xlab("Event Type") + ylab("log10(Property + Crop Damages)") +
    theme(axis.text.x = element_blank())
```

![plot of chunk dataBoxPlot2](figure/dataBoxPlot2.png) 

**Figure 2:** Distribution of economic damage (property + crop) 
for each event type.

With both types of damage (health or economic), it is clear that some events
cause a large amount of damage on average, while others have many _outlier_
points that may indicate a larger total amount of damage.

## Results

#### Analysis Aims

The questions to be answered with the data were as follows:

> Across the United States, which types of events (as indicated in the `EVTYPE` 
> variable) are most harmful with respect to population health?
> 
> Across the United States, which types of events have the greatest economic 
> consequences?

#### Summarizing the Data: Mean and Total Damage

In the explortatory analysis, it was observed from plotting that some event 
types are associated with a large amount of damage on average, while others 
lead to a higher total amount of damage. Given this observation, the data was
reorganized and summarized according to these two statistics (**mean** and
**sum**) using the `ddply()` function from the `plyr` package.


```r
library(plyr)
stormDatHealthStats <- ddply(stormDatHealthDmg, ~ eventType, summarize,
                             meanHealthDmg = mean(HEALTHDMG),
                             totalHealthDmg = sum(HEALTHDMG))

stormDatEconStats <- ddply(stormDatEconDmg, ~ eventType, summarize,
                           meanEconDmg = mean(ECONDMG),
                           totalEconDmg = sum(ECONDMG))
```

The new data frames created with `ddply()` report the mean and total amount of
damage for all events across each event type. A new data frame was created for
both health and economic damage.

#### Most Harmful Event Types with respect to Population Health

Finally, the `arrange()` function was used to order the event types according
to either the mean or total amount of damage caused to population health. The
top 10 event types were then reported for each statistic using the `head()`
function.


```r
stormDatHealthMean <- head(arrange(stormDatHealthStats, 
                                   stormDatHealthStats$meanHealthDmg,
                                   decreasing = TRUE), 10)
stormDatHealthMean
```

```
##                 eventType meanHealthDmg totalHealthDmg
## 1                 tsunami        161.00            161
## 2                   flood         68.69           6869
## 3               hurricane         50.43           1412
## 4                icestorm         47.62           2000
## 5               wintrymix         38.50             77
## 6                    heat         35.82          11069
## 7            snowhighwind         34.00             34
## 8  unseasonablywarmanddry         29.00             29
## 9              waterspout         27.00             27
## 10          tropicalstorm         26.00            416
```

```r
stormDatHealthTotal <- head(arrange(stormDatHealthStats, 
                                   stormDatHealthStats$totalHealthDmg, 
                                   decreasing = TRUE), 10)
stormDatHealthTotal
```

```
##       eventType meanHealthDmg totalHealthDmg
## 1       tornado        22.138          91896
## 2          heat        35.822          11069
## 3         flood        68.690           6869
## 4  thunderstorm         6.577           6413
## 5     lightning         5.502           2696
## 6      icestorm        47.619           2000
## 7    flashflood         9.345           1869
## 8     hurricane        50.429           1412
## 9   winterstorm        12.925           1383
## 10         hail        11.979           1138
```

The event type that causes the most damage to population health on average is
**tsunami**, while the event type that caused the greatest
total amount of damage is **tornado**.

#### Most Harmful Event Types with respect to Economic Consequences

Again, the `arrange()` function was used to order the event types according
to either the mean or total amount of economic damage caused. The top 10 event 
types were then reported for each statistic using the `head()` function.


```r
stormDatEconMean <- head(arrange(stormDatEconStats, 
                                   stormDatEconStats$meanEconDmg,
                                   decreasing = TRUE), 10)
stormDatEconMean
```

```
##                 eventType meanEconDmg totalEconDmg
## 1  heavyrainsevereweather   2.500e+09    2.500e+09
## 2              stormsurge   1.493e+09    4.328e+10
## 3              riverflood   9.204e+08    1.012e+10
## 4          stormsurgetide   6.618e+08    4.632e+09
## 5               hurricane   6.400e+08    9.024e+10
## 6                    heat   1.808e+08    9.039e+08
## 7                 typhoon   1.499e+08    5.994e+08
## 8                   wetne   1.420e+08    1.420e+08
## 9                   flood   1.367e+08    1.486e+11
## 10              hailstorm   1.200e+08    2.400e+08
```

```r
stormDatEconTotal <- head(arrange(stormDatEconStats, 
                                   stormDatEconStats$totalEconDmg, 
                                   decreasing = TRUE), 10)
stormDatEconTotal
```

```
##       eventType meanEconDmg totalEconDmg
## 1         flood   1.367e+08    1.486e+11
## 2     hurricane   6.400e+08    9.024e+10
## 3       tornado   1.454e+07    5.487e+10
## 4    stormsurge   1.493e+09    4.328e+10
## 5          hail   2.235e+07    1.681e+10
## 6    flashflood   1.773e+07    1.663e+10
## 7       drought   1.055e+08    1.498e+10
## 8    riverflood   9.204e+08    1.012e+10
## 9  thunderstorm   1.657e+07    8.929e+09
## 10     icestorm   7.439e+07    8.852e+09
```

The event type that causes the most economic damage average is
**heavyrainsevereweather**, while the event type that caused the greatest
total amount of economic damage is **flood**.
