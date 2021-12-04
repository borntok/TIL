x <- c(2,4,5,8,10)
x
length(x)

#x에 있는 원소들을 순서대로 가져와서 xi라는 변수에 할당한 다음 xi를 출력
for(xi in x) {
    print(xi)
}

#x의 i번째 원소를 인덱싱
for(i in 1:length(x)) {
    print(x[i])
}


#길이가 1인 벡터는 스칼라
y <- 1
is.vector(y)

pi
print(pi, 16)

#값은 없지만 길이가 10인 벡터
f <- vector(length=10)
f

f[1] <- 1
f[2] <- 1
f

for(i in 3:length(f)) {
   f[i] <- f[i-1] + f[i-2]
}
f

M <- matrix(1:12, nrow=4, ncol=3)
M

M.1 <- matrix(1:12, nrow=4, ncol=3, byrow=TRUE)
M.1

M.2 <- matrix(1:10, nrow=4, ncol=3)
M.2

f[1:2]

#[-] 특정한 벡터에서 그 위치에 있는 원소를 제거
f[-1]
f
f[-3]
f[c(1,3,5,7,9)]

5 %% 2
f %% 2

sum(f %% 2)
#짝수의 개수를 구하는 법
length(f) - sum(f %% 2)


#등차수열
seq(0, 10, by=2.5)

seq(0, 10, length=5)

seq(0, 10, length=6)

rep(3, times=10)

NA
NULL

z <- c(1,2,NULL,4)
z
sum(z)
z[3]

w <- c(1,2,NA,4)
w
sum(w)
sum(w, na.rm=TRUE)

f

(f %% 2) == 1

f[(f %% 2) == 1]

d <- c(1,2,3)
d[c(TRUE,FALSE,TRUE)]

3 == 3
3 != 3

f[(f %% 2) != 1]

subset(f, f %% 2 != 1)


g <- c(-0.6,-0.1,1,0,2.5)

ifelse(g > 0, g, 2*g)

h <- c(1,2,3)
k <- 1:3
h
k
class(h)
class(k)
identical(h, k)

all(h == k)

cbind(h, k)
M.3 <- cbind(h, k)

h
names(h) <- c("x", "y", "z")
h
names(h)


3^2
# 0.5승은 루트
3^0.5
3**2
5 %/% 2


rx <- rnorm(400, 50, 10)
hist(rx, nclass=20, main="정규분포 모의실험")

rx <- rnorm(4000, 50, 10)
hist(rx, nclass=20, main="정규분포 모의실험")


ru <- runif(400, 10, 20)
hist(ru, nclass=10, main="균일분포")

ru <- runif(40000, 10, 20)
hist(ru, nclass=10, main="균일분포")


re <- rexp(400, 0.15)
hist(re, nclass=20, main="지수분포")

re <- rexp(40000, 0.15)
hist(re, nclass=20, main="지수분포")


rb <- rbinom(400, 10, 0.2)
table(rb)
barplot(table(rb), ylab="도수", main="이항분포")

rb <- rbinom(400, 10, 0.1)
table(rb)
barplot(table(rb), ylab="도수", main="이항분포")

rb <- rbinom(400, 10, 0.9)
table(rb)
barplot(table(rb), xlab="엑스", ylab="도수", main="이항분포")


rp <- rpois(400, 3.5)
table(rp)
barplot(table(rp))

rp <- rpois(40000, 35)
table(rp)
barplot(table(rp))


LETTERS
LETTERS[1:3]

sample(LETTERS, 10, replace=TRUE)

sample(LETTERS, 10, replace=FALSE)
