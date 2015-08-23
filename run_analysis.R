
#loads requisite libararies
library("data.table")

#reading through various files and assigning suitable variable names

#1. Features contain name of 561 features. It is 561*2 dimension. First column is id
#   and second is feature name
features <- read.table("features.txt")

#Reads test data

# read values of test data 
X_test <- read.table("./test/X_test.txt")

# id of activities ranging from 1 to 6
Activity_test <- read.table("./test/y_test.txt")

# subject id of test data.. ranging from 1 to 30
subject_test <- read.table("./test/subject_test.txt")

#Reads training data

#  read values of training data
X_train <- read.table("./train/X_train.txt")

# reads activity id of train data . range is 1 to 6 
Activity_train <- read.table("./train/y_train.txt")

# reads subject id of training data.
subject_train <- read.table("./train/subject_train.txt")

# TIME FOR MERGING DATA

#Merges data from test and train data.
X <- rbind(X_test,X_train)

#Merges subject id from test and train data
subject <- rbind(subject_test,subject_train)

#merges activity id from test and train data
activityId <- rbind(Activity_test,Activity_train)


#LET US NAME THEM.

#column naming the merged data.
colnames(X) <- read.table("features.txt")[,2] #[,2] because the SECOND column is name column

#column naming the column with subjectid as "subject id" 
colnames(subject) <- "SubjectId"

#column naming the column with activityid as "activity id"
colnames(activityId) <- "ActivityId"

#TIME TO HUNT COLUMNS WITH MEAN OR STD. DEVIATION

#Finds the index where mean or std words are present in feature name
meanStdValues <- grep("mean\\(\\)|std\\(\\)",features[,2])

#subsetting the column where mean or std words are found
X_meanStd <- X[,meanStdValues]

#Writing good column names
names(X_meanStd) <- gsub("\\(\\)", "", features[meanStdValues, 2]) # remove "()"
names(X_meanStd) <- gsub("mean", "Mean", names(X_meanStd)) # capitalize M
names(X_meanStd) <- gsub("std", "Std", names(X_meanStd)) # capitalize S
names(X_meanStd) <- gsub("-", "", names(X_meanStd)) # remove "-" in column names


#Descriptive Labelling
activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) #lowers the label name
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) #removes _ from walking_upstairs
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) #removes "_" from walking_downstairs
activityLabel <- activity[activityId[, 1], 2] #picks corresponding activity label to activityId
activityId[, 1] <- activityLabel #replaces name of activityId with activity
names(activityId) <- "activity"


names(subject) <- "subject"   #column name of subject as "subject"

#combining Subject, activityId and data to form a clean dataframe.
cleanedData <- cbind(subject, activityId, X) 

#writing clean data to a file.
write.table(cleanedData,"clean_data.txt")

#second dataframe containg mean and standard deviation of each measurement
dataDT <- data.table(cleanedData)
calculatedData<- dataDT[, lapply(.SD, mean), by=c("subject", "activity")]
write.table(calculatedData, "calculated_data.txt")

#####THE END####
