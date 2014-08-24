# Question 1: Consider the following data with x as the predictor and y as as
# the outcome.

x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

# Give a P-value for the two sided hypothesis test of whether β1 from a linear
# regression model is 0 or not.
fit <- lm(y ~ x)
summary(fit)


# Question 2: Consider the previous problem, give the estimate of the residual
# standard deviation.


# Question 3: In the mtcars data set, fit a linear regression model of weight
# (predictor) on mpg (outcome). Get a 95% confidence interval for the expected
# mpg at the average weight. What is the lower endpoint?
data(mtcars)
fit <- lm(mpg ~ wt, data = mtcars)

newData <- data.frame(wt = mean(mtcars$wt))
p_ci <- predict(fit, newData, interval = ("confidence"))
p_ci


# Question 4: Refer to the previous question. Read the help file for mtcars.
# What is the weight coefficient interpreted as?
summary(fit)


# Question 5: Consider again the mtcars data set and a linear regression model
# with mpg as predicted by weight (1,000 lbs). A new car is coming weighing 3000
# pounds. Construct a 95% prediction interval for its mpg. What is the upper
# endpoint?
newData <- data.frame(wt = 3)
p_ci <- predict(fit, newData, interval = ("prediction"), level = 0.95)
p_ci

# Question 6: Consider again the mtcars data set and a linear regression model
# with mpg as predicted by weight (in 1,000 lbs). A “short” ton is defined as
# 2,000 lbs. Construct a 95% confidence interval for the expected change in mpg
# per 1 short ton increase in weight. Give the lower endpoint.
fit <- lm(mpg ~ wt, data = mtcars)
sumCoefs <- summary(fit)$coefficients
sumCoefs[2, 1]  <- 2 * sumCoefs[2, 1]
ci <- sumCoefs[2, 1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoefs[2, 2]
ci

# Question 7: If my X from a linear regression is measured in centimeters and I
# convert it to meters what would happen to the slope coefficient?


# Question 8: I have an outcome, Y, and a predictor, X and fit a linear
# regression model with Y=β0+β1X+ϵ to obtain β^0 and β^1. What would be the
# consequence to the subsequent slope and intercept if I were to refit the model
# with a new regressor, X+c for some constant, c?


# Question 9: Refer back to the mtcars data set with mpg as an outcome and
# weight (wt) as the predictor. About what is the ratio of the the sum of the
# squared errors, ∑ni=1(Yi−Y^i)2 when comparing a model with just an intercept
# (denominator) to the model with the intercept and slope (numerator)?
fit <- lm(mpg ~ wt, data = mtcars)
summary(fit)
yhat <- predict(fit)
sse <- sum((mtcars$mpg - yhat)^2)
sse

fit2 <- lm(mpg ~ offset(wt), data = mtcars)
yhat2 <- predict(fit2)
sse2 <- sum((mtcars$mpg - yhat2)^2)
sse/sse2

# Question 10: Do the residuals always have to sum to 0 in linear regression?