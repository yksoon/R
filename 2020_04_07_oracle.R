###############################
# R 에서 오라클 데이터 읽어오기
###############################

# R에서 데이터베이스에 접속해서 데이터를 가져오는 방법은 2가지 정도.
# 하나는 자바의 기능을 이용한 것.
# 또 다른 하나는 다른 언어의 기능을 사용하지 않고
# 순수 R의 패키지를 이용하는 방법.

# R에서는 Select 구문을 실행하는 경우 바로 data.frame으로 리턴.
# 관계형 데이터베이스의 데이터를 사용하는 것이
# 일반적인 프로그래밍 언어보다 편리.

# 자바의 JDBC를 이용하기 위한 패키지 설정
install.packages("RJDBC")
install.packages("igraph")

# 라이브러리 등록
library(RJDBC)
library(rJava)
library(igraph)

# 작업 디렉토리 안에 data 디렉토리에 ojdbc6.jar 파일이 존재
jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
                   classPath = "./driver/ojdbc6.jar")

# 데이터베이스 연결
con <- dbConnect(jdbcDriver,
                 "jdbc:oracle:thin:@localhost:1521:XE",
                 "yks",  # 계정명
                 "1234") # 비밀번호

# 데이터베이스 연결 종료
# dbDisconnect(con)

# dbGetQuery나 dbSendQuery를 이용해서 
# 첫번째 매개변수로는 데이터베이스 연결변수를 주고
# 두번째 매개변수로 select 구문을 주면 데이터를 가져온다.

# dbGetQuery는 data.frame을 리턴하고
# dbGetQuery는 무조건 모든 데이터를 가져와서
# data.frame을 만들기 때문에 많은 양의 데이터가 검색된 경우
# 메모리 부족 현상을 일으킬 수 있다.

# 이런 경우에는 dbSendQuery를 이용해서
# 데이터에 대한 포인터만 가져온 후
# fetch(커서, n=1)을 이용해서
# n 값으로 데이터 개수를 대입해서 필요한만큼 데이터만 가져와서
# data.frame을 만들수 있다.

# cusor는
# 데이터를 주고 다음으로 자동으로 넘어가는 특징을 가지고 있다.
# 하디만 전진만 하기 때문에 한번 읽은 데이터를 다시 읽지 못한다.

# select구문을 실행하고 저장하기
result <- dbGetQuery(con, "select * from member")

result

# 유형 확인
class(result)

# 실행 결과를 가지고 그래프를 그릴 수 있는 프레임으로 변환
g <- graph.data.frame(result,directed = T)

# 관계도 작성
plot(g,
     layout = layout.fruchterman.reingold,
     vertex.size = 8,
     edge.array.size = 0.5)

# 오라클 쿼리 실행 (sqldf 패키지)
# 오라클 sql쿼리문을 이용하기 위한 패키지 설정
install.packages("sqldf")

# 오라클 sql쿼리문을 이용하기 위한 라이브러리 등록
library(sqldf)

head(iris)

sqldf("select Species from iris")

sqldf("select * from iris limit 4")

# subset
subset(iris, Species %in% c("setosa"))
sqldf("select * from iris where Species in ('setosa')")

subset(iris, Sepal.Length >= 5 & Sepal.Length <= 5.2)
sqldf('select * from iris where "Sepal.Length" between 5 and 6')

####################################
# XML 파싱
####################################
# html 파싱과 동일
# XML은 엄격한 HTML이고 태그의 해석을 브라우저가 하지 않고
# 클라이언트가 직접 한다는 점이 HTML과 다른 점.
# 모든 HTML 파싱 방법은 XML에 적용 가능.
# XML파싱 방법으로는 파싱하지 못하는 HTML이 있을 수도 있다.

# 1. 태그의 내용 가져오기

# 문자열을 가지고 올 주소를 생성
url <- "https://www.weather.go.kr/weather/forecast/mid-term-xml.jsp?stnId=109"

# 문자열 다운로드
library(rvest)
weather <- read_html(url)
weather

tmn <- weather %>% html_nodes("tmn") %>% html_text()
tmn


###########################
# JSON 파싱
###########################
# jsonlite 패키지와 httr 패키지를 이용.
# frameJSON() 함수에 URL을 대입하면 data.frame 으로 리턴

# 즉, https://api.github.com/users/hadley/repos 데이터를
# data.frame으로 변환

# 1. 필요한 패키지 설치
install.packages("jsonlite")
install.packages("httr")

# 2. 필요한 패키지 로드
rm(list = ls())

library(jsonlite)
library(httr)

# 3. json 데이터 가져오기
df <- fromJSON("https://api.github.com/users/hadley/repos")
df
