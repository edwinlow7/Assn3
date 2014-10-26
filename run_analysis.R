library(reshape2)
ActivityLabels<-read.table("./activity_labels.txt",col.names=c("activity_id","activity_name"))

#Get Feature Names
features<-read.table("features.txt")
FeatureNames<- features[,2]

#Read Test Data
TestData<-read.table("./test/X_test.txt")
colnames(TestData)<-FeatureNames

#Read Training Data
TrainData<-read.table("./train/X_train.txt")
colnames(TrainData)<-FeatureNames

###########################################

#Get id of the test subjects
test_subject_id <- read.table("./test/subject_test.txt")
colnames(test_subject_id) <- "subject_id"
        
#Get activity id of test data
test_activity_id <- read.table("./test/y_test.txt")
colnames(test_activity_id) <- "activity_id"
        
#Get ids of the test subjects(training data)
train_subject_id <- read.table("./train/subject_train.txt")
colnames(train_subject_id) <- "subject_id"
        
#Get activity ids of the training data
train_activity_id <- read.table("./train/y_train.txt")
colnames(train_activity_id) <- "activity_id"
        
#Combine test subject ids, the test activity ids and the test data
Temp_TestData <- cbind(test_subject_id , test_activity_id , TestData)
        
#Combine the test subject id's, the test activity id's 
Temp_TrainData <- cbind(train_subject_id , train_activity_id , TrainData)
        
#Combine the test data and the train data into one dataframe
CombineData <- rbind(Temp_TrainData,Temp_TestData)

#Get Mean and STD columns
mean_colID <- grep("mean",names(CombineData),ignore.case=TRUE)
mean_colNames <- names(CombineData)[mean_colID]
std_colID <- grep("std",names(CombineData),ignore.case=TRUE)
std_colNames <- names(CombineData)[std_colID]
Temp_CombineData <-CombineData[,c("subject_id","activity_id",mean_colNames,std_colNames)]
        
#Merge the mean/std values to the activity names 

DescriptiveNames <- merge(ActivityLabels,Temp_CombineData,by.x="activity_id",by.y="activity_id",all=TRUE)

#Melt the dataset
MeltData <- melt(DescriptiveNames,id=c("activity_id","activity_name","subject_id"))
        
#Cast the melted dataset
TidyData <- dcast(MeltData,activity_id + activity_name + subject_id ~ variable,mean)

write.table(TidyData,"tidy_data.txt",row.name=FALSE)

