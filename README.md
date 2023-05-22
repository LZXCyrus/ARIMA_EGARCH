# ARIMA_EGARCH
A simple example on how to use ARIMA_EGARCH models to analyze and predict time series 


## Requirements
**1. python   (3.9)**

- numpy          (1.21.5)
- pandas          (1.5.1)
- statsmodels      (0.13.2)

**2. R   (4.2.2)**

- tseries          (0.10-52)
- rugarch          (1.4-9)

## Directory Structure

```
filetree 
├── /code/
│  ├── ADF检验.py
│  ├── ARIMA模型白噪声检验.R
│  ├── GARCH衍生模型选择.R
│  ├── 部分画图代码.py
│  ├── 建立ARIMA模型与ARCH检验.R
│  ├── 建立GARCH模型.R
│  ├── 建立GARCH模型后的ARCH检验.R
│  ├── 预测.R
├── /data/
│  ├── data.csv
│  ├── data_for_rollingforecast.csv

```

### 文件内容说明

##### 1. data
- **data.csv**：training data
- **data_for_rollingforecast.csv**：training data and test data for prediction

##### 2. code
- **ADF检验.py**：检验数据平稳性
- **建立ARIMA模型与ARCH检验.R**：选择适合的ARIMA模型，对拟合好的ARIMA模型做ARCH检验
- **ARIMA模型白噪声检验.R**：对拟合好的ARIMA模型做白噪声检验
- **建立GARCH模型.R**：选择合适的基础GARCH模型
- **建立GARCH模型后的ARCH检验.R**：对拟合好的ARIMA-GARCH模型做ARCH检验，确认GARCH的有效性
- **GARCH衍生模型选择.R**：选择适合的GARCH衍生模型
- **prediction.R**：Make rolling predictions for the short and long term
