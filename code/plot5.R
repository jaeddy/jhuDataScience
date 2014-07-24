# Load required packages
library(dplyr)
library(ggplot2)

# Load the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# 5. How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

# Use grep to identify all motor vehicle sources, as indicated by the term
# "mobile," and subset the SCC table
mobileSources <- grep("mobile", tolower(SCC$SCC.Level.One))
mobileSCC <- SCC[mobileSources, ]

# Use dplyr to do the following: (1) filter observations to only include mobile 
# sources and observations in Baltimore (based on fips code); (2) log-transform
# emissions values (after adding 1 to avoid -Inf values when transforming
# zeros); (3) calculate total emissions for each year
mobileBmoreEmissionsSummary <- NEI %>%
    filter(SCC %in% mobileSCC$SCC, fips == "24510") %>%
    mutate(Emissions = log10(Emissions + 1)) %>%
    group_by(year) %>%
    mutate(total_Emissions = sum(Emissions))

# Create boxplots of the data, showing the median, 75th percentile, and 25th 
# percentile for each year; fit a basic linear regression line to estimate the
# trend; scale the fill color of boxes according to the total emissions
png("figures/plot5.png", width = 480, height = 480)
ggplot(mobileBmoreEmissionsSummary, aes(factor(year), Emissions)) +
    geom_boxplot(aes(fill = total_Emissions), colour = "#E69F00") + 
    geom_smooth(method = "lm", aes(group = 1), 
                colour = "#D55E00", size = 2)
dev.off()

# Based on the overall trend (as modeled by linear regression), motor vehicle 
# sources in Baltimore show a decrease in emissions from 1999 to 2008; this
# pattern is mostly reflected by median emissions, which decrease or remain
# steady each observed year. Total emissions also appear to decrease over time
# from 1999-2008.
