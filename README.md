---
title: 'README for Getting and Cleaning Data Coursera Project'
author: "Jason D. Miller"
date: "Sunday, December 21, 2014"
output: html_document
---

# About the Data 

The data were sourced from a copy of UCI's "Human Activity Recognition Using Smartphones Dataset".

The original researchers were Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto. 

Links to a full description and the original dataset are available in CodeBook.md

# About run_analysis.R

The R file run_analysis.R does the following things:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It does those 5 things above by first downloading data, then reading in the data, assigning data to objects and human readable names to columns, then merging, filtering, and tidying the data.

# Special notes
## Special note #1
I called the package `sqldf` for convenience, however this is not a necessary step.
The same data transformations can be carried out using the functions in base R.

## Special note #2
I have commented out my `download.file` and `unzip` commands because, due to SSL,
they are not consistently sucessful. A work-around is download the compressed dataset
in your browser.

## Special note #3
Check out my blog and follow me on Github! :)
1. http://hack-r.com
2. http://github.com/hack-r
3. http://hack-r.github.io