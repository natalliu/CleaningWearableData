# CleaningWearableData
Getting and Cleaning Data Course Project: R script creating tidy data set out of Samsung wearable data.


##Objective: 

The goal of this project is to transform data collected from the accelerometers from the Samsung Galaxy S smartphone 
into tidy dataset with the average of body acceleration for each activity and each subject.
Script run_analisys.R works with original data taken from this link 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and create file tidyData.txt with tidy data set.

##Steps to get tidy data:

1. Download original data and extract all files into some folder on the computer: C:\MyFolder
Folder C:\MyFolder\UCI HAR Dataset will be created after extraction. 
2. Set working directory in RStudio to C:\MyFolder\UCI HAR Dataset
3. Copy file run_analisys.R into working directory
4. Install and attach dplyr package: install.packages("dplyr"); library("dplyr")
5. Run script with command source("run_analisys.R")
6. Ignore message "There were 50 or more warnings (use warnings() to see the first 50)"
7. Find resulting file "tidyData.txt" in the working directory


##What run_analisys.R script does?


1. Reads the following 8 data files into memory:

	* subject Ids of test and train data for each observation

	  * /UCI HAR Dataset/test/subject_test.txt
	  * /UCI HAR Dataset/train/subject_train.txt

	* labels of test and train data for each observation 

	  * /UCI HAR Dataset/test/y_test.txt
	  * /UCI HAR Dataset/train/y_train.txt

	* test and train data sets (features of body acceleration for each observation)

	  * /UCI HAR Dataset/test/X_test.txt")
	  * /UCI HAR Dataset/train/X_train.txt")

	* labels mapping to activities names
 
	  * /UCI HAR Dataset/activity_labels.txt

	* features names 

	  * /UCI HAR Datase/features.txt

2. Changes labels given as numbers to corresponding strings that are descriptive activity names
like "LAYING", etc, using function  activityNames(label_test,activities). Code for this function
located inside the main script file run_analisys.R

3. After reading data script makes a sanity check that 
	* there are 561 features (columns) in the data sets
	* subject_test.txt, y_test.txt and X_test.txt have the same number of observations (rows)
	* subject_train.txt, y_train.txt and X_train.txt have the same number of observations (rows)

4. We want to extract only the measurements on the mean and standard deviation for each measurement.
Assuming that these measurements have "mean()" or "std()" substrings in their full names, we 
extract serial numbers of the corresponding columns using file UCI HAR Datase/features.txt. 
Then we create new subsets of test and train data that hold only columns corresponding to selected set of numbers.

5. As the original data sets did not have meaningful column names we will add them to data frames.

6. Merge  subject_test.txt, y_test.txt and X_test.txt horizontally into one table adding subject and activity 
for each observation 

7. Do the same for train data: merge subject_train.txt, y_train.txt and X_train.txt into one table

8. Merge test and train data set vertically into one table. Number of records in this table should be 
the sum of record numbers in test and train data sets

9. create a second, independent tidy data set with the 
average of each variable for each activity and each subject. This will add 2 new columns to the table
meaning subjectId and activity to  the first and second place and make 2 last columns meaningless.

10. Remove last 2 columns

11. Change the column names to reflect their new meaning. We add string mean- to every feature column
and change first column name from default to "subjectId" and second from default to "activity"

12. Export tidy data set to the file "tidyData.txt" located in the working directory.









