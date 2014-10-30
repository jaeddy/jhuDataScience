# Question 1: At a party a friend brags that they can tell the difference
# between cheap and expensive wine. You ask him to taste eight glasses wine for
# which you have randomized as 4 expensive and 4 cheap. Calculate a P-vlaue for
# the relevant exact hypothesis test using R's fisher.test function.

#                   Actually Expensive  Actually Cheap
# Guess Expensive	4	                2
# Guess Cheap	    1	                6

wineValue <- matrix(c(4, 1, 2, 6), nrow = 2,
                    dimnames = list(Guess = c("Expensive", "Cheap"),
                                    Actually = c("Expensive", "Cheap")))
fisher.test(wineValue, alternative = "two.sided")


# Question 2: A drug treatment (T = treatment, P = Placebo) has been randomized
# to 5 patients in each arm. Consider testing an increase in side effects (S =
# side effects, N = none). The data are

#       T   P
#   S   3	1
#   N	2	4

# Calculate Fisher's exact P-value for a one sided test of the relevant
# hypothesis.

drugTreatment <- matrix(c(3, 2, 1, 4), nrow = 2,
                    dimnames = list(SideEffects = c("S", "N"),
                                    Treatment = c("T", "P")))
fisher.test(drugTreatment, alternative = "greater")


# Question 3: In a review of the author Jane Austen's work, scholars found the
# following relative frequencies of the words an'',that'' and “this''

# an    that	this
# 0.53	0.35	0.12

# An new story claimed to be Austen's was discovered with the word "an” 140
# times, the word “that” 100 times and the word “this” 50 times. Are these
# counts consistent with Austen's traditional frequencies? Give a chi-squared
# P-value for the relevant test.

x <- c(140, 100, 50)
p <- c(0.53, 0.35, 0.12)
chisq.test(x = x, p = p, correct = FALSE)

n <- sum(x)
E <- p * n
pchisq(sum((x - E)^2 / E), 2, lower.tail = FALSE)


# Question 4: Two drugs, A and B , are being investigated in a randomized trial
# with the data are given below. Investigators would like to know if the Drug A
# and Drug B are equivalent in the terms of the distribution of side effects.

#           None    Nausea  Nauesea and Vomiting    Total
# Drug A	80	    15	    5	                    100
# Drug B	60	    30	    10	                    100

# What are the expected cell counts under the null hypothesis?

drugEffects <- matrix(c(80, 60, 15, 30, 5, 10), nrow = 2,
                      dimnames = list(Drug = c("A", "B"),
                                      Effects = c("None", 
                                                  "Nausea", 
                                                  "Nausea+Vomit")))
colSums(drugEffects)/200


# Question 5: 100 people who took a pain medication for chronic pain were asked
# if they still had pain one hour after receiving the dose. They received the
# dose on two separate weeks. The results are given below with the result of the
# first week's dose on the rows and the second week's on the columns.

#       Yes No
# Yes	43  4
# No	8   45

# Does it appear that the self report impact of the medication is independent
# from one week to the next? (Test using the relevant chi-squared test.)

pain <- matrix(c(43, 8, 4, 45), nrow = 2,
               dimnames = list(Week1 = c("Yes", "No"),
                               Week2 = c("Yes", "No")))
pain
E = matrix(rep(rowSums(pain)) * rep(colSums(pain), each = 2) / sum(pain),
           nrow = 2)
chisq <- sum((pain - E)^2 / E)
pchisq(chisq, 1, lower.tail = FALSE)
chisq.test(pain, correct = FALSE)


# Question 6: A researcher is studying migration patterns. She collected the
# location of the current and previous homes for subjects who moved across
# regions (Northeast, Souteast and West). She recorded the following:

#       NE  SE	W
# NE	-   267	255
# SE	135 _	139
# W	    240	234	-

# Here the row is current home region and the column is the region the person
# moved to.
 
# Here the diagonals are not included since she only studied subjects who moved
# between regions. She would like to know if the probability of moving from
# region a to b is the same as the probability of moving from region b to a for
# all regions a and b.

# What can be said about the expected cell counts?

moves <- matrix

# Question 7: Standard decks of playing cards have 13 cards of each suit
# (diamonds, clubs, hearts, spades) for a total of 52 cards. Someone gives you a
# 52 card deck. You draw a card, record its suit, replace the card, shuffle the
# deck and repeat that process 200 times, obtaining the following table

# Diamonds  Clubs	Hearts	Spades
# 46        54      49	    51

# Does the distribution of suits appear to be standard?

p <- rep(13, 4) / 52
x <- c(46, 54, 49, 51)
chisq.test(x = x, p = p, correct = FALSE)


# Question 8: Consider the table below comparing the self reported job stress
# levels of three occupations. 100 people from each of three occupations were
# surveyed.

# Job           High	Low
# Exec          65	    35
# Prof	        70	    30
# Lion Tamer	15	    85

# Researchers are interested in whether or not the perception of job stress
# differs by occupation. Using the relevant chi-sqared test. What can be said
# about the researcher's hypothesis?

jobStress <- matrix(c(65, 70, 15, 35, 30, 85), nrow = 3,
                    dimnames = list(Job = c("Exec", "Prof", "LionTamer"),
                                    Stress = c("High", "Low")))
jobStress

E = matrix(rep(rowSums(jobStress), ncol(jobStress)) * 
               rep(colSums(jobStress), each = nrow(jobStress)) / 
               sum(jobStress),
           nrow = 3)
df <- (nrow(jobStress) - 1) * (ncol(jobStress) - 1)
chisq <- sum((jobStress - E)^2 / E)
pchisq(chisq, df, lower.tail = FALSE)
