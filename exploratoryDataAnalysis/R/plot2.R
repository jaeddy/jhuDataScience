# Load required packages
library(dplyr)

# Load the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

# Use dplyr functions to sum the emission across all sources for each year,
# this time filtering observations to only include Baltimore based on the
# corresponding fips code
bmoreAnnualEmissions <- NEI %>% 
    filter(fips == "24510") %>% 
    group_by(year) %>%
    summarise(num_Observations = length(Emissions),
              Emissions = sum(Emissions))

# Create a basic scatter plot of total emissions vs. year, with a dashed line
# showing rough trend over time; also, plot the total number of observations
# for each year
png("figures/plot2.png", width = 480, height = 640)
par(mfrow = c(2, 1))
with(bmoreAnnualEmissions, {
    plot(year, Emissions, col = "blue", 
         main = "Baltimore emissions per year")
    lines(year, Emissions, lty = 2)
    plot(year, num_Observations, col = "blue", 
         main = "Number of observations per year")
    lines(year, num_Observations, lty = 2)
})
dev.off()

# Again, while the number of source-emissions observations has increased each 
# year from 1999 to 2008, the total emissions have clearly decreased over the
# full span of this time period. Even though there appears to be an increase
# in total emissions from 2002 to 2005, the total for 2008 is still less than
# that of 1999.

