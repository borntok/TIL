
library(forecast)
library(tseries)

lh
plot(lh)
kpss.test(lh)
par(mfrow=c(1,2))
acf(lh)
pacf(lh)
Arima(lh, order=c(1,0,0))
tsdiag(Arima(lh, order=c(1,0,0)))
forecast(Arima(lh, order=c(1,0,0)), h=20)

auto.arima(lh)
forecast(auto.arima(lh))
plot(forecast(auto.arima(lh)))
tsdiag(auto.arima(lh))
autoplot(auto.arima(lh))

Arima(lh, order=c(2,0,0))
autoplot(Arima(lh, order=c(2,0,0)))
Arima(lh, order=c(2,0,1))
autoplot(Arima(lh, order=c(2,0,1)))



AirPassengers
plot(AirPassengers)
plot(log(AirPassengers))
auto.arima(log(AirPassengers))
forecast(auto.arima(log(AirPassengers)))
plot(forecast(auto.arima(log(AirPassengers))))





co2
plot(co2)
kpss.test(co2)
kpss.test(diff(co2))

Arima(co2, order=c(5,0,0))
autoplot(Arima(co2, order=c(5,0,0)))
autoplot(Arima(co2, order=c(4,1,0)))
plot(diff(co2))
acf(diff(co2))
pacf(diff(co2))
autoplot(Arima(co2, order=c(4,1,1)))
autoplot(Arima(co2, order=c(4,1,2)))

auto.arima(co2)






HoltWinters(log(AirPassengers))
forecast(HoltWinters(log(AirPassengers)))
par(mfrow=c(1,2))
plot(forecast(HoltWinters(log(AirPassengers))))
forecast(auto.arima(log(AirPassengers)))
plot(forecast(auto.arima(log(AirPassengers))))




x <- log(AirPassengers)[1:132]
x <- ts(x, frequency=12, start=1949)
y <- log(AirPassengers)[-(1:132)]

forecast(HoltWinters(x), h=12)
HW.fore <- forecast(HoltWinters(x), h=12)$mean
y-HW.fore

forecast(auto.arima(x), h=12)
ARIMA.fore <- forecast(auto.arima(x), h=12)$mean
y-ARIMA.fore

cbind(y-HW.fore, y-ARIMA.fore)
sum((y-HW.fore)^2)
sum((y-ARIMA.fore)^2)





p.error <- c()
for(i in 1:12) {
	f1 <- forecast(HoltWinters(ts(log(AirPassengers)[1:(132+i-1)], frequency=12, start=1949)), h=1)$mean
	e1 <- log(AirPassengers)[132+i]-f1
	f2 <- forecast(auto.arima(ts(log(AirPassengers)[1:(132+i-1)], frequency=12, start=1949)), h=1)$mean
	e2 <- log(AirPassengers)[132+i]-f2
	p.error <- rbind(p.error, c(e1, e2))
}
p.error
colSums(p.error^2)

