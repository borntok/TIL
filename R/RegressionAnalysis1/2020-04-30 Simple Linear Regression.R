
x <- c(40, 50, 30, 60, 70, 60, 30, 60, 20, 80)
y <- c(87, 108, 69, 135, 148, 132, 73, 128, 50, 170)
plot(x, y)
out <- lm(y~x)
abline(out, col="blue")

anova(out)
summary(out)

predict(out, newdata=data.frame(x=50))
predict(out, newdata=data.frame(x=c(50, 70, 100)))
predict(out, newdata=data.frame(x=c(50, 70, 100)), interval="confidence")
predict(out, newdata=data.frame(x=c(50, 70, 100)), interval="confidence", level=0.9)
predict(out, newdata=data.frame(x=c(50, 70, 100)), interval="prediction")