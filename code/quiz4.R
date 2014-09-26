# Question 1: Load the vowel.train and vowel.test data sets:
library(ElemStatLearn)
library(dplyr)
library(caret)
data(vowel.train)
data(vowel.test) 

# Set the variable y to be a factor variable in both the training and test set.
# Then set the seed to 33833. Fit (1) a random forest predictor relating the
# factor variable y to the remaining variables and (2) a boosted predictor using
# the "gbm" method. Fit these both with the train() command in the caret
# package.

vowel.train <- vowel.train %>%
    mutate(y = as.factor(y))
vowel.test <- vowel.test %>%
    mutate(y = as.factor(y))

set.seed(33833)
rfModel <- train(y ~ ., method = "rf", data = vowel.train)
gbmModel <- train(y ~ ., method = "gbm", data = vowel.train)

# What are the accuracies for the two approaches on the test data set? What is
# the accuracy among the test set samples where the two methods agree?

rfPred <- predict(rfModel, newdata = vowel.test)
mean(rfPred == vowel.test$y)

gbmPred <- predict(gbmModel, newdata = vowel.test)
mean(gbmPred == vowel.test$y)

agreePred <- rfPred == gbmPred
mean(rfPred[agreePred] == vowel.test$y[agreePred])


# Question 2: Load the Alzheimer's data using the following commands
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Set the seed to 62433 and predict diagnosis with all the other variables using
# a random forest ("rf"), boosted trees ("gbm") and linear discriminant analysis
# ("lda") model. Stack the predictions together using random forests ("rf").
# What is the resulting accuracy on the test set? Is it better or worse than
# each of the individual predictions?

set.seed(62433)
rfModel <- train(diagnosis ~ ., method = "rf", data = training)
gbmModel <- train(diagnosis ~ ., method = "gbm", data = training, 
                  verbose = FALSE)
ldaModel <- train(diagnosis ~ ., method = "lda", data = training)

rfPred <- predict(rfModel, newdata = testing)
mean(rfPred == testing$diagnosis)

gbmPred <- predict(gbmModel, newdata = testing)
mean(gbmPred == testing$diagnosis)

ldaPred <- predict(ldaModel, newdata = testing)
mean(ldaPred == testing$diagnosis)

predDF <- data.frame(rfPred, gbmPred, ldaPred, diagnosis = testing$diagnosis)
combModel <- train(diagnosis ~ ., method = "rf", data = predDF)
combPred <- predict(combModel, newdata = testing)
mean(combPred == testing$diagnosis)


# Question 3: Load the concrete data with the commands:
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Set the seed to 233 and fit a lasso model to predict Compressive Strength.
# Which variable is the last coefficient to be set to zero as the penalty
# increases? (Hint: it may be useful to look up ?plot.enet).
set.seed(233)
lassoModel <- train(CompressiveStrength ~ ., method = "lasso", data = training)
plot.enet
x <- training %>%
    dplyr::select(-CompressiveStrength) %>%
    as.matrix()
y <- training %>%
    dplyr::select(CompressiveStrength) %>%
    as.matrix()

lassoModel <- enet(x = x, y = y)
plot.enet(lassoModel$finalModel, xvar = "penalty")
dev.off()


# Question 4: Load the data on the number of visitors to the instructors blog
# from here:
fileAddress <- "https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"
dir.create("data")
download.file(fileAddress, "data/gaData.csv", method = "curl")

# Using the commands:
    
library(lubridate)  # For year() function below
dat = read.csv("data/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

# Fit a model using the bats() function in the forecast package to the training
# time series. Then forecast this model for the remaining time points. For how
# many of the testing points is the true value within the 95% prediction
# interval bounds?

library(forecast)
batsModel <- bats(tstrain)
batsPred <- forecast(batsModel, h = length(ts(testing$date)))

plot(batsPred); lines(ts(testing$visitsTumblr), col = "red")

sum(ts(testing$visitsTumblr) > batsPred$lower[, 2] &
        ts(testing$visitsTumblr) < batsPred$upper[, 2])
226/235


# Question 5: Load the concrete data with the commands:
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Set the seed to 325 and fit a support vector machine using the e1071 package
# to predict Compressive Strength using the default settings. Predict on the
# testing set. What is the RMSE?

set.seed(325)
library(e1071)
x <- training %>%
    dplyr::select(-CompressiveStrength)
y <- training %>%
    dplyr::select(CompressiveStrength)

svmModel <- svm(x = x, y = y)
svmPred <- predict(svmModel, testing %>% dplyr::select(-CompressiveStrength))

rmse <- sqrt(mean((svmPred - testing$CompressiveStrength)^2, na.rm = TRUE))

