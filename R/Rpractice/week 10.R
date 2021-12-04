for(i in 1:10) {
    print(i)
}

for(x in c(1,3,2,7)) {
    print(x)
}


set.seed(1)
x <- rnorm(100)

sum <- 0
for(ix in x) {
   sum <- sum + ix
}

sum / length(x)

mean(x)


sum <- 0
for(i in 1:length(x)) {
    sum <- sum + x[i]
}

sum / length(x)


i <- 0
while(i < 10) {
    print(i)
    i <- i + 1
}


x

sum = 0
for(ix in x) {

    if(ix < 0) {
        sum <- sum + ix
    }
}
sum


n_sum <- 0
p_sum <- 0
for(ix in x) {

    if(ix < 0) {
        n_sum <- n_sum + ix
    } else {
        p_sum <- p_sum + ix
    }
}
n_sum
p_sum


flag <- TRUE
i <- 0
while(flag) {
    print(i)
    if(i > 9) {
        flag <- FALSE
    } 
    i <- i + 1
}



rin_mean <- function(x) {
    n <- length(x)
    sum <- 0
    for(ix in x) {
        sum <- sum + ix
    }
    rin_m <- sum / n
    return(rin_m)
}

rin_mean(x)



v <- c(1,2,3)
v[-1]


rin <- function(x) {
    if(length(x) <= 1) {
        return()
    }
    pivot <- x[1]
    therest <- x[-1]
    sv1 <- therest[therest < pivot]
    sv2 <- therest[therest >= pivot]

    sv1 <- rin(sv1)
    sv2 <- rin(sv2)

    sorted_x <- c(sv1, pivot, sv2)

    return(sorted_x)
}

rin(x)


rin <- function(x) {
    if(length(x) <= 1) {
        return()
    }
    pivot <- x[1]
    therest <- x[-1]
    sv1 <- therest[therest >= pivot]
    sv2 <- therest[therest < pivot]

    sv1 <- rin(sv1)
    sv2 <- rin(sv2)

    sorted_x <- c(sv1, pivot, sv2)

    return(sorted_x)
}

rin(x)

class(rin)
ls()












k <- c(3,7,1,9,4,6,2,5,8,0)
S <- function(x) {
    f <- vector(length=10)
    for(i in 1:10) {
        f[i] <- x[i] > x[i+1]
    }
    return(f)
    }
S(k)