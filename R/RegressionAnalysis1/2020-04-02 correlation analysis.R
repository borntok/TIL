<상관계수의 추정>

library(MASS)

n <- 1000
rho <- 0.5 #모상관계수
k <- 1000
corr.vec <- rep(0, k) #0이 k개 있는 벡터생성

for(i in 1:k){
    X <- mvrnorm(n, mu=c(0,0), Sigma=matrix(c(1,rho,rho,1), nrow=2, ncol=2))
    corr.vec[i] <- cor(X[,1], X[,2])
}

summary(corr.vec)
hist(corr.vec, xlim=c(-1,1)); abline(v=rho, col="red")

par(mfrow=c(1,3)) #그림을 여러개 그릴 수 있는 함수




<Null distribution> 귀무가설이 참일 때 검정통계량이 갖는 분포

n <- 100
rho <- 0.0
k = 1000
corr.vec <- rep(0, k)
t.vec <- rep(0, k)

for(i in 1:k){
    X <- mvrnorm(n, mu=c(0,0), Sigma=matrix(c(1,rho,rho,1), nrow=2, ncol=2))
    s.cor <- cor(X[,1], X[,2])
    corr.vec[i] <- s.cor
    t.vec[i] <- s.cor*sqrt(n-2)/sqrt(1-s.cor^2)
}

par(mfrow=c(1,2))
summary(corr.vec)
hist(corr.vec); abline(v=rho, col="red")
summary(t.vec)
hist(t.vec, freq=FALSE); abline(v=rho, col="red")
curve(dt(x,n-2), add=TRUE, col="blue")





<cars 자료와 trees 자료>
data(cars)
cars
names(cars)
dim(cars)

attach(cars)
plot(speed, dist)
plot(cars)
cor(speed, dist)
cor(cars)
cor.test(speed, dist)

attach(trees)
names(trees)
plot(trees)
dim(trees)
pairs(trees)
plot(Girth, Height)
detach(trees)