
# Question 1: Which of the following items is required for an R package to pass
# R CMD check without any warnings or errors?

# unit tests
# DESCRIPTION file
# a demo directory
# example data sets


# Question 2: Which of the following is a generic function in a fresh
# installation of R, with only the default packages loaded?

colSums
dgamma
lm
show


# Question 3: What function is used to obtain the function body for an S4 method function?

getS3method()
getMethod()
showMethods()
getClass()


# Question 4: Which one of the following functions must be defined in order to
# deploy an R function on yhat?

model.load
model.transform
model.require
model.predict


# Question 5: Please download the R package DDPQuiz3 from the course web site.
# Examine the createmean function implemented in the R/ sub-directory. What is
# the appropriate text to place above the createmean function for Roxygen2 to
# create a complete help file?

#' This function calculates the mean
#' 
#' @param x is a numeric vector
#' @return the mean of x
#' @export
#' @examples 
#' x <- 1:10
#' createmean(y)

#' This function calculates the mean
#' 
#' @param x is a numeric vector
#' @return the mean of x
#' @export
#' @examples 
#' x <- 1:10
#' createmean(x)

#' This function calculates the mean
#' 
#' @return the mean of x
#' @export
#' @examples 
#' x <- 1:10
#' createmean(x)

#' This function calculates the mean
#' 
#' @param x is a numeric vector
#' @export
#' @examples 
#' x <- 1:10
#' createmean(x)