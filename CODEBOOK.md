Step 1

To understand how the original data fits together, kindly look at this visual representation by David Hood, Community TA:
https://coursera-forum-screenshots.s3.amazonaws.com/ab/a2776024af11e4a69d5576f8bc8459/Slide2.png

The entire code in Step 1 just binds the various pieces together according to this figure. All test data belong in the test dataframe (test_df), with 563 columns and 2947 rows. 
All training data belong in the train dataframe (train_df), with 563 columns and 7352 rows.

Once we put these two dataframes together using rowbind, we get a unified dataframe (unified_df), with 563 columns and 10299 rows. 
Note that the first two columns indicate the subject (subjectID) and the type of activity (activityID), while the remaining 561 columns contain measurements of various variables. 
Note that none of the columns here have headers / descriptive names.

Step 2

Now we subset only those variables which include a mean() or std() in their name, which gives us a subsetted dataframe (subset_df), with 10299 rows but only 68 columns. 
The 68 columns include two that indicate the subject (subjectID) and type of activity (activityID).
In this step I assume the names of features are provided to us in the same order as that of the columns in x_train and x_test.

Step 3

Here I create a new variable to further describe the type of activity, rather than just provide a number between 1 and 6. 
This variable is called "activityName", and it is a factor variable with six columns, based on the information provided in the "activity_labels.txt" file downloaded with the dataset. 
By adding this to our subsetted dataframe, it now has dimensions of 10299 rows and 69 columns.

Step 4

I finally integrate the names of the columns with the data frame, by setting the column names of the subsetted dataframe equal to a subsetted version of the features vector. 

Step 5

First of all, I delete the "activityID" column because it contains no information that is not already contained in the "activityNames" columns. I prefer "activityNames" because tidy data should contain variables with descriptive categories. 
Now the subsetted dataframe has 10299 rows and 68 columns.

Next, I convert the entire subsetted dataframe into a table, for ease of summarizing. I then group by both "subjectID" and "activityName", which will allow me to average every column by these two groups using the "summarise_each()" function. 
This gives me the tidy data table (tidy_table), with 180 rows and 68 columns. 

Finally, I suffix all variables - except "subjectID" and "activityName" - with the string "_AVG", to indicate that the tidy data columns represent averages, not absolute values.

Thank you!
