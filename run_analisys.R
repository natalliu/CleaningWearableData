##file "run_analisys.R"

##Pre-requisite:
##script need to be run in the working directory "UCI HAR Dataset"
##of the original data collected from the accelerometers 
##from the Samsung Galaxy S smartphone located at
##https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Objective: 
##This script merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation 
##for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##Creates a second, independent tidy data set with the average of each 
##variable for each activity and each subject.

##Steps:
##read "subject_test.txt"/"subject_train.txt" to create 
##Id_test/Id_train vectors containing identifies (Subject Id) 
##of the subject who performed the activity 
##Its range is from 1 to 30.

id_test<-read.table("./test/subject_test.txt")
id_train<-read.table("./train/subject_train.txt")

##read "y_test.txt"/"y_train.txt" to create vectors 
##to hold test/train labels that map to activities 

label_test<-read.table("./test/y_test.txt")
label_train<-read.table("./train/y_train.txt")

##read table that maps numbers in label_test/train to activities names 
activities<-read.table("activity_labels.txt")

##function that will create vector of activity names corresponding
##to label_test vector of numbers
activityNames<-function(label_test,activities) {
        names<-NULL
        for(i in seq_along(label_test[[1]])){
                pos<-which(activities[1]==label_test[[1]][i])
                names<-c(names,as.character(activities[[2]][pos]))
        }
        return(names)
}
##create vector activity_test corresponding to label_test
activity_test<-activityNames(label_test,activities)

##create vector activity_train corresponding to label_train
activity_train<-activityNames(label_train,activities)

## create objects to hold test and train sets
x_test<-read.table("./test/X_test.txt")
x_train<-read.table("./train/X_train.txt")

##check that both test and train sets have 561 columns of features
if(ncol(x_test) != 561) stop('number of columns is not equal to 561 in x_test')
if(ncol(x_train) != 561) stop('number of columns is not equal to 561 in x_train')

#calculate number of observations (rows) in test set
ntest<-nrow(id_test)
## check that x_test and label_test have the same number of rows as sub_test
if(ntest != nrow(x_test))  stop('X_test and id_test have different row numbers')
if(ntest != nrow(label_test))  stop('label_test and id_test have different row numbers')

#calculate number of observations (rows) in train set
ntrain<-nrow(id_train)
## check that x_train and label_train have the same number of rows as sub_train
if(ntrain != nrow(x_train))  stop('X_test and id_test have different row numbers')
if(ntrain != nrow(label_train))  stop('label_test and id_test have different row numbers')

## read features names into vector
features<-read.table("./features.txt")

## subset feature names that contain "mean()" or "std()" substrings.
##We assume that only these features contain measurements on the mean 
##and standard deviation for each measurement
##we get number vector of positions in feature vector that we are interested in
sub_f<-grep("mean()|std()",features$V2)

##pick up corresponding feature names itself to make column names
sub_names<-grep("mean()|std()",features$V2,value=TRUE) 

## subset test and train sets to extract only columns with mean() and std() measurements
x_sub_test<-x_test[,sub_f]
x_sub_train<-x_train[,sub_f]

##change default column names to actual meaningful column names
colnames(x_sub_test)<-sub_names
colnames(x_sub_train)<-sub_names

##add id_test and activity_test vectors as a columns to x_sub_test
##this will add subject Id and activity to each record
x_sub_test$subjectId<-id_test[[1]]
x_sub_test$activity<-activity_test

##add id_train and activity_train vactors as a columns to x_sub_train
##this will add subject Id and activity to each record
##using different code because id_train is data frame while
##activity_train is vector
x_sub_train$subjectId<-id_train[[1]]
x_sub_train$activity<-activity_train

#Merges the training and the test sets to create one data set 
x_sub<-rbind(x_sub_test, x_sub_train)
nrow(x_sub)

## creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject.
aggdata <-aggregate(x_sub, 
                    by=list(x_sub$subjectId,x_sub$activity),
                    FUN=mean)

##remove 2 last columns that now are meaningless
aggdata<-aggdata[,-c(82,83)]
## rename all others column names by adding "mean-"
##at the beginning of old names becaus now all columns except 1st and 2d
## are mean per subject and activity
colnames(aggdata)<-paste("mean-",colnames(aggdata),sep="")
## rename 2 new columns to  subjectId and activity
colnames(aggdata)[1]<-"subjectId"
colnames(aggdata)[2]<-"activity"

## write tidy data to the file
write.table(aggdata,"tidyData.txt", row.names=FALSE)
