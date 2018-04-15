labels <- read.table("features.txt") # names for columns, for measures
activitynames_test <- read.table("./test/y_test.txt") # names for rows, for activities, test set
activitynames_train <- read.table("./train/y_train.txt") # names for rows, for activities, train set
test <- read.table("./test/X_test.txt", col.names = labels[,2]) # reading test data set with columns names
train <- read.table("./train/X_train.txt", col.names = labels[,2]) # reading train data set with columns names

# set significant names for activitynames_test

for (i in 1:2947) {
  
  if (activitynames_test[i,] == 1) activitynames_test[i,] <- "WALKING"
  if (activitynames_test[i,] == 2) activitynames_test[i,] <- "WALKING_UPSTAIRS"
  if (activitynames_test[i,] == 3) activitynames_test[i,] <- "WALKING_DOWNSTAIRS"
  if (activitynames_test[i,] == 4) activitynames_test[i,] <- "SITTING"
  if (activitynames_test[i,] == 5) activitynames_test[i,] <- "STANDING"
  if (activitynames_test[i,] == 6) activitynames_test[i,] <- "LAYING"
  i<- i+1
  
}

# set significant names for activitynames_train

for (i in 1:7352) {
  
  if (activitynames_train[i,] == 1) activitynames_train[i,] <- "WALKING"
  if (activitynames_train[i,] == 2) activitynames_train[i,] <- "WALKING_UPSTAIRS"
  if (activitynames_train[i,] == 3) activitynames_train[i,] <- "WALKING_DOWNSTAIRS"
  if (activitynames_train[i,] == 4) activitynames_train[i,] <- "SITTING"
  if (activitynames_train[i,] == 5) activitynames_train[i,] <- "STANDING"
  if (activitynames_train[i,] == 6) activitynames_train[i,] <- "LAYING"
  i<- i+1
  
}

subject_test <- read.table("./test/subject_test.txt") # subjects for test set
subject_train <- read.table("./train/subject_train.txt") # subjects for train set

test["subject"] <- subject_test # add subjects to test data set
train["subject"] <- subject_train # add subjects to train data set

test<-cbind(activitynames_test, test) # add significant names for activities
names(test)[1] <- "activity"   # rename column

train<-cbind(activitynames_train, train) # add significant names for activities
names(train)[1] <- "activity"  #rename column

common_set <- merge(test, train, all = TRUE) # merge train and test sets, create one, common data set 

# select only mean and standart deviation for each measurement
mean_and_sd <- select(common_set, "activity", "subject", contains(".mean.."), contains(".std.."))

# figure out mean values
common_meanvalues <- group_by(common_set, activity, subject) %>% summarise_all(mean)
