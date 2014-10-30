# Question 1: You would like to estimate the prevalence of a disease. You
# randomly sample 10 people from the population of interest and 4 of them have
# the condition. Using a Beta prior with α and β both being 10, what is the
# posterior mean prevalence closest to?
x <- 4
n <- 10

alpha <- 10
beta <- 10

alpha_til <- x + alpha
beta_til <- n - x + beta

post_mean <- alpha_til / (alpha_til + beta_til)

# Question 2: You simulate a lot of lognorma(5, 1) random variables and take
# their geometric mean. What will it likely be close to?
X <- rlnorm(10000, meanlog = 5, sdlog = 1)


# Question 3: You simulate a lot of lognormal(5,1) random variables and take
# their mean. What is this number closest to?
mean(X)
exp(5.5)

# Question 4: If you simulate a very large number of binomial(n,p) random
# variables, calculate a 95% Wald confidence interval for p and calculate the
# percentage of times the intervals covers the value of p used for simulation. p
# is neither 0 or 1. Which of the following are true about the percentage of
# times the intervals cover the true value (check all that are true)?
p <- 0.5
n = 10

p_cov <- vector("numeric", length = 1000000)
for (i in 1:1000000) {
    X <- rbinom(1, n, p)
    p_hat <- X/n
    ci <- p_hat + c(-1, 1) * qnorm(0.975, mean = 0, sd = 1) *
        sqrt(p_hat * (1 - p_hat) / n)
    p_cov[i] <- p >= ci[1] & p <= ci[2]
}
mean(p_cov)

# Question 5: The difference between μ and x is