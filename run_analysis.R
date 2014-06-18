#  Pre-processing: invoke necessary library for data manipulation
library(reshape2)
#  create data directory / fetch data / load into memory
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/getdata_projectfiles_UCI HAR Dataset.zip",method="curl")
unzip("./data/getdata_projectfiles_UCI HAR Dataset.zip")
#  Declare vectors for immediate use
sbj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
sbj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
act_lab <- read.table("./UCI HAR Dataset/activity_labels.txt")
feat <- read.table("./UCI HAR Dataset/features.txt")

#1 Merge training and test sets into one dataset
#  join the test and train data
sbj <- rbind(sbj_train,sbj_test)
y <- rbind(y_train,y_test)
x <- rbind(x_train,x_test)

#3 Use descriptive activity names to name the activities in the dataset
#  before merging, programmatically change activity labels from numbers to chars
for (i in 1:nrow(act_lab)) {y[,1] <- gsub(act_lab[i,1],act_lab[i,2],y[,1])}
#4 before merging, programmatically write variable names to x col names
colnames(x) <- feat[,2]

#2 Extract only the measurements needed for this assignment
xcolindx <- sort(c(grep("mean\\(\\)",colnames(x)),
                   grep("std\\(\\)",colnames(x))))
#1 
#  merge the subject identifier, activity identifier, and raw data
df_raw <- cbind(sbj,y,x[,xcolindx])
df_raw[,1] <- as.factor(df_raw[,1])
df_raw[,2] <- as.factor(df_raw[,2])

#4 Appropriately label the data set with descriptive variable names
colnames(df_raw)[1:2] <- c("SUBJECT","ACTIVITY")
colnames(df_raw) <- sub("BodyBody","Body",colnames(df_raw))

#5 Create a second, tidy data set w/ average of each var for SUBJECT / ACTIVITY 
#  melt / cast data / calculate mean
df_clean <- melt(df_raw,id.vars=c("SUBJECT","ACTIVITY"))
df_clean <- dcast(df_clean,SUBJECT + ACTIVITY ~ variable,mean)
#4
colnames(df_clean)[3:68] <- paste("Mean Of",colnames(df_clean)[3:68])

#Write to txt files
write.table(df_clean,file="CLEAN DATA.txt")