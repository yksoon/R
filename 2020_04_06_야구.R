data1 <- read.csv("./data/야구성적.csv", header = T)
class(data1)


dev.new()


v1 <- data1[1:25, 21]  # 연봉대비 출루율
v1

name <- data1$선수명
name

out <- barplot(as.matrix(v1),
                   main = "야구 선수별 연봉 대비 출루율 분석",
                   beside = T,
                   axes = F,
                   ylab = "연봉대비출루율",
                   xlab = "",
                   cex.names = 1.15,
                   las = 2,
                   ylim = c(0,50),
                   col = rainbow(8),
                   border = "white",
                   names.arg = name
                   )

axis(2, ylim=seq(0,35,10))
abline(h=seq(0,35,5), lty=2)
text(x = name,
     y = data1$연봉대비출루율,
     labels = paste(v1,"%"),
     col = "black",
     cex = 0.4,
     pos = 1.5
     )
