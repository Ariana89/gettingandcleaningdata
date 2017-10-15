# Part 1
setwd(“/Users/marilindacroes/Documents/coursera/gettingAndcleaningData/UCIHARDataset")
Set working directory to features.txt location

col_names <- read.table(“features.txt")
Read features.txt to be used as column names for the train and test datasets.

setwd(“/Users/marilindacroes/Documents/coursera/gettingAndcleaningData/UCIHARDataset/test")
Set working directory to subject.txt location

Read in X_test.txt as a table; this contains most variables
Read in subject_test.txt to append later to X_test.txt as an added column of subject
Read in y_test.txt to append later to X_test.txt as an added column of activity labels
First change the column names of X_test.txt, then add the two columns for subject and labels. Repeat this for the train set.

setwd("/Users/marilindacroes/Documents/coursera/gettingAndcleaningData")

# merge test & trainset
row bind the train and test data frames to form one data frame train_test

# Part 2
# Extracts only the measurements on the mean and standard deviation for each measurement.
a <- extracts all column names with mean in it and stores it in the data frame “a”
b <- extracts all column names with std in it and stores it in the data frame “b”
c <- extracts all column names with labels in it and stores it in the data frame “c”
d <- extracts all column names with subject in it and stores it in the data frame “d”
train_test2 <- column binds data frames a, b, c and d and save in data frame “train_test2”

# Part 3
# Use descriptive activity names to name the activities in the data set “train_test2”
Create a new column “labels_description” which contains the value “walking” when labels equal 1, “walking_upstairs” when labels equals 2, “walking_downstairs" when labels equals 3, “sitting” when labels equals 4, “standing" when labels equals 5, "laying"  when labels equals 6.

# Part 4
# Appropriately label the data set “train_test2” with descriptive variable names.
Remove “-“ from column names
Remove any other non-numeric, non-letter items from column names.
Make all column names lower case.

# Part 5
# From the “train_set2” data set in part 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

First create a vector “column_names” with all the column names from “train_test2” and remove “labels”, “subject” and “labelsdescription” because we are interested in the averages of these columns.

Create empty data frame “tidymean_traintest2” with 180 rows which will later be filled in by a for-loop and become our tidy data set. 180 rows comes from 180 possible averages for each column (6 labels * 30 subjects)
Create empty aggregation data frame to be used in the for loop.
create a dummy variable to help with appending columns in the loop.

Create a loop that checks for every column name in “train_test2” if it appears in the “column_name” vector then create a data frame “aggregation”.
“aggregation” takes the average of the column where are in grouped by labels and subject and returns a data frame with 3 columns “labels”, “subject” and “[name of the column]”.
For the first column bind between “tidymean_trainset2” and “aggregation”, all 3 columns from “aggregation” will be appended to “tidymean_trainset2”, for all other following column binds, only the new column will be appended (thus not appending “labels” and “subject” over and over again.

Add back the activity description variable.

And now we have a tidy data set as per the course assignment.
