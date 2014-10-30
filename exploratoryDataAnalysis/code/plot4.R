# Load required packages
library(dplyr)
library(ggplot2)

# Load the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# 4. Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

# Use grep to identify all coal sources and subset the SCC table
coalSources <- grep("coal", tolower(SCC$SCC.Level.Three))
coalSCC <- SCC[coalSources, ]

# Use dplyr to do the following: (1) filter observations to only include coal
# sources; (2) log-transform emissions values (after adding 1 to avoid -Inf
# values when transforming zeros); (3) calculate total emissions for each year
coalEmissionsSummary <- NEI %>%
    filter(SCC %in% coalSCC$SCC) %>%
    mutate(Emissions = log10(Emissions + 1)) %>%
    group_by(year) %>%
    mutate(total_Emissions = sum(Emissions))

# Create boxplots of the data, showing the median, 75th percentile, and 25th 
# percentile for each year; fit a basic linear regression line to estimate the
# trend; scale the fill color of boxes according to the total emissions
png("figures/plot4.png", width = 480, height = 480)
ggplot(coalEmissionsSummary, aes(factor(year), Emissions)) +
    geom_boxplot(aes(fill = total_Emissions), colour = "#E69F00") + 
    geom_smooth(method = "lm", aes(group = 1), 
                colour = "#D55E00", size = 2)
dev.off()

# Based on the overall trend (as modeled by linear regression), coal sources
# show a decrease in emissions from 1999 to 2008; this pattern is also 
# reflected by median emissions, which decrease or remain steady each observed
# year. Based on total emissions, there is an increase for the period of
# 2002-2008 before decreasing in 2008.
