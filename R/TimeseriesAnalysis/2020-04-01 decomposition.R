#분기별 매출액 자료
x <- c(10, 31, 43, 16, 11, 33, 45, 17, 13, 34, 48, 19, 15, 37, 51, 21)
is.ts(x)

x.ts <- ts(x, frequency = 4, start = c(2009, 1))
x.ts
plot(x.ts)

decompose(x.ts) #분해법

