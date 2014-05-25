
# Code to obtain solutions to Quiz 1 problems

## Question 1: Take a look at the 'iris' dataset that comes with R. The data 
## can be loaded with the code:
library(datasets)
data(iris)

## A description of the dataset can be found by running
?iris

## There will be an object called 'iris' in your workspace. In this dataset, 
## what is the mean of 'Sepal.Length' for the species virginica? 
## (Please only enter the numeric result and nothing else.)
species.Sepal.Length.mean <- tapply(iris$Sepal.Length, iris$Species, mean)
species.Sepal.Length.mean["virginica"]

## Question 2: Continuing with the 'iris' dataset from the previous Question, 
## what R code returns a vector of the means of the variables 'Sepal.Length', 
## 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?
iris.means <- colMeans(iris[, c('Sepal.Length', 'Sepal.Width', 
                              'Petal.Length', 'Petal.Width')], 
                       na.rm = TRUE)
iris.means

## Question 3: Load the 'mtcars' dataset in R with the following code
library(datasets)
data(mtcars)

## There will be an object names 'mtcars' in your workspace. You can find some 
## information about the dataset by running
?mtcars

## How can one calculate the average miles per gallon (mpg) by number of 
## cylinders in the car (cyl)?
cyl.mpg.means <- tapply(mtcars$mpg, mtcars$cyl, mean)


## Question 4: Continuing with the 'mtcars' dataset from the previous Question, 
## what is the absolute difference between the average horsepower of 4-cylinder 
## cars and the average horsepower of 8-cylinder cars?
cyl.hp.means <- tapply(mtcars$hp, mtcars$cyl, mean)
hp.diff <- abs(cyl.hp.means["4"] - cyl.hp.means["8"])


## Question 5: If you run
debug(ls)

## what happens when you next call the 'ls' function?
ls
