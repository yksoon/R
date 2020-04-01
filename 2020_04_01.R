# 데이터 입력해 데이터프레임 만들기

english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
english

math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
math

# english, math로 데이터 프레임 생성해서 df_midterm에 할당
df_midterm <- data.frame(english, math)
df_midterm

class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm

mean(df_midterm$english)  # df_midterm의 english로 평균 산출
mean(df_midterm$math)     # df_midterm의 math로 평균 산술

# 데이터프레임 한번에 만들기
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))

df_midterm

## Q. data.frame()과 c()를 조합해서 표의 내용을 데이터 프레임으로 만들어 출력해보세요

sales <- data.frame(fruit = c("사과", "딸기", "수박"),
                    price = c(1800, 1500, 3000),
                    volume = c(24, 38, 13))

sales


# exam 데이터 파악하기
exam <- read.csv(file.choose())

head(exam)   # 앞에서부터 6행 출력
head(exam,10)   # 앞에서부터 10행 출력

tail(exam)   # 뒤에서부터 6행 출력

View(exam)   # 뷰어창에서 데이터 확인

dim(exam)    # 행, 열 출력

str(exam)    # 데이터 속성 확인

summary(exam)   # 요약 통계량 출력


# mpg 데이터 파악하기

mpg <- as.data.frame(ggplot2::mpg)    # 데이터프레임 형태로 바꿔주는 함수

head(mpg)
tail(mpg)

View(mpg)

dim(mpg)

str(mpg)

summary(mpg)


# 2. 데이터 수정하기 - 변수명 바꾸기

install.packages("dplyr") # dplyr 설치
library(dplyr)            # dplyr 로드

df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

### 1. 데이터 프레임 복사본 만들기
df_new <- df_raw   # 복사본 생성
df_new             # 출력

### 2. 변수명 바꾸기
df_new <- rename(df_new, v2 = var2) # var2 를 v2 로 수정,  [유의] rename()에 '새 변수명 = 기존 변수명' 순서로 입력
df_new

### 3. 수정 전후 비교
df_raw
df_new


# 분석 도전

## 문제 1. ggplot2 의 midwest 데이터를 데이터 프레임 형태로 불러와서 데이터의 특성을 파악하세요.

midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
str(midwest)

## 문제 2. poptotal(전체 인구)을 total 로, popasian(아시아 인구)을 asian 으로 변수명을 수정하세요.

mid_new <- midwest
mid_new <- rename(mid_new, total = poptotal, asian = popasian)
str(mid_new)

## 문제 3. total, asian 변수를 이용해 '전체 인구 대비 아시아 인구 백분율' 파생변수를 만들고, 히스토그램을 
##         만들어 도시들이 어떻게 분포하는지 살펴보세요.

mid_new$asian_per <- (mid_new$asian / mid_new$total) * 100
head(mid_new$asian_per)

## 문제 4. 아시아 인구 백분율 전체 평균을 구하고, 평균을 초과하면 "large", 그 외에는 "small"을 부여하는
##         파생변수를 만들어 보세요.

mid_new$asian_per_mean <- ifelse(mean(mid_new$asian_per)<= mid_new$asian_per, "large", "small")
str(mid_new)
head(mid_new$asian_per_mean, 15)

## 문제 5. "large"와 "small"에 해당하는 지역이 얼마나 되는지, 빈도표와 빈도 막대 그래프를 만들어 확인해
##         보세요.

table(mid_new$asian_per_mean)

library(ggplot2)
qplot(mid_new$asian_per_mean)








