run_analysis <- function() {
    if (!require("data.table")) {
        install.packages("data.table")
        ##require(data.table)
    }
    
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
    
    ## pull in the feature labels
    x_FeatureNames = read.table(paste(strLoc, "features.txt", sep=""))
    ## name all of the columns in the data set
    names(x_Features) <- x_FeatureNames[,2] 
    ## search for columns with mean and std
    measures_MeanAndStd <- grep("mean\\(\\)|std\\(\\)", x_FeatureNames[,2], value=TRUE, ignore.case = TRUE)
    ## create a new variable to only hold the mean and std columns
    x_Features_measures_meanAndStd <- x_Features[,measures_MeanAndStd]
    
    ## pull in the activity labels
    y_ActivityNames = read.table(paste(strLoc, "activity_labels.txt", sep=""))
    ## reassign activity data with activity labels
    y_Activities[,1] <- y_ActivityNames[y_Activities[,1], 2]
    
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
    
    ## using the aggregate function, find the average for subject/activities
    aggregatedDataSet <- aggregate(. ~Subject + Activities, finalDataSet, mean)
    ## sort the data 
    aggregatedDataSet <- aggregatedDataSet[order(aggregatedDataSet$Subject, aggregatedDataSet$Activities),]
    ## write the dataset
    write.table(aggregatedDataSet, file="tidydata.txt", row.names=FALSE)
    
}
    
