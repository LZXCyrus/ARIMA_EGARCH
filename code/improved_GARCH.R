dat <- read.csv('./data/data.csv',header = T)
data <- ts(dat[,4],start = c(1),frequency = 365)#change dat[,i]
data <- diff(data)
library(tseries)
library(knitr)
library(pedquant)
library(zoo)
library(imputeTS)
library(forecast)
library(MTS)
library(rugarch)
library(dplyr)

md_name <- c( "eGARCH", "gjrGARCH")
md_dist <- c('std')

# define function
model_train <- function(data_, m_name, m_dist) {
  res <- NULL
  for (i in m_name) {
    sub_model <- NULL
    main_model <- i
    if (i == "TGARCH" | i == "NAGARCH") {
      sub_model <- i
      main_model <- "fGARCH"
    }
    
    for (j in m_dist) {
      model_name <- paste0('ARIMA(3,1,6)', '-',
                           i, 
                           sep = "",j)
      if (main_model == "fGARCH") {
        model_name <- paste0('ARIMA(3,1,6)', '-',
                             sub_model, 
                             sep = "",j)
      }
      print(model_name)
      # set model
      mean.spec <- list(armaOrder = c(3,6))
      var.spec <- list(model = main_model, garchOrder = c(0, 2),
                       submodel = sub_model,
                       external.regressors = NULL,
                       variance.targeting = F)
      dist.spec <- j
      my_spec <- ugarchspec(mean.model = mean.spec,
                            variance.model = var.spec,
                            distribution.model = dist.spec)
      # fit model
      my_fit <- ugarchfit(data = data_, spec = my_spec)
      res <- rbind(res, c(list(ModelName = model_name),
                          list(LogL = likelihood(my_fit)),
                          list(AIC = infocriteria(my_fit)[1]),
                          list(BIC = infocriteria(my_fit)[2]),
                          list(RMSE = sqrt(mean(residuals(my_fit)^2))),
                          list(md = my_fit)))
    }
  }
  return(res)
}


my_model <- model_train(data, md_name, md_dist)
armaOrder <- c(3,6) # ARMA parameter#
garchOrder <- c(0,2) # GARCH parameter#
varModel <- list(model = "sGARCH", garchOrder = garchOrder)
spec <- ugarchspec(varModel, mean.model = list(armaOrder = armaOrder),
                   distribution.model = "std",fixed.pars = list("omega" = 0.66007, "beta1" = 0.39274, "beta2" = 0.1868,"ar1" = 0.0126, "ar2" = -0.0187, "ar3" = -0.92,"ma1"=0.0035,"ma2"=0.141,"ma3"=0.8691,"ma4"=0.0267,"ma5"=0.1308,"ma6"=-0.1128)) # t 标准残差#

model_origin <- ugarchfit(spec, data = data) # fit#
likelihood(model_origin)
infocriteria(model_origin)[1]
write.table(my_model[, 1:5],
            "result.txt",
            sep = " ")
