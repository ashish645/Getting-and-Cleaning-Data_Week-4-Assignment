
# Step0: Downloding and labeling the data

# Importing Data
library(dplyr)
library(data.table)
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file_path <-"G:/coursera/Getting and Cleaning Data/Data/UCI_Smartphones.zip"
download.file(file_url,file_path,method = "curl")

#unzipping the data set
unzip(file_path,exdir = "G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set")

# extracting data from zip file

# reading test data
X_testData <- read.table("G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set/UCI HAR Dataset/test/X_test.txt")
Y_testData <- read.table("G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set/UCI HAR Dataset/test/y_test.txt")
SubjectTest <- read.table("G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set/UCI HAR Dataset/test/subject_test.txt")

# reading traning data
X_trainingData <- read.table("G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set/UCI HAR Dataset/train/X_train.txt")
Y_trainingData <- read.table("G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set/UCI HAR Dataset/train/y_train.txt")
SubjectTraining <- read.table("G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set/UCI HAR Dataset/train/subject_train.txt")

# Reading Activity lable data
Activity_lables <- read.table("G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set/UCI HAR Dataset/activity_labels.txt")

# Reading variable/feature  data
features <- read.table("G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set/UCI HAR Dataset/features.txt")

# assining proper name to the variables 
colnames(features)
features <- rename(features, N = V1, Varible_Name = V2 )
colnames(X_trainingData) = features[,2]
colnames(X_testData) = features[,"Varible_Name"]
Activity_lables <- rename(Activity_lables, ActivityCode = V1, ActivityName = V2 )
Y_testData <- rename(Y_testData, ActivityCode = V1 )
Y_trainingData <- rename(Y_trainingData, ActivityCode = V1 )
Y_testData <- rename(Y_testData, ActivityCode = V1 )
Y_trainingData <- rename(Y_trainingData, ActivityCode = V1 )
SubjectTraining <- rename(SubjectTraining, SubjectCode = V1 )
SubjectTest <- rename(SubjectTest, SubjectCode = V1 )

# Step :1 Merges the training and the test sets to create one data set.

# Merging traning and test data set
X_Combined <- rbind(X_testData,X_trainingData)
Y_Combined <- rbind(Y_testData,Y_trainingData)
Subject_combined <- rbind(SubjectTest,SubjectTraining)
Combined_Data <- cbind(Subject_combined,Y_Combined,X_Combined)

# Step:2 Extracts only the measurements on the mean and standard deviation for each measurement.

# Selecting varible of interest
varNames <-colnames(Combined_Data)
mean_std <- (grepl("mean..", varNames) | grepl("std..",varNames)|grepl("ActivityCode",varNames)|grepl("SubjectCode",varNames))
tidyDataSet<- Combined_Data[,mean_std==TRUE]

# Step:3 Uses descriptive activity names to name the activities in the data set

# labeling Activity
tidyDataSet$ActivityCode <-Activity_lables[tidyDataSet$ActivityCode,2]
View(tidyDataSet)

# Step:4 Appropriately labels the data set with descriptive variable names.

# assigning descriptive variable name

names(tidyDataSet) <-  gsub("Acc", "Accelerometer",names(tidyDataSet)) 
names(tidyDataSet) <- gsub("gravity", "Gravity", names(tidyDataSet))
names(tidyDataSet) <- gsub("angle", "Angle", names(tidyDataSet))
names(tidyDataSet) <- gsub("freq", "Frequency", names(tidyDataSet))
names(tidyDataSet) <- gsub("-std", "Standard Deviation", names(tidyDataSet))
names(tidyDataSet) <- gsub("mean", "Mean", names(tidyDataSet))
names(tidyDataSet) <- gsub("Body", "Body", names(tidyDataSet))
names(tidyDataSet) <- gsub("^f", "Frequency", names(tidyDataSet))
names(tidyDataSet) <- gsub("^t", "Time", names(tidyDataSet))
names(tidyDataSet) <- gsub("Mag", "Magnitude", names(tidyDataSet))
names(tidyDataSet) <- gsub("BodyBody", "Body", names(tidyDataSet))
names(tidyDataSet) <- gsub("Gyro", "Gyroscope", names(tidyDataSet))
names(tidyDataSet) <- gsub("-", "_", names(tidyDataSet))
names(tidyDataSet) <- gsub("Standard Deviation", "_Standard Deviation", names(tidyDataSet))
names(tidyDataSet) <- gsub("MeanFreq", "MeanFrequency", names(tidyDataSet))
names(tidyDataSet)

# Step:5 From the data set in Step 4, creates a second, independent tidy data set with
#  the average of each variable for each activity and each subject.

tidyDataSet_average <- tidyDataSet %>% 
                            group_by(SubjectCode,ActivityCode) %>%
                                      summarise_all(funs(mean))
View(tidyDataSet_average)

# creating text data
finaldata_path <- "G:/coursera/Getting and Cleaning Data/Data/Smartphones Data Set/tidyDataSet_average.text"
write.table(tidyDataSet_average,file = finaldata_path, row.names = FALSE,col.names = TRUE )

