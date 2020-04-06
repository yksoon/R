### 블로거들이 추천하는 서울 명소 분석하기

# "seoul_go.txt" 파일을 사용하여
# 블로거들이 추천하는 서울 명소들을 워드클라우드로 생성
# (서울명소추가 : 서울명소merge.txt)
# (제거단어 : 서울명소gsub.txt)

# setwd("c:\\r_temp")

library(KoNLP)
library(wordcloud)
library(stringr)

useSejongDic()

mergeUserDic(data.frame(readLines("./data/서울명소merge.txt"),"ncn")) # 세종딕셔너리를 서울명소merge.txt를 데이터프레임으로 생성 후 병합

txt <- readLines("./data/seoul_go.txt")

place <- sapply(txt, extractNoun, USE.NAMES = F)  # sapply는 결과값으로 벡터 혹은 데이터프레임으로 반환함

head(place, 10)
head(unlist(place), 30)

c <- unlist(place)
res <- str_replace_all(c, "[^[:alpha:]]", "")   # 알파벳으로 시작하는 문자들을 "" 처리함


txt <- readLines("./data/서울명소gsub.txt")
txt

cnt_txt <- length(txt)
cnt_txt

for(i in 1:cnt_txt){
  res <- gsub((txt[i]), "", res)
}

res

res2 <- Filter(function(x) {nchar(x) >= 2}, res)
nrow(res2)

write(res2, "./result_files/seoul_go2.txt")

res3 <- read.table("./result_files/seoul_go2.txt")  # read.table 테이블 형태로 읽어들이는 함수

wordcount <- table(res3)
head(sort(wordcount,decreasing = T), 30)


library(RColorBrewer)
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
       "블로거 추천 서울 명소 분석   ",
       cex=0.6,
       fill=NA,
       border=NA,
       bg="white",
       text.col = "red",
       text.font=2,
       box.col="red")

########################################################################################

