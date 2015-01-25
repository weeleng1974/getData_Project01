# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("~/Coursera/courses/03_GettingData/Project01")
library(plyr)
library(dplyr)

# 1. Merges the training and the test sets to create one data set.
#Merging of the test data into a single data frame
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt", header=FALSE)

# 4. Appropriately labels the data set with descriptive variable names. 
names(subject_test) <- c("subject")
names(activity_label) <- c("feature","activity_label")
cnames <- as.character(features$V2)
names(X_test) <- make.names(cnames)
names(Y_test) <- c("feature")
df.test<-cbind(subject_test,Y_test,X_test)

#Merging of the train data into a single data frame
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt", header=FALSE)

# 4. Appropriately labels the data set with descriptive variable names. 
names(subject_train) <- c("subject")
names(X_train) <- make.names(cnames)
names(Y_train) <- c("feature")
df.train<-cbind(subject_train,Y_train,X_train)

#Merge both test and train data together
df.raw <- rbind(df.test, df.train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
meanCol <- grep("mean\\.",names(df.raw))
stdCol <- grep("std\\.",names(df.raw))
df.final<-df.raw[,c(1,2,meanCol,stdCol)]

# 3. Uses descriptive activity names to name the activities in the data set
df.final.label<-merge(df.final,activity_label, by.x="feature", by.y="feature")

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data_set<-group_by(df.final.label,subject,activity_label) %>% summarise_each(funs(mean))
#Removing the feature variable
tidy_data_set.final<-tidy_data_set[,-3]
write.table(tidy_data_set.final,"tidy_data_set.txt",row.name=FALSE)
