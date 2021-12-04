getwd()
setwd()
dir()


lyrics <- scan("yesterday.txt", what="")
str(lyrics)


grep("Yesterday", lyrics)
lyrics[105]

grep("yesterday", lyrics)

grep("\\?", lyrics)

grep("\\,", lyrics)

lyrics[18]

nchar(lyrics[1])
nchar(lyrics)

paste("JU", "Yerin", sep=" ")
paste(2018, 05, 18, sep="-")
paste(2018, "05", 18, sep="-")

substr("20180518", 7, 8)
substr("20180518", 1, 4)

date <- strsplit("2018-05-18", "-")
str(date)
strsplit(c("a-b-c", "d-e-f"), "-")


unlist(gregexpr(",", lyrics[1]))

gsub(",", "", lyrics[1])
gsub("Yesterday", "yesterday", lyrics)


tolower("Yesterday")
toupper("Yesterday")

tolower(lyrics)

grep("y", lyrics, ignore.case=TRUE)

grep("y.", lyrics, ignore.case=TRUE)

lyrics[1]


A <- grep("y", lyrics, ignore.case=TRUE)
A.1 <- grep("y.", lyrics, ignore.case=TRUE)

A %in% A.1
lyrics[A[10]]


grep(".h.", lyrics, ignore.case=TRUE)
lyrics[56]


filelist <- dir()
filelist

strsplit(filelist, ".", fixed=T)

sapply(strsplit(filelist, ".", fixe=T), "[", 2)

grep("\\d", filelist)
grep("\\s", filelist)
grep("\\_", filelist)


# step1: pre-processing

lyrics
lyrics.1 <- gsub(",", "", lyrics)
lyrics.1 <- gsub("\\.", "", lyrics.1)
lyrics.1 <- gsub("\\!", "", lyrics.1)
lyrics.1 <- gsub("\\?", "", lyrics.1)
lyrics.1

# step2: lower case

lyrics.1 <- tolower(lyrics.1)
lyrics.1

# word count
tab.1 <- table(lyrics.1)
tab.1

# concatenation : minimum count
tab.2 <- sort(tab.1, decreasing=T)
tab.2a <- tab.2[tab.2 > 1]
tab.2a # vocabulary

# Visualization
par(mar=c(4,6,4,4))
barplot(rev(tab.2a), horiz=TRUE, las=2)

# word cloud
library(wordcloud)
windows(width=4, height=4)
par(mar=c(2,2,2,2))
wordcloud(words=names(tab.1), freq=tab.1, min.freq=1, colors=rainbow(10))