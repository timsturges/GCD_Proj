# Getting And Cleanning Data Course Project
============================================
This course project is an exercise in cleaning and processing raw data into a tidy data set, and performing some calculations in order to produce a new tidy data set.

In this repository, one will find:  
  1. This Readme **README.md/html**  
  2. A single R script **run_analysis.R** for processing the raw data as indicated by the project requirements. This script will also output a new tidy data set to a text file **CLEAN DATA.txt**.  
  3. A code book **code book.md/html** which provides a description of the objects created/used in **run_analysis.R**  
  4. A text file output of the tidy data set **CLEAN DATA.txt**  

#### note that the project requirements may not be accomplished in the exact order given, but are labeled with comments in the script  

## 0. Pre-processing

The script invokes the *reshape2* library to accomplish certain calculations and manipulations of the data frames. The script then checks for the existence of a "data" subdirectory in the working directory, and creates it if it does not exist. Then it downloads the necessary data from the Internet and unzips it.  

## 1. Merge the training and test sets to create one data set.

Using the read.table() function, I imported the subject identifiers from "subject_test.txt" and "subject_train.txt", the activity identifiers from "y_test.txt" and "y_train.txt", and the raw data from "X_test.txt" and "X_train.txt", each into their own data frames(**sbj, y, and x**, respectively). It is apparent upon examination that the 3 files each pertaining to test data and train data have the same number of observations (that is, the 3 "test" files have the same number of observations (2947) as each other, and the 3 "train" files have the same number of observations (7352) as each other, so using rbind(), three new data frames are created, each with the original total of 10299 observations. As the subject and activity identifiers are both single columns of data, a new data frame **df_raw** is created using cbind() to attach, in order, the subject identifiers of the combined train and test data, the activity identifiers of the combined train and test data, and the raw measurements of the train and test data.  Thus the various data sets are united into one frame, columns 1 and 2 are converted from integer types to factors, and is ready for further processing.

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Referring to **features.txt** it is clear that there are 66 variables which fit this description: 33 for mean, and 33 for standard deviation. **features.txt** provides indices for where this data appears in the raw measurements, so the column index numbers of these desired variables are stored in **xcolindx**, which is later used to create **df_raw**, as part of completing objective 1.    

## 3. Use Descriptive Activity Names

Activity names are extracted from **act_lab** and substituted for activity index numbers in **y** using *gsub*  

## 4. Appropriately labels the data set with descriptive variable names.  

Before part 1 is completed, descriptive variable names are extracted from **feat** and written to column names of **x** Rows 1 and 2 are manually named "SUBJECT" and "ACTIVITY".  

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

**df_clean** is created by using *melt* on **df_raw** by SUBJECT and ACTIVITY. It is then recast using *dcast* to calculate the mean of each variable for each ACTIVITY and SUBJECT combination. Column names are updated as part of objective 4 to indicate that these new columns are the mean values of the variables from **df_raw**. Finally, **df_clean** is outputted to a file **CLEAN DATA.txt**