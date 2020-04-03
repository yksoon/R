### 패키지 설치
install.packages("rJava")
install.packages("memoise")
install.packages("koNLP")

### 패키지 로드
library(KoNLP)


### 사전 설정하기
useNIADic()

### 데이터 준비

# 데이터 불러오기
txt <- readLines("./data/hiphop.txt")
## Warning message:
##   In readLines("./data/hiphop.txt") :
##   incomplete final line found on './data/hiphop.txt'  (맨 마지막줄은 들여쓰기가 없어 불안정하다고 안내해줌)

head(txt)

### 특수문자 제거
library(stringr)

txt <- str_replace_all(txt, "\\W", " ") # 각 컬럼의 모든 특수기호를 찾아 공백 처리

class(txt)

dim(txt)

View(txt)

### 가장 많이 사용된 단어 알아보기
# 명사 추출하기
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")

# 가사에서 명사 추출
nouns <- extractNoun(txt)   # 명사 추출시 list로 반환됨

class(nouns)

dim(nouns)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))   # unlist로 list를 풀어준다

wordcount

### 자주 사용된 단어 빈도표 만들기
# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

class(df_word)
dim(df_word)
summary(df_word)
head(df_word)

# 변수명 수정
library(dplyr)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

# 두글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2)

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

### 패키지 준비하기
library(wordcloud)

library(RColorBrewer)

### 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2")  # Dark2 색상 목록에서 8개 색상 추출

### 워드 클라우드 생성
set.seed(1234)                   # 난수 고정
wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색깔 목록

wordcloud(words = top_20$word,   # 단어
          freq = top_20$freq,    # 빈도
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색깔 목록









