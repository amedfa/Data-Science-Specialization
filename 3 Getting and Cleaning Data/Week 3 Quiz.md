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
