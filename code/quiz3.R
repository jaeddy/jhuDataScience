# Question 1: Consider the mtcars data set. Fit a model with mpg as the outcome
# that includes number of cylinders as a factor variable and weight as
# confounder. Give the adjusted estimate for the expected change in mpg
# comparing 8 cylinders to 4.

data(mtcars)
model <- lm(mpg ~ factor(cyl) + wt, mtcars)
summary(model)

# 1. -3.206
# 2. -6.071 <<<<
# 3. 33.991
# 4. -4.256


# Question 2: Consider the mtcars data set. Fit a model with mpg as the outcome
# that includes number of cylinders as a factor variable and weight as
# confounder. Compare the adjusted by weight effect of 8 cylinders as compared
# to 4 the unadjusted. What can be said about the effect?

summary(lm(mpg ~ factor(cyl), mtcars))

# 1. Within a given weight, 8 cylinder vehicles have an expected 12 mpg drop in
# fuel efficiency. 
# 2. Holding weight constant, cylinder appears to have less of an impact on mpg
# than if weight is disregarded. <<<<
# 3. Holding weight constant, cylinder appears to have more of an impact on mpg
# than if weight is disregarded.
# 4. Including or excluding weight does not appear to change anything regarding
# the estimated impact of number of cylinders on mpg.


# Question 3: Consider the mtcars data set. Fit a model with mpg as the outcome
# that considers number of cylinders as a factor variable and weight as
# confounder. Consider the model with an interaction between cylinders and
# weight and one without. Give the P-value for the likelihood ratio test
# comparing the two models and suggest a model using 0.05 as a type I error rate
# significance benchmark.

model1 <- lm(mpg ~ factor(cyl) + wt + factor(cyl)*wt, mtcars)
model2 <- lm(mpg ~ factor(cyl) + wt, mtcars)

anova(model1, model2)

# 1. The P-value is larger than 0.05. So, according to our criterion, we would
# fail to reject, which suggests that the interaction terms may not be
# necessary. <<<<
# 2. The P-value is larger than 0.05. So, according to our criterion, we would
# fail to reject, which suggests that the interaction terms is necessary.
# 3. The P-value is small (less than 0.05). Thus it is surely true that there is
# no interaction term in the true model.
# 4. The P-value is small (less than 0.05). Thus it is surely true that there is
# an interaction term in the true model.
# 5. The P-value is small (less than 0.05). So, according to our criterion, we 
# reject, which suggests that the interaction term is not necessary.
# 6. The P-value is small (less than 0.05). So, according to our criterion, we
# reject, which suggests that the interaction term is necessary


# Question 4: Consider the mtcars data set. Fit a model with mpg as the outcome
# that includes number of cylinders as a factor variable and weight inlcuded in
# the model as

lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
lm(mpg ~ wt + factor(cyl), mtcars)

# How is the wt coefficient interpretted?

# 1. The estimated expected change in MPG per half ton increase in weight.
# 2. The estimated expected change in MPG per half ton increase in weight for 
# for a specific number of cylinders (4, 6, 8).
# 3. The estimated expected change in MPG per one ton increase in weight.
# 4. The estimated expected change in MPG per half ton increase in weight for 
# the average number of cylinders.
# 5. The estimated expected change in MPG per one ton increase in weight for a 
# specific number of cylinders (4, 6, 8). <<<<


# Question 5: Consider the following data set

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

# Give the hat diagonal for the most influential point

hatvalues(lm(y ~ x))

# 1. 0.2287
# 2. 0.9946 <<<<
# 3. 0.2025
# 4. 0.2804


# Question 6: Consider the following data set

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

# Give the slope dfbeta for the point with the highest hat value.

dfbetas(lm(y ~ x))

# 1. -.00134
# 2. 0.673
# 3. -0.378
# 4. -134 <<<<


# Question 7: Consider a regression relationship between Y and X with and
# without adjustment for a third variable Z. Which of the following is true
# about comparing the regression coefficient between Y and X with and without
# adjustment for Z.

# 1. The coefficient can't change sign after adjustment, except for slight 
# numerical pathological cases.
# 2. Adjusting for another variable can only attenuate the coefficient toward 
# zero. It can't materially change sign.
# 3. It is possible for the coefficient to reverse sign after adjustment. For 
# example, it can be strongly significant and positive before adjustment and 
# strongly significant and negative after adjustment. <<<<
# 4. For the the coefficient to change sign, there must be a significant 
# interaction term.

