# GCDAssessment
Getting and Cleaning Data Course Project

This repository includes the following:

* **har.zip**: the raw data set collected from Samsung Galaxy S II accelerometers.
* **har_averages.txt**: the average means and standard deviations for all signals recorded, by subject and activity.
* **CodeBook.md**: a code book describing each of the variables in the final data set.
* **run_analysis.R**: an R script responsible for processing the raw data contained in `har.zip` (already included here). It merges the training and test data, applies the appropriate labels, filters the mean and standard deviation signals, calculates the averages for all of them and returns the summarized tidy data on `har_averages.txt`.