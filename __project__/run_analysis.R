# You will be required to submit: 
# 1) a tidy data set as described below 
# 2) a link to a Github repository with your script for performing the analysis 
# 3) a code book that describes the variables, the data, and any transformations 
#    or work that you performed to clean up the data called CodeBook.md. 

# You should also include a README.md in the repo with your scripts. This repo 
# explains how all of the scripts work and how they are connected.

#### 1. Merges the training and the test sets to create one data set.
# Data:
train.Data <- read.table("./train/X_train.txt")
test.Data <- read.table("./test/X_test.txt")
full.Data <- rbind(train.Data, test.Data)
# Labels
train.Labels <- read.table("./train/y_train.txt")
test.Labels <- read.table("./test/y_test.txt")
full.Labels <- rbind(train.Labels, test.Labels)
# Subject
train.Subject <- read.table("./train/subject_train.txt")
test.Subject <- read.table("./test/subject_test.txt")
full.Subject <- rbind(train.Subject, test.Subject)


#### 2. Extracts only the measurements on the mean and standard deviation for 
####    each measurement
features <- read.table("./features.txt")
# The grep function takes your regex as the first argument, and the input 
# vector as the second argument. If you pass value=FALSE or omit the value 
# parameter then grep returns a new vector with the indexes of the elements 
# in the input vector that could be (partially) matched by the regular 
# expression.
# Then we look for patterns like: -mean() or -std(), i.e. -mean\\(\\)|-std\\(\\)"
indices_matching <- grep("-mean\\(\\)|-std\\(\\)", tolower(features[, 2]), value=FALSE)
full.Data <- full.Data[, indices_matching]
names(full.Data) <- tolower(features[indices_matching, 2])


#### 3. Uses descriptive activity names to name the activities in the data set.
activities <- read.table("./activity_labels.txt")
activities[, 2] <- tolower(activities[,2])
# We "create" a vector of the acivities names using the vector of activities
full.Labels[,1] <- activities[full.Labels[,1], 2] 
names(full.Labels) <- "Activity"


#### 4. Appropriately labels the data set with descriptive activity names.
names(full.Subject) <- "Subject"
Tidy.Data <- cbind(full.Subject, full.Labels, full.Data)
write.table(Tidy.Data, "./merged_tidy_data.txt")


#### 5. Creates a second, independent tidy data set with the average of each 
####    variable for each activity and each subject.
id <- c("Subject", "Activity")
measure_vars <- setdiff(colnames(Tidy.Data), id_vars)
# id.vars:  
# vector of id variables. Can be integer (variable position) or string 
# (variable name). If blank, will use all non-measured variables.
# measure.vars:	
# vector of measured variables. Can be integer (variable position) or string 
# (variable name)If blank, will use all non id.vars
melted_data <- melt(Tidy.Data, id=id, measure.vars=measure_vars)
# And we want the average of each varaiable for each activity and each subject
Tidy.Data.Mean <- dcast(melted_data, Activity + Subject ~ variable, mean)
write.table(Tidy.Data.Mean, "./merged_tidy_data_mean.txt")


