rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomeDat <- read.csv("outcome-of-care-measures.csv", 
                         colClasses = "character")
  colNames <- names(outcomeDat)
  
  ## Check that outcome and num arguments are valid
  possibleOutcomes <- c("heart attack", "heart failure", "pneumonia")
  if(!(outcome %in% possibleOutcomes)){
    message("error: invalid outcome")
  }
  
  possibleNums <- c("best", "worst")
  if(is.character(num)){
    if(!(num %in% possibleNums)){
      message("error: invalid num")
    }
  } else {
    if(num == 0){
      message("error: invalid num")
    }
  }
  
  ## Reformat outcome string and column names to identify relevant outcome 
  ## column in the 'outcomeDat' data frame
  colNamesNew <- tolower(gsub(x = colNames, pattern = "\\.", replacement = ""))
  outcomeNew <- gsub(x = outcome, pattern = " ", replacement = "")
  colPrefix = "hospital30daydeathmortalityratesfrom"
  deathRateCol <- colNamesNew %in% paste(colPrefix, outcomeNew, sep = "") 
  
  ## Initialize a data frame to store hospitals
  hospitalByState <- data.frame(matrix(ncol = 2, nrow = 0))
  colnames(hospitalByState) <- c("hospital", "state")
  
  ## For each state, find the hospital of the given rank
  for(state in unique(outcomeDat$State)){
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
    
    hospitalByState[state, ] <- c(rankedHospital, state)
  }
  
  ## Return a data frame with the hospital names and the (abbreviated) state name
  hospitalByState
  
}