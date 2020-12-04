import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn import metrics
from sklearn.model_selection import cross_val_score
from sklearn.preprocessing import StandardScaler

bank_data=pd.read_csv("C:/Users/USER/Desktop/logistic_reg/bank_data.csv")
bank_data.info()

x=bank_data.iloc[:,0:31]
y=bank_data.iloc[:,31]

model=LogisticRegression()
model=model.fit(x,y)
model.score(x,y)#######accuracy=0.89
np.exp(model.coef_)

###train test check
from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test = train_test_split(x,y,test_size = 0.3)

model1=LogisticRegression()
model1=model1.fit(x_train,y_train)
pred=model1.predict(x_test)
prob=model1.predict_proba(x_test)
print(metrics.confusion_matrix(y_test, pred))
print(metrics.classification_report(y_test, pred))###accuracy=0.89

###train data
pred1=model1.predict(x_train)
print(metrics.confusion_matrix(y_train, pred1))
print(metrics.classification_report(y_train, pred1))##accuracy=0.891
######checking model accuracy with cross validation
from sklearn.model_selection import cross_val_score
score=cross_val_score(LogisticRegression(),x,y,scoring='accuracy',cv=10)
print(score)
print(score.mean())
#####avg_score=0.88 hence good model
