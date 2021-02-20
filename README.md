# Getting_and_Cleaning_data_Coursera_Project
Final Project Code

#Getting and Cleaning Data Final Project

# I. set up libraries and directories
#lines 3 to 13 set up the libraries and directories

# II. Read the datasets in
#lines 15 to 31 read the datasets and labels into R studio

# III. Complete assignment objectives
#lines 33 to 86 address each assignment objective:
  -Objective 1: Merges the training and the test sets to create one data set. (lines: 36-49)
    used rbind and cbind to accomplish this, also renamed column variable names here
  -Objective 2: Extracts only the measurements on the mean and standard deviation for each measurement. (lines: 54-55)
    used tidyverse select and contains for this
  -Objective 3: Uses descriptive activity names to name the activities in the data set. (lines: 62-63)
    used the function match to accomplish this
  -Objective 4: Appropriately labels the data set with descriptive variable names. (lines: 68-78)
    used gsub multiple times to accomplish this
  -Objective 5: Create new tidy data set with subject ID and activities grouped, and the activities of each summarized and averaged (lines: 84-86)
    used group_by and summarize_all to accomplish this
 
 # IV. Write out Results
 #lines: 91
 #write out the results to my results file
  used write.table, file.path and set row.names to FALSE
  
