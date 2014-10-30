# Question 1: A case-control study of esophageal cancer was performed. Daily
# alcohol consumption was ascertained (H = high, L = low). The data was
# stratified by 2 age groups.

# Low age group

#           H   L
# Case	    8	5
# Control	52	164

# High age group

#           H	L
# Case	    25	21
# Control	29	128

# Assuming a constant odds ratio across age-strata, test to see if the odds
# ratio is 1 and report a Pvalue

dat <- array(c(8, 52, 5, 164,
               25, 29, 21, 128),
             c(2, 2, 2))
mantelhaen.test(dat, correct = FALSE)


# Question 2: The Biostatistics and Epidemilogy departments are running a 10K
# road race. There are three pairs of runners. In each case, a runner from
# Biostat was matched to a runner from Epi of the same age, gender and degree of
# running experience. The difference in each pairs times was taken and a signed
# rank test performed.

# What is the smallest value that the two sided exact signed rank p-value could
# take?

diff <- rnorm(n = 3, mean = 0, sd = 1)
diffRank <- rank(diff)
diffRank

diff <- c(12, 5, 99)
wilcox.test(diff, exact = TRUE, correct = FALSE, alternative = "two.sided")

# Question 3: Two computer based methods for diagnostic imaging are being
# studied. Ten images were processed with both methods, resulting in a + or −
# diagnosis for each method and image. The data are as follows

#   +    -
# +	55	41
# -	12	20

# Where Method A is represeted with the two columns and Method B is represented
# on the rows. What is the P-value for a of the hypothesis that the marginal
# probability of a positive diagnosis is the same for the two methods? (Use the
# large sample version.)

dat <- matrix(c(55, 12, 41, 20), 2)
prop.test(dat, correct = FALSE)

# Question 4: Two computer based methods for diagnostic imaging are being
# studied. Ten images were processed with both methods, resulting in a + or −
# diagnosis for each method and image. The data are as follows

#   +    -
# +	55	41
# -	12	20

# Where Method A is represeted with the two columns and Method B is represented
# on the rows. What is the marginal odds ratio of a positive diagnosis comparing
# the two methods? (Put the odds associated with Method B in the numerator.)

dat <- matrix(c(55, 12, 41, 20), 2)
mcnemar.test(dat, correct = FALSE)

totA <- colSums(dat)
probA <- totA[1] / sum(totA)
oddsA <- probA / (1 - probA)

totB <- rowSums(dat)
probB <- totB[1] / sum(totB)
oddsB <- probB / (1 - probB)

oddsB/oddsA


# Question 5: A matched case control study was executed to study an airborn
# environmental toxicant's effect on lung cancer.The data are

# Case and exposure status          count
# Case exposed, control exposed	    243
# Case exposed, control unexposed	189
# Case unexposed, control exposed	54
# Case unexposed, control unexposed	153

# What is the conditional odds ratio of odds of exposure for cases over odds of
# exposure for controls?

n21 <- 189
n12 <- 54
n21/n12


# Question 6: A topical rash treatment was applied to a portion of a rash on n
# patients. A quantitative measure of redness was calculated for the treated and
# untreated regions of the rash. A sign of + was given when the treated area was
# less red (more improved) than the untreated area and a − sign when it was not.
# It is desired to know whether the treatment improves the rash.

# How many possible values can the P-value for the sign test take?



# Question 7: A topical rash treatment was applied to a portion of a rash on n
# patients. A quantitative measure of redness was calculated for the treated and
# untreated regions of the rash. A sign of + was given when the treated area was
# less red (more improved) than the untreated area and a − sign when it was not.
# It is desired to know whether the treatment improves the rash.

# Consider a 5% one sided sign test for 5 subjects. What would be the power of
# the test if the probability that the treatment works is actually 80% instead
# of the 50% assumed under the null?

binom.test(4, 5, p = 0.8)
