# Load required packages
library(dplyr)
library(ggplot2)

# Load the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# 3. Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases 
# in emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.

# First, filter observations to only include Baltimore based on the
# corresponding fips code
bmoreEmissions <- NEI %>% 
    filter(fips == "24510") 

# Plot histogram of emissions values for Baltimore (not included in results)
ggplot(bmoreEmissions, aes(Emissions)) +
    geom_histogram()

# The histogram shows that the distribution of emissions values is very heavy-
# tailed, suggesting that it would be useful to log-normalize the data

# Use dplyr to do the following: (1) log-transform emissions values (after 
# adding 1 to avoid -Inf values when transforming zeros); (2) calculate the 
# total emissions for each year-type combination
bmoreEmissionsSummary <- bmoreEmissions %>%
    mutate(Emissions = log10(Emissions + 1)) %>%
    group_by(year, type) %>%
    mutate(total_Emissions = sum(Emissions))

# Create boxplots of the data, showing the median, 75th percentile, and 25th 
# percentile for each year; fit a basic linear regression line to
# estimate the trend; show each type of emission in a separate panel; scale the
# fill color of boxes according to the total emissions
png("figures/plot3.png", width = 640, height = 640)
ggplot(bmoreEmissionsSummary, aes(factor(year), Emissions)) +
    geom_boxplot(aes(fill = total_Emissions), colour = "#E69F00") +
    geom_smooth(method = "lm", aes(group = 1),
                colour = "#D55E00", size = 2) + 
    facet_wrap(~ type, scales = "free")
dev.off()

# Based on the overall trends (as modeled by linear regression), each source
# type shows a decrease in emissions from 1999 to 2008. However, based on
# median emissions, the pattern is less consistent: (1) non-road sources show
# only a very modest decrease; non-point sources increase in 2002 and 2005 
# before decreasing in 2008; and point sources decrease, increase, and then
# decrease again. Based on total emissions, both non-point and point sources
# also seem to show a relative increase in 2008 compared to 1999. On-road
# sources are consistently decreased (albeit modestly) from 1999-2008 across
# all measures.
