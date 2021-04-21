---
title: "README"
date: April 21, 2021
output: html_document
---

## Repository Contents:
 * **README.md** : This file. Provides an overview of repository contents, the project and an explanation of the script used.
 * **Codebook.md**: Codebook. Describes how data was collected, variables and observations obtained from raw data set and those included in the final tidy data set, their units, and a brief description of transformations preformed on raw data to generate tidy data. 
 * **run_analysis.R** : R script. Code used to transform raw data into a tidy dataset
 * **average_data.txt**: Final tidy dataset generated from run_analysis.R script. 

## Project Overview:
This project was preformed as the assignment for the Getting and Cleaning Data course by Johns Hopkins University on Coursera. Untidy data was provided in a folder ("UCI HAR Dataset") in .txt format as multiple files. As per the assignment/project instructions, these data were read into R, merged into a large temporary dataset, observations and variables were filtered to include only relevant information, and variables were renamed to be descriptive. Finally, the tidy data set was saved as average_data.txt
 * More information on the files included in the raw data set and the variables can be found in the Codebook.md file on Github Repository

## Explaination of run_analysis.R Script to Transform Raw Data Into Tidy Data with Sample Codes Included:

Packages used:

``` 
library(data.table)
library(plyr)
library(dplyr)
```

All raw data files were read into R and dimensions were analyzed to determine how they can be merged together: 

```
subject_test <- fread("subject_test.txt", header = FALSE )
dim(subject_test)
```

Raw data table columns were bound in particular orders to generate temporary, partial, data tables:

```
test_data <- cbind(y_test, subject_test, X_test)
```

These partial data tables were then merged by combining rows:

```
merged_data <- rbind(test_data, train_data)
```


Regular Expressions were used to extract relative/desired columns with information on mean and standard deviation only:

```
filtered_merged_data <- subset(merged_data, select = grep("(.*[Mm]ean|std.*)|Activity|Subject", names(merged_data))) 
```

Adjusted variable names using several methods. Adjustments were made according to the priciples of variable names in tidy data which include: lower case letters, descriptive, not duplicated, and no underscores, dashes, dots, or white spaces. For example:

 * Replace factor levels with their labels:

```
filtered_merged_data$Activity <- factor(filtered_merged_data$Activity, levels=1:6, labels= activity_labels$V2)
```

 * Use functions to edit text variables (e.g. sub, gsub, to lower) on combinations of metacharacters and literal regular expressions:
 ```
names(filtered_merged_data) <- tolower(names(filtered_merged_data)) #make all variable names lowercase
names(filtered_merged_data) <- sub("^t|t ", "time ", names(filtered_merged_data)) #remove abbreviations to make descriptive
names(filtered_merged_data) <- gsub("-", " ", names(filtered_merged_data)) #remove dashes
names(filtered_merged_data) <- gsub("  "," ", names(filtered_merged_data)) #remove white space
```

Eliminated excessive observations by averaging each variable for each activity and each subject. Function colMeans() was applied to filtered_merged_data for each activity and subject to get the final tidy dataset, which was written as a text file: average_data.txt 

```
average_data <- ddply(.data = filtered_merged_data, .(activity, subject), function(x) colMeans(x[,3:88])) 
write.table(average_data, "average_data.txt", row.names = FALSE) 
```