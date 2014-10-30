### Practical Machine Learning Course Project

This repository contains all code and data needed to reproduce the analysis and
results at: 
[http://jaeddy.github.io/pmlProject/](http://jaeddy.github.io/pmlProject/)

The analysis can be run by compiling the file `project_report.Rmd` using the
`knitr` package, while in the top-level repository directory.

Results from the analysis were saved and subsequently submitted using the
following code (where `pml_write_files` is takes the function provided on the
course website and adds an input option for specifying target directory):

```
# Create new directory to store results
if (!file.exists("results/")) {
    dir.create("results/")
}

source("R/output_predictions.R")
pml_write_files(testPred, "results/")
```
