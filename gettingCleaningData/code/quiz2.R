
# Code for Quiz 2

# Question 1: Register an application with the Github API here 
# https://github.com/settings/applications. Access the API to get information 
# on your instructors repositories (hint: this is the url you want 
# "https://api.github.com/users/jtleek/repos"). Use this data to find the time 
# that the datasharing repo was created. What time was it created? This tutorial 
# may be useful 
# (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.

library(httr)

# set up authorization for using GitHub API
oauth_endpoint("github")
myapp <- oauth_app(appname = "github", key = "918eb9282281d8ca6d58",
                   secret = "28794193d38a0a3ba13ae78e5b32fe5012f2118a")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# get the url of interest
url <- "https://api.github.com/users/jtleek/repos"
req <- GET(url, config(token = github_token))
stop_for_status(req)
jtleekRepo <- content(req)

# convert the JSON object
jtleekRepo2 <- jsonlite::fromJSON(jsonlite::toJSON(jtleekRepo))

colnames(jtleekRepo2)
head(jtleekRepo2$created_at)

# find the time that the 'datasharing' repo was created
datasharingTime <- jtleekRepo2[jtleekRepo2$name == "datasharing", "created_at"]


# Question 2: The sqldf package allows for execution of SQL commands on R data 
# frames. We will use the sqldf package to practice the queries we might send 
# with the dbSendQuery command in RMySQL. Download the American Community Survey 
# data and load it into an R object called 'acs'
library(sqldf)
fileAddress <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
# this file was already downloaded for quiz 1 and saved as "data/acsIdahoData.csv"

acs <- read.csv("data/acsIdahoData.csv")

# Which of the following commands will select only the data for the probability 
# weights pwgtp1 with ages less than 50?
pwgtp1AGElt50 <- sqldf("select pwgtp1 from acs where AGEP < 50")


## Question 3: Using the same data frame you created in the previous problem, 
# what is the equivalent function to unique(acs$AGEP)
uniqueAges <- unique(acs$AGEP)
uniqueAgesSQL <- sqldf("select distinct AGEP from acs")


# Question 4: How many characters are in the 10th, 20th, 30th and 100th lines 
# of HTML from this page: 
url <- "http://biostat.jhsph.edu/~jleek/contact.html" 

# (Hint: the nchar() function in R may be helpful)
library(httr)
library(XML)

html <- GET(url)
htmlContent <- content(html, as = "text")
parsedHtml <- htmlParse(htmlContent, asText = TRUE)
str(parsedHtml)

con <- url(url)
htmlCode <- readLines(con)
close(con)

nchar(htmlCode[c(10, 20, 30, 100)])


# Question 5: Read this data set into R and report the sum of the numbers in the
# fourth column. 

fileAddress <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for" 

# Original source of the data: 
# http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 

# (Hint this is a fixed width file format)

download.file(fileAddress, "data/sstData.for", method = "curl")

# read the first couple lines to check widths
con <- file("data/sstData.for")
sstLine <- readLines(con, 5)
close(con)

# lots of screwy code to set widths...
testLine <- sstLine[5]
match <- unlist(gregexpr(pattern = "(03|2|-0|[[:space:]]+)", text = testLine, 
                perl = TRUE))
widths <- vector(mode = "numeric", length = length(match))
for(i in 1:length(match)-1){
    widths[i] <- match[i] - match[i + 1]
}
widths[abs(widths) == 4] <- 4
widths[abs(widths) == 9] <- 9
widths[abs(widths) == 0] <- 4

sstDat <- read.fwf("data/sstData.for", widths = widths, skip = 4)

# get the sum (finally) of column 4
sum(sstDat[, 4])
