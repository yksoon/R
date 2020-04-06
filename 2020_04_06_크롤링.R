############# 크롤링 작업
install.packages("rvest")
library(rvest)

naver <- read_html("http://www.naver.com")
naver

# 1. 웹에서 데이터를 가져오기 위한 패키지 설치
install.packages("rvest")

# 2. 패키지 메모리 로드
library(rvest)

# 3. 문자열을 가지고 올 주소를 생성
url <- 'http://tv.naver.com/r/category/drama'


# 4. 문자열 다운로드
cast <- read_html(url)

# 5. 문자열 확인
cast

# 6. span 안에 내용들이 출력
craw <- cast %>% html_nodes(".tit") %>% html_nodes('span')
craw

# 7. tit 클래스 안에 있는 span 안에 내용 가져오기
craw <- cast %>% html_nodes(".tit") %>% html_nodes('span') %>% html_text()
craw

# 8. tooltip 태그 안의 내용 가져오기
craw <- cast %>% html_nodes("tooltip") %>% html_text()
craw

########################################################
# 한겨레 신문에서 데이터를 검색한 후 검색 결과를 가지고 워드 클라우드 만들기

# 한겨레 신문사에서 지진으로 뉴스 검색하는 경우
# url
# http://search.hani.co.kr/Search?command=query&keyword=검색어입력부분&sort=d&period=all&media=news

# 기사 검색이나 SNS 검색을 하는 경우
# 검색어를 가지고 검색하면 그 결과는 검색어를 가진 URL의 모임이다
# 기사나 SNS글이 아니다

# 검색결과에서 URL을 추출해서 그 URL의 기사내용을 다시 가져와야 한다
# dt 태그 안에 있는 a태그의 href 속성의 값이 실제 기사의 링크이다

# 실제 기사에서 클래스가 text 안에 있는 내용이 기사 내용이다.

######################################################

# 1. 기존의 변수를 모두 제거
rm(list=ls())

# 2. 필요한 패키지 설치
install.packages("stringr")
install.packages("wordcloud")
install.packages("rJava")
install.packages("KoNLP")
install.packages("dplyr")
install.packages("RColorBrewer")
install.packages("rvest")
install.packages('devtools')
devtools::install_github('haven-jeon/KoNLP')

# 3. 필요한 패키지 로드
library(stringr)
library(wordcloud)
library(KoNLP)
library(dplyr)
library(RColorBrewer)
library(memoise)
library(rvest)
library(rJava)

# 4. 기사 검색을 url을 생성
url <- 'http://search.hani.co.kr/Search?command=query&keyword=날씨&sort=d&period=all&media=news'

# 5. url에 해당하는 데이터 가져오기
k <- read_html(url, encoding = "utf-8")
k

# 6. dt태그 안에 있는 a태그 들의 href 속성의 값을 가져오기
k <- k %>% html_nodes("dt") %>% html_nodes("a") %>% html_attr("href")
k

# 7. k에 저장된 모든 URL에 해당하는 데이터의 클래스가 text인 데이터를 읽어서 파일에 저장
# for(임시변수 in 컬렉션 이름){
# }
for(addr in k){    # k의 첫번째를 addr에 할당
  temp <- read_html(addr) %>% html_nodes(".text") %>% html_text()
  cat(temp, file = "temp.txt", append = TRUE)
}

# 8. 파일의 모든 내요을 가져오기
txt <- readLines("temp.txt")
head(txt)

# 9. 명사만 추출
useNIADic()
nouns <- extractNoun(txt)
nouns

# 10. 빈도수 만들기 - 각 단어가 몇번씩 나왔는지
wordcount <- table(unlist(nouns))
wordcount

# 11. 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word
class(df_word)

# 12. 필터링
df_word <- filter(df_word, nchar(Var1) >= 2)

# 13. 워드클라우드 색상 판 생성
pal <- brewer.pal(8, "Dark2")

# 14. 시드 설정
set.seed(1234)

# 15. 워드클라우드 생성
wordcloud(words = df_word$Var1,
          freq = df_word$Freq,
          min.freq = 2, max.words = 200,
          random.order = F,
          rot.per = .1, scale = c(4, 0.3), colors = pal)

##################################################################################

# 웹 크롤링 실습
# http://search.hani.co.kr/Search?command=query&keyword=코로나19&sort=d&period=all&media=magazine
# &media=news
# &media=magazine
# &media=common

# 1. 기존의 변수를 모두 제거
rm(list=ls())

# 2. 필요한 패키지 설치
install.packages("stringr")
install.packages("wordcloud")
install.packages("rJava")
install.packages("KoNLP")
install.packages("dplyr")
install.packages("RColorBrewer")
install.packages("rvest")
install.packages('devtools')
devtools::install_github('haven-jeon/KoNLP')

# 3. 필요한 패키지 로드
library(stringr)
library(wordcloud)
library(KoNLP)
library(dplyr)
library(RColorBrewer)
library(memoise)
library(rvest)
library(rJava)

# 4. 기사 검색 url을 생성
url <- 'http://search.hani.co.kr/Search?command=query&keyword=코로나19&sort=d&period=all&media=magazine'

# 5. url 데이터 가져오기
k <- read_html(url, encoding = "utf-8")
k

# 6. dt태그 안에 있는 a태그 들의 href 속성의 값을 가져오기
k <- k %>% html_nodes("dt") %>% html_nodes("a") %>% html_attr("href")
k

# 7. k에 저장된 모든 URL에 해당하는 데이터의 클래스가 text인 데이터를 읽어서 파일에 저장
for(addr in k){
  temp <- read_html(addr) %>% html_nodes(".text") %>% html_text()
  cat(temp, file = "han_코로나19.txt", append=TRUE)
}

# 8. 파일의 모든내용 가져오기
txt <- readLines("han_코로나19.txt")
head(txt)

# 9. 명사만 추출
useNIADic()
nouns <- extractNoun(txt)
nouns

# 10. 빈도수 만들기
wordcount <- table(unlist(nouns))
wordcount

# 11. 데이터프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word
class(df_word)

# 12. 필터링(두글자 이상 단어만 추출)
df_word <- filter(df_word, nchar(Var1) >= 2)
df_word

# 13. 워드클라우드 색상
pal <- brewer.pal(8, "Dark2")

# 14. 시드설정
set.seed(1234)

# 15. 워드클라우드 생성
wordcloud(df_word$Var1,
          freq = df_word$Freq,
          min.freq = 2, max.words = 200,
          random.order = F,
          rot.per = .1, scale = c(4, 0.3), colors = pal)
 
##################################################################################

# 웹 크롤링 실습
# http://news.donga.com/search?p=1&query=코로나19&check_news=1&more1&sorting=1&search_date=1&v1=&v2=&range=1
# &media=news
# &media=magazine
# &media=common

# 1. 기존의 변수를 모두 제거
rm(list=ls())

# 2. 필요한 패키지 설치
install.packages("stringr")
install.packages("wordcloud")
install.packages("rJava")
install.packages("KoNLP")
install.packages("dplyr")
install.packages("RColorBrewer")
install.packages("rvest")
install.packages('devtools')
devtools::install_github('haven-jeon/KoNLP')

# 3. 필요한 패키지 로드
library(stringr)
library(wordcloud)
library(KoNLP)
library(dplyr)
library(RColorBrewer)
library(memoise)
library(rvest)
library(rJava)

# 4. 기사 검색 url을 생성
url <- 'http://news.donga.com/search?p=1&query=코로나19&check_news=1&more1&sorting=1&search_date=1&v1=&v2=&range=1'

# 5. url 데이터 가져오기
k <- read_html(url, encoding = "utf-8")
k

# 6. dt태그 안에 있는 a태그 들의 href 속성의 값을 가져오기
k <- k %>% html_nodes(".searchContWrap") %>% html_nodes("p") %>% html_nodes("a") %>% html_attr("href")
k

k_remove = c("#")
k %in% k_remove
k = k[!(k %in% k_remove)]
k

# 7. k에 저장된 모든 URL에 해당하는 데이터의 클래스가 text인 데이터를 읽어서 파일에 저장
for(addr in k){
  temp <- read_html(addr) %>% html_nodes(".article_txt") %>% html_text()
  cat(temp, file = "donga_코로나19.txt", append=TRUE)
}

# 8. 파일의 모든내용 가져오기
txt <- readLines("donga_코로나19.txt")
head(txt)

# 9. 명사만 추출
useNIADic()
nouns <- extractNoun(txt)
nouns

# 10. 빈도수 만들기
wordcount <- table(unlist(nouns))
wordcount

# 11. 데이터프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word
class(df_word)

# 12. 필터링(두글자 이상 단어만 추출)
df_word <- filter(df_word, nchar(Var1) >= 2, nchar(Var1))
df_word <- df_word[!(df_word$Var1 == 'googletag' ), ]
df_word 

# 13. 워드클라우드 색상
pal <- brewer.pal(8, "Dark2")

# 14. 시드설정
set.seed(1234)

# 15. 워드클라우드 생성
wordcloud(df_word$Var1,
          freq = df_word$Freq,
          min.freq = 2, max.words = 200,
          random.order = F,
          rot.per = .1, scale = c(4, 0.3), colors = pal)
