
#AR(2)
acf.ar <- ARMAacf(ar=c(1.5, -0.75), ma=0, 24)
pacf.ar <- ARMAacf(ar=c(1.5, -0.75), ma=0, 24, pacf=T)

par(mfrow=c(1,2))
plot(acf.ar, main="AR(2) ACF", type="h", xlab="lag")
abline(h=0)

plot(pacf.ar, main="AR(2) PACF", type="h", xlab="lag")
abline(h=0)



#MA(2)
acf.ma <- ARMAacf(ar=0, ma=c(0.23, -0.8), 24)
pacf.ma <- ARMAacf(ar=0, ma=c(0.23, -0.8), 24, pacf=T)

par(mfrow=c(1,2))
plot(acf.ma, main="MA(2) ACF", type="h", xlab="lag")
abline(h=0)

plot(pacf.ma, main="MA(2) PCAF", type="h", xlab="lag")
abline(h=0)



#ARMA(2,2)

acf.arma <- ARMAacf(ar=c(1.5, -0.75), ma=c(0.23, -0.8), 24)
pacf.arma <- ARMAacf(ar=c(1.5, -0.75), ma=c(0.23, -0.8), 24, pacf=T)

par(mfrow=c(1,2))
plot(acf.arma, main="ARMA(2,2) ACF", type="h", xlab="lag")
abline(h=0)

plot(pacf.arma, main="ARMA(2,2) PACF", type="h", xlab="lag")
abline(h=0)



par(mfrow=c(3,2))