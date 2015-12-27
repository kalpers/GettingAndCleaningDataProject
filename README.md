# README File

# Getting and Cleaning Data Course Project
> *Coursera - Free Online Courses From Top Universities states that "one of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"*

> *Data file used can be found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip*

## Files found in the repository
* **README.md** - Current file
* **CodeBook.md** - describes the variables, the data, and any transformations or work that was performed to clean up the data
* **run_analysis.R** - R Code File that contains the functions to tidy up the data

## Requirements for **run_analysis.R** file
> Load the data.table and dplyr packages

```r
if (!require("data.table")) {
    install.packages("data.table")
    ##require(data.table)
}
```

1. Merges the training and the test sets to create one data set.
* Combine train and test data into x_Features, y_Activities and sub

```r
## set the location of the files
strLoc <- "UCI HAR Dataset/"
## load the feature data
x_Features <- rbind(
    read.table(paste(strLoc, "train/x_train.txt", sep="")), 
    read.table(paste(strLoc, "test/x_test.txt", sep="")))

## load the activities data
y_Activities <- rbind(
    read.table(paste(strLoc, "train/y_train.txt", sep="")), 
    read.table(paste(strLoc, "test/y_test.txt", sep="")))

## load in the subject data
sub <- rbind(
    read.table(paste(strLoc, "train/subject_train.txt", sep="")), 
    read.table(paste(strLoc, "test/subject_test.txt", sep="")))
```

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

```r
## pull in the feature labels
x_FeatureNames = read.table(paste(strLoc, "features.txt", sep=""))
## name all of the columns in the data set
names(x_Features) <- x_FeatureNames[,2] 
## search for columns with mean and std
measures_MeanAndStd <- grep("mean\\(\\)|std\\(\\)", x_FeatureNames[,2], value=TRUE, ignore.case = TRUE)
## create a new variable to only hold the mean and std columns
x_Features_measures_meanAndStd <- x_Features[,measures_MeanAndStd]
```


3. Uses descriptive activity names to name the activities in the data set

```r
## pull in the activity labels
y_ActivityNames = read.table(paste(strLoc, "activity_labels.txt", sep=""))
## reassign activity data with activity labels
y_Activities[,1] <- y_ActivityNames[y_Activities[,1], 2]
```

4. Appropriately labels the data set with descriptive variable names. 

```r
## provide full names to abreviations
names(x_Features_measures_meanAndStd) <- gsub("Acc", "Accelerometer", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("angle", "Angle", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("BodyBody", "Body", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("^f", "Frequency", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("-freq()", "Frequency", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("gravity", "Gravity", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("Gyro", "GyroScope", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("Mag", "Magnitude", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("-mean()", "Mean", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("-std()","StandardDeviation", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("^t", "Time", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("^tBody", "TimeBody", names(x_Features_measures_meanAndStd))
names(x_Features_measures_meanAndStd) <- gsub("-", "_Minus_", names(x_Features_measures_meanAndStd))
## remove () from the column names
names(x_Features_measures_meanAndStd) <- gsub("\\(|\\)", "", names(x_Features_measures_meanAndStd))

## name the data column from V1 to Activities
names(y_Activities) <- "Activities"

## name the subject column
names(sub) <- "Subject"

## combine all data into a single dataset
finalDataSet <- cbind(x_Features_measures_meanAndStd, y_Activities, sub)
```

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```r
## using the aggregate function, find the average for subject/activities
aggregatedDataSet <- aggregate(. ~Subject + Activities, finalDataSet, mean)
## sort the data 
aggregatedDataSet <- aggregatedDataSet[order(aggregatedDataSet$Subject, aggregatedDataSet$Activities),]
## write the dataset
write.table(aggregatedDataSet, file="tidydata.txt", row.names=FALSE)
```




<hr/>

<dl>
  <dt>Citation</dt>
  <dd>"Coursera - Free Online Courses From Top Universities." Coursera. Web. 24 Dec. 2015. <https://class.coursera.org/getdata-035>.</dd>
</dl>



