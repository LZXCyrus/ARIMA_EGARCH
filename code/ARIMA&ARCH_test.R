dat <- read.csv('./data.csv',header = T)
data <- ts(dat[,4],start = c(1,1),frequency = 365)#change dat[,i]

models <- data.frame(par = c(0),aic = c(0));r <-1 
for(p in 0:6){
  for(q in 0:6){ 
    fit <- arima(data,order = c(p,1,q))
    models[r,1] <- paste0('arima','(',p,',1,',q,')')
    models[r,2] <- fit$aic #aic#
    r <- r+1 
  }
}

models <- models[order(models$aic),] #rank aic#

models
write.csv(models, file="D:/Desktop/result.csv")

data.fit <- arima(data,order = c(3,1,6))
data.fit
summary(data.fit)

for(i in 1:3) print(Box.test(data.fit$residuals,type = c('Ljung-Box'),lag = i*6))

residual <- data.fit$residuals
par(pin = c(4,2))
plot(residual)
par(pin = c(2,2))
qqnorm(residual);qqline(residual) 

ks.test(residual,pnorm) 
data.dif <- diff(data)
par(pin = c(4,2))
plot(residual^2) 
for(i in 1:10) print(Box.test(residual^2,lag = i)) 
ArchTest <- function (x, lags=i,
                      demean = FALSE)
{
  # Capture name of x for documentation in the output  
  xName <- deparse(substitute(x))
  #
  x <- as.vector(x)
  if(demean) x <- scale(x, center = TRUE, scale = FALSE)
  #  
  lags <- lags + 1
  mat <- stats::embed(x^2, lags)
  arch.lm <- summary(stats::lm(
    mat[, 1] ~ mat[, -1]))
  STATISTIC <- arch.lm$r.squared *
    length(stats::residuals(arch.lm))
  names(STATISTIC) <- "Chi-squared"
  PARAMETER <- lags - 1
  names(PARAMETER) <- "df"
  PVAL <- stats::pchisq(STATISTIC,
                        df = PARAMETER, lower.tail=FALSE)
  METHOD <- paste("ARCH LM-test; ",
                  "Null hypothesis:  no ARCH effects")
  result <- list(statistic = STATISTIC,
                 parameter = PARAMETER,
                 p.value = PVAL, method = METHOD,
                 data.name = xName)
  class(result) <- "htest"
  return(result)
}
for(i in 1:10) print(ArchTest(residual,lag = i)) #LM test#
