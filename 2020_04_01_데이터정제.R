                       
                 #### 데이터 정제 ####

## 결측치 착지

# 결측지 만들기
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df

# 결측지 확인하기
is.na(df)   # 결측치 확인

table(is.na(df))   # 결측치 빈도 출력

# 변수별로 결측지 확인하기
table(is.na(df$sex)) # sex 결측치 빈도 출력
table(is.na(df$score)) # score 결측치 빈도 출력

# 결측치 포함된 상태로 분석
mean(df$score) # 평균 산출
sum(df$score) # 합계 산출



## 결측치 제거하기

#결측지 있는 행 제거하기
library(dplyr)
df %>% filter(is.na(score)) # score 가 NA 인 데이터만 출력

df %>% filter(!is.na(score)) # score 결측치 제거

# 결측치 제외한 데이터로 분석하기
df_nomiss <- df %>% filter(!is.na(score))   # score 결측치 제거
mean(df_nomiss$score)   # score 평균 산출

sum(df_nomiss$score)   # score 합계 산출

# 여러 변수 동시에 결측치 없는 데이터 추출하기
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))  # score, sex 결측치 제외
df_nomiss 

# 결측치가 하나라도 있으면 제거하기
df_nomiss2 <- na.omit(df)   # 모든 변수에 결측치 없는 데이터 추출
df_nomiss2 

# 함수의 결측치 제외 기능 이용하기 - na.rm = T
mean(df$score, na.rm = T) # 결측치 제외하고 평균 산출
sum(df$score, na.rm = T) # 결측치 제외하고 합계 산출



## summarise()에서 na.rm = T사용하기

# 결측치 생성
exam <- read.csv(file.choose())
exam[c(3, 8, 15), "math"] <- NA    # 3, 8, 15 행의 math 에 NA 할당

# 평균 구하기
exam %>% summarise(mean_math = mean(math)) # 평균 산출

exam %>% summarise(mean_math = mean(math, na.rm = T)) # 결측치 제외하고 평균 산출

# 다른 함수들에 적용
exam %>% summarise(mean_math = mean(math, na.rm = T),   # 평균 산출
                   sum_math = sum(math, na.rm = T),     # 합계 산출
                   median_math = median(math, na.rm = T)) # 중앙값 산출



## 결측치 대체하기
# • 결측치 많을 경우 모두 제외하면 데이터 손실 큼
# • 대안: 다른 값 채워넣기
## 결측치 대체법(Imputation)
# • 대표값(평균, 최빈값 등)으로 일괄 대체
# • 통계분석 기법 적용, 예측값 추정해서 대체

# 평균값으로 결측치 대체하기
mean(exam$math, na.rm = T) # 결측치 제외하고 math 평균 산출

# 평균으로 대체하기
exam$math <- ifelse(is.na(exam$math), 55, exam$math) # math 가 NA 면 55 로 대체
table(is.na(exam$math)) # 결측치 빈도표 생성


## 이상치 제거하기
# • 논리적으로 존재할 수 없으므로 바로 결측 처리 후 분석시 제외

# 이상치 포함됨 데이터 제거
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier

# 이상치 확인하기
table(outlier$sex)
table(outlier$score)

# 결측 처리하기 - sex
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)  # sex 가 3 이면 NA 할당
outlier

# 결측 처리하기 - score
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)   # sex 가 1~5 아니면 NA 할당
outlier

# 결측치 제외하고 분석
outlier %>%
  filter(!is.na(sex) & !is.na(score)) %>%
  group_by(sex) %>%
  summarise(mean_score = mean(score))


## 이상치 제거하기 - 2. 극단적인 값
# • 정상범위 기준 정해서 벗어나면 결측 처리

# 상자그림으로 극단치 기준 정해서 제거하기
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

boxplot(mpg$hwy)$stats # 상자그림 통계치 출력

# 결측 처리하기
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)   # 12~37 벗어나면 NA 할당
table(is.na(mpg$hwy))

# 결측치 제외하고 분석하기
mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))


###### 정리하기 ######
# 1.결측치 정제하기

# 결측치 확인
table(is.na(df$score))

# 결측치 제거
df_nomiss <- df %>% filter(!is.na(score))

# 여러 변수 동시에 결측치 제거
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))

# 함수의 결측치 제외 기능 이용하기
mean(df$score, na.rm = T)
exam %>% summarise(mean_math = mean(math, na.rm = T))






