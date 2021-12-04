#Box-cox 변환 예제:AirPassengers

AirPassengers
plot(AirPassengers)
acf(AirPassengers)

library("MASS")
x <- 1:length(AirPassengers)


boxcox(AirPassengers~x)
bc <- boxcox(AirPassengers~x, plotit=FALSE)
max(bc$y)
which.max(bc$y)
bc$x[22]
lam <- bc$x[which.max(bc$y)]
air.lam <- (AirPassengers^lam-1)/lam
air.log <- log(AirPassengers)


par(mfrow=c(2,2))
plot(AirPassengers)
boxcox(AirPassengers~x)
plot(air.lam)
plot(air.log)






#Box-Cox 변환 예제:가상자료

x <- 1:400
y <- sqrt(x)*rnorm(400, 0, 1)
par(mfrow=c(2,2))

plot(y, type="l")
y1 <- y-min(y)+10
boxcox(y1~x)
bc1 <- boxcox(y1~x, plotit=FALSE)
lam1 <- bc1$x[which.max(bc1$y)]
y1.t <- (y1^1-1/1)
plot(y1.t, type="l")

y2 <- abs(y)+1
boxcox(y2~x)
bc2 <- boxcox(y2~x, plotit=FALSE)
lam2 <- bc2$x[which.max(bc$y)]
y2.t <- sign(y)*(y2^lam2-1)/lam2
plot(y2.t, type="l")
plot(y, type="l")
plot(y/sqrt(x), type="l")
plot(x, y^2, type="l")

out <- lm(y^2~x)
summary(out)
confint(out)
out1 <- lm(y^2~x-1)
summary(out1)

plot(y/sqrt(x), type="l")
plot(y, type="l")





# 가상자료 : 선형추세 추정 후 추세제거
x <- 1:400
y <- x/100+rnorm(400,0,1)
par(mfrow=c(1,2))
plot(x, y, type="l")
out <- lm(y~x)
abline(out, col="green")
plot(out$resid, type="l")



#Log(AirPassengers) : 다항추세 추정 후 추세제거

plot(log(AirPassengers))

x <- 1:length(AirPassengers)
out1 <- lm(log(AirPassengers)~x)
plot(x, log(AirPassengers), type="l")
abline(out1, col="blue")
plot(out1$resid, type="l")

out2 <- lm(log(AirPassengers)~x+I(x^2))
summary(out2)
plot(out2$resid, type="l")




#Log(AirPassengers) 이동평균 이용하여 추세제거

decompose(log(AirPassengers))
plot(decompose(log(AirPassengers)))

