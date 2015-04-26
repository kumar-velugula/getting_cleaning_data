---
title: "README.md"
author: "Kumar Velugula"
date: "April 25, 2015"
output: html_document
---
# Overview

This markdown file explains how the run_analysis.R script works and how to run the script to generate the final output data file "step5_final_data_output.txt".

# Setup
Download below project's source data zipfile and extract to your working directory.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Extracted directory name is "UCI HAR Dataset"

Place run_analysis.R file inside the above extracted directory and open the run_anaysis.R file from the R Studio to view and run the script using Run button click.

# run_analysis.R script execution details

1. Towards creating a combined data set of both test and train data files, x, y and subject data files from respective folders are first read into tables and then combined using rbind into x,y and subject data tables

2. To extract those features that contain mean and std, loaded the features.txt file into table. Used grep to match on those string literals and assigned to the column names of xData table

3. To use descriptive activity names,activity_lables.txt file is loaded into table and swapped out the yData column indices with activity descriptive text 

4. To appropriately name the data set with descriptive variables, above resolved subject, y and x data is column bound into cleanedData. Just for debugging purpose, cleanedData is written to step4_merged_cleaned_data.txt (this is not a required step). This is the first tidy data set.

5. To create final tidy set with calculation of average of each variable for each subject and activity, used 2 loops to iterate through each unique subject and activity, created output data row. For each of the output data row, mean of the variable is calculated and updated along with subject and activity data.
Output data strucure is written to file "step5_final_data_output.txt" using write.table with row names turned off. 
To read the file, use read.table("step5_final_data_output.txt") and the data frame has 180 observations of 68 variables.







