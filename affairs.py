import pandas as pd
import numpy as np

affairs=pd.read_csv("C:/Users/USER/Desktop/logistic_reg/Affairs.csv")
affairs1=affairs.iloc[:,1:]
affairs1['naffairs'].values[affairs1['naffairs'] > 1] = 1
affairs1.info()
affairs1.columns
#########train -test
x=affairs1.iloc[:,1:]
y=affairs1.iloc[:,0]
from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test = train_test_split(x,y,test_size = 0.3)
#############
from sklearn.linear_model import LogisticRegression
model=LogisticRegression()
model=model.fit(x,y)
###accuracy of training model
model.score(x,y)
y.mean()#####only 24% are having affairs
###coeff
model.coef_
np.transpose(model.coef_)

#######model validation

model1=LogisticRegression()
model1=model.fit(x_train,y_train)
pred=model1.predict(x_test)
####probability values
prob1=model1.predict_proba(x_test)

from sklearn import metrics
print(metrics.confusion_matrix(y_test, pred))
print(metrics.classification_report(y_test, pred))
###predict on train data
pred1=model1.predict(x_train)
print(metrics.classification_report(y_train,pred1))

######cross-validation
from sklearn.model_selection import cross_val_score
score=cross_val_score(LogisticRegression(),x,y,scoring='accuracy',cv=10)
print(score)
print(score.mean())
