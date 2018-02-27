library(dplyr)   #to rename column

## read text files
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", check.names=FALSE) #containing also the measurements of mean and std
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")                    #containing activity labels

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", check.names=FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt") #identifies the subject who performed 
                                                                       #the activity
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

## 1. Merges the training and the test sets to create one data set
merged_X <- rbind(X_train, X_test)
merged_y <- rbind(y_train, y_test)
merged_y <- rename(merged_y, c("V1"="Activities"))
merged_subj <- rbind(subject_train, subject_test) 
merged_subj <- rename(merged_subj, c("V1"="Subjects"))

## 2. Extracts only the measurements on the mean and standard deviation for each measurement
features <- read.table("UCI HAR Dataset/features.txt")
idx <- unlist(subset(features, grepl("mean()", V2) | grepl("std()", V2))['V1'])
merged_x <- merged_X[,idx]

## 4. 
name <- subset(features, grepl("mean", V2) | grepl("std", V2))['V2']
name$V2 <- gsub("-", "_", name$V2)
name$V2 <- gsub("\\(\\)", "", name$V2)
names(merged_x) <- name$V2

## 3. Uses descriptive activity names to name the activities in the data set
data <- cbind(merged_x, merged_y, merged_subj)

data$Activities <- replace(data$Activities, data$Activities==1, "walk")
data$Activities <- replace(data$Activities, data$Activities==2, "walk_up")
data$Activities <- replace(data$Activities, data$Activities==3, "walk_down")
data$Activities <- replace(data$Activities, data$Activities==4, "sit")
data$Activities <- replace(data$Activities, data$Activities==5, "stand")
data$Activities <- replace(data$Activities, data$Activities==6, "lay")

## 4. Appropriately labels the data set with descriptive variable names
#done before

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
##    each variable for each activity and each subject
df <- data %>%
        group_by(Activities, Subjects) %>% 
        summarise_all(mean)


## 6. create text file
write.table(df, "data.txt", row.name=FALSE)
