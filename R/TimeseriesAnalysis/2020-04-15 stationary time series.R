
x <- rnorm(400, 0, 1) #정규분포를 따르는 난수 생성
plot.ts(x) #시계열그림
mean(x)

acf(x, plot=FALSE, lag.max=5, type="covariance") #자기상관함수
acf(x, plot=FALSE, lag.max=5, type="correlation")
acf(x, plot=FALSE, lag.max=5, type="partial")

acf(x, plot=TRUE, lag.max=5, type="correlation")
