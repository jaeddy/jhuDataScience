
# Code to obtain solutions to Quiz 1 problems

# Question 11: In the datasets provided for this Quiz, what are the column 
# names of the dataset?

# first read the data using read.csv()
quizData <- 
  read.csv('~/Google Drive/MyCode/RCode/rProgrammingCourse/data/hw1_data.csv')

# next use cnames to obtain column names
quizColNames <- colnames(quizData)


# Question 12: Extract the first 2 rows of the data frame and print them to the
# console. What does the output look like?

quizData[1:2, ]


# Question 13: How many observations (i.e. rows) are in this data frame?

# can be seen in the Environment tab, but just to try out the str function; 
# could also use nrow
str(quizData)


# Question 14: Extract the last 2 rows of the data frame and print them to the 
# console. What does the output look like?

# first determine the number of rows
quizRows <- nrow(quizData)

# pull out all columns beginning from the (number of rows - 1)th row to the 
# (number of rows)th row
quizData[c(quizRows-1, quizRows), ]


# Question 15: What is the value of Ozone in the 47th row?
quizData$Ozone[47]
quizData[47, ]$Ozone


# Question 16: How many missing values are in the Ozone column of this data 
# frame?

# use the is.na function and count the number of TRUE instances
sum(is.na(quizData$Ozone))


# Question 17: What is the mean of the Ozone column in this dataset? Exclude 
# missing values (coded as NA) from this calculation.

# combine logical indexing with the mean function
meanOzone <- mean(quizData$Ozone[!is.na(quizData$Ozone)])

# check how this compares to the summary output
summary(quizData) # looks the same!


# Question 18: Extract the subset of rows of the data frame where Ozone values 
# are above 31 and Temp values are above 90. What is the mean of Solar.R in 
# this subset?

# first define a logical vector based on the specified conditions
highOzoneTemp <- (quizData$Ozone > 31 & quizData$Temp > 90)

# check for missing values, as this might cause errors in subsequent steps
sum(is.na(highOzoneTemp))
sum(highOzoneTemp[!is.na(highOzoneTemp)]) # there should be 10 total rows

# next extract rows according to the specified conditions
quizDataSub <- quizData[highOzoneTemp, ] # this resulted in 14 rows

# adjust the logical vector to ensure NA rows aren't mistakenly extracted
highOzoneTemp[is.na(highOzoneTemp)] <- FALSE

# try again to extract the appropriate rows
quizDataSub <- quizData[highOzoneTemp, ] # this resulted in 10 rows!

# now use summary() to quickly calculate the mean
summary(quizDataSub)


# Question 19: What is the mean of "Temp" when "Month" is equal to 6?

# can do this following same logic of Question 18 code
month6 <- quizData$Month == 6
sum(is.na(month6)) # no missing values, so we're good
summary(quizData[month6, ])


# Question 20: What was the maximum ozone value in the month of May (i.e. 
# Month = 5)?

# repeat Quesiton 19 approach
month5 <- quizData$Month == 5
sum(is.na(month5))
summary(quizData[month5, ])
