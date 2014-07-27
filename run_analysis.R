run_analysis <- function() {
    
    library(qdap)           # lookup() function
    library(reshape2)       # melt() and dcast() functions
    
    #--------------------------------------------------------------------------
    # Part I - Merge test and training data sets into a single data set
    #--------------------------------------------------------------------------
    #
    # Create a single merged data set containing both the test and training
    # sets, extracting only the mean and standard deviations for each 
    # measurements.  The merged dataset will have descriptive activity names 
    # (e.g. "WALKING", "WALKING UPSTAIRS", ...) and will use descriptive 
    # labels (column headers) for each variable.
    #
    #--------------------------------------------------------------------------
    
    # set paths to training and test datasets
    # presumes the UCI HAR Dataset folder is in the working directory
    path <- paste(getwd(), "UCI HAR Dataset", sep="/")     
    path.train <- paste(path, "train", sep="/")
    path.test <- paste(path, "test", sep="/")
    
    #--------------------------------------------------------------------------
    # Prepare the variable column headers
    #
    # For example:  
    #
    # Clean up of tBodyAcc-mean()-X results in time_BodyAcc_mean_X
    #
    #--------------------------------------------------------------------------    
    
    # set up a row of column headers
    df.features <- t(read.table(paste(path, "features.txt", sep="/" ), sep=""))

    # replace cryptic abbreviations with more descriptive words
    df.features[2,] <- gsub("^t","time_",df.features[2,],ignore.case=T)
    df.features[2,] <- gsub("^f","freq_",df.features[2,],ignore.case=T)
    df.features[2,] <- gsub("-","_",df.features[2,],ignore.case=T)
    df.features[2,] <- gsub("[^A-Za-z0-9_]","",df.features[2,],ignore.case=T)
    df.features[2,] <- gsub("bodybody","Body",df.features[2,],ignore.case=T)
    df.features[2,] <- gsub("^anglet","angle_time_",df.features[2,],ignore.case=T)
    df.features[2,] <- gsub("^anglex","angle_X_",df.features[2,],ignore.case=T)
    df.features[2,] <- gsub("^angley","angle_Y_",df.features[2,],ignore.case=T)
    df.features[2,] <- gsub("^anglez","angle_Z_",df.features[2,],ignore.case=T)
    
    #--------------------------------------------------------------------------
    # Assemble the training data
    #--------------------------------------------------------------------------    
    
    # read the training datasets
    df.subj_train <- read.table(paste(path.train, "subject_train.txt", sep="/" ), sep="")
    df.y_train <- read.table(paste(path.train, "y_train.txt", sep="/" ), sep="")
    df.x_train <- read.table(paste(path.train, "X_train.txt", sep="/" ), sep="")

    # merge the training datasets into a data frame 
    df.m_train <- cbind(df.subj_train, df.y_train, df.x_train)
    
    # label the data set with descriptive variable names
    names(df.m_train) <- c("subject_id", "activity_id", df.features[2,])
    
    #--------------------------------------------------------------------------
    # Assemble the test data
    #--------------------------------------------------------------------------    
    
    # Read the test datasets
    df.subj_test <- read.table(paste(path.test, "subject_test.txt", sep="/" ), sep="")
    df.y_test <- read.table(paste(path.test, "y_test.txt", sep="/" ), sep="")
    df.x_test <- read.table(paste(path.test, "X_test.txt", sep="/" ), sep="")
    
    # Merge the test datasets into a data frame 
    df.m_test <- cbind(df.subj_test, df.y_test, df.x_test)
    
    # Label the data set with descriptive variable names
    names(df.m_test) <- c("subject_id", "activity_id", df.features[2,])
    
    #--------------------------------------------------------------------------
    # Merge the training and test data sets
    #--------------------------------------------------------------------------    
    
    # Combine the test and training data frames into one
    df.m_all <- rbind(df.m_test, df.m_train)
    
    # Replace activity_id with the descriptive activity_name using lookup() function from qdap package
    df.m_all$activity_id <- lookup(df.m_all$activity_id, sort(unique(df.m_all$activity_id)),
                               c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

    # Rename the column to correctly describe its contents
    colnames(df.m_all)[colnames(df.m_all) == "activity_id"] <- "activity_name"
     
    #--------------------------------------------------------------------------
    # Subset the merged data set to include only mean and standard deviations
    #--------------------------------------------------------------------------    
    
    # Subset the key columns and the mean and std measurements
    df.m_sub <- df.m_all[,c(c("subject_id", "activity_name"),
                        grep("mean()|std()", names(df.m_all), ignore.case=TRUE, value=TRUE) )]    
    
    # Write merged data set to a file
    write.csv(df.m_sub, "./UCI_HAR_Merged.txt", na = "NA", row.names=FALSE)
    
    #--------------------------------------------------------------------------
    # Part II - Create a tidy data set
    #--------------------------------------------------------------------------
    #
    # Create a sorted tidy dataset with with the average of each variable for 
    # each activity for each subject.
    #
    #--------------------------------------------------------------------------
    
    # Melt the raw variables into a tidy data set
    df.m_sub.melted <- melt(df.m_sub,id=c("subject_id", "activity_name"))
    
    # Cast the data back to wide format, calculating the average for all variables
    #df.m_sub.mean <- dcast(df.m_sub.melted, ... ~ variable, fun.aggregate = mean)
    df.m_sub.mean <- dcast(df.m_sub.melted, subject_id + activity_name ~ variable, fun.aggregate = mean)
    
    # Modify variable names to indicate 
    df.features.avg <- colnames(df.m_sub.mean)
    # replace first character "t" with "time_"
    df.features.avg <- gsub("^time_","avg_time_",df.features.avg,ignore.case=T)
    # replace first character "f" with "freq_"
    df.features.avg <- gsub("^freq_","avg_freq_",df.features.avg,ignore.case=T)
    # Label the data set with descriptive variable names
    names(df.m_sub.mean) <- df.features.avg
    
    # Melt the averaged variable back into tidy format
    df.m_sub.tidy <- melt(df.m_sub.mean,id=c("subject_id", "activity_name"))
    # Sort by key rather than variable  
    df.m_sub.tidy <- df.m_sub.tidy[with(df.m_sub.tidy, order(subject_id, activity_name)), ]
    
    # Write the tidy data sets to files
    write.csv(df.m_sub.tidy, "./UCI_HAR_Tidy.txt", na = "NA", row.names=FALSE)
    
    return("complete")    
}