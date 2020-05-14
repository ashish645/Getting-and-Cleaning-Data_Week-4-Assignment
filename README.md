# Getting-and-Cleaning-Data_Week-4-Assignment
### Introduction
This repository was created as a part week 4 peer graded assignment. It include the information regarding how i have run the analysis on 
the data set of UCI Human Activity Recognition Using Smartphones Data Set

#### Dataset 
* You can found a full description of raw data from here [Description of data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
* The raw data in Zip format can be downloded from this [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Files
* **CodeBook.md**  a code book that describes the variables, the data, and any transformations or work that i have performed to clean up the data 

* **run_alanysis.R** perform the following 6 step
  + Step0: First we download data and unzip it and then label the Columns 
  + Step1: Merges the training and the test sets to create one data set.
  + Step2: Extracts only the measurements on the mean and standard deviation for each measurement.
  + Step3: Uses descriptive activity names to name the activities in the data set
  + Step4: Appropriately labels the data set with descriptive variable names.
  + Step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity   and each subject.

* **tidyDataSet_average** is the final version of tidy data
