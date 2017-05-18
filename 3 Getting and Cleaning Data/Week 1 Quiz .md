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
