
par(mfrow=c(2,2))


#seasonal AR(1)
ARMAacf(ar=c(rep(0,11), 0.5), lag.max=40)
plot(0:40, ARMAacf(ar=c(rep(0,11), 0.5), lag.max=40), type="h", xlab="lag")
abline(h=0, lty=2)

ARMAacf(ar=c(rep(0,11), 0.5), lag.max=40, pacf=TRUE)
plot(ARMAacf(ar=c(rep(0,11), 0.5), lag.max=40, pacf=TRUE), type="h")
abline(h=0, lty=2)


#AR(1)
plot(0:40, ARMAacf(ar=0.5, lag.max=40), type="h", xlab="lag")
plot(ARMAacf(ar=0.5, lag.max=40, pacf=TRUE), type="h")





#seasonal MA(1)
plot(0:40, ARMAacf(ma=c(rep(0,11), 0.7), lag.max=40), type="h", xlab="lag", ylab="acf-MA(1)12")
plot(ARMAacf(ma=c(rep(0,11), 0.7), lag.max=40, pacf=TRUE), type="h", xlab="lag", ylab="pacf-MA(1)12")

#MA(1)
plot(0:40, ARMAacf(ma=0.7, lag.max=40), type="h", xlab="lag", ylab="acf-MA(1)")
plot(ARMAacf(ma=0.7, lag.max=40, pacf=TRUE), type="h", xlab="lag", ylab="pacf-MA(1)")




#seasonal ARMA(1,1)
plot(0:40, ARMAacf(ar=c(rep(0,11), 0.5), ma=c(rep(0,11), 0.7), lag.max=40), type="h", xlab="lag", ylab="acf-ARMA(1,1)12")
plot(ARMAacf(ar=c(rep(0,11), 0.5), ma=c(rep(0,11), 0.7), lag.max=40, pacf=TRUE), type="h", xlab="lag", ylab="pacf-ARMA(1,1)12")

#ARMA(1,1)
plot(0:40, ARMAacf(ar=0.5, ma=0.7, lag.max=40), type="h", xlab="lag", ylab="acf-ARMA(1,1)")
plot(ARMAacf(ar=0.5, ma=0.7, lag.max=40, pacf=TRUE), type="h", xlab="lag", ylab="pacf-ARMA(1,1)")





AirPassengers

plot(AirPassengers) #추세,계절성 있음. 분산안정화 필요
plot(log(AirPassengers)) #분산 안정
plot(diff(log(AirPassengers))) #추세 제거됨, 계절성 존재
plot(diff(log(AirPassengers), lag=12)) #추세, 계절성 제거

library(tseries)
kpss.test(diff(log(AirPassengers), lag=12))

y <- diff(diff(log(AirPassengers), lag=12), lag=1)
plot(y)
z <- diff(diff(log(AirPassengers), lag=1), lag=12)
plot(y-z) #차분 순서가 달라도 결과는 동일

par(mfrow=c(1,2))
acf(y)
pacf(y)


#ARIMA(1,0,0)*(1,0,0)12
arima(y, order=c(1,0,0), seasonal=list(order=c(1,0,0)))
arima(y, order=c(1,0,0), seasonal=list(order=c(1,0,0)), include.mean=FALSE)
tsdiag(arima(y, order=c(1,0,0), seasonal=list(order=c(1,0,0)), include.mean=FALSE))

#ARIMA(0,0,1)*(0,0,1)12
arima(y, order=c(0,0,1), seasonal=list(order=c(0,0,1)), include.mean=FALSE)
tsdiag(arima(y, order=c(0,0,1), seasonal=list(order=c(0,0,1)), include.mean=FALSE))

#AR(13)
arima(y, order=c(13,0,0), include.mean=FALSE)



library(forecast)
forecast(arima(y, order=c(0,0,1), seasonal=list(order=c(0,0,1)), include.mean=FALSE))
plot(forecast(arima(y, order=c(0,0,1), seasonal=list(order=c(0,0,1)), include.mean=FALSE)))
forecast(arima(log(AirPassengers), order=c(0,1,1), seasonal=list(order=c(0,1,1)), include.mean=FALSE))
plot(forecast(arima(log(AirPassengers), order=c(0,1,1), seasonal=list(order=c(0,1,1)), include.mean=FALSE)))

