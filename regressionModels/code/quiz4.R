# Question 1: Consider the space shuttle data ?shuttle in the MASS library.
# Consider modeling the use of the autolander as the outcome (variable name
# use). Fit a logistic regression model with autoloader (variable auto) use
# (labeled as "auto" 1) versus not (0) as predicted by wind sign (variable
# wind). Give the estimated odds ratio for autoloader use comparing head winds,
# labeled as "head" in the variable headwind (numerator) to tail winds
# (denominator).

library(MASS)
?shuttle
model <- glm(use ~ wind, family = binomial, data = shuttle)
summary(model)
exp(coef(model)[2])

# Question 2: Consider the previous problem. Give the estimated odds ratio for
# autoloader use comparing head winds (numerator) to tail winds (denominator)
# adjusting for wind strength from the variable magn.

model <- glm(use ~ wind + magn, family = binomial, data = shuttle)
summary(model)
exp(coef(model)[2])

# Question 3: If you fit a logistic regression model to a binary variable, for
# example use of the autolander, then fit a logistic regression model for one
# minus the outcome (not using the autolander) what happens to the coefficients?

shuttle$use <- relevel(shuttle$use, "noauto")
model <- glm(use ~ wind, family = binomial, data = shuttle)
summary(model)

# Question 4: Consider the insect spray data InsectSprays. Fit a Poisson model
# using spray as a factor level. Report the estimated relative rate comapring
# spray A (numerator) to spray B (denominator).

data(InsectSprays)
model <- glm(count ~ factor(spray) - 1, family = poisson, data = InsectSprays)
summary(model)
exp(coef(model)[1] - coef(model)[2])
exp(coef(model)[2] - coef(model)[1])
1/exp(0.05588)

# Question 5: Consider a Poisson glm with an offset, t. So, for example, a model
# of the form glm(count ~ x + offset(t), family = poisson) where x is a factor
# variable comparing a treatment (1) to a control (0) and t is the natural log
# of a monitoring time. What is impact of the coefficient for x if we fit the
# model glm(count ~ x + offset(t2), family = poisson) where t2 <- log(10) + t?
# In other words, what happens to the coefficients if we change the units of the
# offset variable. (Note, adding log(10) on the log scale is multiplying by 10
# on the original scale.)

download.file("https://dl.dropboxusercontent.com/u/7710864/data/gaData.rda",
              destfile="./data/gaData.rda", method = "curl")
load("./data/gaData.rda")
gaData$julian <- julian(gaData$date)

library(dplyr)
countData <- gaData %>% 
    mutate(count = visits + simplystats,
           x = factor(ifelse(simplystats > 0, 1, 0)))

t <- log(countData$julia)
t2 <- log(10) + t
model <- glm(count ~ x, offset = t2, family = poisson,
             data = countData)
summary(model)

# Question 6: Consider the data

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)

# Using a knot point at 0, fit a linear model that looks like a hockey stick
# with two lines meeting at x=0. Include an intercept term, x and the knot point
# term. What is the estimated slope of the line after 0?

knot <- 0
splineTerms <- sapply(knot, function(knot) (x > knot) * (x - knot))
xMat <- cbind(1, x, splineTerms)
yhat <- predict(lm(y ~ xMat - 1))
model <- lm(y ~ xMat - 1)
summary(model)
exp(coef(model)[3])

plot(x, y, frame=FALSE, pch=21, bg="lightblue", cex=2)
lines(x,yhat,col="red",lwd=2)
