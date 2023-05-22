dat <- read.csv('./data/data.csv',header = T)
data <- ts(dat[,4],start = c(1),frequency = 365)# change dat[,i]
data.fit <- arima(data,order = c(3,1,6))
residual <- data.fit$residuals 
library(tseries)
models.garch <- data.frame(par = c(0),aic = c(0));r <- 1 ##
for(p in 0:2){
  for(q in 1:2){
    residual.garch <- garch(residual,order = c(p,q))
    models.garch[r,1] <- paste0('GARCH','(',p,',',q,')')
    models.garch[r,2] <- AIC(residual.garch) #aic#
    r <- r+1 
  }
}

models.garch <- models.garch[order(models.garch$aic),] #rank aic#

models.garch 
write.csv(models.garch, file="D:/Desktop/result.csv")
