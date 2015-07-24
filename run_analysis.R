library(dplyr)

features <- read.table(unz('har.zip', 'UCI HAR Dataset/features.txt'), row.names=1, header=FALSE)[,]
activity <- read.table(unz('har.zip', 'UCI HAR Dataset/activity_labels.txt'), row.names=1, header=FALSE)[,]

train <- read.table(unz('har.zip', 'UCI HAR Dataset/train/X_train.txt'), header=FALSE)
test <- read.table(unz('har.zip', 'UCI HAR Dataset/test/X_test.txt'), header=FALSE)
names(train) <- features
names(test) <- features

train.activity <- read.table(unz('har.zip', 'UCI HAR Dataset/train/y_train.txt'), header=FALSE)[,]
test.activity <- read.table(unz('har.zip', 'UCI HAR Dataset/test/y_test.txt'), header=FALSE)[,]

train.subject <- read.table(unz('har.zip', 'UCI HAR Dataset/train/subject_train.txt'), header=FALSE)[,]
test.subject <- read.table(unz('har.zip', 'UCI HAR Dataset/test/subject_test.txt'), header=FALSE)[,]

data <- rbind(train, test)[,grep("(mean|std)\\(\\)", features)]
data$activity <- factor(c(train.activity, test.activity), labels=activity)
data$subject <- c(train.subject, test.subject)
data.grouped <- group_by(data, activity, subject)
data.averages <- summarise_each(data.grouped, funs(mean))
write.table(data.averages, 'har_averages.txt', row.name=FALSE)
