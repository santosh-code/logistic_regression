import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn import metrics
from sklearn.model_selection import cross_val_score
from sklearn.preprocessing import StandardScaler

election_data=pd.read_csv("C:/Users/USER/Desktop/logistic_reg/election_data.csv")
election_data1=election_data.iloc[1:,[1,0,2,3,4]]
x=election_data1.iloc[:,1:]
y=election_data1.iloc[:,0]
model=LogisticRegression()
model=model.fit(x,y)
model.score(x,y)  #####accu=0.9
model.coef_
np.exp(model.coef_)#####we will get coeff values

