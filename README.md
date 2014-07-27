Read Me
===========================================
Coursera Data Science Specialization - Getting & Cleaning Data


Introduction
------------

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare a tidy data set that can be used for later analysis. 

Source Data
-----------

The data set, as well as the description and attribute information, resides here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Analysis
--------

The run_analysis.R script creates a single merged data set containing both the test and training sets, extracting only the mean and standard deviations for each measurements.  The merged data set will have descriptive activity names (e.g. "WALKING", "WALKING UPSTAIRS", ...) and will use descriptive labels (column headers) for each variable.

The script uses the qdap package for the lookup() function reshape2 package for the melt() and dcast() functions

```{r}
library(qdap)
lhape2)
```

Set paths to training and test datasets (presumes the UCI HAR Dataset folder is in the working directory)

```{r}
path <- paste(getwd(), "UCI HAR Dataset", sep="/")     
path.train <- paste(path, "train", sep="/")
path.test <- paste(path, "test", sep="/")
```

Prepare the variable column headers and clean up the variable names to work well with R processing.

```{r}
# set up a row of column headers
df.features <- t(read.table(paste(path, "features.txt", sep="/" ), sep=""))    
df.features[2,] <- gsub("^t","time_",df.features[2,],ignore.case=T)
df.features[2,] <- gsub("^f","freq_",df.features[2,],ignore.case=T)
df.features[2,] <- gsub("-","_",df.features[2,],ignore.case=T)
df.features[2,] <- gsub("[^A-Za-z0-9_]","",df.features[2,],ignore.case=T)
df.features[2,] <- gsub("bodybody","Body",df.features[2,],ignore.case=T)
df.features[2,] <- gsub("^anglet","angle_time_",df.features[2,],ignore.case=T)
df.features[2,] <- gsub("^anglex","angle_X_",df.features[2,],ignore.case=T)
df.features[2,] <- gsub("^angley","angle_Y_",df.features[2,],ignore.case=T)
df.features[2,] <- gsub("^anglez","angle_Z_",df.features[2,],ignore.case=T)
```
    
Assemble the training and test data sets first, including the cleaned up labels

```{r}
# read the training datasets
df.subj_train <- read.table(paste(path.train, "subject_train.txt", sep="/" ), sep="")
df.y_train <- read.table(paste(path.train, "y_train.txt", sep="/" ), sep="")
df.x_train <- read.table(paste(path.train, "X_train.txt", sep="/" ), sep="")

# merge the training datasets into a data frame 
df.m_train <- cbind(df.subj_train, df.y_train, df.x_train)
    
# label the data set with descriptive variable names
names(df.m_train) <- c("subject_id", "activity_id", df.features[2,])
    
# Read the test datasets
df.subj_test <- read.table(paste(path.test, "subject_test.txt", sep="/" ), sep="")
df.y_test <- read.table(paste(path.test, "y_test.txt", sep="/" ), sep="")
df.x_test <- read.table(paste(path.test, "X_test.txt", sep="/" ), sep="")
    
# Merge the test datasets into a data frame 
df.m_test <- cbind(df.subj_test, df.y_test, df.x_test)
    
# Label the data set with descriptive variable names
names(df.m_test) <- c("subject_id", "activity_id", df.features[2,])
```

Create the full merged data set using rbind(), then use the qdap lookup() function to replace activity identifiers with activity names.  Once the full data set is complete then subset out only the columns that contain "mean" or "std", and write the data set to a text file.

```{r}    
# Combine the test and training data frames into one
df.m_all <- rbind(df.m_test, df.m_train)
    
# Replace activity_id with the descriptive activity_name using lookup() function from qdap package
df.m_all$activity_id <- lookup(df.m_all$activity_id, sort(unique(df.m_all$activity_id)),
                           c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", 
                           "STANDING", "LAYING"))

# Rename the column to correctly describe its contents
colnames(df.m_all)[colnames(df.m_all) == "activity_id"] <- "activity_name"
     
# Subset the merged data set to include only mean and standard deviations
df.m_sub <- df.m_all[,c(c("subject_id", "activity_name"),
                    grep("mean|std", names(df.m_all), value=TRUE) )]    
    
# Write merged data set to a file
write.csv(df.m_sub, "./UCI_HAR_Merged.txt", na = "NA", row.names=FALSE)
```

Using the same subset, create a sorted tidy dataset with with the average of each variable for each activity for each subject.  This involves melting the data set, casting it back to wide format using the mean function, and then melting the data set again to put the averaged variables back into tidy format.  Also, the variable names for all of the "mean" and "std" variables are pre-pended with "avg_" for clarity.

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
    
# Write the tidy data sets to files
write.csv(df.m_sub.tidy, "./UCI_HAR_Tidy.txt", na = "NA", row.names=FALSE)
```

Session Information
-------------------
R version 3.1.0 (2014-04-10)
Platform: x86_64-apple-darwin13.1.0 (64-bit)

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods  
[7] base     

loaded via a namespace (and not attached):
[1] tools_3.1.0
