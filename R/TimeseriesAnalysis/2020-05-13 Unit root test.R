
#ARMA model 이론적 계산

acf <- ARMAacf(ar=0.3, ma=0, lag.max=5, pacf=FALSE)
pacf <- ARMAacf(ar=0.3, ma=0, lag.max=5, pacf=TRUE)
par(mfrow=c(1,2))
plot(acf, type="h", xlab="lag")
abline(h=0)
plot(pacf, type="h", xlab="lag")
abline(h=0)


#ARMA model 시계열데이터 생성

x <- arima.sim(model=list(ar=0.3, ma=0), n=300)
plot(x)
par(mfrow=c(2,2))


#표본(부분)자기상관함수

acf(x, lag.max=5)
acf(x, lag.max=5, plot=FALSE)
pacf(x, lag.max=5)





#Unit root test

library(urca)
x <- arima.sim(model=list(ar=0.3, ma=0), n=300) # mean=0
ur.df(x, type="none")
summary(ur.df(x, type="none"))

x <- 10 + arima.sim(model=list(ar=0.3, ma=0), n=300) # mean=10
plot(x)
summary(ur.df(x, type="none"))
summary(ur.df(x, type="drift"))

x <- (1:300)/10 + arima.sim(model=list(ar=0.3, ma=0), n=300)
plot(x)
summary(ur.df(x, type="drift"))
summary(ur.df(x, type="trend"))



library(tseries)
x <- 10 + arima.sim(model=list(ar=0.3, ma=0), n=300) # mean=10
adf.test(x)
adf.test(x, k=1)
y <- (1:300)/10 + arima.sim(model=list(ar=0.3, ma=0), n=300)
adf.test(y)


x <- 10 + arima.sim(model=list(ar=0.3, ma=0), n=300) # mean=10
kpss.test(x, null="Level")

y <- (1:300)/10 + arima.sim(model=list(ar=0.3, ma=0), n=300)
plot(y)
kpss.test(y, null="Level")
kpss.test(y, null="Trend")
