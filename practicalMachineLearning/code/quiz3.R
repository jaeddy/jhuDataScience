# Question 1: Load the cell segmentation data from the AppliedPredictiveModeling
# package using the commands:
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(dplyr)

# 1. Subset the data to a training set and testing set based on the Case
# variable in the data set.

training <- segmentationOriginal %>%
    filter(Case == "Train")
testing <- segmentationOriginal %>%
    filter(Case == "Test")

# 2. Set the seed to 125 and fit a CART model with the rpart method using all
# predictor variables and default caret settings.
set.seed(125)
cartModel <- train(Class ~ ., method = "rpart", data = training)

# 3. In the final model what would be the final model prediction for cases with
# the following variable values:
# a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2
# b. TotalIntench2 = 50,000; FiberWidthCh1 = 10; VarIntenCh4 = 100 
# c. TotalIntench2 = 57,000; FiberWidthCh1 = 8; VarIntenCh4 = 100 
# d. FiberWidthCh1 = 8; VarIntenCh4 = 100; PerimStatusCh1=2 

cartModel$finalModel

newSamples <- data.frame(TotalIntench2 = c(23000, 50000, 57000, NA),
                         FiberWidthCh1 = c(10, 10, 8, 8),
                         PerimStatusCh1 = c(2, NA, NA, 2),
                         VarIntenCh4 = c(NA, 100, 100, 100))

a. PS
b. WS
c. PS
d. Not possible to tell


# Question 2: If K is small in a K-fold cross validation is the bias in the
# estimate of out-of-sample (test set) accuracy smaller or bigger? If K is small
# is the variance in the estimate of out-of-sample (test set) accuracy smaller
# or bigger. Is K large or small in leave one out cross validation?


# Question 3: Load the olive oil data using the commands:
library(pgmm)
data(olive)
olive = olive[,-1]

# (NOTE: If you have trouble installing the pgmm package, you can download the
# olive dataset here: olive_data.zip. After unzipping the archive, you can load
# the file using the load() function in R.) These data contain information on
# 572 different Italian olive oils from multiple regions in Italy. Fit a
# classification tree where Area is the outcome variable. Then predict the value
# of area for the following data frame using the tree command with all defaults

cartModel <- train(Area ~ ., method = "rpart", data = olive)

as.data.frame(t(colMeans(olive)))
pred <- predict(cartModel, newdata = as.data.frame(t(colMeans(olive))))

# What is the resulting prediction? Is the resulting prediction strange? Why or
# why not?


# Question 4: Load the South Africa Heart Disease Data and create training and
# test sets with the following code:
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

# Then set the seed to 13234 and fit a logistic regression model (method="glm",
# be sure to specify family="binomial") with Coronary Heart Disease (chd) as the
# outcome and age at onset, current alcohol consumption, obesity levels,
# cumulative tabacco, type-A behavior, and low density lipoprotein cholesterol
# as predictors. Calculate the misclassification rate for your model using this
# function and a prediction on the "response" scale:

set.seed(13234)
glmModel <- glm(chd ~ age + alcohol + obesity + tobacco + typea + ldl,
                  family = "binomial", data = trainSA)
trainPred <- predict.glm(glmModel, type = "response", newdata = trainSA)
testPred <- predict.glm(glmModel, type = "response", newdata = testSA)

missClass = function(values,prediction){
    sum(((prediction > 0.5)*1) != values) / length(values)
}

# What is the misclassification rate on the training set? What is the
# misclassification rate on the test set?

missClass(trainSA$chd, trainPred)
missClass(testSA$chd, testPred)

# Question 5: Load the vowel.train and vowel.test data sets:
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

# Set the variable y to be a factor variable in both the training and test set.
# Then set the seed to 33833. Fit a random forest predictor relating the factor
# variable y to the remaining variables. Read about variable importance in
# random forests here:
# http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm#ooberr The
# caret package uses by defualt the Gini importance. Calculate the variable
# importance using the varImp function in the caret package. What is the order
# of variable importance?

vowel.train <- vowel.train %>%
    mutate(y = as.factor(y))
vowel.test <- vowel.test %>%
    mutate(y = as.factor(y))

set.seed(33833)
rfModel <- train(y ~ ., method = "rf", data = vowel.train)
varImp(rfModel)
