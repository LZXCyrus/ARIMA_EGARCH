dat <- read.csv('./data/data.csv',header = T)
data <- ts(dat[,4],start = c(2019,1),frequency = 365)# change dat[,i]
data.fit <- arima(data,order = c(3,1,6))
for(i in 1:3) print(Box.test(data.fit$residuals,type = c('Ljung-Box'),lag = i*6))
