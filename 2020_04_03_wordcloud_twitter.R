##### 국정원 트윗 텍스트 마이닝

## 데이터 준비하기
# 데이터 로드
twitter <- read.csv("./data/twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

# 변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

# 특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")

# 트윗에서 명사 추출
nouns <- extractNoun(twitter$tw)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

df_word <- filter(df_word, nchar(word) >= 2)

top_40 <- df_word %>%
  arrange(desc(freq)) %>%
  head(40)

library(wordcloud)

library(RColorBrewer)

### 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2")

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

### 패키지 준비하기
library(devtools)
library(htmlwidgets)
library(htmltools)
library(jsonlite)
library(yaml)
library(base64enc)
install.packages("tm")
library(tm)
install.packages("wordcloud2")
library(wordcloud2)

# 3. 워드클라우드2 그리기(기본)
wordcloud2(top_40)

# 3-1. wordcloud2 크기, 색 변경(size, color)
wordcloud2(top_40, size=0.5, col="random-dark")

# 3-2. 키워드 회전 정도 조절(rotateRatio)
wordcloud2(top_40, size = 0.5, col = "random-dark", rotateRatio = 0)

# 3-3. 배경 색 검정(backgroundColor)
wordcloud2(top_40, size = 0.5, col = "random-dark", rotateRatio = 0, backgroundColor = "black")


## 특정 개수 이상 추출되는 글자만 색깔을 변경하여 나타나도록
# https://html-color-codes.info/Korean/

# 사이값 지정시 : (weight > 800 && weight < 1000)
# 100개 이상 검색될 시 노랑으로, 아니면 초록으로 표시한다.
In_out_colors = "function(word, weight){return (weight > 100) ? '#F3EF12':'#1EC612'}"

# wordcloud2 그리기
library(wordcloud2)

# 기존모형으로 wordcloud2 생성
# 모양선택 : shape = 'circle', 'cardioid', 'diamond', 'triangle-forward',
#                    'triangle', 'pentagon', 'star'
wordcloud2(df_word,
           shape = 'diamond',
           size = 0.8,
           color = htmlwidgets::JS(In_out_colors),
           backgroundColor = "black")




# ### 패키지 준비하기
# library(wordcloud)
# 
# library(RColorBrewer)
# 
# # 단어 빈도 막대 그래프 만들기
# library(ggplot2)
# 
# order <- arrange(top20, freq)$word    # 빈도 순서 변수 설정
# 
# ggplot(data = top20, aes(x = word, y = freq)) +
#   ylim(0, 2500) +
#   geom_col() +
#   coord_flip() +
#   scale_x_discrete(limit = order) +    # 빈도 순서 변수 기준 막대 정렬
#   geom_text(aes(label = freq), hjust = -0.3)   # 빈도 표시
