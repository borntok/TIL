
[선형회귀분석:회귀함수 추정]

ex78 <- read.csv("C://Users//LGE1//Documents//대학교//4학년 1학기//회귀분석실습1//실습//ex78.csv", header=TRUE)
fit <- with(ex78, lm(y~x1+x2, x=TRUE, y=TRUE))
fit$x ; fit$y

solve(t(fit$x)%*%(fit$x)) #solve() 역행렬 구하는 함수
solve(t(fit$x)%*%(fit$x)) %*% t(fit$x)%*%fit$y



[선형회귀분석:회귀계수에 대한 신뢰구간]

confint(fit, level=0.95)



[선형회귀분석:회귀계수에 대한 가설검정]

summary(fit)
sqrt(2.903^2*0.0022878) #b1의 SE
pt(14.08, 7, lower.tail=FALSE)*2 #pt() t분포의 누적확률계산

with(ex78, lm(y~x1))



[선형회귀분석:예측]

predict(fit, newdata=data.frame(x1=60, x2=22), interval="confidence") #평균반응 신뢰구간
predict(fit, newdata=data.frame(x1=60, x2=22), interval="prediction") #개별관측값 예측구간



[선형회귀분석:평균반응값에 대한 예측 활용]

predict(fit, newdata=data.frame(x1=-2, x2=0 ), interval="confidence")



[선형회귀분석:분산분석]

anova(fit)
fit0 <- with(ex78, lm(y~1))
anova(fit0, fit)
summary(fit) #F-statistic 분산분석표



[선형회귀분석:모형 진단]

par(mfrow=c(2,2))
plot(fit)


