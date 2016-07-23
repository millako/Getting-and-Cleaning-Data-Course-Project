Introduction

The script run_analysis.R performs the download and uzipping of the source data file and five(5) steps described in the course project's definition.

Once the source file is brought from a website to the local server, first, all the similar data is merged using the cbind() and rbind() functions. By similar, we address those files having the same number of columns and referring to the same entities.
Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
On the whole dataset, those columns with vague column names are corrected.
Finally, we generate a new dataset with all the average measures for each subject and activity type. The output file is called secTidySet.txt, and uploaded to this repository.

Variables
x_train,
y_train,
x_test,
y_test,
subject_train,
subject_test contain the data from the downloaded files.

