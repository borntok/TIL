#lm() 함수 이용하여 최소제곱회귀직선 구하기

x <- c(40, 50, 30, 60, 70, 60, 30, 60, 20, 80)
y <- c(87, 108, 69, 135, 148, 132, 73, 128, 50,170)

out <- lm(y ~ x)
plot(x, y)
abline(out, col="blue")

out$coefficients
haty <- out$coefficients[1] + out$coefficients[2]*x
haty
out$fitted.values

out1 <- lm(y~x, x=TRUE, y=TRUE)
out1$y
out1$x

haty1 <- out1$x %*% out1$coefficients
haty1

y - out$fitted.values
out$residuals

summary(out)





# simulation - distribution of LSE

n.rep <- 1000
beta <- c(2, 3)
n <- 10
x <- runif(n, 0, 10)
b.lse <- matrix(ncol=2, nrow=n.rep)
sse.sim <- rep(0, n.rep)
for (i in 1:n.rep){
  y <- beta[1] + beta[2]*x + rnorm(n, mean=0, sd=1)
  out <- lm(y~x)
  b.lse[i,] <- out$coef
  sse.sim[i] <- sum(out$residuals^2)
}
