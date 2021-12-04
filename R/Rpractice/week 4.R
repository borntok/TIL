n <- 100
p <- 3

x <- rnorm(n * p)

A <- matrix(x, nrow = n, ncol = p)
A
head(A)
tail(A)

A[1:6,]

A[7:12, 1:2]

A[c(1,3,5), 1]

A[, 1] > 0

b <- c(-1, 1, -1, 0)
b > 0
b[b > 0]
b[b == -1]

A[A[, 1] > 0, ]

3 > 2 & 4 > 2
3 > 2 & 4 < 2
3 < 2 & 4 < 2

# |는 or
3 > 2 | 4 < 2

# 필터링,쿼리
A[A[,1] > 0 & A[,2] > 0, ]

A[A[,1] < 0 & A[,3] > 0, ]

A <- matrix(6:1, nrow = 3, ncol=2)
A

t(A)

C <- matrix(c(16,4,1,4,4,1,1,1,1), nrow=3, ncol=3)
C
solve(C)

solve(C) %*% C

# 어려움, 행렬이론 알아야함
n <- 100
x0 <- rep(1, n)
x1 <- rnorm(100)
x2 <- rnorm(100)

X <- cbind(x0, x1, x2)

beta0 <- 1.5
beta1 <- 0.6
beta2 <- -1.36

y <- beta0 + beta1*x1 + beta2*x2 + rnorm(n)

b <- solve(t(X)%*%X)%*%t(X)%*%y

b


y


sum_y <- 0
for(yi in y){
    sum_y <- sum_y + yi
}
sum_y

sum_y <- 0
for(yi in y){
    sum_y = sum_y + yi
}
sum_y

sum_y <- 0
for(i in 1:length(y)) {
    sum_y = sum_y + y[i]
}
sum_y


#리턴이 있어야 개체에 어사인가능
two.number.sum <- function(a, b) {
    c <- a + b
    return(c)
}
two.number.sum(12.3, 42.9)


rin.sum <- function(y) {
   sum_y = 0
   for(yi in y){
      sum_y = sum_y + yi
   }
   return(sum_y)
}
rin.sum(y)


elegance.rin.mean <- function(y) {
   return(rin.sum(y) / length(y))
}
elegance.rin.mean(y)



rin.mean <- function(y) {
   sum_y <- 0
   for(i in 1:length(y)) {
      sum_y = sum_y + y[i]
   }
   mean <- sum_y / length(y)
   return(mean)
}
rin.mean(y)