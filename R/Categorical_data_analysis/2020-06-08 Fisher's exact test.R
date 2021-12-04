

TeaTasting <-
matrix(c(3, 1, 1, 3),
       nrow = 2,
       dimnames = list(Guess = c("Milk", "Tea"),
                       Truth = c("Milk", "Tea")))

fisher.test(TeaTasting, alternative="greater")
fisher.test(TeaTasting, alternative="two.sided")

library(epitools)
ormidp.test(3,1,1,3)

or.midp(TeaTasting)
