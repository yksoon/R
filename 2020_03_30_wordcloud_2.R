# 연설문의 단어에 대한 워드 클라우드 만들기
install.packages('rJava')
install.packages('stringr')
install.packages('hash')
install.packages('Sejong')
install.packages('RSQLite')
install.packages('devtools')

install.packages('tau')
install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz", repos = NULL, type="source")

useSejongDic()

pal2 <- brewer.pal(8, "Dark2")

text <- readLines(file.choose())
text

noun <- sapply(text, extractNoun, USE.NAMES = F)    # 명사만 추출
noun

noun2 <- unlist(noun)    # 리스트로 반환
noun2

# p.221
word_count <- table(noun2)    # 쪼개진 단어들의 갯수를 파악하여 테이블로 반환
word_count

head(sort(word_count, decreasing = TRUE), 10)   # 정렬시킨다음 상위 10개 출력

wordcloud(names(word_count),      # 단어를 꺼냄
          freq = word_count,      # freq : 글자나 숫자를 꺼낼수 있음
          scale = c(6,0.3),       # 비율(가장 큰 값을 6, 가장 작은값을 0.3으로 맞춤)
          min.freq = 3,           # 최소빈도수를 3으로 설정
          random.order = F,       # 실행시 위치 변경
          rot.per = .1,           # 회전 각도를 0.1비율로 회전
          colors = pal2)

