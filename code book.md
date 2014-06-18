# CODE BOOK for Getting And Cleaning Data Course Project
========================================================
This is a code book which identifies all the various objects uses in the **run_analysis.R** script for this project.  

fileUrl = URL of data used by this script  
sbj_train = contents of "./UCI HAR Dataset/train/subject_train.txt" - SUBJECT ID INDEX #s of train data set  
sbj_test = contentds of "./UCI HAR Dataset/test/subject_test.txt" - SUBJECT ID INDEX #s of test data set  
sbj = merged data by rbind of sbj_train and sbj_test  
y_train = contents of "./UCI HAR Dataset/train/y_train.txt" - ACTIVITY ID INDEX #s of train data set    
y_test = contents of "./UCI HAR Dataset/test/y_test.txt" - ACTIVITY ID INDEX #s of test data set    
y = merged data by rbind of y_train and y_test  
x_train = contents of "./UCI HAR Dataset/train/X_train.txt"- raw data readings of train data set  
x_test = contents of "./UCI HAR Dataset/test/X_test.txt" - raw data readings of test data set  
x = merged data by rbind of x_train and x_test  
act_lab = contents of "./UCI HAR Dataset/activity_labels.txt" - Activity label names  
feat = contents of "./UCI HAR Dataset/features_info.txt" - measurement variable names **SEE BELOW**  
df_raw = data frame created by cbind of sbj, y, and x  
df_clean = data frame created by extracting only the desired measurements from df_raw; labeled and processed for readability  
SUBJECT = column of subject ID #s pulled from sbj_train, sbj_test in df_clean, df_raw, *CLEAN DATA.txt*  
ACTIVITY = column name of activity names extracted from act_lab in df_clean, df_raw, *CLEAN DATA.txt*  
xcolindx = character vector used for reading / writing column names for variables used  
CLEAN DATA.txt = result of writting df_clean to file  

## A note regarding variable names for df_clean, df_raw, and *CLEAN DATA.txt*
df_raw, df_clean, and "CLEAN DATA.txt" uses variable names programatically extracted from the study data.  

A full list and desciprtion of these variables has been created by the study authors in the ./UCI HAR Dataset/train/README.txt file, which is not to be confused with the README.md/html files which are part of this project / repo.  

I cannot say that I was able to totally comprehend the variable desciptions, and as such it would be at best redundant, and at worst an exercise in incompetence to attempt to describe these variables any differently that the study's authors already have. Thus, any and all available information regarding these variable desciptions can be found in the study's documentation (./UCI HAR Dataset/). That said, as the project requires calculation of the mean of some of these variables, "Mean Of " has been affixed to the head of the variable names in df_clean and *CLEAN DATA.txt* to indicate that that variable's mean was calculated on the basis of each SUBJECT and ACTIVITY.