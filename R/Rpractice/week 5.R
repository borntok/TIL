M <- matrix(sample(1:6), nrow=3, ncol=2)
M

apply(M, 1, sum)
apply(M, 1, min)
apply(M, 1, max)
apply(M, 2, sum)

col.min <- apply(M, 2, min)
col.min
col.max <- apply(M, 2, max)
col.max
col.mean <- apply(M, 2, mean)
col.mean
# 표준편차
col.sd <- apply(M, 2, sd)
col.sd

apply(M, 1, "-", col.mean)

t(apply(M, 1, "-", col.mean))

M.1 <- t(apply(M, 1, "-", col.mean))
M.1

M.normalized <- t(apply(M.1, 1, "/", col.sd))
M.normalized

round(M.normalized, 4)


#43p 연습문제1
M.2 <- t(apply(M, 1, "-", col.min))
M.2
M.norm <- t(apply(M.2, 1, "/", (col.max - col.min)))
M.norm


#set.seed 실행할 때마다 같은 난수 생성
set.seed(330)
x <- runif(10)
x
#오름차순 정렬
sort(x)

x <- runif(10)
sort(x)



set.seed(330)
n <- 1000
p <- 10
R <- matrix(runif(n*p), nrow=n, ncol=p)
head(R)
R.1 <- t(apply(R, 1, sort))
head(R.1)

r.2 <- R.1[, 2]
hist(r.2, xlim=c(0,1), main="두 번째로 작은 아이들")

r.9 <- R.1[, 9]
hist(r.9, xlim=c(0,1), main="두 번째로 큰 아이들")

r.5 <- R.1[, 5]
hist(r.5, xlim=c(0,1), main="다섯 번째로 작은 아이들")



M

colnames(M) <- c("Joey", "Bada$$")
M
rownames(M) <- paste("티켓판매량", 1:3, sep=".")
M


#범주형자료분석

gender <- sample(c(1,2), 10, replace=TRUE)
dummy.gender <- matrix(0, nrow=10, ncol =2)
dummy.gender

for(i in 1:length(gender)) {
    dummy.gender[i, gender[i]] <- 1
}
dummy.gender

apply(dummy.gender, 2, sum)


direction <- sample(c(1,2,3), 100, replace=TRUE)
dummy.dir <- matrix(0, nrow=100, ncol=3)

for(i in 1:length(derection)) {
    dummy.dir[i, direction[i]] <- 1
}
apply(dummy.dir, 2, sum)

