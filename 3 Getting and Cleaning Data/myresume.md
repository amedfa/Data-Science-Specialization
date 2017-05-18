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