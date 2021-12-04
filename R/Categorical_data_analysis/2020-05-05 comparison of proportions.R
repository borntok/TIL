
x <- c(189, 104)
n <- c(11034, 11037)
prop.test(x=x, n=n, conf.level=0.95, correct=FALSE)
prop.test(x=x, n=n, alternative="greater", conf.level=0.95, correct=FALSE)

prop.test(x=x+1, n=n+2, conf.level=0.95, correct=FALSE)



library(PropCIs)
diffscoreci(189, 11034, 104, 11037, conf.level=0.95)
riskscoreci(189, 11034, 104, 11037, conf.level=0.95)