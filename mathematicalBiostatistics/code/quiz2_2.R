# Question 1: What is the delta method asymptotic standard error of p^‾‾√ where
# p^ is X/n where X∼Binomial(n,p)?

theta <- phat
se_theta <- sqt(phat * (1 - phat) / n)
f_theta <- sqt(phat) # p^1/2
f_prime_theta <- 1 / 2 * sqt(phat)
se_f_theta <- 1 / 2 / sqt(phat) * sqt(phat) * sqt(1 - phat) / sqt(n)
se_f_theta <- sqt((1 - phat) / (4 * n))


# Question 2: You are a bookie taking $1 bets on the NFL Ravens game. The odds
# you give betters determines their payout. If you give 4 to 1 odds against the
# Ravens winning, then if a person bets on the Ravens winning and they win, you
# owe them their original dollar, plus an additional $4 (a total of $5). If a
# person bets on the Ravens losing and they lose, then you owe them their
# original dollar back, plus $0.25 (a total of $1.25).

# Suppose you collect a > 0 one dollar bets on the Ravens winning and b > 0 one
# dollar bets on the Ravens losing. What should you set the odds so that,
# regardless of the outcome of the game, you neither win nor lose money? Note,
# in this case, the betters place their bets and learn the odds later. Note
# also, the odds are something that you set in this case, not a direct measure
# of probability or randomness.

a <- 2
b <- 1

2:1 win:
    a gives 2
    a gets (1 + 1/2)*2
    b gives 1
    b gets 0
    net: (2 + 1) - 3
2:1 loss:
    a gives 2
    a gets 0
    b gives 1
    b gets (1 + 2)*1
    net: (2 + 1) - 3
    


# Question 3: In a randomly sampled survey of self-reported stress levels from
# two occupations, the following data were obtained

#               High Stress    Low Stress
# Professor	    70
# Lion Tamer	15

# What is the P-value for a Z score test of equality of the proportions of high
# stress?

# (Note the notation 1e-5, for example, is 1×10−5).

x <- 70
n1 <- 100
y <- 15
n2 <- 100

p1 <- x / n1
p2 <- y / n2
phat <- (x + y) / (n1 + n2)

se <- sqrt((phat * (1 - phat)) * (1 / n1 + 1 / n2))
ts <- (p1 - p2) / se

2 * pnorm(ts, mean = 0, sd = 1, lower.tail = FALSE)

# Question 4: Consider the following data recording case status relative to an
# environmental exposure

#           Case    Control
# Exposed	45	    21
# Unexposed	15	    52

# What would be the estimated asymptotic standard error for the log relative
# risk for this data? Consider case status as the outcome. That is, we're
# interested in evaluating the ratio of the proportion of cases comparing
# exposed to unexposed groups.

x <- 45
n1 <- 45 + 21
y <- 15
n2 <- 15 + 52

p1 <- x / n1
p2 <- y / n2

se_logRR <- sqrt(((1 - p1) / (p1 * n1)) + ((1 - p2) / (p2 * n2)))

# Question 5: If x1∼Binomial(n1,p1) and x2∼Binomial(n2,p2) and independent
# Beta(2,2) priors are placed on p1 and p2, what is the posterior mean for
# p1−p2?

x <- 11
n1 <- 20
y <- 5
n2 <- 20

alpha1 <- 2
beta1 <- 2
alpha2 <- 2
beta2 <- 2

p1 <- rbeta(1000, x + alpha1, n1 - x + beta1)
p2 <- rbeta(1000, y + alpha2, n2 - y + beta2)

rd <- p1 - p2
mean(rd)
(x + 2)/(n1 + 4) - (y + 2)/(n2 + 4)


# Question 6:   Researchers conducted a blind taste test of Coke versus Pepsi.
# Each of four people was asked which of two blinded drinks given in random
# order that they preferred. The data was such that 3 of the 4 people chose
# Coke. Assuming that this sample is representative, report a P-value for a test
# of the hypothesis that Coke is preferred to Pepsi using a **two sided** exact
# test.

Preferred <- matrix(c(1, 3, 3, 1), 
                    nrow = 2,
                    dimnames = list(Drink = c("Coke", "Pepsi"),
                                    Prefer = c("No", "Yes")))
Preferred
fisher.test(Preferred, alternative = "two.sided")
binom.test(3, 4, 0.5, alternative = "two.sided")
