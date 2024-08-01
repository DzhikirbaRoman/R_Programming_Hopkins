# Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project
---
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

1. Review criteria The submitted data set is tidy. 
2. The Github repo contains the required scripts. 
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information. 
4. The README that explains the analysis files is clear and understandable. 
5. The work submitted for this project is the work of the student who submitted it.

## Getting and Cleaning Data Course Project 
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## You should create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

---

From Question1: Please upload the tidy data set created in step 5 of the instructions. Please upload your data set as a txt file created with write.table() using row.name=FALSE (do not cut and paste a dataset directly into the text box, as this may cause errors saving your submission).

From Evaluation: Has the student submitted a tidy data set? Either a wide or a long form of the data is acceptable if it meets the tidy data principles of week 1 (Each variable you measure should be in one column, Each different observation of that variable should be in a different row).

From Question2: Please submit a link to a Github repo with the code for performing your analysis. The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory. The output should be the tidy data set you submitted for part 1. You should include a README.md in the repo describing how the script works and the code book describing the variables.

From Evaluation2: Github Repo with Required Scripts

Code Book From Overview: A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

README I have included a README.md in the repo with my scripts. This repo explains how all of the scripts work and how they are connected.

## For 1st tiny data set: 
1. Read data sets and combine them. 
2. Read subjects and combine them. 
3. Read data labels and combine them. 
4. Read features list and subset only std and mean features from tis list. 
5. Perform same subset on data set. 
6. Rename features to be more human readable. 
7. Read activity list and rename activities to be more human readable.
8. Rename data labels with activity name.
9. Merge data, subjects, and labels to single tiny data set.
10. Write tiny data set to file 
## For 2nd tiny data set: 
1. Average of measurement for activity and subject.
2. Prepare empty data set of appropriate length. 
3. "for" Loop through subjects, then subloop through activities.
4. For each activity in a subject, get the full list of measurements.
5. Calculate the mean of each of these activities.
6. Place the means in subsequent columns of the subject/activity row.name. 
7. Write second tiny data set to file.

---

Obtain the raw data sets and put them in the working directory (via Rstudio).
The following steps were performed in a Laptop running the operation system Window 10. The data cleaning processes were performed in Rstudio with R version 4.1.1

The raw data downloaded from the following website: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Using the following R command to download the data and set up working directory:

```
getwd()
# Use should write path to your Dir
data.path <- file.path(getwd(),"Project_Course3")

#dir.create(data.path)
setwd(data.path)
Data <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "ProjectData.zip") 
```
## Unzip the raw data sets and set up file pathes to train and test Data 

```
# Unzip a file
unzip("ProjectData.zip", exdir = getwd())
list.files(file.path(getwd(),"UCI HAR Dataset"))
dataset_dir <- file.path(getwd(),"UCI HAR Dataset")
test_dir <- file.path(dataset_dir,"test")
train_dir <- file.path(dataset_dir,"train")
```

```
> getwd()
[1] "C:/__myInfo__/R_Programming_Hopkins/R_Programming_Hopkins/Project_Course3"
```

## Create a tidy data via a R script called run_analysis.R Preparation: data sets and script
The data sets and run_analysis.R must be in the working directory. It is based on one of the requirements this project: The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory. (see "Instructions and Requirements")

The input raw data for the run_analys.R are:

```
./train/X_train.txt, ./train/y_train.txt, subject_train.txt;
./test/X_test.txt, ./test/y_test.txt,  subjecct_test.txt;
./activity_labels.txt, ./features.txt
```

The output tidy data created from run_analysis.R are:

```
./tidy_average_data.txt (180 rows)
./combinedcleaningdata.txt (optional)
```

How the script run_analysis.R works via Rstudio

usage:

```
 > source("run_analysis.R") ## load the script
 > run_analysis() ##run the script
```

## There are 5 main steps in run_analysis.R to process the raw data sets and create the tidy data set.

Step-0: Reminder -- to install special package "reshape2". It is necessary to install and to load the package "reshape2" before to perform any processes.

Step-1: Merges the training and the test data sets to create one data set (such as): Load and read the input raw sets; merge three pairs data set (e.g.: X_train.txt, X_test.txt; y_train.txt, y_test.txt; subject_train.txt, subject_text.txt) into three single data set via "rbind" function.

Setp-2: Extracts only the measurements on the mean and standard deviation for each measurement. This step is mainly done by the "grep" function by providing the key search patterns "-mean()|-std()".

```
++ column names from the data sets were changed into lower-case to avoid any uncessary typos
 (based on the intruction from the "Week4 slide-notes: Editing Text Variables" from 
 Coursera course Getting and Cleaning Data); characters "()" were replaced "" and
 characters "-" was replaced to "." via "gsub" function.
```

Step-3: Uses descriptive activity names to name the activities in the data set. This step is mainly to produce a one-column data frame called "joinlabel" containing descriptive activity names.

Step-4: Appropriately labels the data set with descriptive activity names. The step is mainly to combine three joined data frames into one data frame called "cleandata". This is the first cleaned data frame toward to the final tidy data set. An (optional/temporary) output file is created called "combinedcleandata.txt" just in case for an emergency.

Step-5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```
+ It is necessary to install and to load the package "reshape2" before to perform
any processes.

+ The final tidy data frame called "tidydfrm" via "melt" function and then "dcast" function.

+ Finally, a file called "tidyDataSet.txt" was created via "write.table" function.
  This is the final output tidy processed data.

+ The detailed description of the "tidyDataSet.txt" and the given raw data set
  are in "CodeBook.md" file.
```

====================================================================================================

Acknowledgement Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

License Using the tidy data set "tidyDataSet.txt" in publications must be acknowledged by reference the publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

==========================================================================================================