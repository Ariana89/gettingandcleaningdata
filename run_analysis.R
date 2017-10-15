
# Part 1
# Import data & adding labels
setwd("/Users/marilindacroes/Documents/coursera/gettingAndcleaningData/UCIHARDataset")
col_names <- read.table("features.txt")
col_names <- as.character(col_names[,2])
col_names
setwd("/Users/marilindacroes/Documents/coursera/gettingAndcleaningData/UCIHARDataset/test")
test <- read.table("X_test.txt")
subject_test <- read.table("subject_test.txt")
labels_test <- read.table("y_test.txt")
colnames(test) <- col_names
test$labels <- labels_test$V1
test$subject <- subject_test$V1
setwd("/Users/marilindacroes/Documents/coursera/gettingAndcleaningData/UCIHARDataset/train")
train <- read.table("X_train.txt")
subject_train <- read.table("subject_train.txt")
labels_train <- read.table("y_train.txt")
colnames(train) <- col_names
train$labels <- labels_train$V1
train$subject <- subject_train$V1
setwd("/Users/marilindacroes/Documents/coursera/gettingAndcleaningData")

# merge test & trainset
train_test <- rbind(train, test)

# Part 2
# Extracts only the measurements on the mean and standard deviation for each measurement.
a <- train_test[grepl("mean", names(train_test))]
b <- train_test[grepl("std", names(train_test))]
c <- train_test[grepl("labels", names(train_test))]
d <- train_test[grepl("subject", names(train_test))]
train_test2 <- cbind(c, d, a, b)

# Part 3
# Uses descriptive activity names to name the activities in the data set
train_test2$labelsdescription[train_test2$labels == 1 ] <- "walking"
train_test2$labelsdescription[train_test2$labels == 2 ] <- "walking_upstairs"
train_test2$labelsdescription[train_test2$labels == 3 ] <- "walking_downstairs"
train_test2$labelsdescription[train_test2$labels == 4 ] <- "sitting"
train_test2$labelsdescription[train_test2$labels == 5 ] <- "standing"
train_test2$labelsdescription[train_test2$labels == 6 ] <- "laying"

# Part 4
# Appropriately labels the data set with descriptive variable names.
colnames(train_test2) <- gsub("-", "", names(train_test2))
colnames(train_test2) <- gsub("[ [:punct:]]", "", names(train_test2))
colnames(train_test2) <- tolower(names(train_test2))

# Part 5
# From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
column_names <- colnames(train_test2)
column_names <- column_names[column_names != "labels"]
column_names <- column_names[column_names != "subject"]
column_names <- column_names[column_names != "labelsdescription"]

tidymean_traintest2 <- data.frame(matrix(nrow=180, ncol=0))
aggregation <- data.frame()
firstBind <- TRUE
for (i in 1:ncol(train_test2)){
        currentColumnName <- colnames(train_test2)[i]
        if (currentColumnName %in% column_names) {
                aggregation <- aggregate(train_test2[,i]  ~ labels + subject, data=train_test2, mean)
                colnames(aggregation) <- c("labels", "subject", currentColumnName)
                if (!firstBind) {
                        aggregation <- subset(aggregation, select=c(currentColumnName))
                }
                tidymean_traintest2 <- cbind(tidymean_traintest2, aggregation)
                firstBind = FALSE
        }
}

# add activity description back
tidymean_traintest2$labelsdescription[tidymean_traintest2$labels == 1 ] <- "walking"
tidymean_traintest2$labelsdescription[tidymean_traintest2$labels == 2 ] <- "walking_upstairs"
tidymean_traintest2$labelsdescription[tidymean_traintest2$labels == 3 ] <- "walking_downstairs"
tidymean_traintest2$labelsdescription[tidymean_traintest2$labels == 4 ] <- "sitting"
tidymean_traintest2$labelsdescription[tidymean_traintest2$labels == 5 ] <- "standing"
tidymean_traintest2$labelsdescription[tidymean_traintest2$labels == 6 ] <- "laying"

# output the data frame
write.table(tidymean_traintest2, file="tidydata.txt", row.name=FALSE)
