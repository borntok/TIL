
x <- 1:5
y <- x+rnorm(5, 0, 1)
plot(x,y)
cbind(x, y)

cor(x, y, method="pearson")
cor(x, y, method="spearman")
cor(rank(x), rank(y))
cor(x, y, method="kendall")




tea <- matrix(c(3,1,1,3), nrow=2)


dd <- data.frame(x = rep(1,3), y = rep(1,3))
dd <- rbind(dd, data.frame(x = rep(1,1), y = rep(2,1)))
dd <- rbind(dd, data.frame(x = rep(2,1), y = rep(1,1)))
dd <- rbind(dd, data.frame(x = rep(2,3), y = rep(2,3)))
cor(dd)
cor(dd, method="spearman")
cor(dd, method="kendall")

cbind(rank(dd[,1]), rank(dd[,2]))
cor(cbind(rank(dd[,1]), rank(dd[,2])))


dd[(1:4),1] <- 0
dd[(5:8),1] <- 5
cor(dd)
cor(dd, method="spearman")
cor(dd, method="kendall")






u <- c(0, 0.5, 1.5, 4, 7)

u <- 1:5
v <- c(0, 1)
n <- matrix(c(17066, 14464, 788, 126, 37, 48, 38, 5, 1, 1), nrow=5)
dd <- data.frame(x=rep(u[1], n[1,1]), y=rep(v[1], n[1,1]))
dd <- rbind(dd, data.frame(x=rep(u[1], n[1,2]), y=rep(v[2], n[1,2])))
dim(dd)

for(i in 2:5) {
     dd <- rbind(dd, data.frame(x=rep(u[i], n[i,1]), y=rep(v[1], n[i,1])))
     dd <- rbind(dd, data.frame(x=rep(u[i], n[i,2]), y=rep(v[2], n[i,2])))
}
dim(dd)

cor(dd, method="pearson")
cor(dd, method="spearman")
cor(dd, method="kendal")





library(vcdExtra)
CMHtest(n)
CMHtest(n, rscores=c(0, 0.5, 1.5, 4, 7))
CMHtest(n, rscores="midrank") #spearman 순위상관계수

