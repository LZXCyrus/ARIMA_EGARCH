import pandas as pd
import numpy as np
import matplotlib.pylab as plt
from statsmodels.tsa.arima_process import arma_generate_sample
from statsmodels.tsa.stattools import adfuller
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf
from pmdarima import auto_arima

#import data
data = pd.read_csv('data.csv')
Gold_Close = data['Gold_Close']
Silver_Close = data['Silver_Close']
GS_Ratio = data['GS_Ratio']
Gold_Close = np.diff(Gold_Close)
Silver_Close = np.diff(Silver_Close)
GS_Ratio = np.diff(GS_Ratio)
#adf_test
# result1 = adfuller(Gold_Close)
# print(result1)
# result2 = adfuller(Silver_Close)
# print(result2)
result3 = adfuller(GS_Ratio)
print(result3)
