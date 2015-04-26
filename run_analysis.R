
##1. Merges the training and the test sets to create one data set.
## merge x test and train data into xData
xtest <- read.table("test/X_test.txt")
xtrain <- read.table("train/X_train.txt")
xData <- rbind(xtest,xtrain)

##mege y test and train data into yData
ytest <- read.table("test/y_test.txt")
ytrain <- read.table("train/y_train.txt")
yData <- rbind(ytest,ytrain)

##merge subject test and train data into sData
stest <- read.table("test/subject_test.txt")
strain <- read.table("train/subject_train.txt")
sData <- rbind(stest,strain)


##2. Extracts only the measurements on the mean and standard deviation for each measurement. 

featuresData<- read.table("features.txt")

## match on column names by string std, mean 
reqFeatureIndices <- grep("-std\\(\\)|-mean\\(\\)", featuresData[,2])
xData <- xData[,reqFeatureIndices]
names(xData) <- featuresData[reqFeatureIndices,2]
names(xData) <- gsub("\\(|\\)","",names(xData))
names(xData) <- tolower(names(xData))

##3. Uses descriptive activity names to name the activities in the data set
activitiesdData <- read.table("activity_labels.txt")
activitiesdData[,2] <- gsub("_","",tolower(as.character(activitiesdData[,2])))
yData[,1] = activitiesdData[yData[,1],2]
names(yData) <- "activity"


##4. Appropriately labels the data set with descriptive variable names. 
names(sData) <- "subject"
cleanedData <- cbind(sData,yData,xData)
##for internal debug purposes, writing cleaned data to text file
write.table(cleanedData,"step4_merged_cleaned_data.txt")

##5. From the data set in step 4, creates a second, 
##independent tidy data set with the average of each variable for each activity and each subject.

distinctSubjects <- unique(sData)[,1]
subjectsCount <- length(unique(sData[,1]))
activityCount <- length(activitiesdData[,1])
colCount <- dim(cleanedData)[2]

##initialize the final output data structure
outputData = cleanedData[1:(subjectsCount*activityCount),]
rowIndex = 1

##for each of the subject and for each of the activity, build the final output data structure with subject, activity and mean data
for (sIndex in 1:subjectsCount){
        for(aIndex in 1:activityCount){
                outputData[rowIndex, 1] = distinctSubjects[sIndex]
                outputData[rowIndex, 2] = activitiesdData[aIndex,2]
                tempData <- cleanedData[cleanedData$subject==sIndex & cleanedData$activity ==activitiesdData[aIndex,2],]
                ##calculates the average of each variable for each activity and each subject
                outputData [rowIndex,3:colCount] <- colMeans(tempData[,3:colCount])
                rowIndex = rowIndex + 1
        }
}

## write the final output data to file "step5_final_data_output.txt" with row.names turned off as instructed.
write.table(outputData, "step5_final_data_output.txt", row.names=FALSE)
        
