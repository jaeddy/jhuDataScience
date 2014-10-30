# Question 1: Load the Alzheimer's disease data using the commands:

library(AppliedPredictiveModeling)
library(caret)
library(Hmisc)
library(reshape2)
library(dplyr)
data(AlzheimerDisease)

# Which of the following commands will create training and test sets with about
# 50% of the observations assigned to each?

adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50, list = FALSE)
training = adData[trainIndex, ]
testing = adData[-trainIndex, ] 

# Question 2: Load the cement data using the commands:
data(concrete)

set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain, ]
testing = mixtures[-inTrain, ]

# Make a plot of the outcome (CompressiveStrength) versus the index of the
# samples. Color by each of the variables in the data set (you may find the
# cut2() function in the Hmisc package useful for turning continuous covariates
# into factors). What do you notice in these plots?

training$idx <- 1:nrow(training)

cut2tiers <- function(x, m) {
    xcut <- cut2(x, m)
    sapply(xcut, function(xc) { match(xc, levels(xcut)) })
}

trainMelt <- training %>%
    melt(id.vars = c("idx", "CompressiveStrength"), 
         measure.vars = c("Cement", "BlastFurnaceSlag", "FlyAsh", "Water",
                          "Superplasticizer", "CoarseAggregate",
                          "FineAggregate", "Age")) %>%
    group_by(variable) %>%
    mutate(valueFactor = cut2tiers(value, m = 20))

ggplot(trainMelt, aes(x = idx, y = CompressiveStrength)) +
    geom_point(aes(colour = valueFactor)) +
    facet_wrap( ~ variable)

plot(training$CompressiveStrength,pch=1,col=cut2(training$FlyAsh,m=20))
plot(training$CompressiveStrength,pch=1,col=cut2(training$Age,m=20))
plot(training$CompressiveStrength,pch=1,col=cut2(training$BlastFurnaceSlag,m=20))
plot(training$CompressiveStrength,pch=1,col=cut2(training$Water,m=20))
plot(training$CompressiveStrength,pch=1,col=cut2(training$Superplasticizer,m=20))
plot(training$CompressiveStrength,pch=1,col=cut2(training$CoarseAggregate,m=20))
plot(training$CompressiveStrength,pch=1,col=cut2(training$FineAggregate,m=20))



# Question 3: Load the cement data using the commands:
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

# Make a histogram and confirm the SuperPlasticizer variable is skewed. Normally
# you might use the log transform to try to make the data more symmetric. Why
# would that be a poor choice for this variable?
ggplot(training, aes(x = log(Superplasticizer+1))) +
    geom_histogram()

ggplot(training, aes(x = Superplasticizer)) +
    geom_histogram()

# Question 4: Load the Alzheimer's disease data using the commands:
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Find all the predictor variables in the training set that begin with IL.
# Perform principal components on these variables with the preProcess() function
# from the caret package. Calculate the number of principal components needed to
# capture 80% of the variance. How many are there?

trainIL <- training %>%
    select(starts_with("IL"))
preProc <- preProcess(trainIL, method = "pca", thresh = .8)

# Question 5: Load the Alzheimer's disease data using the commands:
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Create a training data set consisting of only the predictors with variable
# names beginning with IL and the diagnosis. Build two predictive models, one
# using the predictors as they are and one using PCA with principal components
# explaining 80% of the variance in the predictors. Use method="glm" in the
# train function. What is the accuracy of each method in the test set? Which is
# more accurate?

trainIL <- training %>%
    select(starts_with("IL"), matches("diagnosis"))
testIL <- testing %>%
    select(starts_with("IL"), matches("diagnosis"))

model1 <- train(diagnosis ~ ., method = "glm", data = trainIL)
pred <- predict(model1, newdata = testing)
confusionMatrix(data = pred, reference = testing$diagnosis)

preProc <- preProcess(trainIL %>% select(-diagnosis), 
                      method = "pca", thresh = .8)
trainPC <- predict(preProc, trainIL %>% select(-diagnosis))
model2 <- train(trainIL$diagnosis ~ ., method = "glm", data = trainPC)

testPC <- predict(preProc, testIL %>% select(-diagnosis))
pred <- predict(model2, newdata = testPC)
confusionMatrix(data = pred, reference = testIL$diagnosis)
