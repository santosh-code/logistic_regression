library(readr)
bank_da<-read.csv(file.choose())
sum(is.na(bank_da))
#####model1###########
model1<-glm(y~.,data = bank_da,family="binomial")
summary(model1)
plot(model1)
library(car)

prob<-predict(model1,bank_da,type="response")
prob
exp(model1$coefficients)
confusion<-table(prob>0.5,bank_da$y)
confusion

Accuracy<-sum(diag(confusion)/sum(confusion))
Accuracy 

# Creating new column to store the above values
pred_values <- NULL
yes_no <- NULL

pred_values <- ifelse(prob>0.5,1,0)
yes_no <- ifelse(prob>0.5,"yes","no")

bank_da[,"prob"] <- prob
bank_da[,"pred_values"] <- pred_values
bank_da[,"yes_no"] <- yes_no

View(bank_da[,c(32,32:35)])

###roc curve

library(ROCR)
rocrpred<-prediction(prob,bank_da$y)
rocrperf<-performance(rocrpred,'tpr','fpr')

str(rocrperf)

plot(rocrperf,colorize=T,text.adj=c(-0.2,1.7))

######train_test

n<-nrow(bank_da)
n1<-n*0.7
n2<-n-n1
train<-sample(1:n,n1)
bank_da_train<-bank_da[train,]
bank_da_test<-bank_da[-train,]


model<-glm(y~.,data = bank_da_train,family="binomial")
summary(model)
###test data
prob<-predict(model,bank_da_test,type="response")
prob

confu_matrix<-table(prob>0.5,bank_da_test$y)
confu_matrix

acc<-sum(diag(confu_matrix)/sum(confu_matrix))
acc
###accuracy for test=0.89
#####train data
prob<-predict(model,bank_da_train,type="response")
prob

confu_matrix<-table(prob>0.5,bank_da_train$y)
confu_matrix

acc<-sum(diag(confu_matrix)/sum(confu_matrix))
acc
###accuracy for train=0.89

