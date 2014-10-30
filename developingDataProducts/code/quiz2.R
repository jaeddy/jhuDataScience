
# Question 1: In the slidify YAML text. Changing the framework from io2012 to 
# shower does what?

# > It changes nothing.
# > It changes the html5 framework thus changing the style of the slides. <<<
# > It changes whether the document is self contained or requires being 
# connected to the internet.
# > It changes the ability to display mathjax javascript rendering.


# Question 2: You wrote R code in a slidify document as follows
```{r}
fit <- lm(y ~ x1 + x2 + x3)
summary(fit)
```

# If you want to hide the results of the summary statement (yet still have it 
# run) what should you do?

# > Comment out the command # summary(fit)
# > Add a results = 'hide' option in the {r} call of the code chunk  <<<
# > Comment the command as below but also use a bang symbol after the comment, 
# as in #! summary(fit)
# > Add a echo = FALSE option in the {r} call of the code chunk


# Question 3: You wrote R code in a slidify document as follows
```{r}
fit <- lm(y ~ x1 + x2 + x3)
summary(fit)
```

# If you want to display the results, but not the actual code, what should you 
# do?

# > Comment the command, but use a bang symbol after the comment, as in #! 
# summary(fit)
# > Add a echo = FALSE option in the {r} call of the code chunk  <<<
# > Add a echo = TRUE option in the {r} call of the code chunk
# > Comment out the command # summary(fit)


# Question 4: R studio presentation tool does what?

# > Creates HTML5 slides using a generalized markdown format having an extention
# Rpres and creates reproducible presentations by embedding and running the R 
# code from within the presentation document. <<<
# > Creates presentable R code from within presentations. However, it does not
# actually run the code.
# > Creates a presentation that can only be run from within Rstudio.
# > Creates a power point presentation from a generalized markdown format having
# an extension Rpres.


# Question 5: In Rstudio presenter, if you do not want the code to be evaluated,
# what option do you need to add to the {r} options?

# results = 'hide'
# eval = FALSE <<<
# echo = FALSE
# run = FALSE


# Question 6: When presenting data analysis to a broad audience, which of the following should be done?

# > Present results in the chronological order in which it was performed.
# > Explain why each step was necessary.
# > Show every analysis and method that was done.
# > Do not include figure captions.