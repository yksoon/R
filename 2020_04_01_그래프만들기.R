###### 그래프 만들기 ######


### 산점도 만들기
# • 산점도(Scater Plot) : 데이터를 x축과 y축에 점으로 표현한 그래프
# • 나이와 소득처럼, 연속 값으로 된 두 변수의 관계를 표현할 때 사용

library(ggplot2)

# 1. 배경 설정하기
ggplot(data = mpg, aes(x = displ, y = hwy))   # x 축 displ, y 축 hwy 로 지정해 배경 생성

# 2. 그래프 추가하기
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()   # 배경에 산점도 추가

# 3. 축 범위를 조정하는 설정 추가하기
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)   # x 축 범위 3~6 으로 지정

ggplot(data = mpg, aes(x = displ, y = hwy)) +    # y 축 범위 10~30 으로 지정
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)    # 코드 가독성을 높이려면 + 뒤에 엔터로 작성

# ggplot() vs qplot()
# • qplot() : 전처리 단계 데이터 확인용 문법 간단, 기능 단순
# • ggplot() : 최종 보고용. 색, 크기, 폰트 등 세부 조작 가능





### 막대그래프 - 집단 간 차이 표현하기
# • 막대 그래프(Bar Chart) : 데이터의 크기를 막대의 길이로 표현한 그래프
# • 성별 소득 차이처럼 집단 간 차이를 표현할 때 주로 사용

## 막대 그래프 1 - 평균 막대그래프 만들기
# 1. 집단별 평균표 만들기
library(dplyr)

df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

df_mpg

# 2. 그래프 생성하기
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()   # geom_col() : 막대그래프로 생성

# 3. 크기 순으로 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()


## 막대 그래프 2 - 빈도 막대 그래프
# • 값의 개수(빈도)로 막대의 길이를 표현한 그래프

ggplot(data = mpg, aes(x = drv)) + geom_bar()   # x 축 범주 변수, y 축 빈도

ggplot(data = mpg, aes(x = hwy)) + geom_bar()   # x 축 연속 변수, y 축 빈도

# geom_col() VS geom_bar()
# • 평균 막대 그래프 : 데이터를 요약한 평균표를 먼저 만든 후 평균표를 이용해 그래프 생성 - geom_col()
# • 빈도 막대 그래프 : 별도로 표를 만들지 않고 원자료를 이용해 바로 그래프 생성 - geom_bar()



### 선그래프 - 시간에 따라 달라지는 데이터 표현하기
# • 선 그래프(Line Chart) : 데이터를 선으로 표현한 그래프
# • 시계열 그래프(Time Series Chart) : 일정 시간 간격을 두고 나열된 시계열 데이터(Time Series Data)를
#   선으로 표현한 그래프. 환율, 주가지수 등 경제 지표가 시간에 따라 어떻게 변하는지 표현할 때 활용

# 시계열 그래프 만들기
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()   # geom_line() : 데이터와 데이터사이는 line으로 연결(선그래프)



### 상자 그림 - 집단 간 분포 차이 표현하기
# • 상자 그림(Box Plot) : 데이터의 분포(퍼져 있는 형태)를 직사각형 상자 모양으로 표현한 그래프
# • 분포를 알 수 있기 때문에 평균만 볼 때보다 데이터의 특성을 좀 더 자세히 이해할 수 있음

# 상자 그림 만들기
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()



# 앞에서 다룬 ggplot2 함수들
#     값          내용
# geom_point()   산점도
# geom_col()     막대 그래프 - 요약표
# geom_bar()     막대 그래프 - 원자료
# geom_line()    선 그래프
# geom_boxplot() 상자 그림



####### 정리 ######

# 1.산점도
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# 축 설정 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)

# 2.평균 막대 그래프
# 1 단계.평균표 만들기
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

# 2 단계.그래프 생성하기, 크기순 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

# 3.빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar()

# 4.선 그래프
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

# 5.상자 그림 
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()


