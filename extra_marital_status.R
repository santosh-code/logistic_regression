library(readr)
install.packages('AER')
data(Affairs,package="AER")
library('AER')
library(plyr)

summary(affairs1)

affairs1<-Affairs
##converting and repacing
affairs1$gender<-as.factor(revalue(affairs1$gender,c("male"=1,"female"=0)))
affairs1$children<-as.factor(revalue(affairs1$children,c("yes"=1,"no"=0)))
affairs1$affairs[affairs1$affairs > 0] <- 1
affairs1$affairs[affairs1$affairs == 0] <- 0
af<-affairs1[,-10]

#model building
model<-glm(affairs~.,data = af,family = "binomial",maxit = 100)
summary(model)

prob <- predict(model,af,type="response")
prob
summary(model)
##confusion table
confusion<-table(prob>0.5,af$affairs)
confusion

# Model Accuracy 
Accuracy<-sum(diag(confusion)/sum(confusion))
Accuracy # 76.53

##probability table
pred_values <- NULL
yes_no <- NULL

pred_values <- ifelse(prob>=0.5,1,0)
yes_no <- ifelse(prob>=0.5,"yes","no")

# Creating new column to store the above values
af[,"prob"] <- prob
af[,"pred_values"] <- pred_values
af[,"yes_no"] <- yes_no


View(af[,c(1,9:11)])

table(affairs1$ynaffairs,affairs1$pred_values)
##    
library(ROCR)
rocrpred<-prediction(prob,af$affairs)
rocrperf<-performance(rocrpred,'tpr','fpr')


str(rocrperf)
plot(rocrperf,colorize=T,text.adj=c(-0.2,1.7))

rocr_cutoff <- data.frame(cut_off = rocrperf@alpha.values[[1]],fpr=rocrperf@x.values,tpr=rocrperf@y.values)
colnames(rocr_cutoff) <- c("cut_off","FPR","TPR")
View(rocr_cutoff)
library(dplyr)

rocr_cutoff$cut_off <- round(rocr_cutoff$cut_off,6)
# Sorting data frame with respect to tpr in decreasing order 
rocr_cutoff <- arrange(rocr_cutoff,desc(TPR))
View(rocr_cutoff)