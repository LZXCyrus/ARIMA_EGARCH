dat <- read.csv('./data/data.csv',header = T)
data <- ts(dat[,4],start = c(1),frequency = 365)#change dat[,i]
data.fit <- arima(data,order = c(3,1,6))
data.fit
library(tseries)
residual <- data.fit$residuals 
residual.fit <- garch(residual,order = c(0,2))
res <- residual.fit$residuals
summary(residual.fit)
for(i in 1:10) print(Box.test(res^2,lag = i)) #Portmanteau Q test#
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
for(i in 1:10) print(ArchTest(res,lag = i)) #LM test#
