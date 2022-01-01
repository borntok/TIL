head(co2)
tail(co2)
plot(co2)

library(smooth)
library(TTR)

?SMA #moving averages(�̵���չ�)

m <- 12
ma1 <- SMA(co2, n=m) #n�� �̵���ձⰣ����
ma2 <- SMA(ma1, n=m)
#lines�Լ��� ������ �׷����� ���� �߰�
lines(ma1, col="blue")
lines(ma2, col="red")
tail(cbind(co2, ma1, ma2))

n <- length(co2)

<�ܼ��̵���չ�>
p.int <- 1:5 #�����ϰ� ���� ������ ���� ����
xhat1 <- ma1[n] + 0*p.int #���Ⱑ 0

<�����̵���չ�>
level.m <- 2*ma1[n]-ma2[n]
trend.m <- 2/(m-1)*(ma1[n]-ma2[n])
xhat.dm <- level.m + trend.m*p.int




Holt-Winter's exponential smoothing

#�ܼ�������Ȱ��
es1 <- HoltWinters(co2, alpha=0.2, beta=FALSE, gamma=FALSE) #�ܼ�������Ȱ��
plot(es1)
names(es1) #names(� ������ �����ִ°�)
head(es1$fitted)
es2 <- HoltWinters(co2, beta=FALSE, gamma=FALSE)
es2$alpha #������ �ּҷ� �ϴ� ���İ�
es1$SSE
es2$SSE
es1.p <- predict(es1, 12, prediction.interval=TRUE)
plot(es1, es1.p)

#ȦƮ ����������Ȱ��
es.t <- HoltWinters(co2, gamma=FALSE)
es.t.p <- predict(es.t, 12, prediction.interval=TRUE)
plot(es.t, es.t.p)

#ȦƮ-���� ����������Ȱ��
es.s <- HoltWinters(co2)
es.s.p <- predict(es.s, 12, prediction.interval=TRUE)
plot(es.s, es.s.p)