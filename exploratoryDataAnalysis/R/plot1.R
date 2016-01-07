# Load required packages
library(dplyr)

# Load the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# 1. Have total emissions from PM2.5 decreased in the United States from 1999
# to 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Use dplyr functions to sum the emission across all sources for each year
annualEmissions <- NEI %>% 
    group_by(year) %>% 
    summarise(num_Observations = length(Emissions),
              Emissions = sum(Emissions))

# Create a basic scatter plot of total emissions vs. year, with a dashed line
# showing rough trend over time; also, plot the total number of observations
# for each year
png("figures/plot1.png", width = 480, height = 640)
par(mfrow = c(2, 1))
with(annualEmissions, {
    plot(year, Emissions, col = "blue", 
         main = "Total emissions per year")
    lines(year, Emissions, lty = 2)
    plot(year, num_Observations, col = "blue", 
         main = "Number of observations per year")
    lines(year, num_Observations, lty = 2)
})
dev.off()

# In spite of the number of observations increasing each year (suggesting
# greater vigilance in monitoring emissions) from 1999 to 2008, the total 
# emissions have clearly decreased over this time period.
