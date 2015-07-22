download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'har.zip')

features <- read.table(unz('har.zip', 'UCI HAR Dataset/features.txt'), row.names=1, stringsAsFactors=FALSE, header=FALSE)[,]
activity <- read.table(unz('har.zip', 'UCI HAR Dataset/activity_labels.txt'), row.names=1, header=FALSE)[,]

train <- read.table(unz('har.zip', 'UCI HAR Dataset/train/X_train.txt'), col.names=features, header=FALSE)
train.activity <- read.table(unz('har.zip', 'UCI HAR Dataset/train/y_train.txt'), header=FALSE)[,]
train$subject <- read.table(unz('har.zip', 'UCI HAR Dataset/train/subject_train.txt'), header=FALSE)[,]
train$activity <- factor(train.activity, labels=activity)

test <- read.table(unz('har.zip', 'UCI HAR Dataset/test/X_test.txt'), col.names=features, header=FALSE)
test.activity <- read.table(unz('har.zip', 'UCI HAR Dataset/test/y_test.txt'), header=FALSE)[,]
test$subject <- read.table(unz('har.zip', 'UCI HAR Dataset/test/subject_test.txt'), header=FALSE)[,]
test$activity <- factor(test.activity, labels=activity)

columns <- features[grep("(mean|std)\\(\\)", features)]
columns <- append(columns, c("activity", "subject"))
data <- rbind(train, test)[,columns] # broken because God knows why
#data.metrics <- ???