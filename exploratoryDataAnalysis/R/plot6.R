# Load required packages
library(dplyr)
library(ggplot2)

# Load the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# 6. Compare emissions from motor vehicle sources in Baltimore City with
# emissions from motor vehicle sources in Los Angeles County, California
# (fips == "06037"). Which city has seen greater changes over time in motor
# vehicle emissions?

# Use grep to identify all motor vehicle sources, as indicated by the term
# "mobile," and subset the SCC table
mobileSources <- grep("mobile", tolower(SCC$SCC.Level.One))
mobileSCC <- SCC[mobileSources, ]

# Use dplyr to do the following: (1) filter observations to only include mobile 
# sources and observations in Baltimore and Los Angeles County (based on fips
# code); (2) log-transform emissions values (after adding 1 to avoid -Inf values
# when transforming zeros); (3) calculate total emissions for each year-location
# combination
mobileEmissionsComp <- NEI %>%
    filter(SCC %in% mobileSCC$SCC, fips %in% c("24510", "06037")) %>%
    mutate(Emissions = log10(Emissions + 1)) %>%
    group_by(year, fips) %>%
    mutate(total_Emissions = sum(Emissions))

# Create boxplots of the data, showing the median, 75th percentile, and 25th 
# percentile for each year; fit a basic linear regression line to estimate the 
# trend; show each location in a separate pane; scale the fill color of boxes
# according to the total emissions
png("figures/plot6.png", width = 640, height = 480)
ggplot(mobileEmissionsComp, aes(factor(year), Emissions)) +
    geom_boxplot(aes(fill = total_Emissions), colour = "#E69F00") + 
    geom_smooth(method = "lm", aes(group = 1), 
                colour = "#D55E00", size = 2) +
    facet_wrap(~ fips, scales = "free")
dev.off()

# Based on the overall trends (as modeled by linear regression), motor vehicle
# sources show a decrease in emissions from 1999 to 2008 for both Baltimore and
# Los Angeles County; this pattern is also reflected by median emissions, but
# more dramatically in Los Angeles, which has much higher emission levels than
# Baltimore in general. While the percent change in median emissions might be
# similar for both cities, Los Angeles clearly shows a greater "absolute" 
# decrease from 1999 to 2008. Interestingly, based on total emissions, there is
# an increase for the period of 2002-2008 in Los Angeles before decreasing in
# 2008; total emissions in Baltimore are generally decreasing or steady.
