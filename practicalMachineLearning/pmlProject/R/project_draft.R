### Load libraries ###
######################
library(caret)
library(randomForest)
library(dplyr)
library(GGally)

### Download the data ###
#########################

# Create new directory to store data
if (!file.exists("data/")) {
    dir.create("data/")
}

# Specify base URL for files
fileBase <- "https://d396qusza40orc.cloudfront.net/predmachlearn/"

# Download training data
trainAddress <- paste0(fileBase, "pml-training.csv")
download.file(trainAddress, "data/pmlTraining.csv", method = "curl")

# Download test data
testAddress <- paste0(fileBase, "pml-testing.csv")
download.file(testAddress, "data/pmlTesting.csv", method = "curl")


### Load & clean the data ###
#############################

# Load the data
training <- read.csv("data/pmlTraining.csv")
testing <- read.csv("data/pmlTesting.csv")

# Inspect the training data
str(training)
summary(training)

training %>%
    select(new_window, num_window, classe) %>%
    ggpairs(colour = "classe")

# Drop non-measurement columns
training <- training %>%
    select(-X, -user_name, -raw_timestamp_part_1, -raw_timestamp_part_2,
           -cvtd_timestamp, -new_window, -num_window)

# Drop any variables with missing values, NAs, or near-zero variance
missingVars <- (colSums(is.na(training) | training == "") != 0)
missingIdx <- seq(1, ncol(training), 1)[missingVars]
nzv <- nearZeroVar(training)
trainingComplete <- training[, -union(missingIdx, nzv)]


### Train a model ###
#####################

set.seed(1234)
inTrain = createDataPartition(trainingComplete$classe, p = 0.7)[[1]]
subTrain <- trainingComplete[inTrain, ]
subTest <- trainingComplete[-inTrain, ]

rfModel <- randomForest(classe ~ ., data = subTrain, importance = TRUE)
classePred <- predict(rfModel, newdata = subTest)
confusionMatrix(data = classePred, reference = subTest$classe)

varImportance <- as.data.frame(importance(rfModel))
varImportance %>%
    ggplot(aes(x = MeanDecreaseGini)) +
    geom_histogram(binwidth = 20, fill = "#56B4E9") +
    geom_vline(xintercept = 250, colour = "#E69F00", size = 1.5,
               linetype = "longdash") +
    ylab("Number of variables")

importantVars <- row.names(varImportance)[varImportance$MeanDecreaseGini > 250]

### Cross-validate model ###
############################

nFolds <- 10
cvFolds <- createFolds(trainingComplete$classe, k = nFolds)
foldAcc <- rep(0, nFolds)

for (fold in 1:nFolds) {
    print(fold)
    foldTrain <- trainingComplete[-cvFolds[[fold]],
                                 names(trainingComplete) %in%
                                     c(importantVars, "classe")]
    foldTest <- trainingComplete[cvFolds[[fold]], ]
    
    foldModel <- randomForest(classe ~., data = foldTrain)
    classePred <- predict(foldModel, newdata = foldTest)
    
    foldAcc[fold] <- confusionMatrix(data = classePred,
                                     reference = foldTest$classe)$overall[1]
}

mean(foldAcc)

### Train final model ###
#########################

trainingImportant <- trainingComplete[, names(trainingComplete) %in%
                                          c(importantVars, "classe")]
rfModel <- randomForest(classe ~ ., data = trainingImportant)


### Predict classes in validation data set ###
##############################################

testPred <- as.character(predict(rfModel, newdata = testing))

# Create new directory to store results
if (!file.exists("results/")) {
    dir.create("results/")
}

source("R/output_predictions.R")
pml_write_files(testPred, "results/")
