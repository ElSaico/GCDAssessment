library(dplyr)

# lists of signal and activity labels
features <- read.table(unz('har.zip', 'UCI HAR Dataset/features.txt'), row.names=1, header=FALSE)[,]
activity <- read.table(unz('har.zip', 'UCI HAR Dataset/activity_labels.txt'), row.names=1, header=FALSE)[,]

# reads the training and test data and applies the column labels
train <- read.table(unz('har.zip', 'UCI HAR Dataset/train/X_train.txt'), header=FALSE)
test <- read.table(unz('har.zip', 'UCI HAR Dataset/test/X_test.txt'), header=FALSE)
names(train) <- features
names(test) <- features

# lists of activity ids per data row
train.activity <- read.table(unz('har.zip', 'UCI HAR Dataset/train/y_train.txt'), header=FALSE)[,]
test.activity <- read.table(unz('har.zip', 'UCI HAR Dataset/test/y_test.txt'), header=FALSE)[,]

# lists of subject ids per data row
train.subject <- read.table(unz('har.zip', 'UCI HAR Dataset/train/subject_train.txt'), header=FALSE)[,]
test.subject <- read.table(unz('har.zip', 'UCI HAR Dataset/test/subject_test.txt'), header=FALSE)[,]

# merges training and test data (only the signal means and stds)
data <- rbind(train, test)[,grep("(mean|std)\\(\\)", features)]
# adds the activity column (with the proper labels) and the subject column
data$activity <- factor(c(train.activity, test.activity), labels=activity)
data$subject <- c(train.subject, test.subject)

# groups by activity type and subject, gets the averages and writes in a file
data.grouped <- group_by(data, activity, subject)
data.averages <- summarise_each(data.grouped, funs(mean))
write.table(data.averages, 'har_averages.txt', row.name=FALSE)
