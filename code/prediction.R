dat <- read.csv('./data/data.csv',header = T)
X<- ts(dat[,4],start = c(1),frequency = 365)#change dat[,i]
X <- diff(X)
library(rugarch)

armaOrder <- c(3,6) # ARMA parameter#
garchOrder <- c(0,2) # GARCH parameter#
varModel <- list(model = "eGARCH", garchOrder = garchOrder)
spec <- ugarchspec(varModel, mean.model = list(armaOrder = armaOrder),
                   distribution.model = "std") 

fit <- ugarchfit(spec, data = X) # fit#
infocriteria(fit)
fit
plot(fit)
forecasty <- ugarchforecast(fit,n.ahead=105) 
fore <- forecasty@forecast
fore
write.csv(xx, file="D:/Desktop/X.csv")

plot(forecasty)

##long term
dat <- read.csv('./data/data_for_rollingforecast.csv',header = T)

X<- ts(dat[,4],start = c(1),frequency = 365)#change dat[,i]
X <- diff(X)
library(rugarch)

armaOrder <- c(3,6) # ARMA parameter#
garchOrder <- c(0,2) # GARCH parameter#
varModel <- list(model = "eGARCH", garchOrder = garchOrder)
spec <- ugarchspec(varModel, mean.model = list(armaOrder = armaOrder),
                   distribution.model = "std") 

fit <- ugarchfit(spec, data = X,out.sample=105) # fit#
infocriteria(fit)
fit
plot(fit)
forecasty <- ugarchforecast(fit,n.ahead=105,n.roll=105,out.sample=105)
fore <- forecasty@forecast
fore
write.csv(fore, file="D:/Desktop/result.csv")
plot1 <- plot(forecasty)
