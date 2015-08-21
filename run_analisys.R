        
        library(dplyr)
        library(plyr)

        ## 1- Merges the training and the test sets to create one data set.
        ## Read the data
        DF_train_Data <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses = "numeric", header = F)
        V_train_Label <- scan("./UCI HAR Dataset/train/Y_train.txt")
        V_subjectTrain_Label <- scan("./UCI HAR Dataset/train/subject_train.txt")
        
        DF_test_Data <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses = "numeric", header = F)
        V_test_Label <- scan("./UCI HAR Dataset/test/Y_test.txt")
        V_subjectTest_Label <- scan("./UCI HAR Dataset/test/subject_test.txt")
        
        DF_Activity_Labels <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = c("numeric", "character"), header = F, col.names = c("Y", "Activity"))
        colnames(DF_Activity_Labels) <- c("ID_Activity", "Activity")
        
        ##Features file is going to name each column except the Y and Subject columns
        DF_Features <-  read.table("./UCI HAR Dataset/features.txt", colClasses = c("numeric", "character"), header = F, col.names = c("Y", "Activity"))
        
        ##Appending columns to identify if it's a  test or training set
        DF_train_Data$SetType <- rep('Train', nrow(DF_train_Data))
        DF_test_Data$SetType <- rep('Test', nrow(DF_test_Data))
       
        ##Appending the Y_train and Y_test file as a column ID_Activity
        DF_train_Data$ID_Activity <- V_train_Label
        DF_test_Data$ID_Activity <- V_test_Label
        
        ##Appending the subject file as a column ID_Volunteer
        DF_train_Data$ID_Subject <- V_subjectTrain_Label
        DF_test_Data$ID_Subject <- V_subjectTest_Label
        
        columnsName <- append(append(append(DF_Features$Activity, "SetType"), "ID_Activity"), "ID_Subject")
        
        ## 4- Appropriately labels the data set with descriptive variable names. 
        
        colnames(DF_train_Data) <- columnsName
        colnames(DF_test_Data) <- columnsName
 
        DF_All <- rbind(DF_train_Data, DF_test_Data)
        
        ## 3- Uses descriptive activity names to name the activities in the data set
        #Appending a descriptive column to name the activities
        DF_All <- inner_join(DF_All, DF_Activity_Labels, by = "ID_Activity")
        
        ## 2- Extracts only the measurements on the mean and standard deviation for each measurement. 
       
        #Get the position of the columns that has mean(), std() or the new columns I've added
        tmean <- grep("mean\\(\\)", colnames(DF_All)) 
        tstd <- grep("std\\(\\)", colnames(DF_All))
        tn1 <- grep("Activity", colnames(DF_All))
        tn2 <- grep("ID_Subject", colnames(DF_All))
        tn3 <- grep("SetType", colnames(DF_All))
        x <- c(tmean, tstd, tn1[2], tn2, tn3)
        x <- sort(x)
      
        ## 4- Appropriately labels the data set with descriptive variable names. 
        # just to remove () from column names
        colnames(DF_All) <- gsub("\\(\\)", "", colnames(DF_All))
        #Using the descriptive Time and Frenquence
        colnames(DF_All) <- gsub("^t", "Time", colnames(DF_All))
        colnames(DF_All) <- gsub("^f", "Frequency", colnames(DF_All))
        
        # This is the tidy data.frame, result of all above code
        DF_All <- DF_All[,x]
        write.table(DF_All, file = "./tidydataset.txt", sep = ",", row.name=FALSE)
        
        ##Cleaning the workspace
        rm(DF_test_Data, DF_train_Data, DF_Features, DF_Activity_Labels)
        rm(columnsName, V_subjectTest_Label, V_subjectTrain_Label, V_test_Label, V_train_Label)
        rm(tmean, tstd, tn1, tn2, tn3, x)
        
        
        ## 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        # For this objective I choose to use the package plyr
        DF_Means <- ddply(DF_All, .(ID_Subject, Activity), function(arg) colMeans(arg[, 1:66]))
        # Create a new text file with the result dataset
        write.table(DF_Means, file = "./tidydataset_means.txt", sep = ",", row.name=FALSE)
