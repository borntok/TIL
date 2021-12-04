

exams <- read.csv("exams.csv", header=TRUE)
exams

str(exams)

class(exams)
dim(exams)

colnames(exams)

is.list(exams)

length(exams)

exams$mid

exams[[2]]

exams[exams$course.id == 10,]

exams[c(5, 15),]


exams[exams$course.id == 10, "final"]

median(exams[,2])

median(exams$mid)

median(exams$final)

median(exams$final, na.rm=TRUE)

is.na(exams$final)

exams$final[is.na(exams$final)] <- 0

median(exams$final)

#pch : 점 모양 / xlim : x축의 범위
plot(final ~ mid, data=exams, pch=20, 
      xlim=c(0,45), ylim=c(0,45), main="exam scores")

with(exams, plot(final ~ mid, pch=19, 
      xlim=c(0,45), ylim=c(0,45), main="exam score")
    )

with(exams, cor(mid, final))
cor(mid, final, data=exams)
cor(exams$mid, exams$final)


book2 <- read.csv("book2.csv", header=TRUE)
str(book2)

summary(book2[,2:3])

book2$project[is.na(book2$project)] <- 0

summary(book2$project)


i.order <- order(book2$course.id)
i.order

book2[i.order,]

scoring.data <- merge(exams, book2[i.order,])
head(scoring.data)


score <- apply(scoring.data[,c(2,3,5,6)], 1, sum)
score

hist(score)

scoring.data$score <- score
head(scoring.data)


max(scoring.data$score)

#normalizing
n.score <- scoring.data$score / max(scoring.data$score)
hist(n.score)



set.seed(9422)
g <- sample(c("A", "B"), 100, replace=TRUE)
x <- rnorm(100, 50, 10)

D <- data.frame(grp=g, score=x)
head(D)

boxplot(score ~ grp, xlab="score", 
          horizontal=TRUE, data=D)

with(D, boxplot(score ~ grp))

set.seed(1)
x <- data.frame(math=rnorm(100), stat=rnorm(100))
x[sample(1:100, 20),1] <- NA
x[sample(1:100, 20),2] <- NA
head(x)

head(complete.cases(x))

x.comp <- x[complete.cases(x), ]
head(x.comp)

sorted.x <- x.comp[order(x.comp[,1]),]
head(sorted.x)

airquality
str(airquality)


subset(airquality, Temp > quantile(Temp, 0.95))
