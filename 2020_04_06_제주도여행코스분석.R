#######################################################
# "제주도 여행코스 추천" 검색어 결과를 그래프로 표시. #
#######################################################
# 단어추가(제주도여행지.txt) 를 읽어들인 후, dataframe 으로 변경하여 기존 사전에 추가
# 데이터 읽어오기(jeju.txt)
# 한글 외 삭제, 영어
# 읽어들인 데이터로부터 제거할 단어 리스트 읽어오기(제주도여행코스gsub.txt)
# 두 글자 이상인 단어만 추출
# 현재까지의 작업을 파일로 저장 후, 저장된 파일 읽기
# 단어 빈도 수 구한 후, 워드 클라우드 작업
#ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 가장 추천 수가 많은 상위 10개를 골라서
# 1. pie 그래프로 출력
# 2. bar 형태의 그래프로 표시하기
# 3. 옆으로 누운 바 그래프 그리기
# 4. 3D Pie Chart 로 표현 (plotrix라는 패키지가 추가로 필요)



# 패키지 준비하기
library(KoNLP)
library(stringr)
library(rvest)
library(RColorBrewer)
library(wordcloud)

useSejongDic()

# 단어 추가
mergeUserDic(data.frame(readLines("./data/제주도여행지.txt"), "ncn"))

# 데이터 읽어오기
txt <- readLines("./data/jeju.txt")


place <- sapply(txt, extractNoun, USE.NAMES = F)  # 명사부분 분리

head(place)
head(unlist(place), 30)

# 한글 외 삭제
c <- unlist(place)
res <- str_replace_all(c, "[^[:alpha:]]", "")

res <- str_replace_all(c, "[[:digit:]]", "")

# 읽어들인 데이터로부터 제거할 단어 리스트 읽어오기(제주도여행코스gsub.txt)
txt <- readLines("./data/제주도여행코스gsub.txt")
txt

cnt_txt <- length(txt)
cnt_txt

for (i in 1:cnt_txt) {
  res <- gsub((txt[i]), "", res)
}

res

# 두 글자 이상인 단어만 추출
res2 <- Filter(function(x) {nchar(x) >= 2}, res)
nrow(res2)

# 현재까지의 작업을 파일로 저장 후, 저장된 파일 읽기
write(res2, "./result_files/jeju2.txt")

res3 <- read.table("./result_files/jeju2.txt")

# 단어 빈도 수 구한 후, 워드 클라우드 작업
wordcount <- table(res3)
wordcount

palete <- brewer.pal(8, "Set2")

wordcloud(names(wordcount),
          freq = wordcount,
          scale = c(3,1),
          rot.per = 0.25,
          min.freq = 5,
          random.order = F,
          random.color = T,
          colors = palete)
legend(0.3,
       1,
       "제주도 여행 코스 추천 분석 ",
       cex=0.6,
       fill=NA,
       border=NA,
       bg="white",
       text.col = "black",
       text.font=4,
       box.col="red")

#ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 가장 추천 수가 많은 상위 10개를 골라서
# 1. pie 그래프로 출력
# 2. bar 형태의 그래프로 표시하기
# 3. 옆으로 누운 바 그래프 그리기
# 4. 3D Pie Chart 로 표현 (plotrix라는 패키지가 추가로 필요)

df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word
class(df_word)

df_word <- rename(df_word,
                  word = res3,
                  freq = Freq)

# 가장 추천 수가 많은 상위 10개를 골라서
top_10 <- df_word %>% arrange(desc(freq)) %>% head(10)

# 1. pie 그래프로 출력
pie(top_10$freq,
    col = rainbow(10),
    main = "제주도 추천 여행 코스 TOP 10",
    labels = paste(top_10$word, round(top_10$freq, 1), "%"))





# 2. bar 형태의 그래프로 표시하기
library(ggplot2)

ggplot(data = top_10,
       col = rainbow(),
       aes(x = top_10$word, y = top_10$freq)) + geom_col()

# 3. 옆으로 누운 바 그래프 그리기
ggplot(data = top_10,
       aes(x = top_10$word, y = top_10$freq)) + geom_col() + coord_flip()

# 4. 3D Pie Chart 로 표현 (plotrix라는 패키지가 추가로 필요)
install.packages("plotrix")
library(plotrix)

pie3D(top_10$freq,
      explode = 0.1,
      labels = paste(top_10$word, round(top_10$freq, 1), "%"))
