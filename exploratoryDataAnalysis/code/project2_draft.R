# Create a directory to store data, if one doesn't already exist
if (!file.exists("data/")) {
    dir.create("data/")
}

# Download the data from the web and record the date and time
if (!file.exists("data/FNEI_data.zip")) {
    fileAddress <- paste0("https://d396qusza40orc.cloudfront.net/",
                          "exdata%2Fdata%2FNEI_data.zip")
    
    download.file(fileAddress, "data/FNEI_data.zip", 
                  method = "curl")
    dateDownloaded <- date()
    
    file.create("data/dateDownloaded.txt")
    con <- file("data/dateDownloaded.txt")
    writeChar(dateDownloaded, con)
    close(con)
}

# Unzip the data file
if (!file.exists("data/Source_Classification_Code.rds")) {
    unzip(zipfile = "data/FNEI_data.zip", exdir = "data/")
}

# Load the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# 1. Have total emissions from PM2.5 decreased in the United States from 1999
# to 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)

# Use dplyr functions to sum the emission across all sources for each year
annualEmissions <- NEI %>% 
    group_by(year) %>% 
    summarise(num_Observations = length(Emissions),
              Emissions = sum(Emissions))

par(mfrow = c(2, 1), bg = "transparent")
with(annualEmissions, {
    plot(year, Emissions, col = "blue", 
         main = "Total emissions per year")
    lines(year, Emissions, lty = 2)
    plot(year, num_Emissions, col = "blue", 
         main = "Number of observations per year")
    lines(year, num_Emissions, lty = 2)
    })
dev.off()


# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.
bmoreAnnualEmissions <- NEI %>% 
    filter(fips == "24510") %>% 
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))

with(bmoreAnnualEmissions, {
    plot(year, Emissions, col = "blue", 
         main = "Baltimore emissions per year")
    lines(year, Emissions, lty = 2)
})
dev.off()


# 3. Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases 
# in emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.
library(ggplot2)

bmoreEmissions <- NEI %>% 
    filter(fips == "24510") %>%
    group_by(year, type) %>%
    summarise(total_Emissions = sum(Emissions),
           mean_Emissions = mean(Emissions),
           median_Emissions = median(Emissions),
           se_Emissions = sd(Emissions)/sqrt(length(Emissions)))

limits <- aes(ymin = mean_Emissions - se_Emissions,
              ymax = mean_Emissions + se_Emissions)

p <- ggplot(bmoreEmissions, aes(factor(year), mean_Emissions, 
                                colour = total_Emissions)) +
    geom_point(aes(size = median_Emissions)) +
    geom_line(aes(group = 1)) +
    geom_errorbar(limits, width = 0.2) + 
    facet_wrap(~ type, scales = "free")
p


# 4. Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

coalSources <- grep("coal", tolower(SCC$SCC.Level.Three))
coalSCC <- SCC[coalSources, ]

coalAnnualEmissions <- NEI %>%
    filter(SCC %in% coalSCC$SCC) %>%
    group_by(year) %>%
    summarise(total_Emissions = sum(Emissions),
              mean_Emissions = mean(Emissions),
              median_Emissions = median(Emissions),
              se_Emissions = sd(Emissions)/sqrt(length(Emissions)))

limits <- aes(ymin = mean_Emissions - se_Emissions,
              ymax = mean_Emissions + se_Emissions)

p <- ggplot(coalAnnualEmissions, aes(factor(year), mean_Emissions, 
                                   colour = total_Emissions)) +
    geom_point(aes(size = median_Emissions)) +
    geom_line(aes(group = 1)) +
    geom_errorbar(limits, width = 0.2)
p


# 5. How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

mobileSources <- grep("mobile", tolower(SCC$SCC.Level.One))
mobileSCC <- SCC[mobileSources, ]

mobileBmoreAnnualEmissions <- NEI %>%
    filter(SCC %in% mobileSCC$SCC, fips == "24510") %>%
    group_by(year) %>%
    summarise(total_Emissions = sum(Emissions),
              mean_Emissions = mean(Emissions),
              median_Emissions = median(Emissions),
              se_Emissions = sd(Emissions)/sqrt(length(Emissions)))

limits <- aes(ymin = mean_Emissions - se_Emissions,
              ymax = mean_Emissions + se_Emissions)

p  <- ggplot(mobileBmoreAnnualEmissions, aes(factor(year), mean_Emissions, 
                                            colour = total_Emissions)) +
    geom_point(aes(size = median_Emissions)) +
    geom_line(aes(group = 1)) +
    geom_errorbar(limits, width = 0.2)
p

# 6. Compare emissions from motor vehicle sources in Baltimore City with
# emissions from motor vehicle sources in Los Angeles County, California
# (fips == "06037"). Which city has seen greater changes over time in motor
# vehicle emissions?

mobileCompAnnualEmissions <- NEI %>%
    filter(SCC %in% mobileSCC$SCC, fips %in% c("24510", "06037")) %>%
    group_by(year, fips) %>%
    summarise(total_Emissions = sum(Emissions),
              mean_Emissions = mean(Emissions),
              median_Emissions = median(Emissions),
              se_Emissions = sd(Emissions) / sqrt(length(Emissions)))

p <- ggplot(mobileCompAnnualEmissions, aes(factor(year), mean_Emissions, 
                                           colour = total_Emissions)) +
    geom_point(aes(size = median_Emissions)) +
    geom_line(aes(group = 1)) +
    geom_errorbar(limits, width = 0.2) +
    scale_y_continuous()
    facet_wrap(~ fips, scales = "free")
p
