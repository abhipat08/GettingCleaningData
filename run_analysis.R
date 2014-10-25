library(reshape2)

#geturl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(geturl, destfile = "getdata-projectfiles-UCI HAR Dataset.zip")
#unzip("getdata-projectfiles-UCI HAR Dataset.zip")

# open files in the test directory
test <- read.table("UCI HAR Dataset/test/X_test.txt", sep="")
st <- read.table("UCI HAR Dataset/test/subject_test.txt", sep="")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", sep="")

# open files in the train directory
trn <- read.table("UCI HAR Dataset/train/X_train.txt", sep="")
strn <- read.table("UCI HAR Dataset/train/subject_train.txt", sep="")
ytrn <- read.table("UCI HAR Dataset/train/y_train.txt", sep="")

labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Give names to columns in test and train
n1 <- read.table("UCI HAR Dataset/features.txt", sep="")
n1[,2] <- as.character(n1[,2])
colnames(test) <- n1[,2]
colnames(trn) <- n1[,2]
colnames(st) <- "volntr_number"
colnames(strn) <- "volntr_number"
colnames(ytest) <- "activity"
colnames(ytrn) <- "activity"

# 2) Extracts only the measurements on the mean and standard deviation for each 
# measurement - Select only required columns
cols <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,
          253,254,266:271,294:296, 345:350, 373:375, 424:429, 452:454, 503,
          504,516,517,526,529,530,539,542,543,552,555,556,557,558,559,560,561)
f_test <- test[,cols]
f_trn <- trn[,cols]

# create variable for type of data and bind to test data
f <- nrow(test)
volunteer_type <- rep("test", times=f)
testdata <- cbind(volunteer_type, st, ytest, f_test)

# create variable for type of data and bind to train data
g <- nrow(trn)
volunteer_type <- rep("train", times=g)
traindata <- cbind(volunteer_type, strn, ytrn, f_trn)

# 1) Merges the training and the test sets to create one data set
t_data <- rbind(testdata, traindata)

# 3) Uses descriptive activity names to name the activities in the data set
t_data$activity <- factor(t_data$activity, levels = c(1,2,3,4,5,6), 
                          labels = labels[,2])

# 5) From the data set in step 4, creates a second, independent tidy data set 
#  with the average of each variable for each activity and each subject.
newmelt <- melt(t_data, id=c("volunteer_type", "volntr_number","activity"))
newdat <- dcast(newmelt, volunteer_type+volntr_number+activity ~ variable, mean)
write.table(newdat, file="tidy_data.txt", row.name=FALSE, sep=" ")