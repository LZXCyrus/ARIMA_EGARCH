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
│  ├── ADF_test.py
│  ├── Ljung-Box_test.R
│  ├── improved_GARCH.R
│  ├── ARIMA&ARCH_test.R
│  ├── GARCH.R
│  ├── GARCH&ARCH_test.R
│  ├── prediction.R
├── /data/
│  ├── data.csv
│  ├── data_for_rollingforecast.csv

```

### Document Description

##### 1. data
- **data.csv**：training data
- **data_for_rollingforecast.csv**：training data and test data for prediction

##### 2. code
- **ADF_test.py**：Use Augmented Dickey-Fuller test to check the data stationarity
- **ARIMA&ARCH_test.R**：Select the appropriate ARIMA model and do ARCH test on the well-fitted ARIMA model
- **Ljung-Box_test.R**：Do Ljung-Box test on the fitted ARIMA model
- **GARCH.R**：Select the appropriate base fundamental GARCH model
- **GARCH&ARCH_test.R**：Do ARCH test on the fitted ARIMA-GARCH model to confirm the validity of GARCH
- **improved_GARCH.R**：Select the appropriate improved GARCH model
- **prediction.R**：Make rolling predictions for the short and long term
