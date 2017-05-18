## Week 2 Quiz

### Question 1
Register an application with the Github API here:

- https://github.com/settings/applications.

Access the API to get information on your instructors repositories, hint: this is the url you want:

- https://api.github.com/users/jtleek/repos

Use this data to find the time that the datasharing repo was created. What time was it created?

This tutorial may be useful:

- https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

You may also need to run the code in the base R package and not R studio.
```sh
# Find OAuth settings for github:
# http://developer.github.com/v3/oauth/
github <- oauth_endpoints("github")

# Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "319cffb9580b74b3e3fc",
                   secret = "147be6cc25e9a526f22dc19df75a2c1d47340ea5")

# Get OAuth credentials
github_token <- oauth2.0_token(github, myapp)

# Use the API
gtoken <- config(token = github_token)
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
repo_list <- content(req)

answer <- c() 
for (i in 1:length(repo_list)) {
  repo <- repo_list[[i]]
  if (repo$name == "datasharing") {
    answer = repo
    break
  }
}
msg("The repository 'datasharing' was created at", answer1$created_at)
# The repository 'datasharing' was created at 2013-11-07T13:25:07Z
```
### Question 2

The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R object called
```sh
acs
```
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

Which of the following commands will select only the data for the probability weights that are formatted like pwgtp1, pwgtp2, pwgtp3, etc. for the people with ages less than 50?

```sh
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/Survey.csv")
acs<- read.csv("./data/Survey.csv")
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50")
query2 <- sqldf("select pwgtp1 from acs")  ## NO
query3 <- sqldf("select * from acs where AGEP < 50 and pwgtp1")  ## NO
query4 <- sqldf("select * from acs where AGEP < 50")  ## NO
```
### Question 3
Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
```sh
patron <- unique(acs$AGEP)
query1 <- sqldf("select distinct AGEP from acs")
     AGEP
 [1,] TRUE
 [2,] TRUE
 [3,] TRUE
query2 <- sqldf("select AGEP where unique from acs")
 [3,]  FALSE
 [4,]  FALSE
 [5,]  FALSE
query3 <- sqldf("select unique * from acs")
        RT SERIALNO SPORDER  PUMA    ST ADJUST PWGTP  AGEP   CIT   COW  DDRS  DEYE
    [1,] FALSE    FALSE   FALSE FALSE FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    [2,] FALSE    FALSE   FALSE FALSE FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    [3,] FALSE    FALSE   FALSE FALSE FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    
query4 <- sqldf("select unique AGEP from acs")
        RT SERIALNO SPORDER  PUMA    ST ADJUST PWGTP  AGEP   CIT   COW  DDRS  DEYE
    [1,] FALSE    FALSE   FALSE FALSE FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    [2,] FALSE    FALSE   FALSE FALSE FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    [3,] FALSE    FALSE   FALSE FALSE FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
```

### Question 4

How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

http://biostat.jhsph.edu/~jleek/contact.html

(Hint: the nchar() function in R may be helpful)
```sh
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
codeHTML <- readLines(connection)
close(connection)
c(nchar(codeHTML[10]), nchar(codeHTML[20]), nchar(codeHTML[30]), nchar(codeHTML[100]))
[1] 45 31  7 25
```

### Question 5

Read this data set into R and report the sum of the numbers in the fourth of the nine columns.

https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

(Hint this is a fixed width file format)
```sh
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
codeHTML <- readLines(connection)
close(connection)
c(nchar(codeHTML[10]), nchar(codeHTML[20]), nchar(codeHTML[30]), nchar(codeHTML[100]))
[1] 45 31  7 25
```