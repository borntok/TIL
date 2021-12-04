
ARMAacf(ar=계수, ma=계수, lag.max=출력값 개수, pacf=T/F)
ARMAacf(ar=0.5, ma=0, lag.max=5, pacf=FALSE) #Acf 0,1,2,...
ARMAacf(ar=0.5, ma=0, lag.max=5, pacf=TRUE) #pacf 1,2,3,...
ARMAacf(ar=0, ma=0, lag.max=5, pacf=TRUE) #white noise
ARMAacf(ar=0, ma=0.5, lag.max=5, pacf=TRUE) #MA model



x <- arima.sim(n=400, model=list(ar=0.5, ma=0))
plot(x)
par(mfrow=c(1,3))
acf(x)
pacf(x)
