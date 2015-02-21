#Data cleaning

==================================================================
 
Cleaning of Activity Recognition data originally obtained and 
shared by the team of Università degli Studi di Genova
(Code Book about their data appended below).

==================================================================

Performed by Natallia Usava for "Getting and Cleaning Data"
Course Project at Coursera, lead by instructor Jeff Leek, PhD

==================================================================

This work has be done on 
- Samsung Electronic laptop,
- Windows 7 Home Premium OS, 
- RStudio Version 0.98.1091

==================================================================

##Study design:

==================================================================
 
1. The following data files of the original data

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
has been used to produce the tidy data set - table in the file "tidyData.txt":

- subject Ids of test and train data for each observation
  - /UCI HAR Dataset/test/subject_test.txt
  - /UCI HAR Dataset/train/subject_train.txt

- labels of test and train data for each observation 

  - /UCI HAR Dataset/test/y_test.txt
  - /UCI HAR Dataset/train/y_train.txt

- test and train data sets (features of body acceleration for each observation)

  - /UCI HAR Dataset/test/X_test.txt")
  - /UCI HAR Dataset/train/X_train.txt")

- labels mapping to activities names 
  - /UCI HAR Dataset/activity_labels.txt

- features names 
  - /UCI HAR Datase/features.txt


==================================================================


2. The following transformations with original data has been performed:

- labels given as numbers were changed to corresponding strings that are descriptive activity names
  like "LAYING", etc. We used labels mapping to activities names given in the file
  /UCI HAR Dataset/activity_labels.txt

- We produced a subsets from the test and train data sets by extracting only measurements 
  on the mean and standard deviation for each measurement. We assumed that these 
  measurements can be identified by the presence of the strings "mean()" or "std()" in 
  corresponding column names given in the /UCI HAR Datase/features.txt 

- subject Ids, labels and subsets of original data sets were merged horizontally into one table.
  This was done separately for test and train data 

- 2 tables holding test and train data obtained by horizontal merge were further merged
  vertically to get combined data set of both test and trained data.

- From the combined data set we created a second, independent tidy data set with the average
  of each variable for each activity and each subject.

- We assigned a new column names to the tidy data sets that reflect the fact that measurements were
  further averaged per subjectId and activity. The new column names for features of body acceleration
  were formed by prefixing old feature names with string "mean-"

- the tidy data set with meaningful column names was saved in the file tidyData.txt

==================================================================

##Code book:

==================================================================

- First column in the tidyData.txt is subject Id, which a consecutive numbers from 1 to 30
- Second column is an activity performed by the subject. There are 6 activities coded
  with corresponding meaninful strings: 
  - SITTING
 
  - STANDING
  - LAYING 
  - WALKING
,
  - WALKING_UPSTAIRS

  - WALKING_DOWNSTAIRS
 


- Columns from 3d to 81st contain measurements of selected feature set of the acceleration signal
averaged per subject and activity. Features were normalized and bounded within [-1,1]
in the original work. Old variable names for the features were prefixed with string "mean-"

- The selected feature set consist of Mean value(mean()) and Standard deviation(std()) 
of 3-axial signals in the X,Y,Z directions for each of the following patters:

  - tBodyAcc-XYZ
  - tGravityAcc-XYZ
  - tBodyAccJerk-XYZ
  - tBodyGyro-XYZ
  - tBodyGyroJerk-XYZ
  - tBodyAccMag
  - tGravityAccMag
  - tBodyAccJerkMag
  - tBodyGyroMag
  - tBodyGyroJerkMag
  - fBodyAcc-XYZ
  - fBodyAccJerk-XYZ
  - fBodyGyro-XYZ
  - fBodyAccMag
  - fBodyAccJerkMag
  - fBodyGyroMag
  - fBodyGyroJerkMag

(pattern description is given in the original code book below)

=========================================

The new dataset includes the following files:

- README.md - steps to automatically reproduce tidi data set
- CodeBook.md - describes how data were collected and transformed,
		meaning of each variable and its units
- run_analisys.R - script to automatically reproduce new data set
- tidyData.txt

==================================================================
 

##original CodeBook

###Human Activity Recognition Using Smartphones Dataset
Version 1.0

==================================================================

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws  www.smartlab.ws

==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

==================================================================

####For each record it is provided:


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

==================================================================

####The dataset includes the following files:


- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

==================================================================

####Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

==================================================================

####License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.