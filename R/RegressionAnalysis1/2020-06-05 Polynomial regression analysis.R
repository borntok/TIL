
[다항회귀모형-차수 결정]

y <- c(180, 200, 350, 400, 450, 480, 460, 500, 360, 340)
x <- c(10, 10, 20, 20, 30, 30, 40, 40, 50, 50)
plot(x,y)

fit1 <- lm(y~x)
summary(fit1)
abline(fit1, col="blue")

fit2 <- lm(y~x+I(x^2))
summary(fit2)
curve(fit2$coef[1] + fit2$coef[2]*x + fit2$coef[3]*x^2, col="red", add=TRUE)

fit3 <- lm(y~x+I(x^2)+I(x^3))
summary(fit3)
curve(fit3$coef[1] + fit3$coef[2]*x + fit3$coef[3]*x^2 + fit3$coef[4]*x^3, col="green", add=TRUE)

x2 <- x^2
summary(lm(y~x+x2))




[다항회귀모형-독립변수 중심화]

xc <- x - mean(x)
cbind(x, xc)
lm(y~xc+I(xc^2))

fit2$fitted
fitc <- lm(y~xc+I(xc^2))
fitc$fitted

fit2$resid
fitc$resid

par(mfrow=c(1,2))
plot(x, x^2)
cor(x, x^2)
plot(xc, xc^2)
cor(xc, xc^2)
