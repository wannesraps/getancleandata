
###download and unzip
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp,method="curl")
unzip(temp)
unlink(temp)
###read tables
te1<-read.table("UCI HAR Dataset/test/subject_test.txt",sep="",header=F)
te2<-read.table("UCI HAR Dataset/test/X_test.txt",sep="",header=F)
te3<-read.table("UCI HAR Dataset/test/Y_test.txt",sep="",header=F)
test<-cbind(te1,te2,te3)
tr1<-read.table("UCI HAR Dataset/train/subject_train.txt",sep="",header=F)
tr2<-read.table("UCI HAR Dataset/train/X_train.txt",sep="",header=F)
tr3<-read.table("UCI HAR Dataset/train/Y_train.txt",sep="",header=F)
train<-cbind(tr1,tr2,tr3)
tot<-rbind(test,train)
###labels
lab<-read.table("UCI HAR Dataset/features.txt",sep="",header=F)
names(tot)<-c("ID",as.character(lab[,2]),"activity")
names(tot)
sel<-c(1,grep("-mean()",names(tot),fixed=T),sel<-grep("-std",names(tot),fixed=T),563)
tot2<-tot[,sel]
###aggregate
tidy<-aggregate(tot2[,2:67],by=list(tot2$ID,tot2$activity),FUN=mean)
names(tidy)[1:2]<-c("ID","activity")
###save
save(tidy,file="tidy.Rda")
