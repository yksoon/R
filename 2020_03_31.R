x <- c(9, 15, 20, 6)
label <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
pie(x, labels = label, main = "부서별 영업 실적")

View(x)

# 기준선 변경
pie(x, init.angle = 90, labels = label, main = "부서별 영업 실적")

# 색과 라벨 수정
pct <- round(x/sum(x)*100)
label <- paste(label, pct)
label <- paste(label,"%",sep="")
pie(x, labels = label, init.angle = 90, col = rainbow(length(x)), main = "부서별 영업 실적")


# 3D 파이 차트

### explode : 쪼개지는 비율, labelcex : 라벨과 텍스트간의 비율
pie3D(x, labels = label, explode = 0.1, labelcex = 0.8, main = "부서별 영업 실적")

# 기본 바 차트 출력
height <- c(9, 15, 20, 6)
name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
barplot(height, names.arg = name, main = "부서별 영업 실적")  # height는 고정값이기 때문에 변경 불가

### 막대의 색 지정
barplot(height, names.arg = name, main = "부서별 영업 실적", col = rainbow(length(height)))

barplot(height, names.arg = name, main = "부서별 영업 실적", col = rainbow(length(height)), xlab = "부서", ylab = "영업 실적(억 원)",
        ylim = c(0, 25))


# 데이터 라벨 출력
bp <- barplot(height, names.arg = name, main = "부서별 영업 실적", col = rainbow(length(height)), xlab = "부서", ylab = "영업 실적(억 원)",
              ylim = c(0, 25))

text(x = bp, y = height, labels = round(height, 0), pos = 3)  # pos : position 데이터를 나타내는 위치

# 바 차트의 수평 회전(가로 막대)
barplot(height, names.arg = name, main = "부서별 영업 실적", col = rainbow(length(height)), xlab = "부서", ylab = "영업 실적(억 원)",
        horiz = TRUE,  # horiz : 가로로 출력
        width = 50)

# 스택형 바 차트(Stacked Bar Chart)
height1 <- c(4, 18, 5, 8)
height2 <- c(9, 15, 20, 6)
height3 <- c(3, 10, 15, 8)
height <- rbind(height1, height2, height3)   # rbind : 행 묶기
View(height)

name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
legend_lbl <- c("2014년", "2015년", "2016년")

barplot(height, main = "부서별 영업 실적", names.arg = name, xlab="부서", ylab = "영업 실적(억 원)", col=c("darkblue", "red", "yellow"),
        legend.text = legend_lbl, ylim = c(0,50))

# 그룹형 바 차트(Grouped Bar Chart)
barplot(height, main = "부서별 영업 실적", names.arg = name, xlab="부서", ylab = "영업 실적(억 원)", col=c("darkblue", "red", "orange"),
        legend.text = legend_lbl, ylim = c(0,50),
        beside = TRUE,                       # beside = TRUE : 그룹형으로 생성 가능
        args.legend = list(x = 'topright'))  # 라벨의 위치 지정 가능

# 일반적인 X-Y 플로팅
View(women)

weight <- women$weight
plot(weight)

height <- women$height
plot(height, weight, xlab = "키", ylab = "몸무게")

# 플로팅 문자의 출력
plot(height, weight, xlab = "키", ylab = "몸무게",
     pch = 23,      # 종류상수
     col = "blue",  # 테두리 색깔
     bg = "yellow", # 점 배경 색깔 
     cex = 1.5)     # 점 크기


##########################################################################

# 지진 강도 데이터를 이용한 시각화

# 지진의 강도에 대한 히스토그램
head(quakes)

mag <- quakes$mag
mag

hist(mag,
     main = "지진 발생 강도의 분포",
     xlab = "지진 강도", ylab = "발생 건수")

### 계급 구간과 색
colors <- c("red", "orange", "yellow", "green", "blue", "navy", "violet")

hist(mag,
     main = "지진 발생 강도의 분포",
     xlab = "지진 강도", ylab = "발생 건수",
     col = colors,
     breaks = seq(4, 6.5, by = 0.5))   # breaks : 구간을 만들어주는 옵션 (seq(4, 6.5, by = 0.5) : 4~6 사이 0.5 간격으로)

### 확률 밀도
hist(mag,
     main = "지진 발생 강도의 분포",
     xlab = "지진 강도", ylab = "발생 건수",
     col = colors,
     breaks = seq(4, 6.5, by = 0.5),
     freq = FALSE)

lines(density(mag))   # density : 확률 밀도 구해주는 함수, lines : 선형 그래프 함수



# 박스 플롯
mag <- quakes$mag
min(mag)
max(mag)
mean(mag)
quantile(mag, c(0.25, 0.5, 0.75))

boxplot(mag,
        main = "지진 발생 각도의 분포",
        xlab = "지진", ylab = "발생 건수",
        col = "red")


##########################################################################

# 워드 클라우드

# 지역별 순이동에 따른 워드 클라우드

# install.packages("wordcloud")
# library(wordcloud)

word <- c("인천광역시", "강화군", "옹진군")
frequency <- c(651, 85, 61)

wordcloud(word, frequency, colors = "blue")   # 첫번째자리 : 데이터, 두번째자리 : 노출빈도 수

### 단어들의 색 변환
wordcloud(word, frequency,
          random.order = F,
          random.color = F,
          colors = rainbow(length(word))
          )

### 다양한 단어 색 출력을 위한 팔레트 패키지의 활용
# install.packages("RColorBrewer")
# library(RColorBrewer)
pal2 <- brewer.pal(8, "Dark2")

word <- c("인천광역시", "강화군", "옹진군")
frequency <- c(651, 85, 61)
wordcloud(word, frequency, colors = pal2)




