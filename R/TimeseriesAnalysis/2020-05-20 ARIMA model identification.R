
n <- 500
x1 <- arima.sim(n=n, model=list(order=c(0,0,0))) #ARIMA(0,0,0) = WN
par(mfrow=c(1,3))
plot(x1)
acf(x1); pacf(x1) #d=0, ARMA(p,q) 적용
 


x1 <- arima.sim(n=n, model=list(order=c(0,1,0))) #random walk
par(mfrow=c(2,3))
plot(x1)
acf(x1); pacf(x1)
y1 <- diff(x1) #diff(x, lag=n, differences=n), lag=n(간격), differences=차분 차수
plot(y1); acf(y1); pacf(y1)

library(tseries)
adf.test(x1); adf.test(y1)
kpss.test(x1); kpss.test(y1)




x1 <- arima.sim(n=n, model=list(ar=0.5, order=c(1,0,0)))
par(mfrow=c(2,3))
plot(x1)
acf(x1); pacf(x1)
y1 <- diff(x1)
plot(y1); acf(y1); pacf(y1)

adf.test(x1); adf.test(y1)
kpss.test(x1)
kpss.test(x1, null="Trend")



x1 <- 1:n/100 + arima.sim(n=n, model=list(ar=0.5, order=c(1,0,0)))
par(mfrow=c(2,3))
plot(x1)
acf(x1); pacf(x1)
y1 <- diff(x1)
plot(y1); acf(y1); pacf(y1)

adf.test(x1) #차분x, 추세조정o
kpss.test(x1)
kpss.test(x1, null="Trend")



x1 <- arima.sim(n=n, model=list(ma=0.7, order=c(0,0,1)))
par(mfrow=c(2,3))
plot(x1)
acf(x1); pacf(x1)
y1 <- diff(x1)
plot(y1); acf(y1); pacf(y1)

kpss.test(x1)



x1 <- arima.sim(n=n, model=list(ar=0.5, ma=0.7, order=c(1,0,1)))
par(mfrow=c(2,3))
plot(x1)
acf(x1); pacf(x1)
y1 <- diff(x1)
plot(y1); acf(y1); pacf(y1)

