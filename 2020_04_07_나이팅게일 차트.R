##############################
# 나이팅게일 차트로 표현.
# 주요 선수별 성정-0013.csv
## 힌사람의 주요 정보를 시각화 하기위헤
## 방사형 차트로 보여준다.
## 5각형으로 보여주는 스타스 함수도 있다.

data <- read.csv("./data/주요선수별성적-2013년.csv",header =T)
data

## 원래 데이터는 열 이름이 선수명으로 되어있어서
## 열이름을 뽑아서 새로운 컬럼으로 추가시킨다.
row.names(data) <- data$선수명

## data 로부터 열 선택.
data2 <- data[,c(7,8,11,12,13,14,17,19)]
data2

stars(data2,
      flip.labels = FALSE,
      draw.segments = TRUE,
      frame.plot = TRUE,
      full = TRUE,
      key.loc = c(1.5, 0),
      main= " 야수 선수별 주요 성적 분석-2013년 ")


# stars(x, full = TRUE, scale = TRUE, radius = TRUE,
#       labels = dimnames(x)[[1]], locations = NULL,
#       nrow = NULL, ncol = NULL, len = 1,
#       key.loc = NULL, key.labels = dimnames(x)[[2]],
#       key.xpd = TRUE,
#       xlim = NULL, ylim = NULL, flip.labels = NULL,
#       draw.segments = FALSE,
#       col.segments = 1:n.seg, col.stars = NA, col.lines = NA,
#       axes = FALSE, frame.plot = axes,
#       main = NULL, sub = NULL, xlab = "", ylab = "",
#       cex = 0.8, lwd = 0.25, lty = par("lty"), xpd = FALSE,
#       mar = pmin(par("mar"),
#                  1.1+ c(2*axes+ (xlab != ""),
#                         2*axes+ (ylab != ""), 1, 0)),
#       add = FALSE, plot = TRUE, ...)
# Arguments
# x 
# 행렬 또는 데이터 프레임. x의 각 행에 대해 하나의 스타 또는 세그먼트 플롯이 생성됩니다. 결 측값 (NA)은 허용되지만 값이 0 인 것처럼 처리됩니다 (확장 후, 관련이있는 경우).
# 
# full 
# 논리 플래그 : 참이면 세그먼트 도표가 완전한 원을 차지합니다. 그렇지 않으면 (위) 반원 만 차지합니다.
# 
# scale 
# 논리 플래그 : TRUE 인 경우 데이터 행렬의 열은 각 열의 최대 값이 1이고 최소값이 0이되도록 독립적으로 크기가 조정됩니다. FALSE 인 경우 데이터는 다른 알고리즘에 의해 범위가 조정 된 것으로 추정됩니다. [0, 1].
# 
# radius 
# 논리 플래그 : TRUE에서는 데이터의 각 변수에 해당하는 반지름이 그려집니다.
# 
# labels 
# 플롯에 레이블을 지정하기위한 문자열로 구성된 벡터 S 함수 별과 달리 labels = NULL 인 경우 레이블을 구성하려고 시도하지 않습니다.
# 
# locations 
# 각 세그먼트 도표를 배치하는 데 사용되는 x 및 y 좌표를 가진 두 개의 열 행렬. 또는 모든 플롯을 겹쳐 야하는 경우 길이가 2 인 숫자 ( '스파이더 플롯'의 경우). 기본적으로 위치 = NULL 인 경우 세그먼트 플롯이 직사각형 그리드에 배치됩니다.
# 
# nrow, ncol 
# 위치가 NULL 인 경우 사용할 행 및 열 수를 제공하는 정수 기본적으로 nrow == ncol이며 정사각형 레이아웃이 사용됩니다.
# 
# len 
# 반지름 또는 세그먼트 길이에 대한 배율.
# 
# key.loc 
# 단위 키의 x 및 y 좌표를 가진 벡터
# 
# key.labels 
# 단위 키의 세그먼트에 레이블을 지정하기위한 문자열 벡터 생략하면 dimnames (x)의 두 번째 구성 요소가 사용됩니다 (사용 가능한 경우).
# 
# key.xpd 
# 단위 키의 클리핑 스위치 (도면 및 레이블)는 par ( "xpd")를 참조하십시오.
# 
# xlim 
# x 좌표 범위를 가진 벡터.
# 
# ylim 
# y 좌표 범위를 가진 벡터.
# 
# flip.labels 
# 라벨 위치를 다이어그램에서 다이어그램으로 위아래로 뒤집어 야하는지 여부를 나타내는 논리. 다소 똑똑한 휴리스틱으로 기본 설정됩니다.
# 
# draw.segments 
# l논리적. 참이면 세그먼트 다이어그램을 그립니다.
# 
# col.segments 
# 색상 벡터 (정수 또는 문자, par 참조). 각각 세그먼트 (변수) 중 하나의 색상을 지정합니다. draw.segments = FALSE이면 무시됩니다.
# 
# col.stars 
# 별표 (케이스) 중 하나의 색상을 지정하는 색상 벡터 (정수 또는 문자, 파 참조). draw.segments = TRUE이면 무시됩니다.
# 
# col.lines 
# 색 벡터 (정수 또는 문자, par 참조). 각각은 선 (케이스) 중 하나의 색을 지정합니다. draw.segments = TRUE이면 무시됩니다.
# 
# axes 
# 논리 플래그 : TRUE이면 플롯에 축이 추가됩니다 .
# 
# frame.plot 
# 논리 플래그 : TRUE이면 플롯 영역이 프레임됩니다.
# 
# main 
# 주요 제목
# 
# sub 
# 부제목.
# 
# xlab 
# x 축의 라벨.
# 
# ylab 
# y 축의 라벨.
# 
# cex 
# 라벨의 문자 확장 요소.
# 
# lwd 
# 그리기에 사용되는 선 너비.
# 
# lty 
# 그리기에 사용되는 선 종류.
# 
# xpd 
# 클리핑을 수행해야하는지 여부를 나타내는 논리 또는 NA. par (xpd =.)를 참조.
# 
# mar 
# par (mar = *)에 대한 인수로 일반적으로 기본보다 작은 여백을 선택합니다..
# 
# ... 
# plot ()의 첫 번째 호출에 전달 된 추가 인수는 frame.plot이 true 인 경우 plot.default 및 box ()를 참조.
# 
# add 
# 참이면 현재 플롯에 별표를 추가t.
# 
# plot 
# 논리적 인 경우 FALSE이면 아무것도 표시되지 않습니다.
# 
# 
# 
# 예)
# 
# stars(mtcars[, 1:7], key.loc = c(14, 2),
#       main = "Motor Trend Cars : stars(*, full = F)", full = FALSE)
# stars(mtcars[, 1:7], key.loc = c(14, 1.5),
#       main = "Motor Trend Cars : full stars()", flip.labels = FALSE)
# 
# ## 'Spider' or 'Radar' plot:
# stars(mtcars[, 1:7], locations = c(0, 0), radius = FALSE,
#       key.loc = c(0, 0), main = "Motor Trend Cars", lty = 2)
# 
# ## Segment Diagrams:
# palette(rainbow(12, s = 0.6, v = 0.75))
# stars(mtcars[, 1:7], len = 0.8, key.loc = c(12, 1.5),
#       main = "Motor Trend Cars", draw.segments = TRUE)
# stars(mtcars[, 1:7], len = 0.6, key.loc = c(1.5, 0),
#       main = "Motor Trend Cars", draw.segments = TRUE,
#       frame.plot = TRUE, nrow = 4, cex = .7)
# 
# ## scale linearly (not affinely) to [0, 1]
# USJudge <- apply(USJudgeRatings, 2, function(x) x/max(x))
# Jnam <- row.names(USJudgeRatings)
# Snam <- abbreviate(substring(Jnam, 1, regexpr("[,.]",Jnam) - 1), 7)
# stars(USJudge, labels = Jnam, scale = FALSE,
#       key.loc = c(13, 1.5), main = "Judge not ...", len = 0.8)
# stars(USJudge, labels = Snam, scale = FALSE,
#       key.loc = c(13, 1.5), radius = FALSE)
# 
# loc <- stars(USJudge, labels = NULL, scale = FALSE,
#              radius = FALSE, frame.plot = TRUE,
#              key.loc = c(13, 1.5), main = "Judge not ...", len = 1.2)
# text(loc, Snam, col = "blue", cex = 0.8, xpd = TRUE)
# 
# ## 'Segments':
# stars(USJudge, draw.segments = TRUE, scale = FALSE, key.loc = c(13,1.5))
# 
# ## 'Spider':
# stars(USJudgeRatings, locations = c(0, 0), scale = FALSE, radius  =  FALSE,
#       col.stars = 1:10, key.loc = c(0, 0), main = "US Judges rated")
# 
# ## Same as above, but with colored lines instead of filled polygons.
# stars(USJudgeRatings, locations = c(0, 0), scale = FALSE, radius  =  FALSE,
#       col.lines = 1:10, key.loc = c(0, 0), main = "US Judges rated")
# 
# ## 'Radar-Segments'
# stars(USJudgeRatings[1:10,], locations = 0:1, scale = FALSE,
#       draw.segments = TRUE, col.segments = 0, col.stars = 1:10, key.loc =  0:1,
#       main = "US Judges 1-10 ")
# 
# palette("default")
# stars(cbind(1:16, 10*(16:1)), draw.segments = TRUE,
#       main = "A Joke -- do *not* use symbols on 2D data!")


## 'Spider' or 'Rader' plot:
stars(mtcars[, 1:7],
      locations = c(0,0), radius = FALSE,
      key.loc = c(0,0),
      main = "Motor Trend Cars",
      lty = 2)

## Segment Diagrams:
palette(rainbow(12, s = 0.6, v = 0.75))

stars(mtcars[, 1:7], len = 0.8, key.loc = c(12, 1.5),
      main = "Motor Trend Cars", draw.segments = TRUE)

stars(mtcars[, 1:7], len = 0.8, key.loc = c(12, 1.5),
      main = "Motor Trend Cars", draw.segments = TRUE,
      frame.plot = TRUE, nrow = 4, cex = .7)


