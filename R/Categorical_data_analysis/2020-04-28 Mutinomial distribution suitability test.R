
x <- c(18, 55, 27)
p0 <- c(0.25, 0.5, 0.25)
chisq.test(x, p=p0)
chisq.test(x, p=c(1,2,1), rescale.p=TRUE)
