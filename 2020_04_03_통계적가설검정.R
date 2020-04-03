
### 통계적 가설 검정이란?

## 기술 통계와 추론 통계
# ㅁ 기술통계
# - 데이터를 요약해 설명하는 통계 기법
# - ex) 사람들이 받는 월급을 집계해 전체 월급 평균 구하기

# ㅁ 추론통계
# - 단순히 숫자를 요약하는 것을 넘어 어떤 값이 발생할 확률을 계산하는 통계 기법
# - ex) 수집된 데이터에서 성별에 따라 월급에 차이가 있는것으로 나타났을때, 이런 차이가 우연히 발생할 확률을 계산
# - 이런 차이가 우연히 나타날 확율이 작다
#    -> 성별에 따른 월급 차이가 통계적으로 유의하다고 결론
# - 이런 차이가 우연히 나타날 확률이 크다
#    -> 성별에 따른 월급 차이가 통계적으로 유의하지 않다고 결론
# - 기술 통계 분석에서 집단 간 차이가 있는 것으로 나타났더라도 이는 우연에 의한 차이일 수 있음
#   . 데이터를 이용해 신뢰할 수 있는 결론을 내리려면 유의 확률을 계산하는 통계적 가설검정 절차를 거쳐야 함.

## 통계적 가설 검정

# ㅁ 통계적 가설 검정이란
# - 유의 확률을 이용해 가설을 검정하는 방법
# ㅁ 유의확률
# - 실제로는 집단 간 차이가 없는데 우연히 차이가 있는 데이터가 추출될 확률
# - 분석 결과 유의확률이 크게 나타났다면
#   . '집단 간 차이가 통계적으로 유의하지 않다'고 해석
#   . 실제로 차이가 없더라도 우연에 의해 이 정도의 차이가 관찰될 가능성이 크다는 의미
# - 분석 결과 유의확률이 작게 나타났다면
#   . '집단 간 차이가 통계적으로 유의하다'고 해석
#   . 실제로 차이가 없는데 우연히 이 정도의 차이가 관찰될 가능성이 작다. 우연이라고 보기 힘들다는 의미

#-------------------------------------------------------------------------------------

### compact자동차와 suv 자동차의 도시 연비 t검정

# 데이터 준비
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)
mpg_diff <- mpg %>%
  select(class, cty) %>%
  filter(class %in% c("compact", "suv"))

head(mpg_diff)

table(mpg_diff$class)

# t-test
t.test(data = mpg_diff, cty ~ class, var.equal = T)
#    Two Sample t-test
# 
# data:  cty by class
# t = 11.917, df = 107, p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0  # 평균의 실체 차이가 0이 아니면 신뢰할 수 있다.
# 95 percent confidence interval:
#   5.525180 7.730139
# sample estimates:
#   mean in group compact     mean in group suv 
#               20.12766              13.50000 


## 일반 휘발유와 고급 휘발유의 도시 연비 t검정

# 데이터 준비
mpg_diff2 <- mpg %>%
  select(fl, cty) %>%
  filter(fl %in% c("r", "p"))   # r:regular, p:premium

table(mpg_diff2$fl)

# t-test
t.test(data = mpg_diff2, cty ~ fl, var.equal = T)
#       Two Sample t-test
# 
# data:  cty by fl
# t = 1.0662, df = 218, p-value = 0.2875
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.5322946  1.7868733
# sample estimates:
#   mean in group p mean in group r 
#          17.36538        16.73810 

#####################################################################################

### 상관분석 - 두 변수의 관계성 분석

# 상관분석
# . 두 연속 변수가 서로 관련이 있는지 검정하는 통계 분석 기법
# . 상관 계수
#   - 두 변수가 얼마나 관련되어 있는지. 관련성의 정도를 나타내는 값
#   - 0~1 사이의 값을 지니고 1에 가까울수록 관련성이 크다는 의미
#   - 상관 계수가 양수면 정비례, 음수면 반비례 관계

#-------------------------------------------------------------------------------------

## 실업자 수와 개인 소비 지출의 상관관계

# 데이터 준비
economics <- as.data.frame(ggplot2::economics)

# 상관분석
cor.test(economics$unemploy, economics$pce)
# Pearson's product-moment correlation
# 
# data:  economics$unemploy and economics$pce
# t = 18.63, df = 572, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  0.5608868 0.6630124
# sample estimates:
#       cor
# 0.6145176

#-------------------------------------------------------------------------------------

### 상관행렬 히트맵 만들기

# 상관행렬
#  - 여러 변수 간 상관계수를 행렬로 나타낸 표
#  - 어떤 변수끼리 관련이 크고 적은지 파악할 수 있음

# 데이터 준비
head(mtcars)

# 상관행렬 만들기
car_cor <- cor(mtcars)  # 상관행렬 생성
round(car_cor, 2)       # 소수점 셋째 자리에서 반올림 해서 출력

# 상관행렬 히트맵 만들기
# (히트맵 : 값의 크기를 색깔로 표현한 그래프)

install.packages("corrplot")
library(corrplot)

corrplot(car_cor)

corrplot(car_cor, method = "number")  # 기존 원모양 대신 숫자로 표기


# 다양한 파라미터 지정하기
col <- colorRampPalette(c('#BB4444', '#EE9988', '#FFFFFF', '#77AADD', '#4477AA'))

corrplot(car_cor,
         method = "color",      # 색깔라ㅗ 표현
         col = col(200),        # 색상 200개 선정
         type = "lower",        # 왼쪽 아래에 행렬만 표시
         order = 'hclust',      # 유사한 상관계수끼리 군집화
         addCoef.col = "black", # 상관계수 색깔
         tl.col = "black",      # 변수명 색깔
         tl.srt = 45,           # 변수명 45도로 기울임
         diag = F)              # 대각 행렬 제외
 





