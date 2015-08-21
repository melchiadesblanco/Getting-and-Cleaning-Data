# GettingAndCleaning
##Peer Assessment Getting and Cleaning Data Course Project

This course project get data from many diferent files, clean then and put all together in a way that it can be called tidy data.

## Prerequisites
To run the script you must have installed the packages plyr and dplyr.

###The project contains the following files:
* run_analysis.R
* Code_Book.md
* ReadMe.md
* UCI HAR Dataset (directory containing the files needed to the script)

###The R Script (run_analysis.R.R) does the following:
Setup the data directory
Clean up the files in the UCI HAR Dataset
Label the columns as necessary to make it more descriptive.
Merge test and train datasets into one big dataset appending columns to it.
Create a tidy dataset that includes the average of each Activity and each ID_Subject.

If the execution of the script succeed two dataset separated by comma will be generated: tidydataset.txt and tidydataset_means.txt

###Execution
To execute the script you may either use:

source("run_analisys.R") on the command line of R OR

R CMD BATCH /home/~/run_analisys.R


