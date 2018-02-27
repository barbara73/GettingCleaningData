# GettingCleaningData

## Description
In a first step, the data is loaded and both test.txt (with 2947 observations) and train.txt (with 7352 observation) merged to one data frame, i.e. the X_data contains the the mean and standard deviations among others and is of size 10299 x 561. The y_data containing the activities and the subj_data containing the subjects are also merged. The columns are renamed before merging the total data set.
In a second step, the mean and standard deviations are extractet. 
The final data is of size 10299 x 81, since I keep the mean frequency.

The second data frame is of size 180 x 81 and contains the mean of subjects and activities.
