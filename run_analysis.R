## 1. Create a new working derictory and download and unzip "UCI HAR Dataset" file:
getwd()
if(!file.exists("./data4"))(dir.create("./data4"))
setwd("./data4")

fileurl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile= "./zippeddatafile.zip")
list.files()
unzip(zipfile= "./zippeddatafile.zip")

## 2. Merging the training and  test datasets:

### 2.1. Reading files data

#### Reading training data:
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#### Reading testing data:
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#### Reading features vector:
features <- read.table('./UCI HAR Dataset/features.txt')

#### Reading activity labels:
activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')

### 2.2. Assigning column names:

colnames(x_train)<-features[,2]
colnames(y_train)<-"activityID"
colnames(subject_train)<- "subjectID"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activityLabels)<- c('activityID','activityType')

### 2.3. Merging data in one dataset: 
train_merged<- cbind(y_train, subject_train, x_train)
test_merged<- cbind(y_test, subject_test, x_test)
merged2one<-rbind(train_merged, test_merged)  

## 3. Extracting only the measurements on the mean and standard deviation for each measurement

### 3.1 Reading column names:
colNames<- colnames(merged2one)

### 3.2 Create vector for defining ID, mean and standard deviation:
mean_and_std <- (grepl("activityID" , colNames) | 
                 grepl("subjectID" , colNames) | 
                 grepl("mean.." , colNames) | 
                 grepl("std.." , colNames) 
)

### 3.3 Making nessesary subset from setAllInOne:

setForMeanAndStd <- merged2one[, mean_and_std == TRUE]

## 4. Using descriptive activity names to name the activities in the data set:

setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                                      by="activityID",
                                      all.x=TRUE)

## 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:

### 5.1 Making second tidy data set

secTidySet <- aggregate(. ~subjectID + activityID, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectID, secTidySet$activityID),]

### 5.2 Writing second tidy data set in txt file

write.table(secTidySet, "secTidySet.txt", row.name=FALSE)