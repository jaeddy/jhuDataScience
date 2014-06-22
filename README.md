# Getting and Cleaning Data: Course Project

## Summary
The objective of this analysis was to collect, work with, and clean a data set,
ultimately preparing a tidy data set that can be used for later analysis. Data
collected for accelerometers from the Samsung Galaxy S smartphone was obtained
from the following address:  

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  

The original source of the data is below:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  


Data was collected for 30 subjects (volunteers) performing 6 different physical
activities. In this analysis, the data was extracted, further processed and
summarized in `R` and transformed into a new tidy data set.

## Raw data
Details about the raw data set, including study design, feature/variable
descriptions, and any initial data processing/summarization can be found in the
`data/UCI HAR Dataset` directory. In particular, the `README.txt` and 
`features_info.txt` files provide helpful information about most aspects of the
raw data.

## Tidy data
The final, cleaned data set can be found in the `data/tidy` directory in the 
`uciHarClean.txt` file. Further description of variables included in the tidy
data set and how they were obtained is provided in the `CodeBook.md` file, 
which can be found in the main directory for this repository.

## Approach
All steps of the analysis were carried out using the `run_analysis.R` script.
The script relies primarily on (1) built in `R` functions for reading in data
and working with data frames; (2) the `grep()` and `gsub()` functions for 
identifying or manipulating strings based on regular expressions; and (3) data
frame subsetting/summarizing functions from Hadley Wickham's `dplyr` package.
Further detail and description of individual steps can be found in the comments
within `run_analysis.R`.

## Running the analysis script
After cloning the repo to a local machine, the full analysis can be performed
simply by calling `run_analysis.R` from the top level directory 
(`/gettingDataProject/`).