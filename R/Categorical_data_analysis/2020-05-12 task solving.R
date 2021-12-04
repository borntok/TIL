

#1.3
a <- (50-25)/sqrt(300/4)
pnorm(a, 0, 1, lower.tail=FALSE)
1-pnorm(a, 0, 1)
pbinom(49, 100, 0.25, lower.tail=FALSE)
1-pbinom(49, 100, 0.25)


#1.8
qnorm(0.995, 0, 1) 
#score interval
prop.test(486, n=1374, conf.level=0.99, correct=FALSE)

library(binom) 
#wald interval
binom.confint(486, 1374, conf.level=0.99, method="asymptotic")

z <- ((486/1373)-0.5)/sqrt(0.5*0.5/1374)
pnorm(z, 0, 1)
prop.test(486, n=1374, correct=FALSE, alternative="less")



#1.9
zz <- (60/100-0.5)/sqrt(0.5^2/100)
pnorm(zz, 0, 1, lower.tail=FALSE)
prop.test(60, 100, correct=FALSE, alternative="two.sided")

0.6+1.96*sqrt(0.6*0.4/100)
0.6-1.96*sqrt(0.6*0.4/100)

