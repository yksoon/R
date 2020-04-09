########################################################
# 서점의 고객 데이터에 대한 가상 사례
# (탐색적인 분석과 고객세분화 응용 사례)
########################################################
# 작업 파일 : cust_seg_smpl_280122.csv
# --------------------------------------------------------
# 작업 내용
#--------------------------------------------------------
# 최종구매후기간 recency와 구매한 서적의 수간의 관계 확인
# 동일 좌표에 다수의 고객 존재 가능성이 있으므로 jitter 활용

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

# 엑셀 파일을 사용하는 대신 다운로드 후 csv파일을 사용

cs0 <- read.csv("./data/cust_seg_smpl_280122.csv")

head(cs0)
names(cs0)

cs1 <- cs0

names(cs1) <- c("cust_name", "sex", "age", "location", "days_purchase",
                "recency", "num_books", "amt_books", "amt_non_book",
                "amt_total", "interest_genre", "num_genre",
                "membership_period", "sms_optin" )

names(cs1)

#########################################################
#동일 좌표에 다수의 고객 존재 가능성이 있으므로 jitter 활용
# --------------------------------------------------------
# jitter()
# jitter는 데이터 값을 조금씩 움직여서 같은 점에 데이터가 여러번 겹쳐서 표시되는 현상을 막는다.
# 같은 점에 데이터가 여러번 겹쳐서 표시되는 현상을 막는다.
# --------------------------------------------------------
# Description
# 숫자 벡터에 소량의 노이즈를 추가하는 함수

# Usage
# jitter(x, factor=1, amount=NULL)

# Arguments
# x : 지터를 추가 할 숫자형 벡터

# factor : numeric (숫자)

# amount : numeric (숫자)
#양수이면 양으로 사용되며
#그렇지 않으면 =0
#기본값은 facor * z /50 입니다.

# amount의 기본값은 NULL
# factor * d /5 여기서 d는 x값 사이의 가장 작은 차이

# Examples
# z <- max(x)-min(x) 라고 하자(일반적인 경우를 가정)

# 추가될 양 a는
# 다음과 같이 양의 인수 양으로 제공되거나 z에서 계산된다.
# 만약 amount == 0이면 a <- factor * z/50 을 설정


round(jitter(c(rep(1, 3), rep(1.2, 4), rep(3, 3))), 3)

plot(jitter(cs1$recency), jitter(cs1$num_books))

abline(lm(cs1$num_books~cs1$recency), col = "blue")

#### 구매기간이 오래됐다고 구매서적이 많은 것은 아니다. 즉 관계가 없다.
#------------------------------------------------------------------------

# 구매한 책의 수가 많을수록 구매금액이 큼
# 주로 비싼 책을 샀는지를 파악하기 위해 평균금액을 계산

# 엑셀에서 천단위 comma가 포함된 것을 gsub 함수로 제거
cs1$amt_books <- as.numeric(gsub(",",
                                 "",
                                 as.character(cs1$amt_books))
                            )

cs1$amt_non_book <- as.numeric(gsub(",",
                                 "",
                                 as.character(cs1$amt_non_book)))

plot(jitter(cs1$num_books), jitter(cs1$amt_books))

abline(lm(cs1$amt_books~cs1$num_books),
       col="blue")

# 주로 비싼책을 샀는지를 파악하기 위해 평균금액을 계산
cs1$unitprice_book <- cs1$amt_books / cs1$num_books

plot(jitter(cs1$num_books),
     jitter(cs1$unitprice_book),
     pch=19,
     col="blue",
     cex=0.7,
     ylim=c(0, max(cs1$unitprice_book)*1.05)
)

abline(lm(cs1$unitprice_book~cs1$num_books),
       col="blue",
       lwd=2, lty=2)

abline(h=median(cs1$unitprice_book),
       col="darkgrey")


# 성별을 구분해서 특성 차이 비교

plot(jitter(cs1$num_books),
     jitter(cs1$unitprice_book),
     pch=19,
     cex=0.7,
     col = ifelse(cs1$sex=='여', "pink", "lightblue"),
     ylim = c(0, max(cs1$unitprice_book)*1.05),
     sub="pink: female  blue: male")

abline(lm(cs1$unitprice_book~cs1$num_books),
       col="blue",
       lwd=2, lty=2)

abline(h=median(cs1$unitprice_book),
       col="darkgray")

#--------------------------------------

plot(jitter(cs1$num_books),
     jitter(cs1$unitprice_book),
     pch=19,
     cex=4*cs1$amt_non_book/max(cs1$amt_non_book),
     col = ifelse(cs1$sex=='여', "pink", "lightblue"),
     ylim = c(0, max(cs1$unitprice_book)*1.05),
     sub="size: 서적 이외 상품 구매액")

abline(lm(cs1$unitprice_book~cs1$num_books),
       col="blue",
       lwd=2, lty=2)

abline(h=median(cs1$unitprice_book),
       col="darkgray")

### 남성이 여성보다 평균 구매 서적 금액이 크다고 나타난다. 여성은 구매 서적이 많지만 평균 구매액이 크지 않으므로
### 남성이 여성보다 비싼 책을 구매한다는 경향을 알 수 있다.

#------------------------------------------------------------

# 서적과 서적 이외 구매액 비교

plot(jitter(cs1$amt_books),
     jitter(cs1$amt_non_book),
     pch = 19,
     cex = 1.5,
     col = "khaki",
     ylim = c(0, max(cs1$amt_non_book)*1.05)
     )

abline(h=median(cs1$amt_non_book)*1.5,
       col="darkgray")

abline(v=median(cs1$amt_books)*1.5,
       col="darkgray")

text(median(cs1$amt_books)*1.5 * 2,
     median(cs1$amt_non_book)*1.5 * 0.7, "cross=sell target")

# 대상 집단 조건 - 
# 시각적으로 설정했던 기준선 영역에 해당하는 고객리스트 추출

tgtgridseg <- cs1[cs1$amt_books > median(cs1$amt_books) * 1.5 &
                    cs1$amt_non_book < median(cs1$amt_non_book) * 1.5 ,]

nrow(tgtgridseg)  # 해당하는 인원이 몇명인지

paste("size of target = ",
      as.character(100* nrow(tgtgridseg)/ nrow(cs1)),
      " % of customer base")

# 선정된 집단의 프로파일 시각적으로 확인
# 서적 구매수량과 성별 분포 확인 (여성은 pink)

# 전체고객의 평균과 서적구매수량 중위수를 비교
barplot(tgtgridseg$num_books,
        names.arg = tgtgridseg$cust_name,
        col = ifelse(tgtgridseg$sex=='여', "pink", "lightblue"),
        ylab = "서적 구매 수량")

abline(h=mean(cs1$num_books), lty=2)

abline(h = median(cs1$num_books), lty=2)

##################################################################
# 군집분석을 활용한 고객 세분화

cs2 <- cs1[, names(cs1) %in% c("days_purchase",
                               "recency", "num_books", "amt_books", 
                               "unitprice_book", "amt_non_book",
                               "num_genre", "membership_period")]

kmml <- kmeans(cs2, 3)

table(kmml$cluster)

# 고객 집단을 표시 할 색상을 임의로 지정
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

### 장르가 다양하다고 해서 책을 구매하는 수가 많지 않다.




