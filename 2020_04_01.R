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


##----------------------------------------------------------------------------------------------------##

# 데이터 추출하기

## 조건에 맞는 데이터만 추출하기
exam %>% filter(class == 1)

exam %>% filter(class != 1)

exam %>% filter(math > 50)

## 여러 조건을 충족하는 행 추출하기
exam %>% filter(class == 1 & math >= 50)  # 1 반 이면서 수학 점수가 50 점 이상인 경우

## 여러 조건 중 하나 이상 충족하는 행 추출하기
exam %>% filter(math >= 90 | english >= 90)  # 수학 점수가 90 점 이상이거나 영어점수가 90 점 이상인 경우

## %in% 기호 이용하기
exam %>% filter(class %in% c(1,3,5))


## 필요한 변수만 추출하기
exam %>% select(math) # math 추출

exam %>% select(class, math, english) # class, math, english 변수 추출

exam %>% select(-math, -english) # math, english 제외



# dplyr 함수 조합하기

exam %>% filter(class == 1) %>% select(english)  # class 가 1 인 행만 추출한 다음 english 추출

exam %>%
  filter(class == 1) %>% # class 가 1 인 행 추출
  select(english) # english 추출

exam %>%
  select(id, math) %>% # id, math 추출
  head # 앞부분 6 행까지 추출


##----------------------------------------------------------------------------##

# 순서대로 정렬하기

## 오름차순 정렬
exam %>% arrange(math) # math 오름차순 정렬

## 내림차순 정렬
exam %>% arrange(desc(math)) # math 내림차순 정렬

## 정렬 기준 변수 여러개 지정
exam %>% arrange(class, math) # class 및 math 오름차순 정렬

##---------------------------------------------------------------------------##

# 파생변수 추가

exam %>%
  mutate(total = math + english + science) %>% # 총합 변수 추가
  head # 일부 추출

exam %>%
  mutate(total = math + english + science, # 총합 변수 추가
         mean = (math + english + science)/3) %>% # 총평균 변수 추가
  head # 일부 추출


## mutate()에 ifelse() 적용하기
exam %>%
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
  head

## 추가한 변수를 dplyr 코드에 바로 활용하기
exam %>%
  mutate(total = math + english + science) %>% # 총합 변수 추가
  arrange(total) %>% # 총합 변수 기준 정렬
  head # 일부 추출

##---------------------------------------------------------------------------##

# 집단별로 요약하기

exam %>% summarise(mean_math = mean(math)) # math 평균 산출

exam %>%
  group_by(class) %>% # class 별로 분리
  summarise(mean_math = mean(math), # math 평균
            sum_math = sum(math), # math 합계
            median_math = median(math), # math 중앙값
            n = n()) # 학생 수
mpg %>%
  group_by(manufacturer) %>% # 회사별로 분리
  filter(class == "suv") %>% # suv 추출
  mutate(tot = (cty+hwy)/2) %>% # 통합 연비 변수 생성
  summarise(mean_tot = mean(tot)) %>% # 통합 연비 평균 산출
  arrange(desc(mean_tot)) %>% # 내림차순 정렬
  head(5) # 1~5 위까지 출력


# 데이터 합치기

# 중간고사 데이터 생성
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
# 기말고사 데이터 생성
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

total <- left_join(test1, test2, by = "id") # id 기준으로 합쳐 total 에 할당
total # total 출력


name <- data.frame(class = c(1, 2, 3, 4, 5),     # 반별 담임교사 명단 생성
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by = "class")  # class기준 합치기
exam_new

## 세로로 합치기

# 학생 1~5 번 시험 데이터 생성
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
# 학생 6~10 번 시험 데이터 생성
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

group_all <- bind_rows(group_a, group_b) # 데이터 합쳐서 group_all 에 할당
group_all # group_all 출력






