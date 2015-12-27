# Code Book

# Getting and Cleaning Data Course Project

> This projects objective was to merge multiple datasets, select only the Subject, Activity, mean and standard deviation columns and aggregate the data by Subject and Activity. 

> All data was pulled from the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Files data was imported from
1. **Files used for labels**
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
2. **Files used for data**
* ***Features***
* 'train/X_train.txt': Training set.
* 'test/X_test.txt': Test set.
* ***Activities***
* 'train/y_train.txt': Training labels.
* 'test/y_test.txt': Test labels.
* ***Subjects***
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'test/subject_test.txt'

### Variables used in the features dataset
"t": Time
"f": Frequency
    
"Acc": Accelerometer
"Gyro": GyroScope
"Mag": Magnitude
    
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

We were only concerned with the mean(): Mean value and std(): Standard deviation from this dataset.  Each of the above variable names contain the "-XYZ" which is represented by either mean or std.


#### Variables used in the Activities dataset

* LAYING 
* SITTING 
* STANDING 
* WALKING 
* WALKING_DOWNSTAIRS 
* WALKING_UPSTAIRS

#### Steps
* Data from multiple files are imported into Features, Activities and Subjects
* The Features dataset is cleaned up so only mean and std columns exists
* The new Freatures dataset, Activities and Subjects are merged to form a single dataset
* The new dataset is aggregated by Subject and Activity to get the mean of each data point
* The final output is stored into the tidydata.txt text file to be used later
