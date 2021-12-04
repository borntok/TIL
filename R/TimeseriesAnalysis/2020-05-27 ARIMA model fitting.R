

#AR Yule-Walker

mu <- 10
x <- arima.sim(n=1000, model=list(ar=0.5)) + mu
par(mfrow=c(1,2))
acf(x); pacf(x)

ar(x, aic=TRUE, order.max=5)
ar(x, aic=TRUE, order.max=5)$aic
ar(x, aic=TRUE, order.max=5)$x.mean
mean(x)

ar(x, aic=FALSE, order.max=1)
ar(x, aic=FALSE, order.max=1)$x.mean

arima(x, order=c(1,0,0), method="CSS") #intercept:mu, ar1=pi
arima(x, order=c(1,0,0), method="CSS-ML")
arima(x, order=c(1,0,0), method="ML")



#MA
mu <- 10
x <- arima.sim(n=1000, model=list(ma=0.7)) + mu
par(mfrow=c(1,3))
plot(x)
acf(x); pacf(x)

arima(x, order=c(0,0,1), method="CSS") #intercept:mu, ma1=pi
arima(x, order=c(0,0,1), method="CSS-ML")
arima(x, order=c(0,0,1), method="ML")



#ARMA
mu <- 10
x <- arima.sim(n=1000, model=list(ar=0.5 ,ma=0.7)) + mu
par(mfrow=c(1,3))
plot(x)
acf(x); pacf(x)

arima(x, order=c(1,0,1), method="CSS") #intercept:mu, ma1=pi
arima(x, order=c(1,0,1), method="CSS-ML")
arima(x, order=c(1,0,1), method="ML")