

library(epitools)
oddsratio(c(189, 10845, 104, 10933), method="wald")


library(PropCIs)
orscoreci(189, 11034, 104, 11037, conf.level=0.95)