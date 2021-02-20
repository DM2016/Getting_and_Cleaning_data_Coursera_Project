#Getting and Cleaning Data Final Project

#I. set up libraries and directories

library(tidyverse)
library(data.table)
library(readr)

main_path <- file.path("D:/Docker/Getting_cleaning_data/WK4/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/")
dir.train <- file.path(main_path, "train")
dir.test <- file.path(main_path, "test")
out.path <- file.path("D:/Docker/Getting_cleaning_data/WK4/getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/Results")

#Training data set
my_Xtrain0 <- read.table(file.path(dir.train, "X_train.txt"))
my_train_ycol0 <- read.table(file.path(dir.train, "y_train.txt"))
my_subj_train0 <- read.table(file.path(dir.train, "subject_train.txt"))

#Test data set
my_Xtest0 <- read.table(file.path(dir.test, "X_test.txt"))
my_test_ycol0 <- read.table(file.path(dir.test, "y_test.txt"))
my_subj_test0 <- read.table(file.path(dir.test, "subject_test.txt"))


#labels
my_labels0 <- read.table(file.path(main_path, "features.txt"))
my_act_labels0 <- read.table(file.path(main_path, "activity_labels.txt"))

###Objective 1
#Merges the training and the test sets to create one data set.
my_train <- cbind(my_subj_train0, my_train_ycol0, my_Xtrain0)
my_test <- cbind(my_subj_test0, my_test_ycol0, my_Xtest0)

my_merged_data <- rbind(my_test, my_train)


#add column names with the features.txt file
my_labels1 <- my_labels0 %>%
  select(V2)
         
my_labels2 <- rbind("subj_ids", "activity_names", my_labels1) 

colnames(my_merged_data) <- my_labels2$V2
my_merged_data

###Objective 2
#Extracts only the measurements on the mean and standard deviation for each measurement.
#extract subj_id, activity id and all mean and std measurements
my_merged_data1 <- my_merged_data %>%
  select(subj_ids, activity_names, contains("mean"), contains("std"))

#change activity labels in the second column
#first: get activity_labels.txt

##Objective 3
#Uses descriptive activity names to name the activities in the data set
my_merged_data1$activity_names <- my_act_labels0$V2[match(my_merged_data1$activity_names, my_act_labels0$V1)]
my_merged_data1

##Objective 4
#Appropriately labels the data set with descriptive variable names. 
#replace column names as necessary
names(my_merged_data1) <- gsub("\\()", "", names(my_merged_data1))
names(my_merged_data1) <- gsub("\\(", "", names(my_merged_data1))
names(my_merged_data1) <- gsub("\\,", ".", names(my_merged_data1))
names(my_merged_data1) <- gsub("\\)", "", names(my_merged_data1))
names(my_merged_data1) <- gsub("\\_", ".", names(my_merged_data1))
names(my_merged_data1) <- gsub("\\-", ".", names(my_merged_data1))
names(my_merged_data1) <- gsub("tB", "Time.B", names(my_merged_data1))
names(my_merged_data1) <- gsub("tG", "Time.G", names(my_merged_data1))
names(my_merged_data1) <- gsub("fB", "Freq.B", names(my_merged_data1))
names(my_merged_data1) <- gsub("fG", "Freq.G", names(my_merged_data1))
names(my_merged_data1)

##Objective 5
#create new tidy data set with subject ID and activities grouped,
# and the activities of each summarized and averaged

my_merged_data2 <- my_merged_data1 %>%
  group_by(subj.ids, activity.names) %>%
  summarize_all(mean, na.rm = TRUE)

#write out the results to my results file
write.table(my_merged_data2, file.path(out.path, "merged_test_train_tidy.txt"), row.name = F)



