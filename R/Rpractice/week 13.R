library(datasets)
data(PlantGrowth)
head(PlantGrowth, 20)

str(PlantGrowth)

table(PlantGrowth$group)

anova(with(PlantGrowth, lm(weight ~ group)))

rst <- lm(PlantGrowth$weight ~ PlantGrowth$group)
summary(rst)
anova(rst)


PlantGrowth

plant.tab <- unstack(PlantGrowth, weight ~ group)
class(plant.tab)

plant.tab
stack(plant.tab)


windows(height=5, width=4)
with(PlantGrowth, boxplot(weight ~ group, main="adf"))


plant.tab
class(plant.tab)
plant.tab.1 <- t(plant.tab)
class(plant.tab.1)

plant.tab.1

plant.tab.2 <- as.data.frame(plant.tab.1)
plant.tab.2

colnames(plant.tab.2) <- paste("rep", 1:10, sep=".")
plant.tab.2


is.matrix(plant.tab.1)
is.array(plant.tab.1)

library(datasets)
data(UCBAdmissions)
class(UCBAdmissions)
is.array(UCBAdmissions)
UCBAdmissions
UCBAdmissions[1,1,1]
UCBAdmissions[,1,1]

mosaicplot(UCBAdmissions, off=c(2,2,5),
           dir=c("v","v","h"),
           col=rainbow(6), main="asdf")

UCB.321 <- aperm(UCBAdmissions, c(3,2,1))
UCB.321

mosaicplot(UCB.321, off=c(10,5,0),
           dir=c("v","v","h"),
           col=rainbow(2), main="asdf")


library(datasets)
data(Indometh)
Indometh

Indometh$BP <- round(rnorm(nrow(Indometh), 100, 15))

Indometh.wide <- reshape(Indometh, idvar="Subject", 
          v.names=c("conc", "BP"), timevar="time",
          sep="_", direction="wide")

Indometh.wide

Indometh.wide.1 <- data.frame(Indometh.wide)

Indometh.long.1 <- reshape(Indometh.wide.1,
          idvar="Subject",
          varying=colnames(Indometh.wide.1)[-1],
          sep="_", direction="long")
Indometh.long.1