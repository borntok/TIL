
Clinical <- read.table("http://www.stat.ufl.edu/~aa/cat/data/Clinical.dat", header=TRUE)
Clinical
sum(Clinical$response)
x <- with(Clinical, sum(response))
n <- dim(Clinical)[1]



#Wald interval
hatp <- x/n
SE <- sqrt(hatp*(1-hatp)/n)

qnorm(0.025, 0, 1)
qnorm(c(0.025,0.975), 0, 1)
hatp + qnorm(c(0.025,0.975), 0, 1)



#Agresti interval
A.n <- n+4
A.p <- (x+2)/A.n
A.SE <- sqrt(A.p*(1-A.p)/A.n)
A.p + qnorm(c(0.025,0.975), 0, 1)*A.SE

A.n <- n+qnorm(0.975, 0, 1)^2
A.p <- (x+qnorm(0.975, 0, 1)^2/2)/A.n
A.SE <- sqrt(A.p*(1-A.p)/A.n)
A.p + qnorm(c(0.025,0.975), 0, 1)*A.SE


#Score interval
#prop.test x=성공횟수, n=시행횟수, p=H0 H1 값, alternative=양측?단측?, conf.level=유의수준, correct=연속성수정 여부)
prop.test(9, n=10, conf.level=0.95, correct=FALSE)
prop.test(9, n=10, conf.level=0.95, correct=FALSE)$conf.int





library(binom)
#binom.confint (x=성공횟수, n=시행횟수, conf.level=신뢰수준, methods=agresti/asymptptic(wald)/wilson(score))
binom.confint(9, 10, conf.level=0.95)
binom.confint(9, 10, conf.level=0.95, methods="wilson")
binom.confint(9, 10, conf.level=0.95, methods="asymptotic")
binom.confint(9, 10, conf.level=0.95, methods="agresti-coull")




#소표본검정
binom.test(9, 10, 0.50, alternative="two.sided")
binom.test(9, 10, 0.50, alternative="greater")
binom.confint(9, 10, conf.level=0.95, methods="exact")

dbinom(9, 10, 0.5)
dbinom(10, 10, 0.5)
dbinom(c(9,10), 10, 0.5)
sum(dbinom(c(9,10), 10, 0.5)) #단측검정
sum(dbinom(c(9,10), 10, 0.5))*2 #양측검정

p.9 <- 1-pbinom(8, 10, 0.5) #pbinom 누적확률
p.10 <- 1-pbinom(8, 10, 0.5)
(p.9+p.10)/2 #mid.p-value 단측
(p.9+p.10)/2*2 #m.p 양측

library(exactci)
binom.exact(9,10,0.50, alternative="two.sided")
binom.exact(9,10,0.50, alternative="two.sided", midp=TRUE)




#베이지안 추론
qbeta(c(0.025,0.975), 10, 2) #equal tail distribution
a0 <- pbeta(0.5, 10, 2) #귀무가설 참
a1 <- 1 - pbeta(0.5, 10, 2) #대립가설 참



library(bayestestR)
n <- 1000
posterior <- distribution_beta(n, 10, 2)
hist(posterior, freq=FALSE)
density <- estimate_density(posterior)
lines(density$x, density$y, col="red")
curve(dbeta(x, 10, 2), col="orange", add=TRUE)
ci.eti <- ci(posterior, ci=0.95, method="ETI")
ci.hdi <- ci(posterior, ci=0.95, method="HDI")
abline(v=ci.eti, col="green")
abline(v=ci.hdi, col="blue")
qbeta(c(0.025, 0.975), 10, 2)

