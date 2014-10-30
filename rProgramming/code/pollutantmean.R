pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  # the dir function is used to get a character vector with all file names in
  # the specified directory
  dirFiles <- dir(directory)
  dirIDname <- gsub(".csv", "", dirFiles)
  dirIDnum <- as.numeric(dirIDname)
  
  #idSum <- 0
  pollutantDat <- data.frame()
  for(i in id){
    idFile <- dirFiles[dirIDnum %in% i]
    filePath <- paste(directory, "/", idFile, sep = "")
    idTable <- read.csv(filePath)
    
    pollutantDat <- rbind(pollutantDat, idTable)
    
    #pollutantCol <- idTable[[pollutant]]
    #pollutantMean <- mean(pollutantCol, na.rm = TRUE)
    #print(pollutantMean)
    
    #idSum <- idSum + pollutantMean
  }
  #idMean <- idSum/length(id)
  pollutantCol <- pollutantDat[[pollutant]]
  pollutantMean <- mean(pollutantCol, na.rm = TRUE)
  pollutantMean <- round(pollutantMean, digits = 3)
  pollutantMean
}