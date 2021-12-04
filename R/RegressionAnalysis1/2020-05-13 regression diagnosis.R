
#단순선형회귀모형이 참일 때 잔차 산점도

par(mfrow=c(2,4))

beta <- c(1,1)
n <- 100
x <- runif(n,0,10)
error <- rnorm(n,0,1) #표준정규분포 난수
y <- beta[1] + beta[2]*x +error
out <- lm(y~x)

plot(x, out$resid)
abline(h=0, col="blue")




#예제-잔차분석과 DW검정

data5_1 <- read.table("C://Users//LGE1//Documents//대학교//4학년 1학기//회귀분석실습1//실습//data_ch5//data5_1.txt", header=TRUE)
x <- data5_1$x
y <- data5_1$y
plot(x,y)
out5_1 <- lm(y~x, data=data5_1)

out5_1$resid
plot(x, out5_1$resid)
abline(h=0, col="blue")

qqnorm(out5_1$resid) #정규성검정
qqline(out5_1$resid, col="blue")

plot(out5_1$resid, type="l") #독립성검정
abline(h=0, col="blue")


library(lmtest) #dw검정
dwtest(out5_1, alternative="two.sided")





#적합결여검정
ex5_2 <- read.table("C://Users//LGE1//Documents//대학교//4학년 1학기//회귀분석실습1//실습//data_ch5//data5_2.txt", header=TRUE)
attach(ex5_2)
x <- ex5_2$x
y <- ex5_2$y

H0.out <- lm(y~x)
factor(x)
H1.out <- lm(y~factor(x))

anova(H0.out, H1.out)
