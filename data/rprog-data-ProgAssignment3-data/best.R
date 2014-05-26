best <- function(state, outcome) {
  ## Read outcome data
  outcomeDat <- read.csv("outcome-of-care-measures.csv", 
                         colClasses = "character")
  colNames <- names(outcomeDat)
  
  ## Check that state and outcome are valid
  if(!(state %in% outcomeDat$State)){
    error("invalid state")
  }
  
  possibleOutcomes <- c("heart attack", "heart failure", "pneumonia")
  if(!(outcome %in% possibleOutcomes)){
    error("invalid outcome")
  }
  
  colNamesNew <- tolower(gsub(x = colNames, pattern = "\\.", replacement = ""))
  outcomeNew <- gsub(x = outcome, pattern = " ", replacement = "")
  colPrefix = "hospital30daydeathmortalityratesfrom"
  deathRateCol <- colNamesNew %in% paste(colPrefix, outcomeNew, sep = "") 
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  outcomeByState <- split(outcomeDat[, deathRateCol], outcomeDat$State)
  min(outcomeByState[state])
  
}
