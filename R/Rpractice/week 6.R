members <- list(leaders = c("park", "choi"),
                assistants = "kang",
                workers = c("lee", "kim", "hong", "song")
                )
members

#리스트는 형태가 다른 여러개의 벡터를 가질 수 있다.
class(members)
names(members)

members[[1]]

class(members[[1]])

members[1]

class(members[1])

m.1 <- members[1]
m.1[1]
m.1[[1]]
m.1[[1]][1]
m.1[[1]][2]

members["leaders"]
members[["leaders"]]

members$leaders
members$leaders[1]

members$leaders[1] <- "huh"
members$leaders


salaries <- list(leaders = c(250, 200),
                assistants = 100,
                members = c(300, 200, 180, 120, 100)
                )
team <- list(m = members, s = salaries)
team


team[1]
team[[1]]

team$s$leaders
team[[2]][1]

length(team)
length(team$m)


team.1 <- c(m = members, s = salaries)
team.1
# 접근방법이 한정적
team.1$s.leaders

salaries

mean(salaries$members)


lapply(salaries, mean)
lapply(salaries, median)

class(lapply(salaries, min))

sapply(salaries, median)

# 리스트는 연산이 불가능
lapply(salaries, median) / 100

sapply(salaries, median) / 100

vapply(salaries, range, c(min=0, max=0))

sapply(salaries, range)


members

unlist(members)

median(unlist(salaries))


set.seed(45)
x <- rnorm(10)
x
mean(x)
sd(x)
c(m=mean(x), s=sd(x))

# five number summary
fivenum <- quantile(x)
fivenum

# outlier
fivenum[2] - 1.5 * (fivenum[4] - fivenum[2])
fivenum[4] + 1.5 * (fivenum[4] - fivenum[2])


summarize <- function(x) {
    mean.sd <- c(m=mean(x), s=sd(x))
    fivenum <- quantile(x)
    lower <- fivenum[2] - 1.5 * (fivenum[4] - fivenum[2])
    upper <- fivenum[4] + 1.5 * (fivenum[4] - fivenum[2])
    outliers <- c(x[x < lower], x[x > upper])

    return(list(mean.sd=mean.sd,
                fivenum=fivenum,
                outliers=outliers))
}

set.seed(45)
x <- rnorm(1000)
summarize(x)

lapply(summarize(x), round, 4)




set.seed(45)

cards <- c("Spade", "Heart", "Diamond", "Club")

shuffle.cards <- sample(rep(cards, 52), 52, replace=F)

classified <- list()

for(i in 1:52) {
    r <- shuffle.cards[i]
    classified[[r]] <- c(classified[[r]], i)
}

classified

sapply(classified, length)
