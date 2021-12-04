era <- c(5,4,3,4,5,6)
era

year <- 2001:2006
year

game <- c(1,2,8,6,4,4)
game

era * game

era.all <- sum(game*era)/sum(game)
era.all

is.vector(era.all)
is.vector(x)

class(era)
class(year)

era
era[4]
era[1:4]
era[c(1,3,5)]

sum(era)
length(era)
sum(era) / length(era)
mean(era)


sum.1 <- function(x) {
   temp <- 0
   for(i in 1:length(x)) {
       temp <- temp + x[i]
   }
   return(temp)
}

sum.1(era)

5 %% 2
6 %% 2


is.odd <- function(x) {
    return(x %% 2)
}

is.odd(5)
is.odd(10)


sum.two.number <- function(a,b) {
    return(a + b)
}

sum.two.number(1.6, 3.14)


for(i in 1:10) {
    print(i %% 2)
}


if(5 %% 2 == 1) {
    print(TRUE)
} else {
    print(FALSE)
}


is.odd.1 <- function(z) {
    if(z %% 2 == 1) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}

is.odd.1(5)
is.odd.1(8)


e <- c("Park", "LA Dogers")
e
length(e)

c(1,2,3,"Yerin JU")

era
year
game

cbind(era, year, game)

stat <- cbind(era, year, game)
class(stat)
dim(stat)
nrow(stat)
ncol(stat)

e * 3

e <- c(e, e, e)
e

cbind(e, era, year, game)
# 숫자가 들어가면 문자로 취급

rbind(era, year, game)

stat
stat[1, 1]
stat[5, 2]
stat[2,]
stat[,2]

f <- c("Yerin JU", "KGU")

L <- list(game, era, f)
L
L[[1]]
L[[2]]
L[[3]]

L.1 <- list(name=f, era=era, game=game)
L.1
L.1[[1]]
L.1["name"]


year <- 2011:2014
winner <- c("SLN", "SFN", "BOS", "SFN")
loser <- c("TEX", "DET", "SLN", "KCA")
wins <- c(4, 4, 4, 4)
losses <- c(3, 0, 3, 3)

WS <- data.frame(year, winner, loser, wins, losses)
WS

dim(WS)
nrow(WS)
ncol(WS)

WS[1,1]
WS[2,]
WS[,3]
