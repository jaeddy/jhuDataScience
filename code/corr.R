corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  dirFiles <- dir(directory)
  dirIDname <- gsub(".csv", "", dirFiles)
  dirIDnum <- as.numeric(dirIDname)
  
  idCompCases <- complete(directory)
  corIDs <- idCompCases$nobs > threshold
  
  pollutantCorr <- vector(mode = "numeric", length = sum(corIDs))
  idx <- 1
  for(i in 1:length(dirFiles)){
    if(corIDs[i] == TRUE){
      idFile <- dirFiles[dirIDnum %in% i]
      filePath <- paste(directory, "/", idFile, sep = "")
      idTable <- read.csv(filePath)
      
      corrDat <- idTable[c("sulfate", "nitrate")]
      pollutantCorr[idx] <- cor(corrDat[["sulfate"]], corrDat[["nitrate"]],
                                use = "complete.obs")
      idx <- idx + 1
    }
  }
  #pollutantCorr <- round(pollutantCorr, digits = 5)
  pollutantCorr
}