
Download the data from the following source and extact it to your R working folder

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Open the run_analsis.R script in R(Version:3.1.1)
Run the code. The final data file tidy_data.txt is saved in your working folder.

The code goes through the following steps.

1.Reading the features.txt file to get the variable names. The features.txt has one variable with 561 rows with
the variable names.

2.Editing the variable names to remove special characters and also identifying the mean and std variables.
New descriptive variable names are created and the mean and standard deviation variables are created.


3.Reading the activity labels file. The activity lables file has 2 columns and 6 rows. It associated  descriptive activity
names to the activity ID.

4.Reading the X_test, Y_test  and subject_test files

The X_test file has 561 columns and 2947 rows.
The subject_test file has the subject ID corresponding to the 2947 rows.
The Y_test file has the activities corresponding to the 2947 rows.


The X_train file has 561 columns and 7352 rows.
The subject_train file has the subject ID corresponding to the 2947 rows.
The Y_train file has the activities corresponding to the 2947 rows.


#putting it all together
Train and Test files are merged together and appended to form a dataset with 10299 rows.
The dataset is subsetted to have only the mean and the standard deviation variable.

Finally the Mean of the subsetted variables is calculated and put into the tidy_means file.
subset_all_mean_std_vars= all_withactivity[,c('activity','subject_id',varnames$newvarname[varnames$mean_std_var==TRUE])]
tidy_means=aggregate(.~activity + subject_id, data=subset_all_mean_std_vars,FUN = mean,na.rm = TRUE, na.action="na.pass") 
The final dataset has 180 observations and 68 variables. The final dataset is written to the working directory as tidy.txt datafile.

