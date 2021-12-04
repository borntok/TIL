
Political <- read.table("http://www.stat.ufl.edu/~aa/cat/data/Political.dat", header=TRUE)
head(Political)
tail(Political)

Party <- factor(Political$party, levels=c("Dem", "Rep", "Ind"))
GenderGap <- xtabs(~gender+Party, data=Political)

chisq.test(GenderGap)


GenderGap1 <- matrix(c(495, 272, 590, 330, 265, 498), nrow=2, ncol=3, byrow=TRUE)
chisq.test(GenderGap1)

result <- chisq.test(GenderGap1)
result$statistic
result$parameter
result$p.value
result$observed
result$expected
result$resid
result$stdres


