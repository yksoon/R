# 벡터 만들기
x <- c(80, 85, 70)
x

c(80, 85, 70) -> x
x


# 벡터 원소가 하나일 때
x <- c(80)
x

x <- 80
x


# 산술 연산
x ＜－ c(1, 2, 3, 4, 5)

x[2]
x[c(1, 3, 5)]
x[-c(2, 4)]
x[x＞2]
x[x＞=2 & x＜=4] 
x[2] ＜－ 20
x[c(3, 4)] ＜－ 15   
x[x＜=15] ＜－ 10

x ＜－ seq(1:10)

mean(x)
var(x)
sd(x)
sqrt(x)
length(x)
abs(x)

x <- array(1:3, dim=c(3))


x <- array(1:6, dim=c(2, 3))
x

v1 <- c(1,2,3,4)
v2 <- c(5,6,7,8)
v3 <- c(9,10,11,12)

x <- cbind(v1, v2, v3)
x

x <- list("홍길동", "2016001", 20, c("IT융합", "데이터 관리"))
x

y = list("성명"="홍길동", "학번"="2016001", "나이"=20, "수강과목"=c("IT융합", "데이터 관리"))
y



x <- data.frame(성명=c("홍길동", "손오공"), 나이=c(20,30), 주소=c("서울","부산"))
x


x <- cbind(x, 학과=c("전산학","경영학"))
x

x <- rbind(x, data.frame(성명="장발장", 나이=40, 주소="파리", 학과="전산학"))
x


head(quakes, n=10)
tail(quakes, n=6)
names(quakes)
str(quakes)
dim(quakes)
summary(quakes)
summary(quakes$mag)


write.table(quakes, "C:/YKS/R/quakes.txt", sep=",")

x <- read.csv("C:/YKS/R/quakes.txt", header=T)
x

x <- read.csv(file.choose(), header=T)
x

height <- c(9,15,20,6)

name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")

barplot(height, names.arg=name, main="부서별 영업 실적", col=rainbow(length(height)),xlab="부서", ylab="영업 실적(억 원)")


x <- c(9,15,20,6)

label <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")

pie(x, labels = label, mail="부서별 영업 실적")







