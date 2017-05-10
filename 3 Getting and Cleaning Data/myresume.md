## Reading HTML
```sh
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
codeHTML <- readLines(connection)
close(connection)
codeHTML[5]
```
## Reading CSV
```sh
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cameras.csv")
cameraData<- read.csv("./data/cameras.csv")
```
## Reading XML
```sh
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(doc)
```
```sh
library(XML)
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
```

## Reading JSON
```sh
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
```

```sh
names(jsonData$owner)
```
```sh
 [1] "login"               "id"                  "avatar_url"         
 [4] "gravatar_id"         "url"                 "html_url"           
 [7] "followers_url"       "following_url"       "gists_url"          
[10] "starred_url"         "subscriptions_url"   "organizations_url"  
[13] "repos_url"           "events_url"          "received_events_url"
[16] "type"                "site_admin"  
```
```sh
jsonData$owner$login
```
```sh
 [1] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
[10] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
[19] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
[28] "jtleek" "jtleek" "jtleek"
```
```sh
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)
```
```sh
[
 {
    "Sepal.Length": 6.2,
    "Sepal.Width": 3.4,
    "Petal.Length": 5.4,
    "Petal.Width": 2.3,
    "Species": "virginica"
  },
  {
    "Sepal.Length": 5.9,
    "Sepal.Width": 3,
    "Petal.Length": 5.1,
    "Petal.Width": 1.8,
    "Species": "virginica"
  }
]
```
```sh
iris2 <- fromJSON(myjson)
head(iris2)
```
```sh
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
```

## Using datatable
```sh
library(data.table)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),ech=3),z=rnorm(9))
head(DF)
```
```sh
           x y          z
1 -0.1129317 a  0.5020680
2 -0.2022358 b -0.1145041
3 -1.4899435 c -1.0180807
4  1.2923336 a  0.1017729
5 -1.5007446 b  0.2561411
6  0.2093349 c  1.5861166
```
```sh
library(data.table)
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),ech=3),z=rnorm(9))
head(DT,3)
```
```sh
           x y          z
1: 0.9124817 a  0.1206672
2: 0.3769950 b -1.0864503
3: 0.8168680 c -1.0107140
```
```sh
tables()
```
```sh
     NAME NROW NCOL MB COLS  KEY
[1,] DT      9    3  1 x,y,z    
Total: 1MB
```
```sh
DT[2,]
```
```sh
          x y        z
1: 0.376995 b -1.08645
```
```sh
DT[DT$y=="a",]
```
```sh
            x y          z
1:  0.9124817 a  0.1206672
2: -0.5213147 a -1.1043890
3: -2.0558934 a -0.3709098
```
Subsetting rows
```sh
DT[c(2,3)]
```
```sh
          x y         z
1: 0.376995 b -1.086450
2: 0.816868 c -1.010714
```

```sh
DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(DT,x)
DT['a']
```
```sh
     x           y
  1: a -0.55099223
  2: a  2.10044317
  3: a  0.90254971
  4: a  0.90159789
  5: a  0.52632994
  6: a  0.29217634
  ```
  
  ## Reading MySQL
  
  ```sh
  install.packages("RMySQL")
  require(RMySQL)
  ucscDb <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
  result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb) 
  ```
  ```sh
    hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host= "genome-mysql.cse.ucsc.edu")
  allTables <- dbListTables(hg19)
  length(allTables)  
  [1] 11040
  ```
   ```sh
  allTables[1:5]
  [1] "HInv"         "HInvGeneMrna" "acembly"      "acemblyClass" "acemblyPep"    
  ```
```sh
dbListFields(hg19,"affyU133Plus2")
 [1] "bin"         "matches"     "misMatches"  "repMatches"  "nCount"      "qNumInsert" 
 [7] "qBaseInsert" "tNumInsert"  "tBaseInsert" "strand"      "qName"       "qSize"      
[13] "qStart"      "qEnd"        "tName"       "tSize"       "tStart"      "tEnd"       
[19] "blockCount"  "blockSizes"  "qStarts"     "tStarts" 
```
  ```sh
  dbGetQuery(hg19, "select count(*) from affyU133Plus2")
  count(*)
  1    58463
```
  Read from the table
  ```sh
  affyData <- dbReadTable(hg19, "affyU133Plus2")
  head(affyData)
    bin matches misMatches repMatches nCount qNumInsert qBaseInsert tNumInsert tBaseInsert
1 585     530          4          0     23          3          41          3         898
2 585    3355         17          0    109          9          67          9       11621
3 585    4156         14          0     83         16          18          2          93
  ```
  
  ```sh
  #Select a specific subset
query <- db SendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)
  0%  25%  50%  75% 100% 
   1    1    2    2    3 
```

```sh
affyMisSmall <- fetch(query, n=10); dbClearResult(query);
[1] TRUE
```
```sh
> dim(affyMisSmall)
[1] 10 22
```
Close the connection!
```sh
dbDisconnect(hg19)
[1] TRUE
```
```#R HDF5 package
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created
[1] TRUE
```

  ## Week 1 Quiz
  ```
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv?accessType=DOWNLOAD"
  download.file(fileUrl,destfile = "./data/quiz.csv")
  head(quiz)
  quizData <- read.csv("./data/quiz.csv")
  # VAL "Property value"
  length(quizData$VAL[!is.na(quizData$VAL) & quizData$VAL == 24 ])
  [1] 53
 ```
 
 ```
 if(!file.exists("data")){
    dir.create("data")
    
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cloudfront.xlsx", mode= "wb")
dat <- read.xlsx("./data/cloudfront.xlsx", 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

[1] 36534720
```

```sh
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
answer <- length(xpathApply(doc, "//zipcode[text()='21231']", xmlValue))
answer
[1] 127
```

```sh
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,destfile = "./data/quiz1_5.csv")
DT <- fread(input="./data/quiz1_5.csv", sep=",")


system.time(DT[,mean(pwgtp15),by=SEX])
```

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

## Week 3 Quiz

### Question 1

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

which(agricultureLogical)

What are the first 3 values that result?
```sh
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/communities.csv")
communitiesData<- read.csv("./data/communities.csv")
agricultureLogical <- communitiesData$ACR == 3  & communitiesData$AGS == 6 
which(agricultureLogical)[1:3]
[1] 125 238 262
```


### Question 2

Using the jpeg package read in the following picture of your instructor into R

https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

library("jpeg")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl,destfile = "./data/picture.jpg", mode = "wb")
img <- readJPEG("./data/picture.jpg", native = TRUE)
quantile(img, probs = c(0.3, 0.8))

      30%       80% 
-15259150 -10575416 


### Question 3

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats

```sh
ileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv?accessType=DOWNLOAD"
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/FGDP.csv")
download.file(fileUrl1,destfile = "./data/FEDSTATS_Country.csv")
FEDSTATS_Country_Data <- read.csv("./data/FEDSTATS_Country.csv")
FGDP_Data <- read.csv("./data/FGDP.csv" , skip = 4, nrows = 190)
FGDP_Data <- select(FGDP_Data,X,X.4,X.1)
colnames(FGDP_Data)<-  c("Country.Code", "GDP", "rankingGDP")

F_Data <- merge(FGDP_Data, FEDSTATS_Country_Data, by.x="Country.Code", by.y="CountryCode")
F_Data <- arrange(F_Data,desc(rankingGDP))

nrow( F_Data )
[1] 189

F_Data[13,]$Long.Name
[1] St. Kitts and Nevis
```

### Question 4

What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

```sh
summarize(group_by(F_Data, Income.Group),mean(rankingGDP))
# A tibble: 5 × 2
          Income.Group `mean(rankingGDP)`
                <fctr>              <dbl>
1 High income: nonOECD           91.91304
2    High income: OECD           32.96667
```


