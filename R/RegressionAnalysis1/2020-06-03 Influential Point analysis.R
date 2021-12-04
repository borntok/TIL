

IF <- read.csv("C://Users//LGE1//Documents//대학교//4학년 1학기//회귀분석실습1//실습//IF_data.csv", header=TRUE)
fit <- with(IF, lm(y~x))

lm.influence(fit)
hat <- lm.influence(fit)$hat
hat > 2*mean(hat)
which(hat > 2*mean(hat))



residuals(fit)

rstandard(fit)
c.rs <- 2.78+(2.89-2.78)/5
which(rstandard(fit) > c.rs)

rstudent(fit)
qt(0.975, 20-2)
which(rstudent(fit) > qt(0.975, 20-2))

with(IF, plot(x,y))




dfbetas(fit)
which(dfbetas(fit) > 2/sqrt(21))

dffits(fit)
which(abs(dffits(fit)) > 2*sqrt(2/21))

cooks.distance(fit)
which(cooks.distance(fit) > qf(0.5, 2, 21-1-1))

influence.measures(fit)

ls.diag(fit)

plot(fit)


