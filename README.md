GettingDataProject
==================

Project for Getting and Cleaning Data Course (Coursera)
=======================================================

My code cleans up and summarizes data collected from the accelerometers from the Samsung Galaxy S smartphone. 
Here is the data for this project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

Here is the site where the data was obtained from, along with further details about the data: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The project requirements are as follows: 
1. Merge the training and the test sets to create one data set. 
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set 
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

The code is commented accordingly, and broken up into pieces which perform each of these requirements. 
I have included code to download and unzip the data files, which is performed before step #1.

In addition to the base R directory, the code requires the following packages / libraries: 
1. plyr 
2. dplyr 
3. data.table

While we mostly deal with data frames and character vectors, it is convenient to use data tables in the last step.
