# File:   run_analysis.R
# Author: Jason D. Miller

# Set Options -------------------------------------------------------------
setwd("C://Users//Jason//Dropbox//Coursera//getting_and_cleaning//getting_cleaning_project")

# Load Libraries/Functions ------------------------------------------------
library(sqldf)

# Import Data -------------------------------------------------------------

# Raw Data ####
# Uncomment the 2 lines below to download the .zip file 
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip")
#unzip("data.zip")

# Files within the Raw Data ####
# Read activity labels
activity_labels <- read.csv(".//UCI HAR Dataset//activity_labels.txt", sep="", 
                            header=FALSE)
colnames(activity_labels) <- c("activity_number", "activity_label")

# Read Features
features <- read.csv(".//UCI HAR Dataset//features.txt", sep="", header=FALSE)
colnames(features) <- c("feature_number", "feature")

# Read Training Data
X_train       <- read.csv(".//UCI HAR Dataset//train//X_train.txt", sep="", 
                          header=FALSE)
Y_train       <- read.csv(".//UCI HAR Dataset//train//Y_train.txt", sep="", 
                          header=FALSE)
subject_train <- read.csv(".//UCI HAR Dataset//train//subject_train.txt", sep="",
                          header=FALSE)

colnames(X_train)       <- features$feature
Y_train.named           <- sqldf("select a.V1 as activity_number, b. activity_label
                                   from Y_train a 
                                   left join activity_labels b
                                   on a.V1 = b.activity_number") #Descriptive names  
colnames(subject_train) <- "subject"
  
training <- cbind(X_train, Y_train.named, subject_train)

rm(X_train, Y_train, Y_train.named, subject_train)

# Read Test Data
X_test       <- read.csv(".//UCI HAR Dataset//test//X_test.txt", sep="", 
                         header=FALSE)
Y_test       <- read.csv(".//UCI HAR Dataset//test//Y_test.txt", sep="", 
                         header=FALSE)
subject_test <- read.csv(".//UCI HAR Dataset//test//subject_test.txt", sep="", 
                         header=FALSE)

colnames(X_test)       <- features$feature
Y_test.named           <- sqldf("select a.V1 as activity_number, b. activity_label
                                   from Y_test a 
                                   left join activity_labels b
                                   on a.V1 = b.activity_number") #Descriptive names  
colnames(subject_test) <- "subject"

testing <- cbind(X_test, Y_test.named, subject_test)

rm(X_test, Y_test, Y_test.named, subject_test)

# Merge Training and Test Datasets ----------------------------------------
training$group <- "train"
testing$group  <- "test"

data <- rbind(training, testing)

rm(training, testing)

# Extract only the mean and std. dev. for each measurement ----------------
keep <- grepl("mean|std", features[,2])
keep[562:565] <- TRUE

data <- data[,keep]

# Tidy data w/ avg of ea. variable for ea. activity + ea. subject ---------
data.tidy                <- aggregate(data[,1:79], by=list(data$activity_label,
                                                           data$subject), mean)
colnames(data.tidy[1:2]) <- c("activity", "subject")

# Save and Export ---------------------------------------------------------
save.image("getting_cleaning_project.Rdata")
write.csv("data.tidy", file = "final_dataset.csv")