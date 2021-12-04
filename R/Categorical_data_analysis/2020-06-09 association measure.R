
aa <- matrix(c(189, 104, 10845, 10933), nrow=2, ncol=2)

library(epitools)
aa.or <- oddsratio(aa, method="wald", conf=0.95, correct=FALSE)
aa.or$data



library(DescTools)

Phi(aa)
CramerV(aa)
chisq.test(aa, correct=FALSE)
sqrt(chisq.test(aa, correct=FALSE)$statistic /22071)
Lambda(aa)
Lambda(aa, direction="col") #행별 비교
Lambda(aa, direction="row") #열별 비교





library(MASS)
Cars93

x <- Cars93$Type
table(x)
prop.table(table(x)) #상대도수를 활용한 도수분포표

y <- Cars93$Origin
table(y)
prop.table(table(y))

table(x,y)
prop.table(table(x,y)) #칸비율
prop.table(table(x,y), margin=1) #행비율
prop.table(table(x,y), margin=2) #열비율

chisq.test(x, y, correct=FALSE)
fisher.test(x, y)
GTest(x, y) #LRT 통계량 계산

CramerV(x, y)
Lambda(x, y)

Lambda(x, y, direction="col") #행별 비교
l.sum <- 7+0+10+7+6+4
colSums(table(x,y))
l <- 45
(l - l.sum)/l

Lambda(x, y, direction="row") #열별 비교
l1 <- 48-11
l2 <- 45-14
rowSums(table(x,y))
l <- rowSums(table(x,y))-22
(71-(37+31))/71
