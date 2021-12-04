set.seed(1)
alpha <- sample(c("A", "B", "C"), 25, replace=TRUE)
alpha

f <- factor(alpha)
f
# 도수분포표
table(f)
table(alpha)

z <- sample(1:5, 25, replace=TRUE)
g <- factor(z)
table(g)
# 분할표
table(f, g)

addmargins(table(f, g))

addmargins(table(f, g)) / 25

tab <- table(f, g)
class(tab)
dim(tab)
rownames(tab)
colnames(tab)


set.seed(2)
x <- round(rnorm(25, 50, 10))
x
f

data.frame(x=x, f=f)

tapply(x, f, mean)
tapply(x, f, median)
tapply(x, f, min)
tapply(x, f, max)
tapply(x, f, sd)

tapply(x, f, function(y) max(y) - min(y))
tapply(x, f, function(y) (max(y) - min(y))**2)

f
g
z
x

s <- split(data.frame(x=x, z=z), f)
class(s)
sapply(s, apply, 2, median)


aggregate(data.frame(x=x, z=z)$x, list(f), sum)
aggregate(data.frame(x=x, z=z)$x, list(f, g), sum)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

set.seed(3)

x <- runif(100,0,10)
x

y <- 5 + 0.5*(x-5) + rnorm(100)

x.cut <- cut(x, 0:10)
class(x.cut)
# cut 속해있는 구간을 보여줌
x.cut
head(x)

# x.cut 레벨의 몇번째에 속해있는지 보여줌
head(cbind(x, x.cut))
head(cbind(y, x.cut))

y.local <- aggregate(y, list(x.cut), mean)

plot(x, y, ylim=c(1,10), main="x vs. y")
segments(0:9, y.local$x, 1:10, y.local$x, lwd=2)
abline(v=1:9, lty="dotted", col="blue")




tab <- tab + 32
tab

chisq.test(tab)