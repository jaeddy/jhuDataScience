# Question 1: In a random sample of 100 patients at a clinic, you would like to
# test whether the mean RDI is x or more using a one sided 5% type 1 error rate.
# The sample mean RDI had a mean of 12 and a standard deviation of 4. What value
# of x (testing H0:μ=x versus Ha:μ>x) would you reject for?
C <- 12
sd <- 4
n <- 100

mu <- C - qnorm(0.95) * sd / sqrt(n)


# Question 2: A pharmaceutical company is interested in testing a potential
# blood pressure lowering medication. Their first examination considers only
# subjects that received the medication at baseline then two weeks later. The
# data are as follows (SBP in mmHg)

# Baseline    Week 2
# 140	138
# 138	136
# 150	148
# 148	146
# 135	133

# Test the hypothesis that there was a mean reduction in blood pressure. Compare
# the difference between a paired and unpaired test for a two sided 5% level
# test.
bp1 <- c(140, 138, 150, 148, 135)
bp2 <- c(138, 136, 148, 146, 133)

t.test(bp1, bp2, alternative = "two.sided", paired = FALSE)
t.test(bp1, bp2, alternative = "two.sided", paired = TRUE)


# Question 3: Brain volumes for 9 men yielded a 90 % confidence interval of
# 1,077 cc to 1,123 cc. Would you reject in a two sided 5% hypothesis test of
# H0:μ=1,078?


# Question 4: In an effort to improve efficiency, hospital administrators are
# evaluating a new triage system for their emergency room. In an validation
# study of the system, 5 patients were tracked in a mock (simulated) ER under
# the new and old triage system. Their waiting times in natural log of hours
# were:

# Subject    1	2	3	4	5
# New	0.929	-1.745	1.677	0.701	0.128
# Old	2.233	-2.513	1.204	1.938	2.533

# Give a Pvalue for the test of the hypothesis that the new system resulted in
# lower waiting times for a one sided t test.
newDat <-  c(0.929, -1.745, 1.677, 0.701, 0.128)
oldDat <- c(2.233, -2.513, 1.204, 1.938, 2.533)
t.test(newDat, oldDat, alternative = "less", paired = TRUE)


# Question 5: Refer to the previous question. Give a 95% T confidence interval
# for the ratio of the waiting times (recall that the measurements were natural
# logged).
diff <- newDat - oldDat
res <- t.test(diff)
exp(res$conf.int)


# Question 6: Suppose that 18 obese subjects were randomized, 9 each, to a new
# diet pill and a placebo. Subjects’ body mass indices (BMIs) were measured at a
# baseline and again after having received the treatment or placebo for four
# weeks. The average difference from follow-up to the baseline (followup -
# baseline) was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo
# group. The corresponding standard deviations of the differences was 1.5 kg/m2
# for the treatment group and 1.8 kg/m2 for the placebo group. Does the change
# in BMI over the two year period appear to differ between the treated and
# placebo groups? Assuming normality of the underlying data and a common
# population variance, give a pvalue for a two sided t test.
xbar_t <- -3
xbar_p <- 1
s_t <- 1.5
s_p <- 1.8
n <- 9

s_pool <- sqrt(((n - 1) * s_t^2 + (n - 1) * s_p^2) / (n + n - 2))
testStat <- (xbar_t - xbar_p) / s_pool / sqrt(1 / n + 1 / n)
2 * pt(abs(testStat), n + n - 2, lower.tail = FALSE)


# Question 7: Consider a one sided α level single group Z test of H0:μ=μ0 versus
# Ha:μ>μ0 with the data X¯ for the sample mean and s for the sample standard
# deviation with n measurements. What are the collection of points for which you
# would fail to reject the hypothesis?


# Question 8: Researchers would like to conduct a study of n healthy adults to
# detect a four year mean brain volume loss of .01 mm3. Assume that the standard
# deviation of four year volume loss in this population is .04 mm3. What would
# be the value of n needded for 90% power of type one error rate of 5% one sided
# test versus a null hypothesis of no volume loss?
mu <- 0.01
sigma <- 0.04
power.t.test(delta = mu, sd = sigma, sig.level = 0.05, power = 0.90, 
             alternative = "one.sided")


# Question 9: The Daily Planet ran a recent story about Kryptonite poisoning in
# the water supply after a recent event in Metropolis. Their usual field
# reporter, Clark Kent, called in sick and so Lois Lane reported the stories.
# Researchers plan to sample 288 individuals from Metropolis and control city
# Gotham and will compare mean blood Kryptonite levels (in Lex Luthors per
# milliliter, LL/ml). The expect to find a mean difference in LL/ml of around 2.
# Assoming a two sided Z test of the relevant hypothesis at 5%, what would be
# the power. Assume that the standard deviation is 12 for both groups.
n <- 288
mu_diff <- 2
sigma <- 12
power.t.test(n = n, delta = mu_diff, sd = sigma, sig.level = 0.05,
             alternative = "two.sided")


# Question 10: As you increase the type one error rate, α, what happens to
# power?


# Question 11: Consider a setting with iid data from a N(μ,σ2) distribution
# testing H0:μ=0 verus Ha:μ>0. The null hypothesis is rejected if n‾√X¯/σ>1.645.
# What happens to the type I error rate as n goes to infinity?
n <- 100
xbar <- 30
sigma <- 10
power.t.test(n = n, delta = xbar, sd = sigma, power = 0.90, sig.level = NULL,
             alternative = "one.sided")


# Question 12: Suppose that you have three independent samples from a N(μ1,σ2),
# N(μ2,σ2) and N(μ3,σ2) respectively of size n1, n2 and n3. Let S21, S22 and S23
# be the associated sample variances. Define the pooled variance as

# S2p=(n1−1)S21+(n2−1)S22+(n3−1)S23n1+n2+n3−3

# Consider testing H0:aμ1+bμ2+cμ3=0. Let

# TS=aX¯1+bX¯2+cX¯3Sp(a2n1+b2n2+c2n3)1/2

# What distribution do you think TS has under H0?


# Question 13: Consider a one sample Z test of $H_0 : \mu = \mu_0$ versus $H_a :
# \mu > \mu_0$. All else equal, which scenarios will be closer to rejecting the
# null hypothesis?