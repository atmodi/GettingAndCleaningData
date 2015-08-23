CodeBook
========
Introduction
------------
This codebook contains the information about the variables, the data, and transformations or work that are performed to clean up the data.   
The data is obtained from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and information about this data is available is [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  
This analysis is done for Getting And Cleaning Data of Data Science specialization offered by Bloomberg School of Public Health at John Hopkins University.
### How to reproduce the output?
Download the dataset and unzip it. Most probably the folder containing this files would be called UCI HAR Dataset. Make this folder as working directory. The following section will explain what was done in the code. The code is availabe at [run_analysis.R](https://github.com/atmodi/GettingAndCleaningData/blob/master/run_analysis.R).


### Code
The overall code can be divided into various segments.
1. Loading required libraries.
2. Loading the data in suitable vectors with appropriate naming.
3. Merging test and training data
4. Naming the columns
5. Descriptive labelling of Activities
6. Combining Data
7. Obtaining another data file that is only mean value and standard devialtion of measurements.

### Variables
There are 561 variables for different measurement. Names of all 561 variables are available in the [file](https://github.com/atmodi/GettingAndCleaningData/blob/master/features.txt) by Samsung.  
Other two variables are:  
* subjectId: 1 to 30 each representing a participant in the study
* activity: the activity that the subject was doing at the time of the measurement

Thus, our data has total **563** columns. Each column refers to one measurement value and one row to one observation. 