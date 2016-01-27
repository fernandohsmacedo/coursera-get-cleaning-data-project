# NOTE:
# Please set the working directory to the folder in a level above
# "UCI HAR Dataset" folder

# OBJECTIVE:
# Create a tidy data set with the following characteristics:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for
#    each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

# Libraries
library(dplyr)

# Download the data sets if they don't exist
if(!dir.exists("UCI HAR Dataset")) {
    if(!file.exists("datasets.zip")){
        fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url = fileurl, destfile = "datasets.zip")
    }
    unzip("datasets.zip")
}
# Ceate output folder if it doesn't exist
if(!dir.exists("output")) {
    dir.create("output")
}

# Reads the data sets
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")


##################################################################
# 1. Merges the training and the test sets to create one data set.
##################################################################

# Create a column with the type ("training" or "test")
train_set$type <- "training"
test_set$type <- "test"

# Merge both datasets
train_test_set <- bind_rows(train_set, test_set)
train_test_set$type <- as.factor(train_test_set$type)

# Set column names with the values on features data
names(train_test_set)[-562] <- as.character(features$V2)

# Merge train and test activities, name then and label the column
train_test_labels <- train_labels %>% 
    bind_rows(test_labels)
names(train_test_labels) <- "activity_index"

# Merge subject datasets and name the column
train_test_subject <- bind_rows(train_subject, test_subject)
names(train_test_subject) <- "subject"

# Merge train_test_subject, train_test_set and train_test_labels
merged_set <- bind_cols(train_test_set, train_test_labels, train_test_subject)


##################################################################
# 2. Extracts only the measurements on the mean and standard
#    deviation for each measurement.
##################################################################
mean_sd_positions <- grep("mean\\(\\)|std\\(\\)", names(merged_set))
tidy_data_set <- merged_set[ ,c(562, 564, 563, mean_sd_positions)]


##################################################################
# 3. Uses descriptive activity names to name the activities in the
# data set
##################################################################
tidy_data_set <- tidy_data_set %>% 
    left_join(activity_labels, by = c("activity_index" = "V1")) %>% 
    select(-activity_index) %>% 
    rename(activity = V2) %>% 
    select(type, subject, activity, everything())


##################################################################
# 4. Appropriately labels the data set with descriptive variable
#    names.
##################################################################
# Substitute patterns
descriptive_names <- function(name_list) {
    patterns <- c("^t([^a-z])", "^f", "Acc", "Gyro", "Mag", "-X", "-Y", "-Z",
                  "\\(\\)", "-mean", "-std")
    replacements <- c("time\\1", "frequency", "Accelerometer", "Gyroscope",
                      "Magnitude", "Xaxis", "Yaxis", "Zaxis", "", "Mean", "Std")
    result = name_list
    for (i in 1:length(patterns)) {
        result <- gsub(patterns[i], replacements[i], result)
    }
    return(result)
}

names(tidy_data_set) <- descriptive_names(names(tidy_data_set))
write.csv(as.data.frame(tidy_data_set), file = "./output/tidy_data.csv",
          row.names = FALSE)


##################################################################
# 5. From the data set in step 4, creates a second, independent
#    tidy data set with the average of each variable for each
#    activity and each subject.
##################################################################
average_data_set <- tidy_data_set %>%
    select(-type) %>% 
    group_by(subject, activity) %>% 
    summarize_each(funs(mean))
write.csv(as.data.frame(average_data_set),
          file = "./output/average_tidy_data.csv", row.names = FALSE)
