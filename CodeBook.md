Code Book
Getting & Cleaning Data - Course Assignment
========================================================
Coursera Data Science Specialization
Getting & Cleaning Data
Course Programming Assignment
July 27, 2014

This code book describes the UCI HAR data sets and variables, as well as the cleansing and transformations performed on the data sets to create, cleansed, filter, merged and tidy data sets.  Please see the readme.Rmd file for description of the experiment and processing.

Data was read from the following files:

-train/subject_train.txt    Contains the ids of the subjects who participated in the study
-train/X_train.txt          Contains 565 variables related to one study observation    
-train/Y_train.txt          Contains the ids of which tasks were performed for each observation
-test/subject_test.txt      Contents are the same as corresponding files above.
-test/X_test.txt
-test/Y_test.txt

Data from the Intertial Signals folders for test and traing were not used.

Data Set Description
--------------------

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

Selection Criteria
------------------

For the purposes of this project, only variables relating to mean() and std() were select for the merged and tidy data sets. Angle measurements were excluded as they were calculated separately from the XYZ axis variables.  The variable names were cleaned up from the source format to be more descriptive.  The translation follows.  Variable values are normalized and bounded within [-1,1].

```
Source Name                 Cleaned Name
tBodyAcc-mean()-X	        time_BodyAcc_mean_X
tBodyAcc-mean()-Y	        time_BodyAcc_mean_Y
tBodyAcc-mean()-Z	        time_BodyAcc_mean_Z
tBodyAcc-std()-X	        time_BodyAcc_std_X
tBodyAcc-std()-Y	        time_BodyAcc_std_Y
tBodyAcc-std()-Z	        time_BodyAcc_std_Z
tGravityAcc-mean()-X	    time_GravityAcc_mean_X
tGravityAcc-mean()-Y	    time_GravityAcc_mean_Y
tGravityAcc-mean()-Z	    time_GravityAcc_mean_Z
tGravityAcc-std()-X	        time_GravityAcc_std_X
tGravityAcc-std()-Y	        time_GravityAcc_std_Y
tGravityAcc-std()-Z	        time_GravityAcc_std_Z
tBodyAccJerk-mean()-X	    time_BodyAccJerk_mean_X
tBodyAccJerk-mean()-Y	    time_BodyAccJerk_mean_Y
tBodyAccJerk-mean()-Z	    time_BodyAccJerk_mean_Z
tBodyAccJerk-std()-X	    time_BodyAccJerk_std_X
tBodyAccJerk-std()-Y	    time_BodyAccJerk_std_Y
tBodyAccJerk-std()-Z	    time_BodyAccJerk_std_Z
tBodyGyro-mean()-X	        time_BodyGyro_mean_X
tBodyGyro-mean()-Y          time_BodyGyro_mean_Y
tBodyGyro-mean()-Z	        time_BodyGyro_mean_Z
tBodyGyro-std()-X	        time_BodyGyro_std_X
tBodyGyro-std()-Y	        time_BodyGyro_std_Y
tBodyGyro-std()-Z	        time_BodyGyro_std_Z
tBodyGyroJerk-mean()-X	    time_BodyGyroJerk_mean_X
tBodyGyroJerk-mean()-Y	    time_BodyGyroJerk_mean_Y
tBodyGyroJerk-mean()-Z	    time_BodyGyroJerk_mean_Z
tBodyGyroJerk-std()-X	    time_BodyGyroJerk_std_X
tBodyGyroJerk-std()-Y	    time_BodyGyroJerk_std_Y
tBodyGyroJerk-std()-Z	    time_BodyGyroJerk_std_Z
tBodyAccMag-mean()	        time_BodyAccMag_mean
tBodyAccMag-std()	        time_BodyAccMag_std
tGravityAccMag-mean()	    time_GravityAccMag_mean
tGravityAccMag-std()	    time_GravityAccMag_std
tBodyAccJerkMag-mean()	    time_BodyAccJerkMag_mean
tBodyAccJerkMag-std()	    time_BodyAccJerkMag_std
tBodyGyroMag-mean()	        time_BodyGyroMag_mean
tBodyGyroMag-std()	        time_BodyGyroMag_std
tBodyGyroJerkMag-mean()	    time_BodyGyroJerkMag_mean
tBodyGyroJerkMag-std()	    time_BodyGyroJerkMag_std
fBodyAcc-mean()-X	        freq_BodyAcc_mean_X
fBodyAcc-mean()-Y	        freq_BodyAcc_mean_Y
fBodyAcc-mean()-Z	        freq_BodyAcc_mean_Z
fBodyAcc-std()-X	        freq_BodyAcc_std_X
fBodyAcc-std()-Y	        freq_BodyAcc_std_Y
fBodyAcc-std()-Z	        freq_BodyAcc_std_Z
fBodyAccJerk-mean()-X	    freq_BodyAccJerk_mean_X
fBodyAccJerk-mean()-Y	    freq_BodyAccJerk_mean_Y
fBodyAccJerk-mean()-Z	    freq_BodyAccJerk_mean_Z
fBodyAccJerk-std()-X	    freq_BodyAccJerk_std_X
fBodyAccJerk-std()-Y	    freq_BodyAccJerk_std_Y
fBodyAccJerk-std()-Z	    freq_BodyAccJerk_std_Z
fBodyGyro-mean()-X	        freq_BodyGyro_mean_X
fBodyGyro-mean()-Y	        freq_BodyGyro_mean_Y
fBodyGyro-mean()-Z	        freq_BodyGyro_mean_Z
fBodyGyro-std()-X	        freq_BodyGyro_std_X
fBodyGyro-std()-Y	        freq_BodyGyro_std_Y
fBodyGyro-std()-Z	        freq_BodyGyro_std_Z
fBodyAccMag-mean()	        freq_BodyAccMag_mean
fBodyAccMag-std()	        freq_BodyAccMag_std
fBodyBodyAccJerkMag-mean()	freq_BodyAccJerkMag_mean
fBodyBodyAccJerkMag-std()	freq_BodyAccJerkMag_std
fBodyBodyGyroMag-mean()	    freq_BodyGyroMag_mean
fBodyBodyGyroMag-std()	    freq_BodyGyroMag_std
fBodyBodyGyroJerkMag-mean()	freq_BodyGyroJerkMag_mean
fBodyBodyGyroJerkMag-std()	freq_BodyGyroJerkMag_std
```

Transformations
---------------

The key processing and transformations of data for this assignment include:

- Combine the train/subject_train.txt, train/X_train.txt, and train/Y_train.txt to create a single merged training file
- Combine the test/subject_test.txt, test/X_test.txt, and test/Y_test.txt to create a single merged training file
- Replace the merged column names with descriptive, cleansed column names 

```{r}
# Merge the test datasets into a data frame 
df.m_test <- cbind(df.subj_test, df.y_test, df.x_test)
    
# Label the data set with descriptive variable names
names(df.m_test) <- c("subject_id", "activity_id", df.features[2,])

# Merge the test datasets into a data frame 
df.m_test <- cbind(df.subj_test, df.y_test, df.x_test)
    
# Label the data set with descriptive variable names
names(df.m_test) <- c("subject_id", "activity_id", df.features[2,])
```

- Merge the test and training datasets, and replace the activity_id with activity_name

```{r}
# Combine the test and training data frames into one
df.m_all <- rbind(df.m_test, df.m_train)
    
# Replace activity_id with the descriptive activity_name using lookup() function from qdap package
df.m_all$activity_id <- lookup(df.m_all$activity_id, sort(unique(df.m_all$activity_id)),
                           c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

# Rename the column to correctly describe its contents
colnames(df.m_all)[colnames(df.m_all) == "activity_id"] <- "activity_name"
```

- Subset the merged data set to include only mean and standard deviations

```{r}
# Subset the key columns and the mean and std measurements
df.m_sub <- df.m_all[,c(c("subject_id", "activity_name"),
                    grep("mean|std", names(df.m_all), ignore.case=TRUE, value=TRUE) )]    
```

- And finally, melt detailed variables, cast with mean of variables, melt the means, and sort to create a tidy data set.

```{r}
# Melt the raw variables into a tidy data set
df.m_sub.melted <- melt(df.m_sub,id=c("subject_id", "activity_name"))
    
# Cast the data back to wide format, calculating the average for all variables
df.m_sub.mean <- dcast(df.m_sub.melted, subject_id + activity_name ~ variable, fun.aggregate = mean)

# label the data set with descriptive variable names
names(df.m_sub.mean) <- c("subject_id", "activity_id", df.features.avg)
# Modify variable names to indicate 
df.features.avg <- colnames(df.m_sub.mean)
# replace first character "t" with "time_"
df.features.avg <- gsub("^time_","avg_time_",df.features.avg,ignore.case=T)
# replace first character "f" with "freq_"
df.features.avg <- gsub("^freq_","avg_freq_",df.features.avg,ignore.case=T)
# Label the data set with descriptive variable names
names(df.m_sub.mean) <- df.features.avg

#Melt the averaged variable back into tidy format
df.m_sub.tidy <- melt(df.m_sub.mean,id=c("subject_id", "activity_name"))

# Sort by key rather than variable  
df.m_sub.tidy <- df.m_sub.tidy[with(df.m_sub.tidy, order(subject_id, activity_name)), ]
```

