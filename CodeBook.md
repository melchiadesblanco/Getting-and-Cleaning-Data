---
title: Tidy Data Code Book
author: Melchiades Blanco Junior
date: 19 de agosto de 2015
output: html_document
---

###This is a Code Book for the tidy dataset generated for the course project (Getting and Cleaning Data).

This code book is divided into two main groups:

* Dataset definition
* How the dataset was constructed and cleaned

### Dataset definition
The dataset is composed of mean and standard deviation numeric variables. Those variables was selected due to the requirement of the project.
Besides the variables extracted from the files provided in the course project explanation I have added the last three to make the dataset more descriptive. The first 66 columns are all means and standard deviantion and their name was derived from the initial variable name described in the 'UCI HAR Dataset/features_info.txt'
```{r}
TimeBodyAcc-mean-X
TimeBodyAcc-mean-Y
TimeBodyAcc-mean-Z          
TimeBodyAcc-std-X
TimeBodyAcc-std-Y
TimeBodyAcc-std-Z           
TimeGravityAcc-mean-X
TimeGravityAcc-mean-Y
TimeGravityAcc-mean-Z       
TimeGravityAcc-std-X
TimeGravityAcc-std-Y
TimeGravityAcc-std-Z
TimeBodyAccJerk-mean-X
TimeBodyAccJerk-mean-Y
TimeBodyAccJerk-mean-Z      
TimeBodyAccJerk-std-X
TimeBodyAccJerk-std-Y
TimeBodyAccJerk-std-Z       
TimeBodyGyro-mean-X
TimeBodyGyro-mean-Y
TimeBodyGyro-mean-Z         
TimeBodyGyro-std-X
TimeBodyGyro-std-Y
TimeBodyGyro-std-Z          
TimeBodyGyroJerk-mean-X
TimeBodyGyroJerk-mean-Y
TimeBodyGyroJerk-mean-Z     
TimeBodyGyroJerk-std-X
TimeBodyGyroJerk-std-Y
TimeBodyGyroJerk-std-Z      
TimeBodyAccMag-mean
TimeBodyAccMag-std
TimeGravityAccMag-mean      
TimeGravityAccMag-std
TimeBodyAccJerkMag-mean
TimeBodyAccJerkMag-std      
TimeBodyGyroMag-mean
TimeBodyGyroMag-std
TimeBodyGyroJerkMag-mean    
TimeBodyGyroJerkMag-std
FrequencyBodyAcc-mean-X
FrequencyBodyAcc-mean-Y          
FrequencyBodyAcc-mean-Z
FrequencyBodyAcc-std-X
FrequencyBodyAcc-std-Y           
FrequencyBodyAcc-std-Z
FrequencyBodyAccJerk-mean-X
FrequencyBodyAccJerk-mean-Y      
FrequencyBodyAccJerk-mean-Z
FrequencyBodyAccJerk-std-X
FrequencyBodyAccJerk-std-Y       
FrequencyBodyAccJerk-std-Z
FrequencyBodyGyro-mean-X
FrequencyBodyGyro-mean-Y         
FrequencyBodyGyro-mean-Z
FrequencyBodyGyro-std-X
FrequencyBodyGyro-std-Y          
FrequencyBodyGyro-std-Z
FrequencyBodyAccMag-mean
FrequencyBodyAccMag-std          
FrequencyBodyBodyAccJerkMag-mean
FrequencyBodyBodyAccJerkMag-std
FrequencyBodyBodyGyroMag-mean    
FrequencyBodyBodyGyroMag-std
FrequencyBodyBodyGyroJerkMag-mean
FrequencyBodyBodyGyroJerkMag-std 

SetType         Char
        Is used to keep track of the observation's origins
                Train
                Test
                
ID_Subject      2
        The subject ID is the number of the vounteer used during the experiment. There was a total of 30 volunteers in the experiment so this number goes from 1 to 30.
        
Activity        Char
        This is the description of the activity perfomed by the subject. There are 6 activities being monitored.
                WALKING
                WALKING_UPSTAIRS
                WALKING_DOWNSTAIRS
                SITTING
                STANDING
                LAYING

        
```

### Dataset Construction and Cleansing
All the transformations in the tidydata.R script is due to the following objectives:
* You should create one R script called run_analysis.R that does the following.
The script run_analysis.R do all the objectives above and creates two dataset files: tidydataset.txt and tidydataset_means.txt.
To run the script, you must have installed the packages plyr and dplyr.

* Merges the training and the test sets to create one data set.

For this objective I created two data frames, one for the train file and other for the test file. The resulting dataset had 561 column. After this I appended three columns: ID_Subject, Activity and SetType.
The columns was attached to the data set usind cbind function.

* Extracts only the measurements on the mean and standard deviation for each measurement. 

To check all the columns the has the std() and mean() pattern in the variable name. For this I used the gsub to grep and serach the columns. A total of 69 coluns was then selected.

* Uses descriptive activity names to name the activities in the data set.

I used the function inner_join from the package dplyr to join the prior data frame with the Activity data frame so a new column was added "Activity" (activity name) and I removed the ID_Acitivity

* Appropriately labels the data set with descriptive variable names. 

I changed a the columns name to remove the "()" from the names, also replaced the initial letter from t to Time and f to Frequency to make it more descriptive.

* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For this objective I used the package plyr and de function ddply to group by ID_Subject and Activity and make colMeans of the other columns.
