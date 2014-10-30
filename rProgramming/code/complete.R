complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  dirFiles <- dir(directory)
  dirIDname <- gsub(".csv", "", dirFiles)
  dirIDnum <- as.numeric(dirIDname)
  
  pollutantDat <- data.frame()
  for(i in id){
    idFile <- dirFiles[dirIDnum %in% i]
    filePath <- paste(directory, "/", idFile, sep = "")
    idTable <- read.csv(filePath)
    
    idNobs <- c(i, sum(complete.cases(idTable)))
    
    pollutantDat <- rbind(pollutantDat, idNobs)
  }
  names(pollutantDat) <- c("id", "nobs")
  pollutantDat
}