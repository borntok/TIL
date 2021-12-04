library(Lahman)
data(Pitching)
str(Pitching)



# 메이저리그 전체 평균자책점 (1871~2016)

lose.point <- (Pitching$G*Pitching$ERA)
lose.point.sum <- sum(lose.point, na.rm=TRUE)
G <- (Pitching$G)
G.sum <- sum(G, na.rm=TRUE)
era.all <- (lose.point.sum/G.sum)
print(era.all)


data(Salaries)
str(Salaries)

d <- subset(Pitching, yearID==1985)
d$G

# 메이저리그 평균연봉 (1985~2016)

salaries <- Salaries$salary
salaries.sum <- sum(as.numeric(salaries))
players <- 26428
average.salary <- (salaries.sum/players)
print(average.salary)


str(Park)
# 박찬호 평균자책점 (1994~2010)

Park <- subset(Pitching, playerID == "parkch01")
P.lose.point <- sum(Park$G*Park$ERA)
G <- sum(Park$G)
Park.era <- (P.lose.point/G)
print(Park.era)



# 박찬호 평균연봉 (1994~2010)

Park.s <- subset(Salaries, playerID == "parkch01")
P.salary <- sum(Park.s$salary)
P.year <- 15
P.average.salary <- (P.salary/P.year)
print(P.average.salary)



# 메이저리그 평균자책점 (1994~2001)
mlb.1 <- subset(Pitching, yearID >= 1994 & yearID < 2002)
lose.point.1 <- (mlb.1$G*mlb.1$ERA)
lose.point.1.sum <- sum(lose.point.1, na.rm=TRUE)
G.1 <- (mlb.1$G)
G.1.sum <- sum(G.1, na.rm=TRUE)
mlb.1.era <- (lose.point.1.sum/G.1.sum)
print(mlb.1.era)
4.514691

# 박찬호 LA다저스 소속 기간 평균자책점 (1994~2001)
Park.LA <- subset(Park, yearID >= 1994 & yearID < 2002)
lose.point.LA <- sum(Park.LA$G*Park.LA$ERA)
G.LA <- sum(Park.LA$G)
era.LA <- (lose.point.LA/G.LA)
print(era.LA)
3.847466

# 메이저리그 평균연봉 (1994~2001)
mlb.s1 <- subset(Salaries, yearID >= 1994 & yearID < 2002)
salary.t1 <- sum(as.numeric(mlb.s1$salary))
players.1 <- 7426
average.s1 <- (salary.t1/players.1)
print(average.s1)
1,395,487

# 박찬호 LA다저스 소속 기간 평균연봉 (1994~2001)
Park.LA.s <- subset(Salaries, playerID == "parkch01")
Park.LA.s1 <- subset(Park.LA.s, yearID >= 1994 & yearID < 2002)
P.salary.LA <- sum(Park.LA.s1$salary) 
P.year.LA <- 8
P.average.salary.LA <- (P.salary.LA/P.year.LA)
print(P.average.salary.LA)
2,170,875



# 메이저리그 평균자책점 (2002~2005)
mlb.2 <- subset(Pitching, yearID >= 2002 & yearID < 2006)
lose.point.2 <- (mlb.2$G*mlb.2$ERA)
lose.point.2.sum <- sum(lose.point.2, na.rm=TRUE)
G.2 <- (mlb.2$G)
G.2.sum <- sum(G.2, na.rm=TRUE)
mlb.2.era <- (lose.point.2.sum/G.2.sum)
print(mlb.2.era)
4.300098

# 박찬호 텍사스레인저스 소속 기간 평균자책점 (2002~2005)
Park.TEX <- subset(Park, yearID >= 2002 & yearID < 2006)
lose.point.TEX <- sum(Park.TEX$G*Park.TEX$ERA)
G.TEX <- sum(Park.TEX$G)
era.TEX <- (lose.point.TEX/G.TEX)
print(era.TEX)
5.852179

# 메이저리그 평균연봉 (2002~2005)
mlb.s2 <- subset(Salaries, yearID >= 2002 & yearID < 2006)
salary.t2 <- sum(as.numeric(mlb.s2$salary))
players.2 <- 3335
average.s2 <- (salary.t2/players.2)
print(average.s2)
2,522,255

# 박찬호 텍사스레인저스 소속 기간 평균연봉 (2002~2005)
Park.TEX.s <- subset(Salaries, playerID == "parkch01")
Park.TEX.s1 <- subset(Park.TEX.s, yearID >= 2002 & yearID < 2006)
P.salary.TEX <- sum(Park.TEX.s1$salary) 
P.year.TEX <- 4
P.average.salary.TEX <- (P.salary.TEX/P.year.TEX)
print(P.average.salary.TEX)
12,221,201
