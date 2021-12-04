head(co2)
tail(co2)
plot(co2)

library(smooth)
library(TTR)

?SMA #moving averages(이동평균법)

m <- 12
ma1 <- SMA(co2, n=m) #n은 이동평균기간지정
ma2 <- SMA(ma1, n=m)
#lines함수는 기존의 그래프에 선을 추가
lines(ma1, col="blue")
lines(ma2, col="red")
tail(cbind(co2, ma1, ma2))

n <- length(co2)

<단순이동평균법>
p.int <- 1:5 #예측하고 싶은 구간의 길이 설정
xhat1 <- ma1[n] + 0*p.int #기울기가 0

<선형이동평균법>
level.m <- 2*ma1[n]-ma2[n]
trend.m <- 2/(m-1)*(ma1[n]-ma2[n])
xhat.dm <- level.m + trend.m*p.int




Holt-Winter's exponential smoothing

#단순지수평활법
es1 <- HoltWinters(co2, alpha=0.2, beta=FALSE, gamma=FALSE) #단순지수평활법
plot(es1)
names(es1) #names(어떤 변수를 갖고있는가)
head(es1$fitted)
es2 <- HoltWinters(co2, beta=FALSE, gamma=FALSE)
es2$alpha #오차를 최소로 하는 알파값
es1$SSE
es2$SSE
es1.p <- predict(es1, 12, prediction.interval=TRUE)
plot(es1, es1.p)

#홀트 선형지수평활법
es.t <- HoltWinters(co2, gamma=FALSE)
es.t.p <- predict(es.t, 12, prediction.interval=TRUE)
plot(es.t, es.t.p)

#홀트-윈터 계절지수평활법
es.s <- HoltWinters(co2)
es.s.p <- predict(es.s, 12, prediction.interval=TRUE)
plot(es.s, es.s.p)
