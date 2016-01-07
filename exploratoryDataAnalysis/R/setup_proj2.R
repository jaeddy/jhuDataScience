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

# Create a directory to save figures, if one doesn't exist
if (!file.exists("figures/")) {
    dir.create("figures/")
}
