library(readr)
elec_data<-read.csv(file.choose())
summary(elec_data)
elec_data1<-elec_data[-1,-1]

model1<-glm(Result~.,data = elec_data1,family="binomial")
summary(model1)
exp(model1$coefficients)
colnames(elec_data1)
model2<-glm(Result~Amount.Spent+Popularity.Rank,data = elec_data1,family="binomial")
model2

model3<-glm(Result~Amount.Spent,data = elec_data1,family="binomial")
model3

prob<-predict(model3,elec_data1,type = "response")
prob

confusion_mat<-table(prob>0.5,elec_data1$Result)
confusion_mat

acc<-sum(diag(confusion_mat)/sum(confusion_mat))
acc
########model2 acc
prob<-predict(model2,elec_data1,type = "response")
prob

confusion_mat<-table(prob>0.5,elec_data1$Result)
confusion_mat

acc<-sum(diag(confusion_mat)/sum(confusion_mat))
acc

###model1
prob<-predict(model1,elec_data1,type = "response")
prob

confusion_mat<-table(prob>0.5,elec_data1$Result)
confusion_mat

acc<-sum(diag(confusion_mat)/sum(confusion_mat))
acc


library(ROCR)
rocrpred<-prediction(prob,elec_data1$Result)
rocrperf<-performance(rocrpred,'tpr','fpr')

str(rocrperf)

plot(rocrperf,colorize=T,text.adj=c(-0.2,1.7))


