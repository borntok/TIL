setwd("C:/Users/KGU/Documents/temp/chapter_8_input and output")
dir()

exams <- read.table("exams.txt", header=TRUE)
str(exams)

exmas_2 <- read.table("exams_2.txt", header=TRUE)
str(exams)

exams$total <- exams$mid + exams$final
head(exams)

write.table(exams, file="exams_t.txt", row.names=FALSE)
str(exams)


survey <- read.table("survey.txt", header=TRUE)
str(survey)

survey.1 <- read.table("survey.txt", header=TRUE, stringsAsFactors=F)
str(survey.1)



ex <- read.csv("exams.csv", header=TRUE)


lyrics <- scan("yesterday.txt", what="")
str(lyrics)

lyrics.2 <- scan("yesterday.txt", what="", sep="\n")
head(lyrics.2)


uni.abalone <- "http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"
abalone <- read.csv(uni.abalone, header=FALSE)
str(abalone)

with(abalone, boxplot(V2~V1, main="전복길이", ylim=c(0,1)))


