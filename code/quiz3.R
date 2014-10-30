# Question 1: In a new population, a sample of 9 men yielded a sample average
# brain volume of 1,100cc and a standard deviation of 30cc. What is a 95%
# Student's T confidence interval for the mean brain volume in this new
# population?
n <- 9
Xbar <- 1100
S <- 30

ci <- Xbar + c(-1, 1) * qt(0.975, n - 1) * S / sqrt(n) # [1077, 1123]


# Question 2: A diet pill is given to 9 subjects over six weeks. The average
# difference in weight (follow up - baseline) is -2 pounds. What would the
# standard deviation have to be for the 95% T confidence interval to lie
# entirely below 0?
n <- 9
Xbar <- -2
ci_u  <- 0

S <- (ci_u - Xbar) * sqrt(n) / qt(0.975, n - 1) # 2.602
S <- 2.6
ci <- Xbar + c(-1, 1) * qt(0.975, n - 1) * S / sqrt(n)


# Question 3: Refer to the previous question. The interval wound up being [-3.5,
# -0.5] pounds. What can be said about the population mean weight loss at 95%
# confidence?

# There is support at 95% confidence of mean weight loss.


# Question 4: In an effort to improve efficiency, hospital administrators are
# evaluating a new triage system for their emergency room. In an validation
# study of the system, 5 patients were tracked in a mock ER under both the new
# and old triage system. Their waiting times were recorded. Would it be better
# to use an independent group or paired T confidence interval in this setting?

# Paired


# Question 5: Refer to the setting of the previous question. To further test the
# system, administrators selected 20 nights and randomly assigned the new triage
# system to be used on 10 nights and the standard system on the remaining 10
# nights. They calculated the nightly median waiting time (MWT) to see a
# physician. The average MWT for the new system was 3 hours with a variance of
# 0.60 while the average MWT for the old system was 5 hours with a variance of
# 0.68. Give a 95% confidence interval estimate for the differences of the mean
# MWT associated with the new system. Assume a constant variance.

n <- 10
MWT_new <- 3
MWT_old <- 5
MWT_diff <- -2
S_2_new <- 0.6
S_2_old <- 0.68
Sp <- sqrt(((n - 1) * S_2_new + (n - 1) * S_2_old) / (2 * n - 2))
rho = 0
S <- sqrt(S_new^2 + S_old^2 - 2 * S_new * S_old * rho)
S <- sqrt(S_new^2 + S_old^2 - 2 * Sp)

df <- 2*n - 2

Sp^2
ci <- MWT_diff + c(-1, 1) * qt(0.975, df) * Sp * sqrt(1/n + 1/n)


# Question 6: Suppose that you create a 95% T confidence interval. You then
# create a 90% interval using the same data. What can be said about the 90%
# interval with respect to the 95% interval?
n <- 9
Xbar <- 1100
S <- 30

ci_95 <- Xbar + c(-1, 1) * qt(0.975, n - 1) * S / sqrt(n) # [1077, 1123]
ci_90 <- Xbar + c(-1, 1) * qt(0.95, n - 1) * S / sqrt(n) # [1081, 1119]
# 90% CI is narrower


# Question 7: Let distribution 1 be N(μ1,σ21) and distribution 2 be N(μ2,σ22).
# Let x1,α and x2,α be the αth quantile from the two distributions,
# respectively. How are the two mathematically related?
D1 <- rnorm(1000, 0, 1)
D2 <- rnorm(1000, 2, 2)
qqplot(D1, D2)
abline(h = 4, v = 1)
dev.off()

# Question 8: Consider data points x1,…,xn. Imagine a probability mass function,
# so that a random variable X from this distribution has P(X=xi)=p(xi)=1n. This
# is the so-called bootstrap distribution. What is the mean of the bootstrap
# distribution?
x <- rnorm(100, 0, 1)
bd <- x/length(x) 
mean(bd)

# Question 9: Suppose we were to simulate a large number of standard normal
# random variables and a large number of exponential random variables. What
# would a plot of the exponential quantiles (horizontal axis) versus the
# standard normal quantiles (vertical axis) look like? Let Φ be the standard
# normal distribution function.
D1 <- rnorm(1000, 0, 1)
D2 <- rexp(1000, 1)
qqplot(D2, D1)

pdf <- pnorm(q = seq(0, 6, 1), mean = 0, sd = 1)
x <- seq(0, 6, 1)
plot(x, pdf^-1 * (1 - exp(-x)))

# Question 10: Let F(x) be a distribution function. Notice that G(x)=F(a2x+b) is
# also a distribution function for a≠0. If you were to take large samples from F
# and G, what must the QQ plot look like without knowing the specific values of
# a and b?
D1 <- rexp(1000, 1)
D2 <- rexp(1000, 2)
qqplot(D2, D1)

# Question 11: Let your data be the two points {1,3}. What is the bootstrap
# distribution of the sample mean?
library(boot)
data <- c(1, 3)
stat <- function(x, i) {mean(x[i])}
boot.out <- boot(data = data,
                 statistic = stat,
                 R = 1000)
boot.ci(boot.out)
dev.off()
hist(boot.array(boot.out)[, 2])
