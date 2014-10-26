run_analysis <- function() {
  
  # 1. Merge the training and the test sets to create one data set.
  
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./dataset.zip")
  unzip("./dataset.zip", exdir = "./unzippedDataset")
  ## download and unzip dataset in working directory
  
  x_test <-read.table("./unzippedDataset/UCI HAR Dataset/test/X_test.txt")
  ## dim (x_test) = 2947 x 561
  y_test <-read.table("./unzippedDataset/UCI HAR Dataset/test/y_test.txt")
  ## dim (y_test) = 2947 x 1
  subject_test <-read.table("./unzippedDataset/UCI HAR Dataset/test/subject_test.txt")
  ## dim (subject_test) = 2947 x 1
  test_df <- cbind(subject_test, y_test, x_test)
  ## dim (test_df) = 2947 x 563
  
  x_train <- read.table("./unzippedDataset/UCI HAR Dataset/train/X_train.txt")
  ## dim (x_train) = 7352 x 561
  y_train <- read.table("./unzippedDataset/UCI HAR Dataset/train/y_train.txt")
  ## dim (y_train) = 7352 x 1
  subject_train <-read.table("./unzippedDataset/UCI HAR Dataset/train/subject_train.txt")
  ## dim (subject_train) = 7352 x 1
  train_df <- cbind(subject_train, y_train, x_train)
  ## dim (train_df) = 7352 x 563
  
  unified_df <- rbind(train_df, test_df)
  ## dim (unified_df) = 10299 x 563
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  features <- read.table("./unzippedDataset/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
  ## dim (features) = 561 x 2
  subset_df <- unified_df[,c(TRUE,TRUE,grepl("mean\\(\\)|std\\(\\)", features$V2))]
  ## dim (subset_df) = 10299 x 68
  
  # 3. Uses descriptive activity names to name the activities in the data set
  
  activity_labels <- read.table("./unzippedDataset/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
  ## dim (activity_labels) = 6 x 2
  
  subset_df$activityName <- factor(subset_df[,2], levels = as.character(activity_labels[,1]), 
                                   labels = as.character(activity_labels[,2]))
  ## dim (subset_df) = 10299 x 69
  subset_df <- subset_df[c(1,2,69,3:68)]
  ## reorder the columns to place activityName next to ActivityID
  
  # 4. Appropriately labels the data set with descriptive variable names. 
  
  subset_features <- features[grepl("mean\\(\\)|std\\(\\)", features$V2),2]
  ## dim (subset_features) = 1 x 66
  subset_colnames <- c("subjectID", "activityID", "activityName", subset_features)
  ## dim (subset_colnames) = 1 x 69
  colnames(subset_df) <- subset_colnames
  
  # 5. From the data set in step 4, creates a second, independent tidy data set 
  #    with the average of each variable for each activity and each subject.
  
  install.packages("plyr")
  library(plyr)
  install.packages("dplyr")
  library(dplyr)
  install.packages("data.table")
  library(data.table)
  ## installs and loads "plyr", "dplyr", and "data.table"
  
  subset_table <- tbl_dt(subset_df)
  ## convert data frame to table for ease of manipulation
  subset_table <- subset_table[,activityID:=NULL]
  ## dim (subset_table) = 10299 x 68
  
  grouped_subset_table <- group_by(subset_table, subjectID, activityName)
  tidy_table <- summarise_each(grouped_subset_table, funs(mean))
  ## dim (subset_table) = 180 x 68
  
  subset_features_avg <- paste(subset_features, "_AVG", sep="")
  colnames(tidy_table) <- c("subjectID","activityName", subset_features_avg)
  ## make the column names of tidy_table more meaningful, by adding "_AVG" at the end of each column
  
  write.table(tidy_table, file = "./tidy_data.txt", row.names = FALSE)
  
}
