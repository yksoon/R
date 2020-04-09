########################################################
# 서점의 고객 데이터에 대한 가상 사례
# (탐색적인 분석과 고객세분화 응용 사례)
########################################################
# 작업 파일 : cust_seg_smpl_280122.csv
# --------------------------------------------------------
# 작업 내용
#--------------------------------------------------------
# 최종구매후기간 recency와 구매한 서적의 수간의 관계 확인
# 동일 좌표에 다수의 고객 존재 가능성이 있으므로 이를 처리

# 가설 1
# 보조선인 회귀선을 본다면 최근성이 낮을수록, 
# 즉 구매한지 오래되었을 수록 구매한 서적의 수가 많음
#---------------------------------------------------------

# 가설 2
# 구매한 책의 수가 많을수록 구매금액이 큼
# 주로 비싼 책을 샀는지를 파악하기 위해 평균금액을 계산


# 수행 내용
#---------------------------------------------------------
# 성별을 구분해서 특성 차이 비교
#---------------------------------------------------------
# 서적과 서적이외 구매액 비교

# 1차 결론
# 서적 구매는 많으나 기타 상품 구매가 약한 집단을 선정해
# 집중적 cross-selling 노력 기울이는 것이 필요해 보임


#---------------------------------------------------------
# 대상 집단 조건 - 
# 시각적으로 설정했던 기준선 영역에 해당하는 고객리스트 추출


#---------------------------------------------------------
# 선정된 집단의 프로파일 시각적으로 확인
# 서적 구매수량과 성별 분포 확인 (여성은 pink)


#---------------------------------------------------------
# 전체고객의 평균/중위수 서적구매수량과 비교

# 프로파일 확인 결과 중위수에 비해 서적구매수량이 많고, 
# 평균에 비해서도 많은 편인 여성 고객들임

# 2차 결론
# 기타 상품 중 여성 선호 상품을 찾아 제안하는 방식으로 cross-sell
# 캠페인 진행 필요해 보임


#---------------------------------------------------------
# 군집분석을 활용한 고객세분화

# 고객집단을 표시할 색상을 임의로 지정
# 번호순의 색상 이름 벡터 생성

# 각 고객의 소속 집단이 어디인가에 따라 색상 표시


#---------------------------------------------------------
# 3차 결론
# 서적 구매 장르의 수가 많다면 
# 서적 구매 수량이 많을 가능성 높으므로
# 비율을 새로 계산 (=구매한 서적 수량 대비 쟝르의 수)
######################################################


# 데이터 확인하기
data <- read.csv("./data/cust_seg_smpl_280122.csv")
data

# 가설 1
# 보조선인 회귀선을 본다면 최근성이 낮을수록, 
# 즉 구매한지 오래되었을 수록 구매한 서적의 수가 많음

plot(x = data$최종구매후기간, y = data$구매서적수)
  
abline(lm(data$구매서적수~data$최종구매후기간), col = "blue", lwd=1.5)


# 가설 2
# 구매한 책의 수가 많을수록 구매금액이 큼
# 주로 비싼 책을 샀는지를 파악하기 위해 평균금액을 계산

data$서적구매액 <- as.integer(gsub(",", "", data$서적구매액))
data$기타상품구매액 <- as.integer(gsub(",", "", data$기타상품구매액))
data$총구매액 <- as.integer(gsub(",", "", data$총구매액))

plot(x = data$구매서적수, y = data$서적구매액)

abline(lm(data$서적구매액~data$구매서적수), col = "blue", lwd=1.5)


# 성별을 구분해서 특성 차이 비교
library(dplyr)

unitprice <- as.integer(data$서적구매액) / as.integer(data$구매서적수)
data <- cbind(data, unitprice)

un_m <- data %>% filter(성별 == "남")
un_f <- data %>% filter(성별 == "여")


plot(x = data$구매서적수, y = unitprice, col = ifelse(data$성별 == "남", "blue", "red"))

abline(lm(un_m$unitprice~un_m$구매서적수), col = "blue", lwd=1.5, lty=10)
abline(lm(un_f$unitprice~un_f$구매서적수), col = "red", lwd=1.5)


# 서적 이외 상품 구매액

library(ggplot2)

ggplot(data = data,
       aes(x = 구매서적수,
           y = unitprice)) + 
  geom_point(data= data, aes(color=성별, size = 구매서적수)) + 
  ylim(0,45000) + 
  geom_smooth(data = un_m, aes(x = 구매서적수, y = unitprice), method = "lm") + 
  geom_smooth(data = un_f, aes(x = 구매서적수, y = unitprice), method = "lm", color = "red")


# 서적과 서적이외 구매액 비교

ggplot(data = data,
       aes(x = 서적구매액,
           y = 기타상품구매액)) +
  geom_point(colour = "orange", size = 4) + geom_vline(xintercept = mean(data$서적구매액)) + geom_hline(yintercept = mean(data$기타상품구매액))

### 남성이 여성보다 평균 구매 서적 금액이 크다고 나타난다. 여성은 구매 서적이 많지만 평균 구매액이 크지 않으므로
### 남성이 여성보다 비싼 책을 구매한다는 경향을 알 수 있다.


# 1차 결론
# 서적 구매는 많으나 기타 상품 구매가 약한 집단을 선정해
# 집중적 cross-selling 노력 기울이는 것이 필요해 보임

#---------------------------------------------------------
# 대상 집단 조건 - 
# 시각적으로 설정했던 기준선 영역에 해당하는 고객리스트 추출

#---------------------------------------------------------
# 선정된 집단의 프로파일 시각적으로 확인
# 서적 구매수량과 성별 분포 확인 (여성은 pink)

mean_book = data %>% filter(기타상품구매액 <= mean(기타상품구매액) & 서적구매액 >= mean(서적구매액))
mean_book

ggplot(data = mean_book, aes(x = 고객명,
                             y = 구매서적수)) +
  geom_bar(stat = "identity", fill = ifelse(mean_book$성별 == "여", "pink", "skyblue")) +
  geom_hline(yintercept = mean_book$구매서적수, linetype="dashed") +
  geom_hline(yintercept = median(data$구매서적수))


# 2차 결론
# 기타 상품 중 여성 선호 상품을 찾아 제안하는 방식으로 cross-sell
# 캠페인 진행 필요해 보임


#---------------------------------------------------------
# 군집분석을 활용한 고객세분화

cs0 <- read.csv("./data/cust_seg_smpl_280122.csv")
cs1 <- cs0

names(cs1) <- c("cust_name", "sex", "age", "location", "days_purchase",
                "recency", "num_books", "amt_books", "amt_non_book",
                "amt_total", "interest_genre", "num_genre",
                "membership_period", "sms_optin" )

cs1$amt_books <- as.numeric(gsub(",",
                                 "",
                                 as.character(cs1$amt_books))
)

cs1$amt_non_book <- as.numeric(gsub(",",
                                    "",
                                    as.character(cs1$amt_non_book)))

cs2 <- cs1[, names(cs1) %in% c("days_purchase",
                               "recency", "num_books", "amt_books", 
                               "unitprice_book", "amt_non_book",
                               "num_genre", "membership_period")]

kmml <- kmeans(cs2, 3)

table(kmml$cluster)

# 고객집단을 표시할 색상을 임의로 지정
# 번호순의 색상 이름 벡터 생성

cols <- c("red", "green", "blue")

barplot(table(kmml$cluster),
        names.arg = names(table(kmml$cluster)),
        col = cols,
        main = "군집별 고객수 분포포")

# 각 고객의 소속 집단이 어디인가에 따라 색상 표시

plot(jitter(cs2$days_purchase),
     jitter(cs2$num_genre),
     col = cols[kmml$cluster],
     pch = 19,
     main = "고객세분집단 프로파일 : 구매빈도와 서적구매 장르 다양성 분포",
     sub = "Cl#1: red, Cl#2: green, Cl#3: blue")

ggplot(data = cs2,
       aes(x = days_purchase,
           y = num_genre))+ geom_jitter(col=cols[kmml$cluster]) + geom_smooth(aes(x = days_purchase, y = num_genre))

### 구매를 많이 안하는 사람일수록 장르를 따진다



  
  

