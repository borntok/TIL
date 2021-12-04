
par(mfrow=c(1,2))
plot(lh)
plot(diff(lh))

par(mfrow=c(2,2))
acf(lh)
pacf(lh)
acf(diff(lh))
pacf(diff(lh))

library(tseries)
adf.test(lh)

kpss.test(lh, null="Level")
kpss.test(lh, null="Trend")



arima(lh, order=c(1,0,0))
fit <- arima(lh, order=c(1,0,0))
fit$coef
fit$sigma2
fit$var.coef
sqrt(fit$var.coef)
fit$loglik
fit$arma
fit$aic
fit$residuals


par(mfrow=c(1,3))
plot(fit$residuals)
abline(h=0, col="blue")
acf(fit$residuals)
pacf(fit$residuals)



#Portmateau test
Box.test(fit$residuals, type="Ljung", fitdf=2, lag=3)
Box.test(lh, type="Ljung", fitdf=0, lag=3)
tsdiag(fit)



#overfitting
fit2 <- arima(lh, order=c(2,0,0))
fit2

fit11 <- arima(lh, order=c(1,0,1))
fit11



arima(lh, order=c(1,0,0))$aic
arima(lh, order=c(2,0,0))$aic
arima(lh, order=c(3,0,0))$aic
arima(lh, order=c(1,0,1))$aic
arima(lh, order=c(2,0,1))$aic

ar(lh, order.max=5)
ar(lh, order.max=5)$aic
