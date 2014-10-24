

#Reading the features.txt file to get the variable names
varnames=read.table("UCI HAR Dataset/features.txt",sep=" ")

#Editing the variable names to remove special characters and also identifying the mean and std variables.
varnames$mean_std_var=grepl("mean[(][)]|std[(][)]", varnames$V2,fixed=FALSE,ignore.case = FALSE, perl = TRUE)
varnames$newvarname=tolower(gsub("[^A-Z0-9]","_", varnames$V2,fixed=FALSE,ignore.case = TRUE, perl = TRUE))
varnames$newvarname=gsub("tbody","time_body_", varnames$newvarname,fixed=FALSE)
varnames$newvarname=gsub("tgravity","time_gravity_", varnames$newvarname,fixed=FALSE)
varnames$newvarname=gsub("fbody|fbodybody","freq_body_", varnames$newvarname,fixed=FALSE)
varnames$newvarname=gsub("_acc","_acceleration_", varnames$newvarname,fixed=FALSE)
varnames$newvarname=gsub("(_)+","_", varnames$newvarname,fixed=FALSE)
varnames$newvarname=gsub("(_)$","", varnames$newvarname,fixed=FALSE)


# Reading the activity labels file
activity_labels=read.table("UCI HAR Dataset/activity_labels.txt",sep=" ", col.names=c("activity_id", "activity"))

#Reading the X_test, Y_test  and subject_test files
test_x=read.table("UCI HAR Dataset/test/X_test.txt",sep="", colClasses=rep("double",561),col.names=varnames$newvarname)
test_y=read.table("UCI HAR Dataset/test/Y_test.txt",sep="",col.names=("activity_id"))
subject_test=read.table("UCI HAR Dataset/test/subject_test.txt",sep="",col.names=("subject_id"),colClasses=('integer'))

#Reading the X_train, Y_train  and subject_train files
train_x=read.table("UCI HAR Dataset/train/X_train.txt",sep="", colClasses=rep("double",561),col.names=varnames$newvarname)
train_y=read.table("UCI HAR Dataset/train/Y_train.txt",sep="",col.names=("activity_id"))
subject_train=read.table("UCI HAR Dataset/train/subject_train.txt",sep="",col.names=("subject_id"),colClasses=('integer'))

#putting it all together
train_x$category="train"
test_x$category="test"
train=cbind(subject_train,train_y,train_x)
test=cbind(subject_test,test_y,test_x)
all=rbind(train,test)
all_withactivity=merge(activity_labels,all,by.x="activity_id",by.y="activity_id")

subset_all_mean_std_vars= all_withactivity[,c('activity','subject_id',varnames$newvarname[varnames$mean_std_var==TRUE])]
tidy_means=aggregate(.~activity + subject_id, data=subset_all_mean_std_vars,FUN = mean,na.rm = TRUE, na.action="na.pass") 

#writing the tidy dataset out
write.table(tidy_means,file="tidy.txt",row.name=FALSE)

