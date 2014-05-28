rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcomeDat <- read.csv("outcome-of-care-measures.csv", 
                         colClasses = "character")
  colNames <- names(outcomeDat)
  
  ## Check that state, outcome, and num arguments are valid
  if(!(state %in% outcomeDat$State)){
    error("invalid state")
  }
  
  possibleOutcomes <- c("heart attack", "heart failure", "pneumonia")
  if(!(outcome %in% possibleOutcomes)){
    error("invalid outcome")
  }
  
  possibleNums <- c("best", "worst")
  if(is.character(num)){
    if(!(num %in% possibleNums)){
      error("invalid num")
    }
  }
  else {
    if(num == 0)
      error("invalid num")
  }
  
  ## Reformat outcome string and column names to identify relevant outcome 
  ## column in the 'outcomeDat' data frame
  colNamesNew <- tolower(gsub(x = colNames, pattern = "\\.", replacement = ""))
  outcomeNew <- gsub(x = outcome, pattern = " ", replacement = "")
  colPrefix = "hospital30daydeathmortalityratesfrom"
  deathRateCol <- colNamesNew %in% paste(colPrefix, outcomeNew, sep = "") 
  
  ## First split the data frame by state and pull out information for input 
  ## state of interest
  outcomeByState <- split(outcomeDat, outcomeDat$State)
  stateDat <- outcomeByState[[state]]
  
  ## Remove hospitals for which data is not available for outcome
  excludeHosps <- stateDat[, deathRateCol] %in% "Not Available"
  stateDat <- stateDat[!excludeHosps, ]
  
  ## Select only the columns needed for output
  stateDat <- stateDat[, c("Hospital.Name", colNames[deathRateCol])]
  
  ## Sort hospitals first by rate (low to high) then by name (alphabetical)
  hospOrder <- order(as.numeric(stateDat[, 2]), stateDat[, 1])
  stateDat <- stateDat[hospOrder, ]
  
  ## Append rank column
  stateDat <- cbind(stateDat, 1:nrow(stateDat))
  
  ## Update column names
  colnames(stateDat) <- c("Hospital.Name", "Rate", "Rank")
  
  ## Return hospital name in that state with the given rank 30-day death rate
  if(num == "best"){
    rankedHospital <- stateDat[1, 1]
  }
  else if(num == "worst"){
    rankedHospital <- stateDat[nrow(stateDat), 1]
  }
  else if(num > nrow(stateDat)){
    rankedHospital <- NA
  }
  else {
    rankedHospital <- stateDat[num, 1]
  }
  rankedHospital
}