Assn3
=====

Getting and Cleaning Data - Assignment 3

 - Script starts by loading the reshape2 library for melt function. Please install reshape2 package before running script
 - All necessary data is being read into memory -> Test and Training Data
 - The activity ID and subject ID are then binded to the data
 - Using the grep function, the columns with "mean" and "std" are split and put into a separate table
 - These are then merge to form a new table with mean and std
 - The data is then melted to stack all the columns on top of each other to get ready for casting
 - "dcast" is then used to get the the average of each variable for each activity and each subject
