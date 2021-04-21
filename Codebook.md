
---
title: "CodeBook"
date: April 21, 2021
output: html_document

---


## Part 1: Data Collection and Observations: 

##### Information on data collection below is obtained from: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. Smartlab - Non Linear Complex Systems Laboratory. DITEN - Universit‡ degli Studi di Genova. Via Opera Pia 11A, I-16145, Genoa, Italy.activityrecognition@smartlab.ws  www.smartlab.ws (README.txt file in the UCI HAR Dataset from Coursera Getting and Cleaning Data Cousse Assignment)


Experiments involved 30 subject/volunteers within an age bracket of 19-48 years. Each subjectn performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. Subject movement was video-recorded and data was manually labeled. The obtained dataset was randomly separated into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Observations for the variables described below were recorded for each subject, for each of the six activities. 

---

## Part 2: Variables in Dataset

### 2A. Variables in Raw Data Set
##### Information on variables in raw data set are adapted from the features_info.txt in the UCI HAR Dataset from Coursera Getting and Cleaning Data Course Assignment 

#### Description of Raw Dataset Variables:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ). Body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. The body acceleration signal obtained by subtracting the gravity from the total acceleration. 


#### List of Raw Dataset Variables: 

 * **Measurements:** 
    + tBodyAcc-XYZ
    + tGravityAcc-XYZ
    + tBodyAccJerk-XYZ
    + tBodyGyro-XYZ
    + tBodyGyroJerk-XYZ
    + tBodyAccMag
    + tGravityAccMag 
    + tBodyAccJerkMag
    + tBodyGyroMag
    + tBodyGyroJerkMag 
    + fBodyAcc-XYZ
    + fBodyAccJerk-XYZ
    + fBodyGyro-XYZ
    + fBodyAccMag
    + fBodyAccJerkMag 
    + fBodyGyroMag
    + fBodyGyroJerkMag
        * Note: prefix 'f' indicates frequency of domain signals and prefix 't' denotes time domain signals 


 * **To each of the measurements above, the following estimations were applied, generating a total of 561 variables in the raw dataset:**
    + mean(): Mean value
    + std(): Standard deviation
    + mad(): Median absolute deviation 
    + max(): Largest value in array
    + min(): Smallest value in array
    + sma(): Signal magnitude area
    + energy(): Energy measure. Sum of the squares divided by the number of values. 
    + iqr(): Interquartile range 
    + entropy(): Signal entropy
    + arCoeff(): Autorregresion coefficients with Burg order equal to 4
    + correlation(): correlation coefficient between two signals
    + maxInds(): index of the frequency component with largest magnitude
    + meanFreq(): Weighted average of the frequency components to obtain a mean frequency
    + skewness(): skewness of the frequency domain signal 
    + kurtosis(): kurtosis of the frequency domain signal 
    + bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
    + angle(): Angle between to vectors.

 * **Units**:
    +  The acceleration signals from the smartphone accelerometer (i.e. "Acc") are in standard gravity units 'g'
    +  The angular velocity vectors measured by the gyroscope (i.e. "Gyro") are radians/second. 

### 2B. Variables in Tidy Data Set (average_data.txt)
Raw variables were filtered to only include data on mean() and std() from each of the measurements. A total of 86 variables were included in the final, tidy data set. 

---

## Part 3: Transformations Preformed on Raw Data to Generate Tidy Data
Raw data from both subject groups (test and training) were merged. Variables without mean() or std() information were omitted reducing the number of variables from 561 to 86. Average of each variable for each activity and each subject was taken to reduce the number of observations from 10279 in the raw dataset to 180 in the tidy dataset. Regular expressions were used to provide descriptive variable names. Principles of tidy data are satisfied, with each variable having its own column, each observation having its own row, and each value in its own cell.


