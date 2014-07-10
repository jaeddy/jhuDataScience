# Code for Quiz 2

# Question 2: What is produced by the following code?
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

# Question 4: The following code does NOT result in a plot appearing on the 
# screen device.
library(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)
print(p)

# Question 7: Load the `airquality' dataset form the datasets package in R.
library(datasets)
data(airquality)

# I am interested in examining how the relationship between ozone and wind 
# speed varies across each month. What would be the appropriate code to 
# visualize that using ggplot2?
library(ggplot2)

qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))

airquality <- transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)


# Question 10: The following code creates a scatterplot of 'votes' and 'rating'
# from the movies dataset in the ggplot2 package. After loading the ggplot2 
# package with the library() function, I can run
qplot(votes, rating, data = movies)

# How can I modify the the code above to add a loess smoother to the 
# scatterplot?
qplot(votes, rating, data = movies) + geom_smooth()
