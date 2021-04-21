#setwd 
setwd("/Users/reemabushamma/Downloads/UCI HAR Dataset/")

#load packages to use 
library(data.table)
library(plyr)
library(dplyr)

#read text files into R; look at structure/dimensions: 
subject_test <- fread("subject_test.txt", header = FALSE )
subject_train <- fread("subject_train.txt", header = FALSE)
X_test <- fread("X_test.txt", header = FALSE)
X_train <- fread("X_train.txt", header = FALSE)
y_test <- fread("y_test.txt", header = FALSE)
y_train <- fread("y_train.txt", header = FALSE )
features <- fread("features.txt", header = FALSE)
activity_labels <- fread("activity_labels.txt", header = FALSE)


dim(subject_test)
dim(subject_train)
dim(X_test)
dim(X_train)
dim(y_test) 
dim(y_train)
dim(features)
dim(activity_labels)

#name variables/columns of test set and training set with features 
names(X_test) <- features$V2
names(X_train) <- features$V2

#name variable/column of test label and training label with descriptive "Activity": 
names(y_train) <- "Activity"
names(y_test) <- "Activity"

#name variables/column of subjects for test and train group with descriptive "Subject":
names(subject_test) <- "Subject"
names(subject_train) <- "Subject"

#Bind activity label column, subject into column to test/training data sets (in that particular order): 
test_data <- cbind(y_test, subject_test, X_test)
dim(test_data) #confirm binding by checking that there are two more columns than X_test

train_data <-cbind(y_train, subject_train, X_train)
dim(train_data) #confirm column binding with two more columns to X_train



#REQUIREMENT 1: Merges the training and the test sets to create one data set.
#use rbind() to create merged_data from test_data and train_data 
merged_data <- rbind(test_data, train_data)
dim(merged_data) #confirm merging my checking dimension (nrow = 10299 as expected)

View(merged_data)

#REQUIREMENT 2: Extract only the measurements on the mean and standard deviation for each measurement.
filtered_merged_data <- subset(merged_data, select = grep("(.*[Mm]ean|std.*)|Activity|Subject", names(merged_data))) #use grep to extract column names from merged_data with "M/mean" or "std", while keeping "Activity" and "Subject" columns. Subset merged data based on this. 
dim(filtered_merged_data) #confirm subsetting by checking dimensions (columns were removed)



#REQUIREMENT 3: Use descriptive activity names to name the activities in the data set
filtered_merged_data$Activity <- factor(filtered_merged_data$Activity, levels=1:6, labels= activity_labels$V2) #reassign Activity column in data table with factor labels (from factor levels)


#REQUIREMENT 4: Appropriately label data set with descriptive variable names
#make variable names in data table descriptive and neat using gsub() and sub().
names(filtered_merged_data) <- gsub("([[:lower:]])([[:upper:]])", "\\1 \\2", names(filtered_merged_data)) #add spaces before uppercase letters
names(filtered_merged_data) <- tolower(names(filtered_merged_data)) #make all variable names lowercase
names(filtered_merged_data) <- sub("^t|t ", "time ", names(filtered_merged_data)) #change starting "t" to "time"
names(filtered_merged_data) <- sub("freq", "frequency", names(filtered_merged_data)) #change "freq" to "frequency"
names(filtered_merged_data) <- sub("^f", "frequency", names(filtered_merged_data)) #change starting "f" to "frequency"
names(filtered_merged_data) <- gsub("-", " ", names(filtered_merged_data)) #replace dashes with spaces 
names(filtered_merged_data) <- sub("acc", "acceleration", names(filtered_merged_data)) #replace "acc" with "acceleration" 
names(filtered_merged_data) <- sub("gyro", "angular velocity", names(filtered_merged_data)) #replace "gyro" with "angular velocity" 
names(filtered_merged_data) <- sub("std", "standard deviation", names(filtered_merged_data)) #replace "std" with "standard deviation"
names(filtered_merged_data) <- sub("mag", "magnitude", names(filtered_merged_data)) #replace "mag" with "magnitude" 
names(filtered_merged_data) <- gsub("\\()", "", names(filtered_merged_data)) #remove parenthesis
names(filtered_merged_data) <- sub(" $", "", names(filtered_merged_data)) #remove spaces at end of variable names 
names(filtered_merged_data) <- gsub("  "," ", names(filtered_merged_data)) #remove double spaces and replace with single spaces (getting rid of white spaces )
names(filtered_merged_data) #confirm that variable names are descriptive, lowercase, not duplicated and lack underscores/dashes/white spaces



#REQUIREMENT 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
average_data <- ddply(.data = filtered_merged_data, .(activity, subject), function(x) colMeans(x[,3:88])) #apply colMeans to ddply on activity and subject variables 
write.table(average_data, "average_data.txt", row.names = FALSE) #save tidy data set 
