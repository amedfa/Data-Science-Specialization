# Getting and Cleaning Data Course Project
# 
# You should create one R script called run_analysis.R that does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# "1. Merges the training and the test sets to create one data set."

library(plyr) 

# Comun Data
features        <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
activityLabel   <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)

# Training Data Sets
subjectTrain    <-read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
xTrain          <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
yTrain          <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)

# Test Data Sets
subjectTest    <-read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
xTest         <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
yTest         <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)


# Train column names  =  Test column names         =      Value
colnames(subjectTrain)  <- colnames(subjectTest)        <- "subject"
colnames(xTrain)        <- colnames(xTest)              <- features[,2]
colnames(yTrain)        <- colnames(yTest)              <- "activity"


#Merging Training Data
trainData <- cbind(yTrain,subjectTrain,xTrain)

#Merging Test Data
testData <- cbind(yTest,subjectTest,xTest)

#Merging Test & Training 
fData <- rbind(trainData,testData)

#Deleting Data
rm("subjectTrain")
rm("xTrain")
rm("yTrain")
rm("subjectTest")
rm("xTest")
rm("yTest")
rm("trainData")
rm("testData")


# 2. Extract only the measurements on the mean and standard deviation for each measurement
mean_std <-fData[,grepl("mean|std|subject|activity",colnames(fData))]

#3. #Uses descriptive activity names to name the activities in the data set

# Assign column names
colnames(activityLabel)<-c("activity","activityType")

mean_std <- merge( activityLabel,mean_std, by = "activity")
mean_std <-mean_std[,-1]


#4. Appropriately labels the data set with descriptive variable names.

# Vector names
shortName <- c("Acc","^t","^f","BodyBody","mean","std","Mag","angle","Gyro")
longName <- c("Acceleration","Time","Frequency","Body","Mean","Std","Magnitude","Angle","Gyroscope")

#Remove parentheses
names(mean_std) <- gsub("\\(|\\)", "", names(mean_std), perl  = TRUE)

names(mean_std) <- make.names(names(mean_std))

#Add descriptive names
for(i in 1:length(shortName))
names(mean_std)<- gsub(shortName[i], longName[i], names(mean_std))


#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data<- ddply(mean_std, c("subject","activityType"), numcolwise(mean))


write.table(tidy_data, file = "./tidy_data.txt")


library(knitr)
knit2html("codebook.Rmd")
