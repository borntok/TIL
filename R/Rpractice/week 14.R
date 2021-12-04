n <- 100000
m <- 100

A <- matrix(rnorm(n*m, 100, 15), n, m)

time <- proc.time()
a.max <- apply(A, 1, max)
proc.time() - time

windows(height=5, width=6)
hist(a.max, xlim=c(120, 180), xlab="x.max")

summary(a.max)


time <- proc.time()
a.min <- apply(A, 1, min)
proc.time() - time

windows(height=5, width=6)
hist(a.min, xlim=c(120, 180), xlab="x.min")


# apply 함수
my.apply <- function(X, f) {
   out <- rep(0, nrow(X))
   for (i in 1:nrow(X)) {
        out[i] <- f(X[i,])
   }
   return(out)
}

time <- proc.time()
my.max <- my.apply(A, max)
proc.time() - time



n <- 1000000
m <- 100
s <- rpois(n, m)
head(s)
A <- vector(mode="list", length=n)
head(A)

for(i in 1:n) {
    A[[i]] <- rnorm(s[i], 100, 15)
}

head(A)

time <- proc.time()
list.max <- lapply(A, max)
proc.time() - time

time <- proc.time()
slist.max <- sapply(A, max)
proc.time() - time
head(slist.max)



#절삭평균
trim.mean <- sapply(A, mean, trim=0.1)
hist(trim.mean)


x <- mapply(rnorm, rep(40, 100), 1:100, 1:100, SIMPLIFY=TRUE)
head(x)

mean.x <- apply(x, 2, mean)

plot(mean.x)




n <- 10000
m <- 100
N <- n*m
x <- rnorm(N, 100, 15)
grp <- sample(1:5, N, replace=TRUE)
tapply(x, grp, max)
boxplot(x~grp)
n <- 100000
m <- 100

A <- matrix(rnorm(n*m, 100, 15), n, m)

time <- proc.time()
a.max <- apply(A, 1, max)
proc.time() - time

windows(height=5, width=6)
hist(a.max, xlim=c(120, 180), xlab="x.max")

summary(a.max)


time <- proc.time()
a.min <- apply(A, 1, min)
proc.time() - time

windows(height=5, width=6)
hist(a.min, xlim=c(120, 180), xlab="x.min")


# apply 함수
my.apply <- function(X, f) {
   out <- rep(0, nrow(X))
   for (i in 1:nrow(X)) {
        out[i] <- f(X[i,])
   }
   return(out)
}

time <- proc.time()
my.max <- my.apply(A, max)
proc.time() - time



n <- 1000000
m <- 100
s <- rpois(n, m)
head(s)
A <- vector(mode="list", length=n)
head(A)

for(i in 1:n) {
    A[[i]] <- rnorm(s[i], 100, 15)
}

head(A)

time <- proc.time()
list.max <- lapply(A, max)
proc.time() - time

time <- proc.time()
slist.max <- sapply(A, max)
proc.time() - time
head(slist.max)



#절삭평균
trim.mean <- sapply(A, mean, trim=0.1)
hist(trim.mean)


x <- mapply(rnorm, rep(40, 100), 1:100, 1:100, SIMPLIFY=TRUE)
head(x)

mean.x <- apply(x, 2, mean)

plot(mean.x)




n <- 10000
m <- 100
N <- n*m
x <- rnorm(N, 100, 15)
grp <- sample(1:5, N, replace=TRUE)
tapply(x, grp, max)
boxplot(x~grp)
