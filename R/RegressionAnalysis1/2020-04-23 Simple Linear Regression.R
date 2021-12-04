
x <- c(40, 50, 30, 60, 70, 60, 30, 60, 20, 80)
y <- c(87, 108, 69, 135, 148, 132, 73, 128, 50, 170)

#lm(formula=모형 가정) 단순선형회귀분석
out <- lm(y~x)

plot(x, y)
abline(out, col="blue")


out$coefficients #최소제곱추정값
out$fitted.value #회귀직선상의 점
out$residuals #잔차
sum(out$residuals)
out$residuals*x
sum(out$residuals*x)

summary(out)
# sta.error 추정된 표준오차 S(b0) S(b1)

confint(out) #b의 신뢰구간
residuals(out)