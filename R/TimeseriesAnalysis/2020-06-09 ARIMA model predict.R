

fit <- arima(lh, order=c(1,0,0))
pre <- predict(fit, n.ahead=7)

pre$pred
pre$se
pre$pred - qnorm(0.975, 0, 1)*pre$se #신뢰구간 하한값
pre$pred + qnorm(0.975, 0, 1)*pre$se #신뢰구간 상한값


library(forecast)
forecast(fit, h=7)
plot(forecast(fit, h=7))





x <- arima.sim(100, model=list(ma=0.5))
par(mfrow=c(2,2))
plot(x)

library(tseries)
kpss.test(x)
acf(x)
pacf(x)

fit1 <- arima(x, order=c(0, 0, 1))
tsdiag(fit1)
forecast(fit1)
plot(forecast(fit1))




fit11 <- arima(x, order=c(1, 0, 1))
forecast(fit11)
plot(forecast(fit11))





y <- arima.sim(100, model=list(order=c(0,1,0)))
par(mfrow=c(1,2))
plot(y)
kpss.test(y)
kpss.test(y, null="Trend")

plot(diff(y))
kpss.test(diff(y))

acf(diff(y))
pacf(diff(y))


fit3 <- arima(y, order=c(0,1,0))
forecast(fit3)
plot(forecast(fit3))
