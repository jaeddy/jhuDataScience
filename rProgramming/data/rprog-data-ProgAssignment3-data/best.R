best <- function(state, outcome) {
  ## Read outcome data
  outcomeDat <- read.csv("outcome-of-care-measures.csv", 
                         colClasses = "character")
  colNames <- names(outcomeDat)
  
  ## Check that state and outcome are valid
  if(!(state %in% outcomeDat$State)){
    stop("invalid state")
  }
  
  possibleOutcomes <- c("heart attack", "heart failure", "pneumonia")
  if(!(outcome %in% possibleOutcomes)){
    stop("invalid outcome")
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
  
  #col <- as.numeric(stateDat[, deathRateCol])
  #estRow <- which(col == min(col))
  #print(stateDat[bestRow, deathRateCol])
  
  ## Identify which rows correspond to minimum outcome death rates
  bestRow <- which.min(stateDat[, deathRateCol])
  
  ## Return hospital name in that state with lowest 30-day death rate
  bestHospital <- stateDat$Hospital.Name[bestRow]
  bestHospital
}
