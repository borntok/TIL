x <- c(30, 20, 60, 80, 40, 50, 60, 30, 70, 60)
y <- c(73, 50, 128, 170, 87, 108, 135, 69, 148, 132)
plot(x,y)

k <- 1001  # k <- 1001과 비교
a0 <- seq(from=5, to=15, length.out=k) #seq = 등차수열 (length.out 등차수열 개수)
a1 <- seq(from=0, to=10, length.out=k)
SS.diff <- matrix(nrow=k, ncol=k)

for(i in 1:k){
 for(j in 1:k){
  haty <- a0[i] + a1[j]*x
  diff <- y - haty
  SS.diff[i,j] <- sum(diff^2)
 }
}

index <- which(SS.diff == min(SS.diff), arr.ind=TRUE)
b0 <- a0[index[1]]
b1 <- a1[index[2]]
#b0=10, b1=2 
#y절편은 2이고, 기울기가 10일 때 최소값을 갖는다





<정규방적식의 해>-행렬
x <- c(30, 20, 60, 80, 40, 50, 60, 30, 70, 60)
y <- c(73, 50, 128, 170, 87, 108, 135, 69, 148, 132)

X.mat <- cbind(rep(1, length(x)), x)
solve(t(X.mat)%*%X.mat) #역행렬 구하기
(solve(t(X.mat)%*%X.mat))%*%(t(X.mat)%*%y)



#최소제곱법을 이용한 단순선형회귀분석 함수
lm(y~x)